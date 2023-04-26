import 'package:flutter/material.dart';
import 'package:campusbuzz_app/my_app_bar.dart';
import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/profile.dart';

import 'package:campusbuzz_app/functions/function.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(right: 200),
              child: const Image(
                color: Colors.orange,
                image: AssetImage('images/campusbuzz_logo.png'),
                fit: BoxFit.contain,
                height: kToolbarHeight * 1.1,
              ),
            ),
            Center(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(left: 300),
                  child: Text(
                    'Hello Buzzer!',
                    style: TextStyle(fontSize: 20, color: Colors.orange),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 80, top: 10, bottom: 10),
            child: Container(
              width: 300,
              height: 100,
            ),
          ),
          Container()
        ],
      ),
      body: Container(
        color: Color.fromRGBO(128, 128, 128, 0.5),
        child: Center(
          child: loading
              ? CircularProgressIndicator(color: Colors.orange)
              : Container(
                  
                  height: 500,
                  width: 800,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 10,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(left: 100, bottom: 150),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('images/campusbuzz_logo.png'),
                                  alignment: Alignment(8, 8)),
                            ),
                          ),
                          SizedBox(width: 200),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(top: 100),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 100),
                                          child: Text(
                                            'Log In',
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Center(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 20, bottom: 50, left: 100),
                                          child: Text(
                                            'Welcome Back!',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.orange),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 80),
                                          child: TextFormField(
                                            controller: email,
                                            decoration: InputDecoration(
                                              labelText: "Email *",
                                              
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 40),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 80),
                                            child: TextFormField(
                                              controller: password,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                labelText: "Password *",
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 212, 130, 34)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 500, top: 30),
                            child: ElevatedButton(
                              onPressed: () async {
                                // code to be executed when the button is pressed
                                setState(() {
                                  loading = true;
                                });
                                await login(context, {
                                  "email": email.text,
                                  "password": password.text
                                });
                                password.clear();
                                setState(() {
                                  loading = false;
                                });
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 300, top: 10),
                              child: Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 325),
                              child: GestureDetector(
                                onTap: () {
                                  // navigate to the registration page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyProfilePage()),
                                  );
                                },
                                child: Text(
                                  'Click here to register',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.orange,
                                    fontSize: 14,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
