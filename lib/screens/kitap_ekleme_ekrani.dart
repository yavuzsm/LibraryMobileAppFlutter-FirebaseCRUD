import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KitapEklemeEkrani extends StatefulWidget {
  @override
  _KitapEklemeEkraniState createState() => _KitapEklemeEkraniState();
}

class _KitapEklemeEkraniState extends State<KitapEklemeEkrani> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _yazarController = TextEditingController();
  final TextEditingController _stokAdediController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Kitap ekleme işlemi burada yapılacak
  void _kitapEkle() async {
    String baslik = _baslikController.text;
    String yazar = _yazarController.text;
    int stokAdedi = int.parse(_stokAdediController.text);

    if (baslik.isEmpty || yazar.isEmpty || stokAdedi <= 0) {
      _hataGoster('Lütfen tüm alanları düzgün doldurun.');
      return;
    }

    try {
      // Kitap verilerini Firestore'a kaydetme
      await _firestore.collection('kitaplar').add({
        'baslik': baslik,
        'yazar': yazar,
        'stokAdedi': stokAdedi,
        'tarih': FieldValue.serverTimestamp(),  // Kitap eklenme tarihi
      });

      // Kitap başarıyla eklendiğinde kullanıcıya bilgi ver
      _hataGoster('Kitap başarıyla eklendi!');
      // Formu sıfırlayın
      _baslikController.clear();
      _yazarController.clear();
      _stokAdediController.clear();
    } catch (e) {
      _hataGoster('Kitap eklenirken bir hata oluştu. Tekrar deneyin.');
      print('Hata: $e');
    }
  }

  void _hataGoster(String mesaj) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Mesaj'),
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
      appBar: AppBar(
        title: Text('Kitap Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _baslikController,
                decoration: InputDecoration(labelText: 'Kitap Başlığı'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Başlık girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yazarController,
                decoration: InputDecoration(labelText: 'Yazar'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Yazar adı girin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stokAdediController,
                decoration: InputDecoration(labelText: 'Stok Adedi'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok adedi girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _kitapEkle();
                  }
                },
                child: Text('Kitap Ekle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
