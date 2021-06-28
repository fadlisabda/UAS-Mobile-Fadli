import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginflutter/AdminPage.dart';
import 'package:loginflutter/CustomerPage.dart';

void main() => runApp(new MyApp());

String username='';

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login PHP My Admin',     
      home: new MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/AdminPage': (BuildContext context)=> new AdminPage(username: username,),
        '/CustomerPage': (BuildContext context)=> new CustomerPage(),
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

List<String> status=["admin","customer"];
String _status="admin";

TextEditingController user=new TextEditingController();
TextEditingController pass=new TextEditingController();

String msg='';

Future<List> _login() async {
  final response = await http.post("http://192.168.100.9/login_flutter/proses_login.php", body: {
    "username": user.text,
    "password": pass.text,
  });

  var datauser = json.decode(response.body);
  if(datauser.length==0){
    setState(() {
          msg="Login Fail";
        });
  }else{
    if(datauser[0]['status']=='admin'){
       Navigator.pushReplacementNamed(context, '/AdminPage');
    }else if(datauser[0]['status']=='customer'){
      Navigator.pushReplacementNamed(context, '/CustomerPage');
    }
    
    setState(() {
          username= datauser[0]['username'];
        });

  }

  return datauser;
}
  void pilihStatus(String value){
    setState(() {
      _status=value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Center(
                      child: new Image.asset(
                        "assets/logo.png",
                        height: 70.0,
                        width: 200.0,
                      ),
                    ),
                  ],
                ),
              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              Text("Username",style: TextStyle(fontSize: 18.0),),
              TextField(   
                controller: user,                
                decoration: InputDecoration(
                  hintText: 'Username'
                ),           
                ),
              Text("Password",style: TextStyle(fontSize: 18.0),),
              TextField(  
                controller: pass,  
                obscureText: true,                
                 decoration: InputDecoration(
                  hintText: 'Password'
                ),                
                ),
              
              Text("Status",style: TextStyle(fontSize: 18.0),), 
              new DropdownButton(
                onChanged: (String value){
                  pilihStatus(value);
                },
                value: _status,
                items:status.map((String value){
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(value),
                  );  
                }).toList(),
              ),

              // ignore: deprecated_member_use
              RaisedButton(
                child: Text("Login"),
                onPressed: (){
                  _login();
                },
              ),

              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)
             

            ],
          ),
        ),
      ),
    );
}
}