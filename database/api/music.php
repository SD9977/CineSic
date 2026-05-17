<?php
require 'config.php';

$limit  = intval($_GET['limit']  ?? 20);
$offset = intval($_GET['offset'] ?? 0);
$sort   = $_GET['sort']   ?? 'spotify_streams';
$search = $_GET['search'] ?? '';
$id     = intval($_GET['id'] ?? 0);
$type   = $_GET['type']   ?? ''; // 'tracks' to get tracks of an album

// Single album + its tracks
if ($id > 0) {
    $stmt = $conn->prepare("
        SELECT a.*,
               p.full_name  AS composer_name,
               ml.label_name,
               m.title      AS movie_title,
               m.movie_id,
               m.release_year AS movie_year
        FROM albums a
        LEFT JOIN persons      p  ON a.composer_id = p.person_id
        LEFT JOIN music_labels ml ON a.label_id     = ml.label_id
        LEFT JOIN movies       m  ON a.movie_id     = m.movie_id
        WHERE a.album_id = ?
    ");
    $stmt->bind_param('i', $id);
    $stmt->execute();
    $album = $stmt->get_result()->fetch_assoc();

    // Tracks
    $tracks_res = $conn->query("
        SELECT t.*, 
               GROUP_CONCAT(DISTINCT p.full_name SEPARATOR ', ') AS singers
        FROM tracks t
        LEFT JOIN track_singers ts ON t.track_id  = ts.track_id
        LEFT JOIN persons       p  ON ts.person_id = p.person_id
        WHERE t.album_id = $id
        GROUP BY t.track_id
        ORDER BY t.track_number
    ");
    $tracks = [];
    while ($row = $tracks_res->fetch_assoc()) $tracks[] = $row;

    echo json_encode([
        'status' => 'ok',
        'album'  => $album,
        'tracks' => $tracks
    ]);
    exit;
}

// Allowed sort columns
$allowed_sorts = [
    'spotify_streams'    => 'a.spotify_streams',
    'youtube_views'      => 'a.youtube_views',
    'release_year'       => 'a.release_year',
    'cinesic_rating'     => 'a.cinesic_music_rating',
    'total_tracks'       => 'a.total_tracks',
];
$sort_col = $allowed_sorts[$sort] ?? 'a.spotify_streams';

$where = ['1=1'];
$params = [];
$types  = '';

if ($search) {
    $where[] = "a.album_name LIKE ?";
    $params[] = "%$search%";
    $types   .= 's';
}

$where_sql = implode(' AND ', $where);

$sql = "
    SELECT a.album_id, a.album_name, a.album_type, a.release_year,
           a.total_tracks, a.total_duration_s,
           a.spotify_streams, a.youtube_views, a.jiosaavn_plays,
           a.cinesic_music_rating, a.peak_chart_position,
           p.full_name  AS composer_name,
           ml.label_name,
           m.title      AS movie_title,
           m.movie_id
    FROM albums a
    LEFT JOIN persons      p  ON a.composer_id = p.person_id
    LEFT JOIN music_labels ml ON a.label_id     = ml.label_id
    LEFT JOIN movies       m  ON a.movie_id     = m.movie_id
    WHERE $where_sql
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

$albums = [];
while ($row = $result->fetch_assoc()) $albums[] = $row;

// Top tracks
$top_tracks = [];
if ($_GET['include_tracks'] ?? false) {
    $tr = $conn->query("
        SELECT t.track_title, t.duration_seconds, t.spotify_streams,
               t.bpm, t.musical_key, t.mood,
               a.album_name,
               GROUP_CONCAT(DISTINCT p.full_name SEPARATOR ', ') AS singers
        FROM tracks t
        JOIN albums a ON t.album_id = a.album_id
        LEFT JOIN track_singers ts ON t.track_id  = ts.track_id
        LEFT JOIN persons       p  ON ts.person_id = p.person_id
        GROUP BY t.track_id
        ORDER BY t.spotify_streams DESC
        LIMIT 10
    ");
    while ($row = $tr->fetch_assoc()) $top_tracks[] = $row;
}

echo json_encode([
    'status'     => 'ok',
    'total'      => count($albums),
    'data'       => $albums,
    'top_tracks' => $top_tracks
]);
?>
