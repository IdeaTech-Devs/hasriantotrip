<?php
include 'koneksi.php';

// Set header untuk JSON
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nama = isset($_POST['nama']) ? trim($_POST['nama']) : '';
    $nik = isset($_POST['nik']) ? trim($_POST['nik']) : '';
    $email = isset($_POST['email']) ? trim($_POST['email']) : '';
    $kata_sandi = isset($_POST['kata_sandi']) ? trim($_POST['kata_sandi']) : '';
    
    if (!empty($nama) && !empty($nik) && !empty($email) && !empty($kata_sandi)) {
        // Cek apakah NIK atau email sudah ada
        $checkQuery = "SELECT * FROM users_212002 WHERE nik = ? OR email = ?";
        $checkStmt = $conn->prepare($checkQuery);
        $checkStmt->bind_param("ss", $nik, $email);
        $checkStmt->execute();
        $result = $checkStmt->get_result();

        if ($result->num_rows > 0) {
            $existingUser = $result->fetch_assoc();
            if ($existingUser['nik'] == $nik) {
                echo json_encode(['success' => false, 'message' => 'NIK sudah terdaftar']);
            } else if ($existingUser['email'] == $email) {
                echo json_encode(['success' => false, 'message' => 'Email sudah terdaftar']);
            }
        } else {
            $query = "INSERT INTO users_212002 (nik, nama, email, kata_sandi, gambar) VALUES (?, ?, ?, ?, 'default.png')";
            $stmt = $conn->prepare($query);

            if ($stmt) {
                $stmt->bind_param("ssss", $nik, $nama, $email, $kata_sandi);

                if ($stmt->execute()) {
                    echo json_encode(['success' => true, 'message' => 'Registrasi berhasil']);
                } else {
                    echo json_encode(['success' => false, 'message' => 'Gagal menyimpan data pengguna']);
                }

                $stmt->close();
            } else {
                echo json_encode(['success' => false, 'message' => 'Gagal mempersiapkan pernyataan']);
            }
        }

        $checkStmt->close();
    } else {
        echo json_encode(['success' => false, 'message' => 'Data input tidak valid']);
    }

    $conn->close();
} else {
    echo json_encode(['success' => false, 'message' => 'Metode permintaan tidak valid']);
}
?>