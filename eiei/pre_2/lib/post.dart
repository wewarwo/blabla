import 'package:flutter/material.dart';
import './comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import './post_model.dart';
//import './commentPage.dart';

postProvider f = postProvider();
List<Post> posts;

Future<void> getit(int userid) async {
    posts = await f.loadDatas("https://jsonplaceholder.typicode.com/users/${userid}/posts");
    return posts;
  }

class postWid extends StatelessWidget {
  final int id;
  postWid({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("BACK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FutureBuilder(
              future: getit(this.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return new Text('loading...');
                  default:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return createListView(context, snapshot);
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Post> values = snapshot.data;
    return new Expanded(
      child: new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${(values[index].id).toString()} : ${values[index].title}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Text(
                    values[index].body,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => comWid(id: values[index].id),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
