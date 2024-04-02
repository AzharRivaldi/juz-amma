class ModelListSurah {
  int? strJmlAyat;
  String? strNoSurah;
  String? strNamaSurah;
  String? strArtiSurah;
  String? strNoUrut;
  String? strTypeSurah;
  String? strAsmaSurah;

  ModelListSurah(this.strJmlAyat, this.strNoSurah, this.strNamaSurah,
      this.strArtiSurah, this.strNoUrut, this.strTypeSurah, this.strAsmaSurah);

  ModelListSurah.fromJson(Map<String, dynamic> json) {
    strJmlAyat = json['ayat'];
    strNoSurah = json['nomor'];
    strNamaSurah = json['nama'];
    strArtiSurah = json['arti'];
    strNoUrut = json['urut'];
    strTypeSurah = json['type'];
    strAsmaSurah = json['asma'];
  }
}