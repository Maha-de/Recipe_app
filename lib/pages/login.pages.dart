import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_3/pages/homepage.pages.dart';
import 'package:task_3/pages/sign_up.pages.dart';
import '../services/preferences.services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController userName;
  late TextEditingController password;

  late GlobalKey<FormState> formKey;
  bool obSecureText = true;


  void _setData (){
    setState(() {
      PrefrencesService.prefs?.setString("user", userName.text);
      PrefrencesService.prefs?.setString("password", password.text);

      if(userName.text.isNotEmpty && password.text.isNotEmpty) {
        PrefrencesService.prefs?.setBool("isloggedin", true);
        print("isloggedin");
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => HomePageScreen()));
      }else{
        PrefrencesService.prefs?.setBool("isloggedin", false);
        print("not logged in");
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => LoginPage()));

      }

    });
  }

  _retrieveValues() async {
    setState(() {
      userName.text = PrefrencesService.prefs?.getString('user') ?? "";
      password.text = PrefrencesService.prefs?.getString('password') ?? "";

    });
  }

  void toggleObSecure() {
    obSecureText = !obSecureText;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    password = TextEditingController();
    formKey = GlobalKey<FormState>();
    _retrieveValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/background.png"),
          fit: BoxFit.cover)
        ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 110, 10, 20),
            child: Center(
              child: ListView(
                children: [
                  Center(
                    child: Text("Daily Recipe", style: TextStyle(fontSize: 40,
                        color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 50),
                  Center(
                      child: Text("Sign In", style: TextStyle(fontSize: 20,
                          color: Colors.white, fontWeight: FontWeight.bold),)),
                  SizedBox(height: 40,),
                  TextFormField(
                    controller: userName,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.red),
                      prefixIcon: Icon(Icons.email_outlined, color: Colors.white),
                        labelText: "Email Address",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                  ),
                    style: TextStyle(fontSize: 15, color: Colors.white),

                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: password,
                    obscureText: obSecureText,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.red),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                        suffixIcon: InkWell(onTap: () => toggleObSecure(),
                            child: Icon(color: Colors.white,
                                obSecureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                    ),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'password is required';
                        }
                        if (value.length < 6) {
                          return 'password too short';
                        }
                        return null;
                      }
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(230, 10, 0, 20),
                    child: TextButton(onPressed: (){

                    }, child:
                    Text("Forgot Password?", textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.blue))),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 40, 20),
                    child: ElevatedButton (onPressed: () async {
                     if (formKey.currentState?.validate() ?? false) {
                       await PrefrencesService.prefs?.setBool('isLogin', true);
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) =>
                               HomePageScreen()));
                       // _setData();
                     }
                    }, child: Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.white),),
                      style: ElevatedButton.styleFrom(primary: Colors.deepOrange,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 100, 40, 10),
                    child: Row(children: [
                      Text("Don't have an account? ", style: TextStyle(color: Colors.white,),
                      textAlign: TextAlign.center,),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        userName.clear();
                        password.clear();
                      },
                          child: Text("Register", style: TextStyle(color: Colors.deepOrange)))
                    ],),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
