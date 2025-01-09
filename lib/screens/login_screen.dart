import 'package:flutter/material.dart';
import '../services/AuthService.dart'; // AuthService yolunu doğru belirleyin
import 'Librarianscreen.dart';
import 'RegisterPage.dart'; // Kayıt ekranını ekliyoruz

class GirisEkrani extends StatelessWidget {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _emailIleGiris(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    final user = await _authService.loginWithEmail(email, password);
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KutuphaneEkrani()),
      );
    } else {
      _hataGoster(context, 'Giriş başarısız. Lütfen bilgilerinizi kontrol edin.');
    }
  }

  Future<void> _googleIleGiris(BuildContext context) async {
    final user = await _authService.googleIleGiris();
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KutuphaneEkrani()),
      );
    } else {
      _hataGoster(context, 'Google ile giriş başarısız.');
    }
  }

  void _hataGoster(BuildContext context, String mesaj) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hata'),
        content: Text(mesaj),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giriş Ekranı')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _emailIleGiris(context),
              child: Text('E-posta ile Giriş'),
            ),
            ElevatedButton(
              onPressed: () => _googleIleGiris(context),
              child: Text('Google ile Giriş'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KayitEkrani()),
                );
              },
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
