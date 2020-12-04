class Response {
  String token;

  Response({this.token});

  factory Response.fromJson(dynamic json) {
    return Response(token: json['token']);
  }
}
