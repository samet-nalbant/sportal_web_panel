import 'dart:collection';
import 'dart:convert';

import 'package:flutter/services.dart';

class Dropdownlist {
  HashMap ilceler = HashMap<String, List<Ilce>>();
  HashMap mahalleler = HashMap<String, List<Mahalle>>();
  List<dynamic> illerListesi = [];
  List<Sehir> namesIl = [];
  List<Ilce> namesIlce = [];
  List<Mahalle> namesMahalle = [];

  Future<void> fillSehirs() async {
    String jsonString = await rootBundle.loadString("assets/adress/sehir.json");
    var list = json.decode(jsonString);
    illerListesi = list.map((x) => Sehir.fromJson(x)).toList();
    illerListesi.forEach((element) {
      namesIl.add(element);
    });
    print(namesIl.length);
  }

  Future<void> fillIlces() async {
    List<dynamic> _ilceListesi = [];
    String jsonString = await rootBundle.loadString("assets/adress/ilce.json");
    var list = json.decode(jsonString);
    _ilceListesi = list.map((x) => Ilce.fromJson(x)).toList();
    for (int i = 0; i < _ilceListesi.length; i++) {
      ilceler.putIfAbsent(_ilceListesi[i].ilce_sehirkey, () => <Ilce>[]);
      ilceler[_ilceListesi[i].ilce_sehirkey].add(_ilceListesi[i]);
    }
  }

  Future<void> fillMahalles() async {
    String jsonString =
        await rootBundle.loadString("assets/adress/mahalle.json");
    var list = json.decode(jsonString);
    List<dynamic> temp = list.map((x) => Mahalle.fromJson(x)).toList();
    for (int i = 0; i < temp.length; i++) {
      mahalleler.putIfAbsent(temp[i].mahalle_ilcekey, () => <Mahalle>[]);
      mahalleler[temp[i].mahalle_ilcekey].add(temp[i]);
    }
  }

  Future<void> getIlces(String ilce_sehirkey) async {
    namesIlce.clear();
    List<Ilce> temp = ilceler[ilce_sehirkey];
    for (var item in temp) {
      namesIlce.add(item);
    }
  }

  Future<void> getMahalles(String mahalle_ilcekey) async {
    namesMahalle.clear();
    List<Mahalle> temp = mahalleler[mahalle_ilcekey];
    for (var item in temp) {
      namesMahalle.add(item);
    }
  }
}

class Sehir {
  String sehir_id;
  String sehir_title;
  String sehir_key;

  Sehir.fromJson(Map json)
      : sehir_id = json["sehir_id"],
        sehir_title = json["sehir_title"],
        sehir_key = json["sehir_key"];

  Map toJson() {
    return {
      'sehir_id': sehir_id,
      'sehir_title': sehir_title,
      'sehir_key': sehir_key
    };
  }
}

class Ilce {
  String ilce_id;
  String ilce_title;
  String ilce_key;
  String ilce_sehirkey;
  Ilce.fromJson(Map json)
      : ilce_id = json["ilce_id"],
        ilce_title = json["ilce_title"],
        ilce_key = json["ilce_key"],
        ilce_sehirkey = json["ilce_sehirkey"];
  Map toJson() {
    return {
      'ilce_id': ilce_id,
      'ilce_title': ilce_title,
      'ilce_key': ilce_key,
      'ilce_sehirkey': ilce_sehirkey
    };
  }
}

class Mahalle {
  String mahalle_id;
  String mahalle_title;
  String mahalle_key;
  String mahalle_ilcekey;
  Mahalle.fromJson(Map json)
      : mahalle_id = json["mahalle_id"],
        mahalle_title = json["mahalle_title"],
        mahalle_key = json["mahalle_key"],
        mahalle_ilcekey = json["mahalle_ilcekey"];
  Map toJson() {
    return {
      'mahalle_id': mahalle_id,
      'mahalle_title': mahalle_title,
      'mahalle_key': mahalle_key,
      'mahalle_ilcekey': mahalle_ilcekey
    };
  }
}
