class Response {
  String token;
  User user;

  Response({this.token, this.user});

  factory Response.fromJson(dynamic json) {
    return Response(
      token: json['token'],
      user: User(
        id: json['user']['_id'],
        email: json['user']['email'],
        username: json['user']['username'],
        role: json['user']['role'],
      ),
    );
  }
  Map<String, dynamic> get details {
    Map<String, dynamic> userDetails = {
      "id": User().id,
      "username": User().username,
      "email": User().email,
      "role": User().role
    };
    return userDetails;
  }
}

class User {
  String id;
  String username;
  String email;
  int role;

  User({this.id, this.username, this.email, this.role});

  Map<String, dynamic> get details {
    Map<String, dynamic> userDetails = {
      "id": id,
      "username": username,
      "email": email,
      "role": role
    };
    return userDetails;
  }
}
