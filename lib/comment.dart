class Comment {
  String? comment;
  String? date;
  int? rate;
  String? userID;

  Comment(comment, date, rate, userID) {
    this.comment = comment;
    this.date = date;
    this.rate = rate;
    this.userID = userID;
  }

  Map<String, dynamic> toMap() {
    return {"comment": comment, "data": date, "rate": rate, "userID": userID};
  }
}
