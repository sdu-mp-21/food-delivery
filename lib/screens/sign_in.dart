import 'package:delivery_app/screens/sign_in.dart';
import 'package:flutter/material.dart';

void main() => runApp(const SignIn());

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}
class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Positioned(
            child: Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
            ),
          ),
             Positioned(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: double.infinity,
                  )
                ), 
        Container(
          width:size.width,
          child: Column(
            children: <Widget>[
               Container(
           width: size.width*0.8,
           child:TextFormField(
             decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                    width: 1,
                    color: Colors.red
                  ),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Email",
              fillColor: Colors.white70),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the email';
              }
              return null;
            },
          ),),
           SizedBox(height: size.height * 0.02),  
           Container(width: size.width*0.8,
           child:TextFormField(
             decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                    width: 1,
                    color: Colors.red
                  ),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Password",
              fillColor: Colors.white70),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the password';
              }
              return null;
            },
          ),),
            ],
          ),
        ),
            SizedBox(height: size.height * 0.02),  
          Container(
            width: size.width,
            child:Column(children: <Widget>[
              Container(
                 width: size.width*0.5,
                 child:  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: OutlinedButton(
                  onPressed: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignIn();
                        },
                      ),
                  );  
                  }, 
                  child: Text('Sign up',
                  style: TextStyle(color: Colors.white),),
                  style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(
                    width: 1,
                    color: Colors.red
                  ),
                   backgroundColor: Colors.red
                )
                ),
              ),
              ),
               Text("Do you have not an account?",   style: TextStyle(height: 5, fontSize: 10),), 
              SizedBox(height: size.height * 0.01), 
                Container(
                 width: size.width*0.5,
                 child:  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: OutlinedButton(
                  onPressed: (){
                    
                  }, 
                  child: Text('Sign up',
                  style: TextStyle(color: Colors.white),),
                  style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(
                    width: 1,
                    color: Colors.blue
                  ),
                  backgroundColor: Colors.blue
                )
                ),
              ),
              ),
            ],),
          ),
               SizedBox(height: size.height * 0.03), 
        ],
      ),
    );
  }
}