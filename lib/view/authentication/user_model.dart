// class UserModel{
//   String? name;
//   String? email;
//   String? password;
//   String? pic;
//   String? id ;

//   UserModel({
//      this.name,
//      this.email,
//      this.password,
//      this.pic,
//      this.id,
//   });



//   Map<String, dynamic> toMap() {
//     return {
//       'name': this.name,
//       'email': this.email,
//       'password': this.password,
//       'pic': this.pic,
//       'id': this.id,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//   return UserModel(
//     name: map['name'] as String? ?? '',        // Fallback to an empty string
//     email: map['email'] as String? ?? '',
//     password: map['password'] as String? ?? '',
//     pic: map['pic'] as String? ?? '',
//     id: map['id'] as String? ?? '',
//   );
// }


// }
class UserModel {
  String? id;
  String? name;
  String? password;
  String? email;
  String? pic;
  List<String>? following; // Users the current user is following
  List<String>? followers; // Users following the current user

  UserModel({
    this.id,
    this.name,
    this.password,
    this.email,
    this.pic,
    this.following,
    this.followers,
  });

  // Convert Firestore document to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      password: map['password'],
      email: map['email'],
      pic: map['pic'],
      following: List<String>.from(map['following'] ?? []),
      followers: List<String>.from(map['followers'] ?? []),
    );
  }

  // Convert UserModel to Firestore document
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'pic': pic,
      'following': following ?? [],
      'followers': followers ?? [],
    };
  }
}

