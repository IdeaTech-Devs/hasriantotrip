<?php
include 'koneksi.php';

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nama_lokasi = $_POST['nama_lokasi'];
    $waktu_keberangkatan = $_POST['waktu_keberangkatan'];
    $waktu_sampai = $_POST['waktu_sampai'];
    $catatan = $_POST['catatan'];
    $id_pengguna = $_POST['id_pengguna'];

    // Insert lokasi baru jika belum ada
    $lokasiQuery = "INSERT INTO lokasi_212002 (nama) VALUES (?)";
    $stmtLokasi = $conn->prepare($lokasiQuery);
    $stmtLokasi->bind_param("s", $nama_lokasi);
    $stmtLokasi->execute();
    $id_lokasi = $stmtLokasi->insert_id;
    $stmtLokasi->close();

    // Insert perjalanan
    $query = "INSERT INTO perjalanan_21002 (waktu_keberangkatan, waktu_sampai, id_lokasi, id_pengguna, catatan) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ssiss", $waktu_keberangkatan, $waktu_sampai, $id_lokasi, $id_pengguna, $catatan);

    if ($stmt->execute()) {
        echo json_encode(['success' => true, 'message' => 'Data berhasil disimpan']);
    } else {
        echo json_encode(['success' => false, 'message' => 'Gagal menyimpan data']);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Metode permintaan tidak valid']);
}
?>