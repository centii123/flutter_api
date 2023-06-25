import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3:true
      ),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List usersData = [];

  Future getUsers() async {
    var response =
        await http.get(Uri.http('api.escuelajs.co', '/api/v1/users'));
    var data = json.decode(response.body);
    setState(() {
      usersData = data;
    });

  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('API SEBASTIAN', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 24, 24, 24),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: usersData == null ? 0 : usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Color.fromARGB(255, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person, color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${usersData[index]["name"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
