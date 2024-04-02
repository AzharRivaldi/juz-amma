import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:juz_amma/model/model_detail_surah.dart';
import 'package:flutter/services.dart' as rootBundle;

class PageDetailSurah extends StatefulWidget {
  final String strId, strSurah;

  const PageDetailSurah({super.key, required this.strId, required this.strSurah});

  @override
  State<PageDetailSurah> createState() => _PageDetailSurahState();
}

class _PageDetailSurahState extends State<PageDetailSurah> {

  //parameter
  late String strId, strSurah;
  List listData = [];

  @override
  initState() {
    strId = widget.strId;
    strSurah = widget.strSurah;
    readJsonData();
    super.initState();
  }

  //method get data assets by id
  Future<List<ModelDetailSurah>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/detail_surah/surah$strId.json');
    listData = (jsonDecode(jsonData))['data']['ayat'];
    return listData.map((e) => ModelDetailSurah.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Surah $strSurah",
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black
            ),
          ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْم",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            ),
            const Text(
              "Dengan menyebut nama Allah Yang Maha Pemurah lagi Maha Penyayang.",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontStyle: FontStyle.italic
              ),
            ),
            FutureBuilder(
              future: readJsonData(),
              builder: (context, data) {
                if (data.hasError) {
                  return Center(child: Text("${data.error}"));
                } else if (data.hasData) {
                  var items = data.data as List<ModelDetailSurah>;
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: const BoxDecoration(
                                      color: Colors.purple,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        (index + 1).toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    items[index].strArabic.toString(),
                                    style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    items[index].strLatin.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.purple,
                                        fontStyle: FontStyle.italic
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    items[index].strArti.toString(),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
