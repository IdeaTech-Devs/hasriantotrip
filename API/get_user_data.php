<?php
include 'koneksi.php';

// Memeriksa apakah data POST ada
if (isset($_POST['id'])) {
    $id = $_POST['id'];

    // Menggunakan prepared statement untuk keamanan
    $stmt = $conn->prepare("SELECT * FROM users_212002 WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Jika data ditemukan
        $user_data = $result->fetch_assoc();
        echo json_encode(['success' => true, 'data' => $user_data]);
    } else {
        // Jika data tidak ditemukan
        echo json_encode(['success' => false, 'message' => 'Pengguna tidak ditemukan']);
    }
    $stmt->close();
} else {
    // Jika data POST tidak lengkap
    echo json_encode(['success' => false, 'message' => 'Data tidak lengkap']);
}

$conn->close();

