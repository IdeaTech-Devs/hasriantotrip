<?php
include 'koneksi.php';

if (isset($_POST['id'])) {
    $id = $_POST['id'];

    $stmt = $conn->prepare("SELECT id, nik, nama, email, gambar, peran, status FROM users_212002 WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user_data = $result->fetch_assoc();
        echo json_encode(['success' => true, 'data' => $user_data]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Pengguna tidak ditemukan']);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Data tidak lengkap']);
}

$conn->close();