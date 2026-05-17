<?php
require 'config.php';

// Preset safe queries only — no raw user SQL for security
$preset = $_GET['preset'] ?? 'director_power';

$presets = [

    'director_power' => [
        'name' => 'Director Power Index',
        'description' => 'Ranks directors by total worldwide gross with avg IMDb and ROI — uses window functions',
        'sql' => "
            SELECT p.full_name AS director,
                   COUNT(DISTINCT m.movie_id)             AS total_films,
                   ROUND(AVG(m.imdb_rating),2)             AS avg_imdb,
                   SUM(b.worldwide_gross_usd)               AS total_gross_usd,
                   ROUND(AVG(b.roi_pct),1)                  AS avg_roi_pct,
                   RANK() OVER (ORDER BY SUM(b.worldwide_gross_usd) DESC) AS gross_rank
            FROM persons p
            JOIN movies     m ON m.director_id = p.person_id
            JOIN box_office b ON m.movie_id    = b.movie_id
            WHERE p.is_director = 1
            GROUP BY p.person_id
            HAVING total_films >= 2
            ORDER BY total_gross_usd DESC
            LIMIT 15
        "
    ],

    'movie_music_bridge' => [
        'name' => 'Movie ↔ Music Bridge',
        'description' => 'Links films to their soundtracks — shows streaming impact vs box office gross',
        'sql' => "
            SELECT m.title AS film, m.release_year,
                   a.album_name AS soundtrack,
                   p.full_name  AS composer,
                   a.spotify_streams,
                   b.worldwide_gross_usd,
                   ROUND(a.spotify_streams / b.worldwide_gross_usd * 1000000, 2) AS music_impact_ratio
            FROM movies m
            JOIN movie_music_bridge mmb ON m.movie_id   = mmb.movie_id AND mmb.is_primary_ost = 1
            JOIN albums             a   ON mmb.album_id  = a.album_id
            JOIN box_office         b   ON m.movie_id    = b.movie_id
            LEFT JOIN persons       p   ON a.composer_id = p.person_id
            WHERE b.worldwide_gross_usd > 0 AND a.spotify_streams > 0
            ORDER BY music_impact_ratio DESC
            LIMIT 15
        "
    ],

    'hundred_cr_club' => [
        'name' => '100 Crore Club Report',
        'description' => 'All films that crossed ₹100 Crore domestic — with full financial breakdown',
        'sql' => "
            SELECT m.title, m.release_year,
                   p.full_name   AS director,
                   l.language_name,
                   ROUND(b.india_gross_inr/10000000,1)      AS india_gross_cr,
                   ROUND(b.worldwide_gross_usd/1000000,1)   AS worldwide_m,
                   b.roi_pct, b.verdict,
                   m.imdb_rating, m.rt_tomatometer
            FROM movies m
            JOIN box_office b ON m.movie_id    = b.movie_id
            JOIN persons    p ON m.director_id = p.person_id
            JOIN languages  l ON m.language_id = l.language_id
            WHERE m.is_100cr_club = 1
            ORDER BY b.india_gross_inr DESC
        "
    ],

    'actor_matrix' => [
        'name' => 'Actor Performance Matrix',
        'description' => 'Ranks actors by total box office carried with rating consistency score',
        'sql' => "
            SELECT p.full_name AS actor,
                   p.nationality,
                   COUNT(DISTINCT mc.movie_id)               AS total_films,
                   SUM(b.worldwide_gross_usd)                 AS total_gross,
                   ROUND(AVG(m.imdb_rating),2)                AS avg_imdb,
                   ROUND(STDDEV(m.imdb_rating),2)             AS rating_consistency,
                   DENSE_RANK() OVER (ORDER BY SUM(b.worldwide_gross_usd) DESC) AS box_office_rank
            FROM persons p
            JOIN movie_cast  mc ON p.person_id  = mc.person_id
            JOIN movies      m  ON mc.movie_id  = m.movie_id
            JOIN box_office  b  ON m.movie_id   = b.movie_id
            WHERE (p.is_actor = 1 OR p.is_actress = 1)
            GROUP BY p.person_id
            HAVING total_films >= 3
            ORDER BY total_gross DESC
            LIMIT 15
        "
    ],

    'genre_decade' => [
        'name' => 'Genre Trends by Decade',
        'description' => 'How genre popularity has shifted decade by decade — great for the line chart',
        'sql' => "
            SELECT FLOOR(m.release_year/10)*10  AS decade,
                   g.genre_name,
                   COUNT(*)                      AS movie_count,
                   ROUND(AVG(m.imdb_rating),2)   AS avg_imdb,
                   SUM(b.worldwide_gross_usd)     AS total_gross
            FROM movies m
            JOIN movie_genres mg ON m.movie_id  = mg.movie_id AND mg.is_primary = 1
            JOIN genres       g  ON mg.genre_id = g.genre_id
            LEFT JOIN box_office b ON m.movie_id = b.movie_id
            GROUP BY decade, g.genre_id
            ORDER BY decade, movie_count DESC
        "
    ],

    'composer_impact' => [
        'name' => 'Composer Box Office Impact',
        'description' => 'Do great composers lead to better box office? This query answers it.',
        'sql' => "
            SELECT p.full_name AS composer,
                   COUNT(DISTINCT a.album_id)               AS total_scores,
                   SUM(a.spotify_streams)                    AS total_streams,
                   ROUND(AVG(a.cinesic_music_rating),1)      AS avg_music_rating,
                   SUM(b.worldwide_gross_usd)                 AS movies_gross,
                   ROUND(AVG(b.roi_pct),1)                   AS avg_movie_roi
            FROM persons p
            JOIN albums             a   ON a.composer_id  = p.person_id
            JOIN movie_music_bridge mmb ON mmb.album_id   = a.album_id
            JOIN movies             m   ON mmb.movie_id   = m.movie_id
            JOIN box_office         b   ON m.movie_id     = b.movie_id
            WHERE p.is_composer = 1
            GROUP BY p.person_id
            ORDER BY total_streams DESC
            LIMIT 12
        "
    ],

    'language_dominance' => [
        'name' => 'Language Dominance',
        'description' => 'Which language film industry earns the most? Bollywood vs Hollywood vs South.',
        'sql' => "
            SELECT l.language_name,
                   COUNT(m.movie_id)                          AS movie_count,
                   ROUND(AVG(m.imdb_rating),2)                AS avg_imdb,
                   SUM(b.worldwide_gross_usd)                  AS total_gross,
                   ROUND(AVG(b.roi_pct),1)                    AS avg_roi,
                   SUM(CASE WHEN m.is_100cr_club=1 THEN 1 ELSE 0 END) AS hundred_cr_films
            FROM languages l
            JOIN movies     m ON m.language_id = l.language_id
            JOIN box_office b ON m.movie_id    = b.movie_id
            GROUP BY l.language_id
            ORDER BY total_gross DESC
        "
    ],

    'top_soundtracks' => [
        'name' => 'Top Soundtracks by Streams',
        'description' => 'Most streamed film soundtracks on Spotify + YouTube combined',
        'sql' => "
            SELECT a.album_name, a.release_year,
                   m.title           AS film,
                   p.full_name       AS composer,
                   a.spotify_streams, a.youtube_views,
                   (a.spotify_streams + a.youtube_views) AS combined_plays,
                   a.cinesic_music_rating
            FROM albums a
            LEFT JOIN persons p ON a.composer_id = p.person_id
            LEFT JOIN movies  m ON a.movie_id    = m.movie_id
            WHERE a.spotify_streams > 0
            ORDER BY combined_plays DESC
            LIMIT 15
        "
    ],

    'verdict_summary' => [
        'name' => 'Verdict Distribution',
        'description' => 'How many films are blockbusters vs flops — with avg IMDb and ROI per category',
        'sql' => "
            SELECT b.verdict,
                   COUNT(*)                        AS film_count,
                   ROUND(AVG(m.imdb_rating),2)     AS avg_imdb,
                   ROUND(AVG(b.roi_pct),1)          AS avg_roi,
                   SUM(b.worldwide_gross_usd)        AS total_gross,
                   ROUND(AVG(b.budget_usd)/1000000,1) AS avg_budget_m
            FROM box_office b
            JOIN movies m ON b.movie_id = m.movie_id
            GROUP BY b.verdict
            ORDER BY avg_roi DESC
        "
    ],

    'franchise_comparison' => [
        'name' => 'Franchise Comparison',
        'description' => 'Compares all film franchises by total gross and average rating',
        'sql' => "
            SELECT f.franchise_name,
                   COUNT(m.movie_id)                AS parts,
                   ROUND(AVG(m.imdb_rating),2)       AS avg_imdb,
                   SUM(b.worldwide_gross_usd)         AS total_gross,
                   MAX(b.worldwide_gross_usd)          AS best_part_gross,
                   ROUND(AVG(b.roi_pct),1)            AS avg_roi
            FROM franchises f
            JOIN movies     m ON m.franchise_id = f.franchise_id
            JOIN box_office b ON m.movie_id     = b.movie_id
            GROUP BY f.franchise_id
            ORDER BY total_gross DESC
        "
    ],
];

// Run the selected preset
if (!isset($presets[$preset])) {
    echo json_encode(['status'=>'error','message'=>'Unknown preset']);
    exit;
}

$p       = $presets[$preset];
$result  = $conn->query(trim($p['sql']));

if (!$result) {
    echo json_encode(['status'=>'error','message'=>$conn->error]);
    exit;
}

$rows    = [];
$columns = [];
$fields  = $result->fetch_fields();
foreach ($fields as $f) $columns[] = $f->name;
while ($row = $result->fetch_assoc()) $rows[] = $row;

// Return all presets list too (for dropdown)
$preset_list = [];
foreach ($presets as $key => $val) {
    $preset_list[] = ['key'=>$key,'name'=>$val['name'],'description'=>$val['description']];
}

echo json_encode([
    'status'      => 'ok',
    'preset'      => $preset,
    'name'        => $p['name'],
    'description' => $p['description'],
    'sql'         => trim($p['sql']),
    'columns'     => $columns,
    'rows'        => $rows,
    'row_count'   => count($rows),
    'all_presets' => $preset_list
]);
?>
