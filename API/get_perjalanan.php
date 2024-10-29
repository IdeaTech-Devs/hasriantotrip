<?php
include 'koneksi.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['id_pengguna'])) {
        $id_pengguna = $_POST['id_pengguna'];

        $query = "SELECT p.*, l.nama AS nama_lokasi 
                  FROM perjalanan_21002 p
                  JOIN lokasi_212002 l ON p.id_lokasi = l.id_lokasi
                  WHERE p.id_pengguna = ?";
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
        echo json_encode(['success' => false, 'message' => 'ID pengguna tidak ditemukan']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Metode permintaan tidak valid']);
}
?>