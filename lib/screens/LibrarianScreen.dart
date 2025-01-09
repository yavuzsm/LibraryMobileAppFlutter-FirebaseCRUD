import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Entity/Kitap.dart';
import '../repository/BookRepository.dart';
import '../screens/kitap_ekleme_ekrani.dart';
import '../screens/kitap_guncelleme_ekrani.dart';


class KutuphaneEkrani extends StatelessWidget {
  final KitapDeposu _kitapDeposu = KitapDeposu();

  Future<void> _cikisYap(BuildContext context) async {
    // Çıkış işlemi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kütüphane Paneli'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _cikisYap(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Üstte sabit olarak Kitap Başlığı, Yazar ve Stok Adedi
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Text('Kitap Başlığı', textAlign: TextAlign.center)),
                Expanded(child: Text('Yazar', textAlign: TextAlign.center)),
                Expanded(child: Text('Stok Adedi', textAlign: TextAlign.center)),
                Expanded(child: Text('İşlemler', textAlign: TextAlign.center)),
              ],
            ),
            SizedBox(height: 10),
            // Kitapları Firebase'den çek ve ekranda listele
            Expanded(
              child: StreamBuilder<List<Kitap>>(
                stream: _kitapDeposu.kitaplariGetir(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Bir hata oluştu.'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Kitap bulunamadı.'));
                  }

                  List<Kitap> kitaplar = snapshot.data!;

                  return ListView.builder(
                    itemCount: kitaplar.length,
                    itemBuilder: (context, index) {
                      Kitap kitap = kitaplar[index];

                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Kitap Başlığı
                              Expanded(
                                child: Text(
                                  kitap.baslik,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Yazar
                              Expanded(
                                child: Text(
                                  kitap.yazar,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Stok Adedi
                              Expanded(
                                child: Text(
                                  '${kitap.stokAdedi}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // İşlemler: Sil ve Güncelle butonları
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      // Kitap güncelleme ekranına yönlendir
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => KitapGuncellemeEkrani(kitap: kitap),
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      // Kitap silme işlemi
                                      _kitapDeposu.kitapSil(kitap.id);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Kitap ekleme ekranına yönlendirme
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KitapEklemeEkrani()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
