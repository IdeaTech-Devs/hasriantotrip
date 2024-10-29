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
    _userId = prefs.getString('userId');
    if (_userId != null) {
      _fetchPerjalanan();
    }
  }

  Future<void> _fetchPerjalanan() async {
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
                return ListTile(
                  title: Text(perjalanan['nama_lokasi']),
                  subtitle: Text(
                      'Keberangkatan: ${perjalanan['waktu_keberangkatan']}\nSampai: ${perjalanan['waktu_sampai']}'),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}
