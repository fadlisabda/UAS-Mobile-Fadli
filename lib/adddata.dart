import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {


TextEditingController controllerUsername = new TextEditingController();
TextEditingController controllerPassword = new TextEditingController();
TextEditingController controllerStatus = new TextEditingController();

void addData(){
  var url="http://192.168.100.9/login_flutter/adddata.php";

  http.post(url, body: {
    "username": controllerUsername.text,
    "password": controllerPassword.text,
    "status": controllerStatus.text
  });
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ADD DATA"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerUsername,
                  decoration: new InputDecoration(
                      hintText: "Username", labelText: "Username"),
                ),
                new TextField(
                  controller: controllerPassword,
                  decoration: new InputDecoration(
                      hintText: "Password", labelText: "Password"),
                ),
                new TextField(
                  controller: controllerStatus,
                  decoration: new InputDecoration(
                      hintText: "Status", labelText: "Status"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                // ignore: deprecated_member_use
                new RaisedButton(
                  child: new Text("ADD DATA"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    addData();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}