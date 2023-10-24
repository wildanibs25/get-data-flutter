import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_flutter/model/api_model.dart';
import 'package:test_flutter/model/berita_model.dart';
import 'package:test_flutter/model/detail_berita_model.dart';
import 'package:test_flutter/tools/constant.dart';

class BeritaRepository {

  Future getBerita() async {
    try {
      // get datanya
      final response = await http.get(Uri.parse('$baseURL/get_latest_news'));
      // petakan data api nya
      var apiData = API.fromJson(jsonDecode(response.body));
      // cek apakah kode http true atau tidak
      if(apiData.error == 200){
        // jika true maka akan memasukan data ke data iterable
        Iterable it = apiData.data;
        // kemudian mempetakan data berita
        List<Berita> berita = it.map((item) => Berita.fromJson(item)).toList();
        return berita;
      }else{
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getBeritaById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseURL/get_detail_news/$id'));
        // kemudian mempetakan data berita
        var berita = DetailBerita.fromJson(jsonDecode(response.body));
        return berita;
    } catch (e) {
      print(e.toString());
    }
  }
}