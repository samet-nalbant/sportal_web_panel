import 'dart:html';

import 'package:sportal_web_panel/comment.dart';

class FieldOwner {
  String? name;
  String? phoneNumber;
  String? password;
  String? mail;
  String? il;
  String? ilce;
  String? mahalle;
  String? adress;
  String? cost;
  int favNum = 0;
  int commentNum = 0;
  int rate = 0;
  bool type = true;
  String? start, end;
  List<Comment> comments = [];
  String? properties;
  List<String> photos = [];

  FieldOwner(this.mail, this.password);

  Future<void> addPhoto(Uri url) async {
    print("added url\n" + url.toString());
    photos.add(url.toString());
  }

  void setName(String name) {
    this.name = name;
  }

  void setNum(String num) {
    phoneNumber = num;
  }

  void setAdress(String il, String ilce, String mahalle, String adress) {
    this.il = il;
    this.ilce = ilce;
    this.mahalle = mahalle;
    this.adress = adress;
  }

  void setProperties(String properties) {
    this.properties = properties;
  }

  void setCost(String cost) {
    this.cost = cost;
  }

  void setHours(String start, String end) {
    this.start = start;
    this.end = end;
  }

  Map<String, dynamic> toMap2() {
    return {"comments": comments};
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phoneNumber,
      'adress': adress,
      'mail': mail,
      'il': il,
      'ilce': ilce,
      'cost': cost,
      'mahalle': mahalle,
      'type': type,
      'properties': properties,
      'start': start,
      'end': end,
      'favNum': favNum,
      'commenNum': commentNum,
      'rate': rate,
      'photos': photos
    };
  }
}
