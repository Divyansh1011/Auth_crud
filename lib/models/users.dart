class User1 {
  final String id;
  final String fullName;
  final String email;
  final String userRole;

  User1({this.id, this.fullName, this.email, this.userRole});

  //To serializa the data in constructor
  User1.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'];


  //TO update in the firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullName,
      'email': email,
      'userRole': userRole,
    };
  }
}
