import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
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
      appBar: AppBar(
        title: Text('API SEBASTIAN', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 0, 4, 255),
      ),
      body: ListView.builder(
        itemCount: usersData == null ? 0 : usersData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "${usersData[index]["name"]}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
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
