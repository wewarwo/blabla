class Album {
  final int userid;
  final int id;
  final String title;

  Album({this.userid, this.id, this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
      return Album(
      userid: json['userId'],
      id: json['id'],
      title: json['title']
    );
  }
}