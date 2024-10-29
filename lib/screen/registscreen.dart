import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/koneksi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginscreen.dart';

class RegistScreen extends StatefulWidget {
  @override
  _RegistScreenState createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    final response = await ApiService.register(
      _nameController.text,
      _nikController.text,
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _isLoading = false;
    });

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}'); // Debug respons

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        if (data['success']) {
          _showSuccessDialog('Registrasi berhasil! Silakan login.');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          _showErrorDialog(data['message'] ?? 'Registrasi gagal.');
        }
      } catch (e) {
        _showErrorDialog('Invalid response format.');
      }
    } else {
      _showErrorDialog('Server error, please try again later.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registrasi Gagal'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Oke'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registrasi Berhasil'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Oke'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nikController,
              decoration: InputDecoration(
                labelText: 'NIK',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Kata Sandi',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    child: const Text('Daftar'),
                    onPressed: _register,
                  ),
          ],
        ),
      ),
    );
  }
}
