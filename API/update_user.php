<?php
include 'koneksi.php';

// Set header untuk JSON
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // Validasi dan sanitasi input
    $id = isset($_POST['id']) ? intval($_POST['id']) : 0;
    $nama = isset($_POST['nama']) ? trim($_POST['nama']) : '';
    $nik = isset($_POST['nik']) ? trim($_POST['nik']) : '';

    if ($id > 0 && !empty($nama) && !empty($nik)) {
        $query = "UPDATE users SET nama = ?, nik = ? WHERE id = ?";
        $stmt = $conn->prepare($query);

        if ($stmt) {
            $stmt->bind_param("ssi", $nama, $nik, $id);

            if ($stmt->execute()) {
                echo json_encode(['success' => true, 'message' => 'Data berhasil diperbarui']);
            } else {
                echo json_encode(['success' => false, 'message' => 'Gagal memperbarui data']);
            }

            $stmt->close();
        } else {
            echo json_encode(['success' => false, 'message' => 'Gagal mempersiapkan pernyataan']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Data input tidak valid']);
    }

    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Metode permintaan tidak valid']);
}
?>
