import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2/apitrip';

  static Future<http.Response> login(String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {
        'email': email,
        'kata_sandi': password,
      },
    );
  }

  static Future<http.Response> getUserData(String userId) {
    return http.post(
      Uri.parse('$baseUrl/get_user_data.php'),
      body: {'id': userId},
    );
  }

  static Future<http.Response> changePassword(
      String userId, String oldPassword, String newPassword) {
    return http.post(
      Uri.parse('$baseUrl/change_password.php'),
      body: {
        'id': userId,
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );
  }

  static Future<http.Response> updateUserData(
      String id, String nama, String nik) {
    return http.post(
      Uri.parse('$baseUrl/update_user.php'),
      body: {
        'id': id,
        'nama': nama,
        'nik': nik,
      },
    );
  }

  static Future<http.Response> register(
      String nama, String nik, String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/register.php'),
      body: {
        'nama': nama,
        'nik': nik,
        'email': email,
        'kata_sandi': password,
      },
    );
  }

  static Future<http.Response> addPerjalanan(
      String namaLokasi, String waktuKeberangkatan, String waktuSampai, String catatan, String idPengguna) {
    return http.post(
      Uri.parse('$baseUrl/add_perjalanan.php'),
      body: {
        'nama_lokasi': namaLokasi,
        'waktu_keberangkatan': waktuKeberangkatan,
        'waktu_sampai': waktuSampai,
        'catatan': catatan,
        'id_pengguna': idPengguna,
      },
    );
  }
}
