<?php
include 'koneksi.php';

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Memeriksa apakah data POST ada
if (isset($_POST['email']) && isset($_POST['kata_sandi'])) {
    $email = $_POST['email'];
    $kata_sandi = $_POST['kata_sandi'];

    // Menggunakan prepared statement untuk keamanan
    $stmt = $conn->prepare("SELECT * FROM users_212002 WHERE email = ? AND kata_sandi = ?");
    $stmt->bind_param("ss", $email, $kata_sandi);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Jika email dan kata_sandi cocok
        echo json_encode(['success' => true]);
    } else {
        // Jika email dan kata_sandi tidak cocok
        echo json_encode(['success' => false]);
    }
    $stmt->close();
} else {
    // Jika data POST tidak lengkap
    echo json_encode(['success' => false, 'message' => 'Data tidak lengkap']);
}

$conn->close();
