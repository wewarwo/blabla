class Posts{
  final int userid;
  final int id;
  final String title;
  final String body;

  Posts({this.userid, this.id, this.title, this.body});

  factory Posts.fromJson(Map<String, dynamic> json) {
      return Posts(
      userid: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}