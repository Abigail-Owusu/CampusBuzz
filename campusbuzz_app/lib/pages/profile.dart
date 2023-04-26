import 'package:flutter/material.dart';
import 'package:campusbuzz_app/my_app_bar.dart';
import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/profile.dart';
import 'package:campusbuzz_app/pages/user_info_form.dart';
import 'package:campusbuzz_app/pages/login.dart';



class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 212, 130, 34),
        title: Text('Sign Up',
        style: TextStyle(
          fontSize: 25
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLoginPage()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Text('Welcome to your Buzz Profile!🤌🏽',
                  style: TextStyle(fontSize: 30,color: Color.fromARGB(255, 212, 130, 34))),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/profile.jpg'),
                ),
              ),
            ),
            Center(
              child: Container(
                  height: 550,
                  width: 550,
                  margin: EdgeInsets.only(top: 100),
                  child: UserInfoForm()),

            ),
            
          ],
        ),
      ),
    );
  }
}
