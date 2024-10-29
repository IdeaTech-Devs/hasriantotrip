import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/koneksi.dart';
import 'loginscreen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  bool isLoading = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('user_id') ?? '';
    print('User ID: $userId');

    if (userId.isEmpty) {
      print('User ID kosong');
      return;
    }

    final response = await ApiService.getUserData(userId);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        setState(() {
          userData = data['data'];
          _nameController.text = userData['nama'];
          _nikController.text = userData['nik'];
          isLoading = false;
        });
      } else {
        print('Gagal mengambil data pengguna: ${data['message']}');
      }
    } else {
      print('Gagal terhubung ke server: ${response.statusCode}');
    }
  }

  Future<void> _changePassword() async {
    // Implementasi dialog untuk mengubah kata sandi
    // Gunakan ApiService.changePassword untuk mengirim permintaan ke server
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua data sesi

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _updateUserData() async {
    setState(() {
      isLoading = true;
    });

    final response = await ApiService.updateUserData(
      userData['id'].toString(),
      _nameController.text,
      _nikController.text,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Debug respons

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            userData['nama'] = _nameController.text;
            userData['nik'] = _nikController.text;
            isLoading = false;
          });
          print('Data pengguna berhasil diperbarui');
        } else {
          print('Gagal memperbarui data pengguna: ${data['message']}');
        }
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Gagal terhubung ke server: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          '${ApiService.baseUrl}/images/${userData['gambar']}'),
                    ),
                  ),
                  SizedBox(height: 20),
                  buildInfoTile('NIK', userData['nik']),
                  buildInfoTile('Nama', userData['nama']),
                  buildInfoTile('Email', userData['email']),
                  buildInfoTile('Peran', userData['peran']),
                  buildInfoTile('Status', userData['status']),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(labelText: 'Nama'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Logika untuk mengedit nama
                          _nameController.text = userData['nama'];
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nikController,
                          decoration: InputDecoration(labelText: 'NIK'),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Logika untuk mengedit NIK
                          _nikController.text = userData['nik'];
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: _updateUserData,
                          child: Text('Simpan Perubahan'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _logout,
                          child: Text('Keluar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 100,
              child:
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
