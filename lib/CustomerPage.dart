import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Detail.dart';

void main() {
  runApp(new MaterialApp(
    title: "Daftar Customer",
    home: new CustomerPage(),
  ));
}

class CustomerPage extends StatefulWidget {
  @override
  _CustomerPageState createState() => new _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  Future<List> getData() async {
    final response = await http.get("http://192.168.100.9/login_flutter/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Daftar Customer"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.exit_to_app),
        onPressed: (){
          Navigator.pushReplacementNamed(context,'/MyHomePage');
        },
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new Detail(list:list , index: i,)
              )
            ),
            child: new Card(

              child: new ListTile(
                title: new Text(list[i]['username']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("Status : ${list[i]['status']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}