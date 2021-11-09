import 'package:delivery_app/components/auth_background.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/screens/sign_in.dart';
import 'package:delivery_app/screens/sign_up.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: double.infinity,
        color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[ 
          SizedBox(height: size.height * 0.01),  
          Container(
              width: size.width,
              alignment: Alignment.bottomCenter,
              child: Column(
              children:<Widget>[
                 Positioned(
                  child: Image.asset(
                    'assets/images/basket.png',
                    width: double.infinity,
                  )
                ),
                SizedBox(height: size.height * 0.03),
                Text(
                  "WELCOME, FRIEND!",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, color: Colors.white)
                ),
                SizedBox(height: size.height * 0.03),
               Container(
                 width: size.width*0.8,
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
                  child: Text('Sign in',
                  style: TextStyle(color: Colors.white),),
                  style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(
                    width: 1,
                    color: Colors.white
                  ),
                )
                ),
              ),
              ),
               SizedBox(height: size.height * 0.02),
             Container(
                 width: size.width*0.8,
                 child:  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: OutlinedButton(
                  onPressed: (){
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUp();
                        },
                      ),
                  );  
                  }, 
                  child: Text('Sign up',
                  style: TextStyle(color: Colors.white),
                  ),
                  style: OutlinedButton.styleFrom(
                  shape: StadiumBorder(),
                  side: BorderSide(
                    width: 1,
                    color: Colors.white
                  ),
                )
                ),
              ),
              ),
                SizedBox(height: size.height * 0.08),
              ])
            ),
        ],
        
      ),
    );
  }
}
