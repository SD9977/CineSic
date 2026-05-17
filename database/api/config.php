<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
$host = 'localhost';
$db   = 'cinesic';
$user = 'root';
$pass = '';
$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(['status'=>'error','message'=>$conn->connect_error]);
    exit;
}
?>