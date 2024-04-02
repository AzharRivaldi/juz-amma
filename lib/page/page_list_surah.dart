import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart' as rootBundle;

import 'page_detail_surah.dart';

class PageListSurah extends StatefulWidget {
  const PageListSurah({super.key});

  @override
  State<PageListSurah> createState() => _PageListSurahState();
}

class _PageListSurahState extends State<PageListSurah> {

  //parameter
  TextEditingController searchController = TextEditingController();
  bool searchMode = false;
  List listDataSearch = [];
  List listData = [];

  //method get data assets
  void loadData() async {
    String jsonStr = await rootBundle.rootBundle.loadString('assets/list_surah/list_surah.json');
    var jsonData = jsonDecode(jsonStr);
    listDataSearch = jsonData;
    listData = jsonData;
    setState(() {});
  }

  //method query search listview
  void searchList(String query) {
    if (query.isEmpty) {
      listDataSearch = listData;
      setState(() {});
      return;
    }

    query = query.toLowerCase();
    List resultData = [];
    listDataSearch.forEach((p) {
      var strNamaSurah = p['nama'].toString().toLowerCase();
      var strArtiSurah = p['arti'].toString().toLowerCase();
      var strNoSurah = p['nomor'].toString().toLowerCase();
      if (strNamaSurah.contains(query) ||
          strArtiSurah.contains(query) ||
          strNoSurah.contains(query)) {
        resultData.add(p);
      }
    });

    listDataSearch = resultData;
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: !searchMode
            ? const Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/ic_logo.png'),
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Juz Amma",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ],
              )
            : TextField(
                controller: searchController,
                onChanged: searchList,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        searchController.text = "";
                        searchList(searchController.text);
                      },
                    ),
                    hintText: "Search...",
                    hintStyle: const TextStyle(color: Colors.grey),
                ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              searchMode ? Icons.close : Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                if (!searchMode) {
                  searchMode = true;
                } else {
                  searchMode = false;
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          listDataSearch.isEmpty
              ? const Center(
                  child: Text("Ups, tidak ada data!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
              : listViewData(listDataSearch),
        ],
      ),
    );
  }

  //method list data
  listViewData(itemData) {
    return Expanded(
      child: ListView.builder(
          itemCount: itemData.length,
          itemBuilder: (context, index) {
            var items = itemData[index];
            return GestureDetector(
              onTap: () {
                String strId = items['nomor'].toString();
                String strSurah = items['nama'].toString();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageDetailSurah(
                        strId: strId, strSurah: strSurah)));
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                elevation: 5,
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SvgPicture.asset(
                              'assets/images/no.svg',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            child: Text(items['nomor'].toString(),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              items['nama'].toString(),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text('${items['arti']} • ${items['ayat'].toString()} ayat',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        items['asma'].toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
