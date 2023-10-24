import 'package:flutter/material.dart';
import 'package:test_flutter/repository/berita_repository.dart';

class DetailBeritaPage extends StatefulWidget {
  const DetailBeritaPage({super.key, required this.id});
  final String id;

  @override
  State<DetailBeritaPage> createState() => _DetailBeritaPageState();
}

class _DetailBeritaPageState extends State<DetailBeritaPage> {

  // menampung data yang di dapat dari api
  var detailBerita;

  var loading = true;
  BeritaRepository _beritaRepository = BeritaRepository();

  Future getDetail() async {
    final data = await _beritaRepository.getBeritaById(widget.id);
    setState(() {
      detailBerita = data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetail();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop(context);
                },
              ),
              title: Text(detailBerita.jdl_news),
            ),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        detailBerita.foto_news,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      detailBerita.jdl_news,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.calendar_month,
                              size: 20,
                            ),
                          ),
                          TextSpan(
                              text: detailBerita.post_on,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(detailBerita.ket_news, style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "SEO : ",
                    ),
                    Text(
                      detailBerita.judul_seo,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
