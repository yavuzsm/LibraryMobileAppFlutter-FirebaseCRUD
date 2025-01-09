import 'package:flutter/material.dart';
import '../Entity/Kitap.dart';
import '../repository/BookRepository.dart';

class KitapGuncellemeEkrani extends StatefulWidget {
  final Kitap kitap;
  
  KitapGuncellemeEkrani({required this.kitap});

  @override
  _KitapGuncellemeEkraniState createState() => _KitapGuncellemeEkraniState();
}

class _KitapGuncellemeEkraniState extends State<KitapGuncellemeEkrani> {
  final _kitapDeposu = KitapDeposu();
  late TextEditingController _baslikController;
  late TextEditingController _yazarController;
  late TextEditingController _stokAdediController;

  @override
  void initState() {
    super.initState();
    _baslikController = TextEditingController(text: widget.kitap.baslik);
    _yazarController = TextEditingController(text: widget.kitap.yazar);
    _stokAdediController = TextEditingController(text: widget.kitap.stokAdedi.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kitap Güncelle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _baslikController,
              decoration: InputDecoration(labelText: 'Kitap Başlığı'),
            ),
            TextField(
              controller: _yazarController,
              decoration: InputDecoration(labelText: 'Yazar'),
            ),
            TextField(
              controller: _stokAdediController,
              decoration: InputDecoration(labelText: 'Stok Adedi'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Güncelleme işlemi için kitap nesnesi oluşturuyoruz
                Kitap guncellenmisKitap = Kitap(
                  id: widget.kitap.id,
                  baslik: _baslikController.text,
                  yazar: _yazarController.text,
                  stokAdedi: int.parse(_stokAdediController.text),
                );

                // Güncellenmiş kitap nesnesini KitapDeposu'na gönderiyoruz
                await _kitapDeposu.kitapGuncelle(guncellenmisKitap);

                // Güncelleme işlemi bittikten sonra ekranı kapat
                Navigator.pop(context);
              },
              child: Text('Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}
