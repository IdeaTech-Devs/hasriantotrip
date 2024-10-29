<?php
include 'koneksi.php';

if (isset($_POST['id']) && isset($_POST['nama']) && isset($_POST['nik'])) {
    $id = $_POST['id'];
    $nama = $_POST['nama'];
    $nik = $_POST['nik'];

    $stmt = $conn->prepare("UPDATE users_212002 SET nama = ?, nik = ? WHERE id = ?");
    if ($stmt === false) {
        echo json_encode(['success' => false, 'message' => 'Gagal mempersiapkan pernyataan']);
        exit;
    }

    $stmt->bind_param("ssi", $nama, $nik, $id);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        echo json_encode(['success' => true, 'message' => 'Data pengguna berhasil diperbarui']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Tidak ada perubahan yang dilakukan']);
    }
    $stmt->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Data tidak lengkap']);
}

$conn->close();
?>
