class API {
  final String kategori;
  final String message;
  final int error;
  final dynamic data;

  const API({
    required this.kategori,
    required this.message,
    required this.error,
    required this.data,
  });

  factory API.fromJson(Map<String, dynamic> json) {
    return API(
      kategori: json['kategori'] as String,
      message: json['message'] as String,
      error: json['error'] as int,
      data: json['data'] as dynamic,
    );
  }
}