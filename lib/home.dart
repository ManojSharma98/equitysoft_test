
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userEmail = '';
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    getuserEmail();
  }

  void getuserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = await prefs.getString('email');
    print(userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Homepage",
          ),
        ),
        body: body());
  }

  Widget body() {
    var _usersStream = FirebaseFirestore.instance.collection('Users').doc('m@gmail.com').collection('outfits').snapshots() ;
    return StreamBuilder(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return Text('${snapshot.data!.docs.}');

      },
    );
  }
}
