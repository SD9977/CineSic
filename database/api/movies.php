<?php
require 'config.php';

$limit  = intval($_GET['limit']  ?? 20);
$offset = intval($_GET['offset'] ?? 0);
$sort   = $_GET['sort']   ?? 'imdb_rating';
$genre  = $_GET['genre']  ?? '';
$year   = $_GET['year']   ?? '';
$search = $_GET['search'] ?? '';
$id     = intval($_GET['id'] ?? 0);

// Single movie profile
if ($id > 0) {
    $stmt = $conn->prepare("
        SELECT m.*, 
               l.language_name, c.country_name, cert.certificate_code,
               p.full_name AS director_name,
               ph.house_name AS studio_name,
               b.budget_usd, b.worldwide_gross_usd, b.india_gross_inr,
               b.roi_pct, b.verdict, b.opening_weekend_usd,
               b.domestic_gross_usd, b.overseas_gross_usd,
               b.ott_deal_usd, b.total_revenue_usd
        FROM movies m
        LEFT JOIN languages         l    ON m.language_id    = l.language_id
        LEFT JOIN countries         c    ON m.country_id     = c.country_id
        LEFT JOIN certificates      cert ON m.certificate_id = cert.certificate_id
        LEFT JOIN persons           p    ON m.director_id    = p.person_id
        LEFT JOIN production_houses ph   ON m.studio_id      = ph.house_id
        LEFT JOIN box_office        b    ON m.movie_id       = b.movie_id
        WHERE m.movie_id = ?
    ");
    $stmt->bind_param('i', $id);
    $stmt->execute();
    $movie = $stmt->get_result()->fetch_assoc();

    // Cast
    $cast_res = $conn->query("
        SELECT mc.role_type, mc.character_name, mc.billing_order,
               mc.is_protagonist, mc.is_antagonist,
               p.full_name, p.date_of_birth, p.nationality
        FROM movie_cast mc
        JOIN persons p ON mc.person_id = p.person_id
        WHERE mc.movie_id = $id
        ORDER BY mc.billing_order
        LIMIT 10
    ");
    $cast = [];
    while ($row = $cast_res->fetch_assoc()) $cast[] = $row;

    // Genres
    $genre_res = $conn->query("
        SELECT g.genre_name, mg.is_primary
        FROM movie_genres mg
        JOIN genres g ON mg.genre_id = g.genre_id
        WHERE mg.movie_id = $id
    ");
    $genres = [];
    while ($row = $genre_res->fetch_assoc()) $genres[] = $row;

    // Soundtrack
    $ost_res = $conn->query("
        SELECT a.album_id, a.album_name, a.album_type,
               a.spotify_streams, a.youtube_views, a.cinesic_music_rating,
               p.full_name AS composer_name, mmb.is_primary_ost
        FROM movie_music_bridge mmb
        JOIN albums a  ON mmb.album_id  = a.album_id
        LEFT JOIN persons p ON a.composer_id = p.person_id
        WHERE mmb.movie_id = $id
    ");
    $ost = [];
    while ($row = $ost_res->fetch_assoc()) $ost[] = $row;

    // Streaming
    $stream_res = $conn->query("
        SELECT sp.platform_name, ms.stream_quality, ms.is_exclusive, ms.available_from
        FROM movie_streaming ms
        JOIN streaming_platforms sp ON ms.platform_id = sp.platform_id
        WHERE ms.movie_id = $id
    ");
    $streaming = [];
    while ($row = $stream_res->fetch_assoc()) $streaming[] = $row;

    echo json_encode([
        'status'    => 'ok',
        'movie'     => $movie,
        'cast'      => $cast,
        'genres'    => $genres,
        'soundtrack'=> $ost,
        'streaming' => $streaming
    ]);
    exit;
}

// Whitelist sort columns
$allowed_sorts = [
    'imdb_rating'        => 'm.imdb_rating',
    'release_year'       => 'm.release_year',
    'worldwide_gross'    => 'b.worldwide_gross_usd',
    'roi'                => 'b.roi_pct',
    'title'              => 'm.title',
    'rt_tomatometer'     => 'm.rt_tomatometer',
];
$sort_col = $allowed_sorts[$sort] ?? 'm.imdb_rating';

// Build WHERE clause
$where = ['1=1'];
$params = [];
$types  = '';

if ($genre) {
    $where[] = "g.genre_name = ?";
    $params[] = $genre;
    $types   .= 's';
}
if ($year) {
    $where[] = "m.release_year = ?";
    $params[] = intval($year);
    $types   .= 'i';
}
if ($search) {
    $where[] = "m.title LIKE ?";
    $params[] = "%$search%";
    $types   .= 's';
}

$where_sql = implode(' AND ', $where);

$sql = "
    SELECT DISTINCT
           m.movie_id, m.title, m.release_year, m.runtime_minutes,
           m.imdb_rating, m.rt_tomatometer, m.is_imax, m.is_3d,
           m.is_100cr_club, m.is_billion_usd,
           l.language_name,
           p.full_name  AS director_name,
           b.worldwide_gross_usd, b.india_gross_inr, b.roi_pct, b.verdict,
           GROUP_CONCAT(DISTINCT g.genre_name ORDER BY mg.is_primary DESC SEPARATOR ',') AS genres
    FROM movies m
    LEFT JOIN languages    l  ON m.language_id  = l.language_id
    LEFT JOIN persons      p  ON m.director_id  = p.person_id
    LEFT JOIN box_office   b  ON m.movie_id     = b.movie_id
    LEFT JOIN movie_genres mg ON m.movie_id     = mg.movie_id
    LEFT JOIN genres       g  ON mg.genre_id    = g.genre_id
    WHERE $where_sql
    GROUP BY m.movie_id
    ORDER BY $sort_col DESC
    LIMIT ? OFFSET ?
";

$params[] = $limit;
$params[] = $offset;
$types   .= 'ii';

$stmt = $conn->prepare($sql);
if ($types) $stmt->bind_param($types, ...$params);
$stmt->execute();
$result = $stmt->get_result();

$movies = [];
while ($row = $result->fetch_assoc()) $movies[] = $row;

// Total count
$count_sql = "
    SELECT COUNT(DISTINCT m.movie_id) AS total
    FROM movies m
    LEFT JOIN movie_genres mg ON m.movie_id  = mg.movie_id
    LEFT JOIN genres       g  ON mg.genre_id = g.genre_id
    WHERE $where_sql
";
$count_params = array_slice($params, 0, -2);
$count_types  = substr($types, 0, -2);
$count_stmt   = $conn->prepare($count_sql);
if ($count_types) $count_stmt->bind_param($count_types, ...$count_params);
$count_stmt->execute();
$total = $count_stmt->get_result()->fetch_assoc()['total'];

echo json_encode([
    'status' => 'ok',
    'total'  => intval($total),
    'limit'  => $limit,
    'offset' => $offset,
    'data'   => $movies
]);
?>
