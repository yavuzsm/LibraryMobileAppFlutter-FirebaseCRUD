import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/AuthService.dart';

class KayitEkrani extends StatelessWidget {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _adController = TextEditingController();
  final TextEditingController _soyadController = TextEditingController();

  Future<void> _emailIleKayit(BuildContext context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String ad = _adController.text.trim();
    String soyad = _soyadController.text.trim();

    if (ad.isEmpty || soyad.isEmpty || email.isEmpty || password.isEmpty) {
      _hataGoster(context, 'Lütfen tüm alanları doldurun.');
      return;
    }

    final user = await _authService.registerWithEmail(email, password);
    if (user != null) {
      // Kullanıcı Firestore'a kaydediliyor
      await _firestore.collection('kutuphaneciler').doc(user.uid).set({
        'ad': ad,
        'soyad': soyad,
        'email': email,
      });
      Navigator.pop(context); // Başarılı kayıt sonrası giriş ekranına dön
    } else {
      _hataGoster(context, 'Kayıt başarısız. Lütfen bilgilerinizi kontrol edin.');
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
      appBar: AppBar(title: Text('Kayıt Ekranı')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _adController,
                decoration: InputDecoration(labelText: 'Ad'),
              ),
              TextField(
                controller: _soyadController,
                decoration: InputDecoration(labelText: 'Soyad'),
              ),
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
                onPressed: () => _emailIleKayit(context),
                child: Text('Kayıt Ol'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
