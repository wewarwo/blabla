import 'package:http/http.dart' as http;
import 'dart:convert';

class Post{
  final int userid;
  final int id;
  final String title;
  final String body;

  Post({this.userid, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
      return Post(
      userid: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

class postList {
  final List<Post> posts;
  postList({
    this.posts,
  });
  factory postList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = new List<Post>();
    posts = parsedJson.map((i) => Post.fromJson(i)).toList();
    
    return new postList(
      posts: posts,
    );
  }
}

class postProvider {
  Future<List<Post>> loadDatas(String url) async {
    http.Response resp = await http.get(url);
    final jresp = json.decode(resp.body);
    postList PostList = postList.fromJson(jresp);
    return PostList.posts;
  }
}