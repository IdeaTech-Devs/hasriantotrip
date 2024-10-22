<?php
include 'koneksi.php';

// Membuat koneksi
$conn = new mysqli($servername, $username, $password, $dbname);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Memeriksa apakah data POST ada
if (isset($_POST['email']) && isset($_POST['old_password']) && isset($_POST['new_password'])) {
    $email = $_POST['email'];
    $old_password = $_POST['old_password'];
    $new_password = $_POST['new_password'];

    // Memeriksa kata sandi lama
    $stmt = $conn->prepare("SELECT kata_sandi FROM users_212002 WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->bind_result($stored_password);
    $stmt->fetch();
    $stmt->close();

    if ($old_password === $stored_password) {
        // Mengganti kata sandi
        $stmt = $conn->prepare("UPDATE users_212002 SET kata_sandi = ? WHERE email = ?");
        $stmt->bind_param("ss", $new_password, $email);
        if ($stmt->execute()) {
            echo json_encode(['success' => true, 'message' => 'Kata sandi berhasil diubah']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Gagal mengubah kata sandi']);
        }
        $stmt->close();
    } else {
        echo json_encode(['success' => false, 'message' => 'Kata sandi lama salah']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Data tidak lengkap']);
}

$conn->close();

