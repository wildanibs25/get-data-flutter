import 'package:flutter/material.dart';
import 'package:test_flutter/model/berita_model.dart';
import 'package:test_flutter/page/detail_berita_page.dart';
import 'package:test_flutter/repository/berita_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // pamggil class repositori
  BeritaRepository _beritaRepository = BeritaRepository();

  // menampung data yang di dapat dari api
  List<Berita> dataBerita = [];

  // membuat penampung data yang akan di tampilkan
  List<Berita> berita = [];

  // deklarasi controllernya
  // digunakan untuk menyimpan state dari form
  final _searchController = TextEditingController();

  // membuat fungsi untuk menampung data
  // future berfungsi pengembalian yang harus menunggu
  Future getData() async {
    final data = await _beritaRepository.getBerita();
    setState(() {
      dataBerita = data;
      berita = data;
    });
  }

  onSearch(String text) {
    if (text != "") {
      final search = text.toLowerCase();
      final data = dataBerita.where((item) {
        var title = item.jdl_news.toLowerCase();
        return title.contains(search);
      }).toList();

      setState(() {
        berita = data;
      });
    } else {
      setState(() {
        berita = dataBerita;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        toolbarHeight: 100,
        title: Text(
          "Home",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await getData();
          _searchController.text = '';
        },
        child: Column(
          children: [
            //========= form Search
            Container(
              margin: EdgeInsets.only(
                right: 15,
                left: 15,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 3,
                    spreadRadius: 1,
                  )
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: false,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: " Cari Berita",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      // supaya tidak focus lagi ke TextField saat pencarian
                      FocusManager.instance.primaryFocus?.unfocus();
                      // memanggil fungsi onsearch
                      onSearch(_searchController.text);
                    },
                  ),
                ),
              ),
            ),
            //========= List data
            Expanded(
              child: ListView.builder(
                itemCount: berita.length,
                itemBuilder: (context, key) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailBeritaPage(id: berita[key].id)));
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.only(
                        left: 5,
                        bottom: 5,
                        top: 5,
                        right: 10,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              berita[key].foto_news,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.50),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    berita[key].jdl_news,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    berita[key].post_on,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
