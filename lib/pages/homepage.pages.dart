import 'package:flutter/material.dart';
import 'package:task_3/pages/login.pages.dart';
import 'package:task_3/services/preferences.services.dart';

class HomePageScreen extends StatefulWidget {


  HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Homepage",),
        actions: [
          PopupMenuButton<int>(onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0,
                child: Text("Logout"))
          ])
        ],

      ),
      body: Center(
          child: Text("Welcome to Homepage", style: TextStyle(fontSize: 30))),
    );
  }

  onSelected(BuildContext context, int item) {
    switch (item){
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
        PrefrencesService.prefs?.remove("user");
        PrefrencesService.prefs?.remove("password");
        break;
    }
  }

}
