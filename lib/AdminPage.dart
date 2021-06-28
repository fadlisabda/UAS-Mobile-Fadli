import 'package:flutter/material.dart';
import 'adddata.dart';

class AdminPage extends StatelessWidget {

AdminPage({this.username});
final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Admin"),),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: ()=>Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context)=> new AddData(),
          )
        ),
      ),
      body: Column(
        children: <Widget>[
          Text('Hallo $username', style: TextStyle(fontSize: 20.0),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new Image.asset(
                  "assets/admin.jpg",
                  height: 200.0,
                  width: 200.0,
                ),
              ),
            ],
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            child: Text("LogOUt"),
            onPressed: (){
              Navigator.pushReplacementNamed(context,'/MyHomePage');
            },
          ),
        ],
      ),
    );
  }
}