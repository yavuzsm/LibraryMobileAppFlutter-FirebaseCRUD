class Ogrenci {
  final String id;
  final String ad;
  final String soyad;
  final String email;
  final String telefon;
  final String dersId;

  Ogrenci({
    required this.id,
    required this.ad,
    required this.soyad,
    required this.email,
    required this.telefon,
    required this.dersId,
  });

  Map<String, dynamic> toMap() {
    return {
      'ad': ad,
      'soyad': soyad,
      'email': email,
      'telefon': telefon,
      'dersId': dersId,
    };
  }

  factory Ogrenci.fromMap(String id, Map<String, dynamic> data) {
    return Ogrenci(
      id: id,
      ad: data['ad'] ?? '',
      soyad: data['soyad'] ?? '',
      email: data['email'] ?? '',
      telefon: data['telefon'] ?? '',
      dersId: data['dersId'] ?? '',
    );
  }
}
