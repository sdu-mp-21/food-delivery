import 'package:delivery_app/screens/forgot_password.dart';
import 'package:delivery_app/screens/sign_up.dart';
import 'package:delivery_app/screens/user_profile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:delivery_app/components/header_widget.dart';
import 'package:delivery_app/components/theme_helper.dart';
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
                                decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your username'),
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextField(
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
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
                                  //After successful login we will redirect to profile page. Let's create profile page now
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserProfile()));
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
}