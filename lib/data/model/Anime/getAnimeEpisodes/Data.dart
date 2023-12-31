class Data {
  Data({
    this.malId,
    this.url,
    this.title,
    this.titleJapanese,
    this.titleRomanji,
    this.duration,
    this.aired,
    this.filler,
    this.recap,
    this.synopsis,
  });

  Data.fromJson(dynamic json) {
    malId = json['mal_id'];
    url = json['url'];
    title = json['title'];
    titleJapanese = json['title_japanese'];
    titleRomanji = json['title_romanji'];
    duration = json['duration'];
    aired = json['aired'];
    filler = json['filler'];
    recap = json['recap'];
    synopsis = json['synopsis'];
  }
  int? malId;
  String? url;
  String? title;
  String? titleJapanese;
  String? titleRomanji;
  int? duration;
  String? aired;
  bool? filler;
  bool? recap;
  String? synopsis;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mal_id'] = malId;
    map['url'] = url;
    map['title'] = title;
    map['title_japanese'] = titleJapanese;
    map['title_romanji'] = titleRomanji;
    map['duration'] = duration;
    map['aired'] = aired;
    map['filler'] = filler;
    map['recap'] = recap;
    map['synopsis'] = synopsis;
    return map;
  }
}
