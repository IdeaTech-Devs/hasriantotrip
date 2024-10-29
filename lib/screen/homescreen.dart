import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/koneksi.dart'; // Pastikan Anda mengimpor ApiService

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _namaLokasiController = TextEditingController();
  final TextEditingController _waktuKeberangkatanController =
      TextEditingController();
  final TextEditingController _waktuSampaiController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId');
    });
  }

  Future<void> _submitData() async {
    if (_namaLokasiController.text.isEmpty ||
        _waktuKeberangkatanController.text.isEmpty ||
        _waktuSampaiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap isi semua bidang yang diperlukan')),
      );
      return;
    }

    if (_userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pengguna tidak ditemukan')),
      );
      return;
    }

    try {
      final response = await ApiService.addPerjalanan(
        _namaLokasiController.text,
        _waktuKeberangkatanController.text,
        _waktuSampaiController.text,
        _catatanController.text,
        _userId!,
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data berhasil disimpan')),
        );
        _clearFields();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  void _clearFields() {
    _namaLokasiController.clear();
    _waktuKeberangkatanController.clear();
    _waktuSampaiController.clear();
    _catatanController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Perjalanan'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/backg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildGlassmorphicTextField(
                  controller: _namaLokasiController,
                  labelText: 'Nama Lokasi',
                ),
                _buildGlassmorphicTextField(
                  controller: _waktuKeberangkatanController,
                  labelText: 'Waktu Keberangkatan',
                ),
                _buildGlassmorphicTextField(
                  controller: _waktuSampaiController,
                  labelText: 'Waktu Sampai',
                ),
                _buildGlassmorphicTextField(
                  controller: _catatanController,
                  labelText: 'Catatan',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphicTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(81, 81, 81, 81).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color.fromARGB(255, 81, 81, 81).withOpacity(0.8),
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }
}
