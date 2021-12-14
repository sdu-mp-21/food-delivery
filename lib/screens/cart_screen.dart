import 'package:delivery_app/screens/forgot_password.dart';
import 'package:delivery_app/screens/forgot_password_verification.dart';
import 'package:delivery_app/screens/home_screen.dart';
import 'package:delivery_app/screens/sign_in.dart';
import 'package:delivery_app/screens/sign_up.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Theme.of(context).primaryColor,
                    Theme.of(context).accentColor,
                  ])),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                Icon(Icons.shopping_cart),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                  child: Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [
                    0.0,
                    1.0
                  ],
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.2),
                    Theme.of(context).accentColor.withOpacity(0.5),
                  ])),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).accentColor,
                    ],
                  ),
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Food Delivery',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag_rounded,
                    size: _drawerIconSize, color: Colors.grey.shade800),
                title: Text(
                  'Food List',
                  style: TextStyle(
                      fontSize: _drawerFontSize, color: Colors.grey.shade800),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag_rounded,
                    size: _drawerIconSize, color: Colors.grey.shade800),
                title: Text(
                  'My Orders',
                  style: TextStyle(
                      fontSize: _drawerFontSize, color: Colors.grey.shade800),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.login_rounded,
                    size: _drawerIconSize, color: Colors.grey.shade800),
                title: Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize, color: Colors.grey.shade800),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add_alt_1,
                    size: _drawerIconSize, color: Colors.grey.shade800),
                title: Text(
                  'Registration Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize, color: Colors.grey.shade800),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.password_rounded,
                  size: _drawerIconSize,
                  color: Colors.grey.shade800,
                ),
                title: Text(
                  'Forgot Password Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize, color: Colors.grey.shade800),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.verified_user_sharp,
                  size: _drawerIconSize,
                  color: Colors.grey.shade800,
                ),
                title: Text(
                  'Verification Page',
                  style: TextStyle(
                      fontSize: _drawerFontSize, color: Colors.grey.shade800),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordVerification()),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout_rounded,
                  size: _drawerIconSize,
                  color: Colors.grey.shade800,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontSize: _drawerFontSize, color: Colors.grey.shade800),
                ),
                onTap: () {
                  // SystemNavigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Shopping cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, ind){
                  return Container(
                    width: MediaQuery.of(context).size.width-40,
                    height: 100,
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                              image: NetworkImage("https://rb.gy/ib6ugd"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.0,
                              child: Text(
                                "Food Title",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text(
                                    "1",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue[300],
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 15.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Text(
                                  "2500 T",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );


                },
              ),
            ),
            SizedBox(height:20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),

                ),

                Text(
                  "10000T",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),

                )
              ],
            ),

            SizedBox(height:15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Delivary charge",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),

                ),

                Text(
                  "50 T",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),

                )
              ],
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),

                ),

                Text(
                  "10500T",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),

                )
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: MaterialButton(
                onPressed: (){},
                color: Colors.deepOrange,
                  height: 50.0,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                child: Text(
                    "PROCEED TO CHECKOUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                )
              ),
            ),

            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
