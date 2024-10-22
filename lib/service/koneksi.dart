import 'package:http/http.dart' as http;

Future<http.Response> login(String email, String password) {
  return http.post(
    Uri.parse('http://10.0.2.2/apitrip/login.php'),
    body: {
      'email': email,
      'kata_sandi': password,
    },
  );
}

Future<http.Response> getUserData(String userId) {
  return http.get(
    Uri.parse('http://10.0.2.2/apitrip/get_user_data.php?user_id=$userId'),
  );
}

Future<http.Response> changePassword(String email, String oldPassword, String newPassword) {
  return http.post(
    Uri.parse('http://10.0.2.2/apitrip/change_password.php'),
    body: {
      'email': email,
      'old_password': oldPassword,
      'new_password': newPassword,
    },
  );
}
