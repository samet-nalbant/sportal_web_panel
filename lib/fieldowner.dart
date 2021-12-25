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
  bool type = true;
  List<bool> days = [true, true, true, true, true, true, true];
  String? properties;

  FieldOwner(this.mail, this.password);

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

  void setDay(int day) {
    days[day] = false;
  }

  void setCost(String cost) {
    this.cost = cost;
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
      'days': days
    };
  }
}
