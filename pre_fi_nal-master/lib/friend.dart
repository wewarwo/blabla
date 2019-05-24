import 'package:final_01/file.dart';
import 'package:final_01/friend_detail.dart';
import 'package:final_01/friend_model.dart';
import 'package:final_01/login.dart';
import 'package:final_01/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

FriendProvider f = FriendProvider();
List<Friend> friends;

class myfriend extends StatefulWidget {
  @override
  _myfriendState createState() => _myfriendState();
}

class _myfriendState extends State<myfriend> {
  int _id;
  String _user;
  String _pass;
  String _name;
  String _age;
  String _quote;
  List<Friend> friend_list = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // @override
  // void initState() {
  //   super.initState();
  //   f.loadDatas("https://jsonplaceholder.typicode.com/users").then((r) {
  //     friends = r;
  //     print(friends);
  //   });
  // }
  Future<void> getit() async {
    friends = await f.loadDatas("https://jsonplaceholder.typicode.com/users");
    return friends;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        theme: ThemeData(primaryColor: Color(0xff9c27d0)),
        home: Scaffold(
          appBar: AppBar(
            title: Text("My Friends"),
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
                  future: getit(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return new Text('somthing gone wrong...');
                      case ConnectionState.waiting:
                        return new Text('wait...');
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
        ));
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Friend> values = snapshot.data;
    print("values = $values");
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
                    "${(values[index].id).toString()} : ${values[index].name}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Text(
                    values[index].email,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    values[index].phone,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    values[index].website,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => fdetail(id: values[index].id, name: values[index].name),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  // ···
}
