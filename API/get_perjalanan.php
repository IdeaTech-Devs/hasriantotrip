<?php
include 'koneksi.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id_pengguna = $_POST['id_pengguna'];

    $query = "SELECT * FROM perjalanan_21002 WHERE id_pengguna = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $id_pengguna);
    $stmt->execute();
    $result = $stmt->get_result();

    $perjalanan = [];
    while ($row = $result->fetch_assoc()) {
        $perjalanan[] = $row;
    }

    echo json_encode(['success' => true, 'data' => $perjalanan]);

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Metode permintaan tidak valid']);
}
?>