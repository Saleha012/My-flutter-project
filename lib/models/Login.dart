class Login {
  String ? email;
  String? password;
  Login({
       this.email,
     this.password,});

  Login.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }

}