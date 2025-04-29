class User {
  int? userId;
  String? userFullname;
  String? userName;
  String? userPassword;
  String? userImage;

  User(
      {this.userId,
      this.userFullname,
      this.userName,
      this.userPassword,
      this.userImage});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userFullname = json['userFullname'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userImage = json['userImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userFullname'] = this.userFullname;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userImage'] = this.userImage;
    return data;
  }
}
