class authUserModel {
  String? name;
  String? password;
  // String? phone;
  String? uId;
  String? email;

  bool? isEmailVerified;
  authUserModel({
    this.email,
    this.name,
    // this.phone,
    this.uId,
    this.isEmailVerified,
    this.password,
  });

  authUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    // phone = json['phone'];
    uId = json['uId'];
    password = json['password'];
    isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      // 'phone': phone,
      'password': password,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
    };
  }
}


// class LoginModel{
//   late bool status;
//    late String message;
//    userData? data;
//   LoginModel.FromJson(Map<String,dynamic>json){
//     status = json['status'];
//     message = json['message'];
//     // data = userData.FromJson(json['data']);
//     data = json['data']!=null?userData.FromJson(json['data']):null;
//   }

// }
// class userData{
//    dynamic  id;
//    String? name;
//    String? phone;
//    String? email;
//    String? image;
//    int? points;
//    int? credit;
//    String? token;
//   userData.FromJson(Map<String,dynamic>json){
//     id=json['id'];
//     name=json['name'];
//     email=json['email'];
//     phone=json['phone'];
//     image=json['image'];
//     points=json['points'];
//     credit=json['credit'];
//     token=json['token'];
//   }

// }




// class UserDataModel {
//   bool? status;
//   String? message;
//   Data? data;



//   UserDataModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ?  Data.fromJson(json['data']) : null;
//   }

// }

// class Data {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? image;
//   int? points;
//   int? credit;
//   String? token;



//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     image = json['image'];
//     points = json['points'];
//     credit = json['credit'];
//     token = json['token'];
//   }


// }
