import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/koneksi.dart';
import 'dart:convert';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<dynamic> _perjalananList = [];
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
    print('Loaded userId: $_userId');
    if (_userId != null) {
      _fetchPerjalanan();
    } else {
      _showError('Pengguna tidak ditemukan. Silakan login kembali.');
    }
  }

  Future<void> _fetchPerjalanan() async {
    if (_userId == null) {
      _showError('Pengguna tidak ditemukan. Silakan login kembali.');
      return;
    }

    try {
      final response = await ApiService.getPerjalanan(_userId!);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _perjalananList = data['data'];
          });
        } else {
          _showError(data['message']);
        }
      } else {
        _showError('Gagal mengambil data perjalanan');
      }
    } catch (e) {
      _showError('Terjadi kesalahan: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Perjalanan'),
      ),
      body: _perjalananList.isEmpty
          ? Center(child: Text('Tidak ada data perjalanan'))
          : ListView.builder(
              itemCount: _perjalananList.length,
              itemBuilder: (context, index) {
                final perjalanan = _perjalananList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlassmorphismCard(
                    child: ListTile(
                      title: Text(
                          perjalanan['nama_lokasi'] ?? 'Lokasi tidak tersedia'),
                      subtitle: Text(
                          'Keberangkatan: ${perjalanan['waktu_keberangkatan'] ?? 'Tidak tersedia'}\nSampai: ${perjalanan['waktu_sampai'] ?? 'Tidak tersedia'}'),
                      isThreeLine: true,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class GlassmorphismCard extends StatelessWidget {
  final Widget child;

  const GlassmorphismCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }
}
