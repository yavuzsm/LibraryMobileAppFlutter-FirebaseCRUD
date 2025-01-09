import 'package:cloud_firestore/cloud_firestore.dart';
import '../Entity/Kitap.dart';

class KitapDeposu {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> kitapEkle(Kitap kitap) async {
    await _firestore.collection('kitaplar').add(kitap.toMap());
  }

  Future<void> kitapGuncelle(Kitap kitap) async {
    await _firestore.collection('kitaplar').doc(kitap.id).update(kitap.toMap());
  }

  Future<void> kitapSil(String kitapId) async {
    await _firestore.collection('kitaplar').doc(kitapId).delete();
  }

  Stream<List<Kitap>> kitaplariGetir() {
    return _firestore.collection('kitaplar').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Kitap.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
    });
  }
}
