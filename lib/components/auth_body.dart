import 'package:delivery_app/screens/sign_in.dart';
import 'package:delivery_app/screens/sign_up.dart';
import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget{
  @override
   Widget build(BuildContext context) {

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: ClipOval(
                child: Icon(Icons.android_outlined, size: 128,), //put your logo here
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2.0,
                  offset: Offset(5.0, 3.0),
                  spreadRadius: 2.0,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
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
          SizedBox(height: size.height * 0.03),  
          Positioned(
            child: Text('Food delivery app',
            style: TextStyle(color: Colors.white),
            ),
          ),
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
                SizedBox(height: size.height * 0.06),
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
