import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_3/pages/homepage.pages.dart';
import 'package:task_3/pages/login.pages.dart';
import 'package:task_3/pages/sign_up.pages.dart';
import 'package:task_3/services/preferences.services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var finalEmail;

  Future getData() async {
    var obtainedemail = PrefrencesService.prefs?.getString("user");
    setState(() {
      finalEmail = obtainedemail;
    });
    print(finalEmail);
  }

  // @override
  // void initState() {
  //   getData().whenComplete(() async {
  //     Timer(Duration(seconds: 7),
  //             () =>
  //             Navigator.pushReplacement(context,
  //                 MaterialPageRoute(builder:
  //                     (context) {
  //                   return finalEmail == null ? LoginPage() : HomePageScreen();
  //                 }))
  //     );
  //   });
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/background.png"),
                        fit: BoxFit.cover)),
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 180, 10, 20),
                    child: Center(
                      child: ListView(children: [
                        Center(
                          child: Text(
                            "Daily Recipe",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 50),
                        Center(
                          child: Text("Cooking Done The Easy Way",
                              style: TextStyle(
                                color: Colors.white,)
                          ),
                        ),
                        SizedBox(height: 200,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                          child: ElevatedButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => SignUpPage()));
                          }, child: Text("Register", style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(primary: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 40, 20),
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        }, child: Text("Sign In", style: TextStyle(color: Colors.white)))
                      ]),
                    )))));
  }
}
