import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  // 1. Veri Ekleme (Create)
  Future<void> veriEkle({
    required String collectionPath,
    required String documentId, // docId yerine documentId kullanalım
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).set(data);
      print('Veri başarıyla eklendi!');
    } catch (e) {
      print('Veri ekleme hatası: $e');
    }
  }

  // 2. Belge Okuma (Read)
  Future<Map<String, dynamic>?> veriOku({
    required String collectionPath,
    required String documentId,
  }) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Veri okuma hatası: $e');
    }
    return null;
  }


  // 3. Koleksiyon Belgelerini Okuma (List Read)
  Future<List<Map<String, dynamic>>> veriListesiOku({
    required String collectionPath,
  }) async {
    try {
      final querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Veri listesi okuma hatası: $e');
      return [];
    }
  }

  // 4. Veri Güncelleme (Update)
  Future<void> veriGuncelle({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
      print('Veri başarıyla güncellendi!');
    } catch (e) {
      print('Veri güncelleme hatası: $e');
    }
  }

  // 5. Veri Silme (Delete)
  Future<void> veriSil({
    required String collectionPath,
    required String documentId, // docId yerine documentId kullanalım
  }) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
      print('Veri başarıyla silindi!');
    } catch (e) {
      print('Veri silme hatası: $e');
    }
  }
}
