class Kitap {
  final String id;
  final String baslik;
  final String yazar;
  final int stokAdedi;

  Kitap({
    required this.id,
    required this.baslik,
    required this.yazar,
    required this.stokAdedi,
  });

  factory Kitap.fromMap(String id, Map<String, dynamic> data) {
    return Kitap(
      id: id,
      baslik: data['baslik'] ?? '',
      yazar: data['yazar'] ?? '',
      stokAdedi: data['stokAdedi'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'baslik': baslik,
      'yazar': yazar,
      'stokAdedi': stokAdedi,
    };
  }
}
