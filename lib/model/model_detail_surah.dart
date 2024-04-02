class ModelDetailSurah {
  String? strArabic;
  String? strLatin;
  String? strArti;

  ModelDetailSurah(this.strArabic, this.strLatin, this.strArti);

  ModelDetailSurah.fromJson(Map<String, dynamic> json) {
    strArabic = json['arabic'];
    strLatin = json['latin'];
    strArti = json['translation'];
  }
}