import 'package:flutter/foundation.dart';

class Post {
  final String title;
  final String imageurl;
  final String userId;

  Post({@required this.title, @required this.imageurl, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'imageurl': imageurl,
    };
  }

 static Post fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    } else {
      return Post(
        title: map['title'],
        imageurl: map['imageUrl'],
        userId: map['userId'],
      );
    }
  }
}
