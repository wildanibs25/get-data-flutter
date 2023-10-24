class Berita {
  final String id;
  final String jdl_news;
  final String post_on;
  final String foto_news;
  final String judul_seo;

  const Berita({
    required this.id,
    required this.jdl_news,
    required this.post_on,
    required this.foto_news,
    required this.judul_seo,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      id: json['id'] as String,
      jdl_news: json['jdl_news'] as String,
      post_on: json['post_on'] as String,
      foto_news: json['foto_news'] as String,
      judul_seo: json['judul_seo'] as String,
    );
  }
}