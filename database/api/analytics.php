<?php
require 'config.php';

$type = $_GET['type'] ?? 'boxoffice_top';

switch ($type) {

    // ── Top 15 movies by worldwide gross ──
    case 'boxoffice_top':
        $limit = intval($_GET['limit'] ?? 15);
        $res = $conn->query("
            SELECT m.title, m.release_year, m.imdb_rating,
                   p.full_name AS director,
                   b.worldwide_gross_usd, b.budget_usd,
                   b.roi_pct, b.verdict, b.india_gross_inr
            FROM movies m
            JOIN box_office b ON m.movie_id   = b.movie_id
            JOIN persons    p ON m.director_id = p.person_id
            ORDER BY b.worldwide_gross_usd DESC
            LIMIT $limit
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Genre distribution ──
    case 'genre_distribution':
        $res = $conn->query("
            SELECT g.genre_name,
                   COUNT(DISTINCT mg.movie_id)        AS movie_count,
                   ROUND(AVG(m.imdb_rating),2)         AS avg_imdb,
                   SUM(b.worldwide_gross_usd)           AS total_gross
            FROM genres g
            JOIN movie_genres mg ON g.genre_id  = mg.genre_id AND mg.is_primary = 1
            JOIN movies       m  ON mg.movie_id = m.movie_id
            LEFT JOIN box_office b ON m.movie_id = b.movie_id
            WHERE g.genre_type IN ('Film','Both')
            GROUP BY g.genre_id
            ORDER BY movie_count DESC
            LIMIT 12
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Ratings by decade ──
    case 'ratings_by_decade':
        $res = $conn->query("
            SELECT FLOOR(m.release_year/10)*10    AS decade,
                   COUNT(*)                        AS movie_count,
                   ROUND(AVG(m.imdb_rating),2)     AS avg_imdb,
                   ROUND(AVG(m.rt_tomatometer),1)  AS avg_rt,
                   SUM(b.worldwide_gross_usd)       AS total_gross
            FROM movies m
            LEFT JOIN box_office b ON m.movie_id = b.movie_id
            WHERE m.imdb_rating IS NOT NULL
            GROUP BY decade
            ORDER BY decade
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Director stats (for radar / comparison) ──
    case 'director_stats':
        $limit = intval($_GET['limit'] ?? 10);
        $res = $conn->query("
            SELECT p.full_name AS director,
                   COUNT(DISTINCT m.movie_id)       AS total_films,
                   ROUND(AVG(m.imdb_rating),2)       AS avg_imdb,
                   SUM(b.worldwide_gross_usd)         AS total_gross,
                   ROUND(AVG(b.roi_pct),1)            AS avg_roi,
                   MAX(b.worldwide_gross_usd)          AS best_gross
            FROM persons p
            JOIN movies      m ON m.director_id = p.person_id
            JOIN box_office  b ON m.movie_id    = b.movie_id
            WHERE p.is_director = 1
            GROUP BY p.person_id
            HAVING total_films >= 2
            ORDER BY total_gross DESC
            LIMIT $limit
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Music streaming comparison ──
    case 'music_streams':
        $limit = intval($_GET['limit'] ?? 12);
        $res = $conn->query("
            SELECT a.album_name, a.spotify_streams, a.youtube_views,
                   a.jiosaavn_plays, a.cinesic_music_rating,
                   p.full_name AS composer,
                   m.title     AS movie_title
            FROM albums a
            LEFT JOIN persons p ON a.composer_id = p.person_id
            LEFT JOIN movies  m ON a.movie_id    = m.movie_id
            WHERE a.spotify_streams > 0
            ORDER BY a.spotify_streams DESC
            LIMIT $limit
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── India vs Worldwide gross ──
    case 'india_vs_world':
        $res = $conn->query("
            SELECT m.title, m.release_year,
                   ROUND(b.india_gross_inr/10000000, 1) AS india_cr,
                   ROUND(b.worldwide_gross_usd/1000000, 1) AS worldwide_m,
                   b.verdict, l.language_name
            FROM movies m
            JOIN box_office b ON m.movie_id    = b.movie_id
            JOIN languages  l ON m.language_id = l.language_id
            WHERE b.india_gross_inr > 500000000
            ORDER BY b.india_gross_inr DESC
            LIMIT 15
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Language breakdown ──
    case 'language_breakdown':
        $res = $conn->query("
            SELECT l.language_name,
                   COUNT(m.movie_id)              AS movie_count,
                   ROUND(AVG(m.imdb_rating),2)    AS avg_imdb,
                   SUM(b.worldwide_gross_usd)      AS total_gross
            FROM languages l
            JOIN movies     m ON m.language_id = l.language_id
            LEFT JOIN box_office b ON m.movie_id = b.movie_id
            GROUP BY l.language_id
            ORDER BY movie_count DESC
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Verdict breakdown ──
    case 'verdict_breakdown':
        $res = $conn->query("
            SELECT b.verdict,
                   COUNT(*)                        AS count,
                   ROUND(AVG(m.imdb_rating),2)     AS avg_imdb,
                   ROUND(AVG(b.roi_pct),1)          AS avg_roi
            FROM box_office b
            JOIN movies m ON b.movie_id = m.movie_id
            WHERE b.verdict IS NOT NULL
            GROUP BY b.verdict
            ORDER BY count DESC
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Composer impact on box office ──
    case 'composer_impact':
        $res = $conn->query("
            SELECT p.full_name AS composer,
                   COUNT(DISTINCT a.album_id)          AS total_albums,
                   SUM(a.spotify_streams)               AS total_streams,
                   ROUND(AVG(a.cinesic_music_rating),1) AS avg_rating,
                   SUM(b.worldwide_gross_usd)            AS movies_total_gross
            FROM persons p
            JOIN albums      a   ON a.composer_id  = p.person_id
            JOIN movie_music_bridge mmb ON mmb.album_id = a.album_id
            JOIN movies      m   ON mmb.movie_id   = m.movie_id
            JOIN box_office  b   ON m.movie_id     = b.movie_id
            WHERE p.is_composer = 1
            GROUP BY p.person_id
            ORDER BY total_streams DESC
            LIMIT 10
        ");
        $data = [];
        while ($row = $res->fetch_assoc()) $data[] = $row;
        echo json_encode(['status'=>'ok','data'=>$data]);
        break;

    // ── Summary stats for home page ──
    case 'summary':
        $movies  = $conn->query("SELECT COUNT(*) AS c FROM movies")->fetch_assoc()['c'];
        $albums  = $conn->query("SELECT COUNT(*) AS c FROM albums")->fetch_assoc()['c'];
        $tracks  = $conn->query("SELECT COUNT(*) AS c FROM tracks")->fetch_assoc()['c'];
        $persons = $conn->query("SELECT COUNT(*) AS c FROM persons")->fetch_assoc()['c'];
        $gross   = $conn->query("SELECT SUM(worldwide_gross_usd) AS s FROM box_office")->fetch_assoc()['s'];
        $top     = $conn->query("SELECT title, imdb_rating FROM movies ORDER BY imdb_rating DESC LIMIT 1")->fetch_assoc();
        echo json_encode([
            'status'       => 'ok',
            'movies'       => intval($movies),
            'albums'       => intval($albums),
            'tracks'       => intval($tracks),
            'persons'      => intval($persons),
            'total_gross'  => floatval($gross),
            'top_rated'    => $top
        ]);
        break;

    default:
        echo json_encode(['status'=>'error','message'=>'Unknown type: '.$type]);
}
?>
