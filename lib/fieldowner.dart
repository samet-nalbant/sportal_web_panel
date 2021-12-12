class FieldOwner {
  String? name;
  String? phoneNumber;
  String? password;
  String? mail;
  String? adress;
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

  void setAdress(String adress) {
    this.adress = adress;
  }

  void setProperties(String properties) {
    this.properties = properties;
  }

  void setDay(int day) {
    days[day] = false;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phoneNumber,
      'mail': mail,
      'adress': adress,
      'type': type,
      'properties': properties,
      'days': days
    };
  }
}
