/// mal_id : 0
/// type : "string"
/// name : "string"
/// url : "string"

class Demographics {
  Demographics({
      num? malId, 
      String? type, 
      String? name, 
      String? url,}){
    _malId = malId;
    _type = type;
    _name = name;
    _url = url;
}

  Demographics.fromJson(dynamic json) {
    _malId = json['mal_id'];
    _type = json['type'];
    _name = json['name'];
    _url = json['url'];
  }
  num? _malId;
  String? _type;
  String? _name;
  String? _url;
Demographics copyWith({  num? malId,
  String? type,
  String? name,
  String? url,
}) => Demographics(  malId: malId ?? _malId,
  type: type ?? _type,
  name: name ?? _name,
  url: url ?? _url,
);
  num? get malId => _malId;
  String? get type => _type;
  String? get name => _name;
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mal_id'] = _malId;
    map['type'] = _type;
    map['name'] = _name;
    map['url'] = _url;
    return map;
  }

}