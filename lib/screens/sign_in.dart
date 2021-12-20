import 'dart:convert';

import 'package:delivery_app/screens/forgot_password.dart';
import 'package:delivery_app/screens/sign_up.dart';
import 'package:delivery_app/screens/user_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/components/header_widget.dart';
import 'package:delivery_app/components/theme_helper.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const SignIn());

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<SignIn> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  //final LocalStorage storage = new LocalStorage('token');

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), 
            ),
            SafeArea(
              child: Container( 
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Column(
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Signin into your account',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextField(
                                controller: usernameController,
                                decoration: ThemeHelper().textInputDecoration('Username', 'Enter your username'),
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              else if(val.length<8){
                                return "Password should contain at least 8 characters";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                 Navigator.push( context, MaterialPageRoute( builder: (context) => const ForgotPassword()), );
                                },
                                child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                            
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                  login();
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future <void> login() async {
    if(passwordController.text.isNotEmpty && usernameController.text.isNotEmpty){

     var response =  await http.post(
          Uri.parse("http://thawing-taiga-45359.herokuapp.com/api/token-auth/"),
          headers: { 
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Access-Control-Allow-Origin': '*'
          }, 
          body: jsonEncode({
            "username":usernameController.text,
            "password":passwordController.text
          })
      );
      if(response.statusCode==200){
     //   storage.setItem('token', response.toJSONEncodable());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserProfile()));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid username or password")
        ));
      }
    }  
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Empty username or password is not allowed!")
      ));
    }   
  }

}