class DetailBerita {
  final String id;
  final String jdl_news;
  final String post_on;
  final String foto_news;
  final String judul_seo;
  final String ket_news;
  final String message;
  final int error;

  const DetailBerita({
    required this.id,
    required this.jdl_news,
    required this.post_on,
    required this.foto_news,
    required this.judul_seo,
    required this.ket_news,
    required this.message,
    required this.error,
  });

  factory DetailBerita.fromJson(Map<String, dynamic> json) {
    return DetailBerita(
      id: json['id'] as String,
      jdl_news: json['jdl_news'] as String,
      post_on: json['post_on'] as String,
      foto_news: json['foto_news'] as String,
      judul_seo: json['judul_seo'] as String,
      ket_news: json['ket_news'] as String,
      message: json['message'] as String,
      error: json['error'] as int,
    );
  }
}