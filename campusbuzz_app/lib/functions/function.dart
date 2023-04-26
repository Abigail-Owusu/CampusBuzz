// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:html';
import 'package:campusbuzz_app/pages/view_profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campusbuzz_app/pages/login.dart';
import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/viewOtherUsers.dart';
import 'package:provider/provider.dart';
import 'package:campusbuzz_app/my_provider/providers.dart';

Future<void> login(BuildContext context, data) async {
  var url = Uri.https("ashesisocialapp.uc.r.appspot.com", "/login");
  var request = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  var response_body = jsonDecode(request.body);
  if (response_body["success"] == false) {
    showDialogBox(context, "Error", 'Incorrect email or password');
  }
  if (response_body["success"] == true) {
    Provider.of<MyProvider>(context, listen: false).user_email =
        response_body["email"];
    Provider.of<MyProvider>(context, listen: false).first_name =
        response_body["first_name"];
    Provider.of<MyProvider>(context, listen: false).last_name =
        response_body["last_name"];
    Provider.of<MyProvider>(context, listen: false).student_id =
        response_body["student_id"];

    Provider.of<MyProvider>(context, listen: false).DOB = response_body["DOB"];
    Provider.of<MyProvider>(context, listen: false).best_food =
        response_body["best_food"];

    Provider.of<MyProvider>(context, listen: false).best_movie =
        response_body["best_movie"];
    Provider.of<MyProvider>(context, listen: false).major =
        response_body["major"];
    Provider.of<MyProvider>(context, listen: false).campus_residence =
        response_body["campus_residence"];
    Provider.of<MyProvider>(context, listen: false).year_group =
        response_body["year_group"];
    Provider.of<MyProvider>(context, listen: false).gender =
        response_body["gender"];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyHomePage()),
    );
  } else {
    showDialogBox(context, "Error", 'Incorrect email or password');
  }
}

Future<void> update(BuildContext context, data) async {
  var url = Uri.https("ashesisocialapp.uc.r.appspot.com", "/profile");
  var request = await http.patch(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  var response_body = jsonDecode(request.body);
  if (request.statusCode == 200) {
    Provider.of<MyProvider>(context, listen: false).user_email =
        response_body["email"];
    Provider.of<MyProvider>(context, listen: false).first_name =
        response_body["first_name"];

    showDialogBox(context, "Success", 'Updated Succesfully');

    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const viewUserProfile()),
      );
    });
  } else {
    showDialogBox(context, "Error", 'Update Failed');
  }
}

// getting student logged in.
Future<Map<String, dynamic>> get_profile(String email) async {
  var url = Uri.https("ashesisocialapp.uc.r.appspot.com", "/profile")
      .replace(queryParameters: {"email": email});
  var request = await http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  print(request.body);
  if (request.statusCode == 200) {
    var profile_details = jsonDecode(request.body);
    
    return profile_details;
  } else {
    print('oops');
    return {};
  }
}

Future<List<dynamic>> getFeed() async {
  var url = Uri.https("ashesisocialapp.uc.r.appspot.com", "/feed");

  var request = await http.get(
    url,
    headers: {'Content-Type': 'application/json'},
  );

  print(request.body);
  var responseBody = jsonDecode(request.body);
  if (request.statusCode == 200) {
    return responseBody;
  }
  return ['works'];
}

Future<void> createPost(BuildContext context, String email, String post) async {
  var url = Uri.http("ashesisocialapp.uc.r.appspot.com", "/create_post");
  // var url = Uri.http("127.0.0.1:5000", "/create_post");
  var request = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({"email": email, "post": post}),
  );
  if (request.statusCode == 201) {
    print('post created');
  }
  print('error');
}

Future<void> profile(BuildContext context, data) async {
  var url = Uri.https("ashesisocialapp.uc.r.appspot.com", "/profile");
  var request = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  // print(request.statusCode);

  if (request.statusCode == 201) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyLoginPage()),
    );
  } else {
    
    showDialogBox(context, "Error", 'The sign up was unsuccessful');
  }
}

// post container
showFeed(BuildContext context, String email, String message, String time) {
  return Container(
    height: 180,
    width: 900,
    margin: EdgeInsets.only(right: 30, bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(children: [
      ListTile(
        horizontalTitleGap: 4,
        leading: Container(
          height: 90,
          width: 90,
          child: CircleAvatar(
            // radius: 20,
            backgroundImage: AssetImage('images/profile.jpg'),
          ),
        ),
        title: GestureDetector(
            onTap: () {
              
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => viewOtherProfile(email: email,),
                    ),
                  );
            },
            child: Text(email)),
        subtitle: Text(time),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(message),
      ),
    ]),
  );
}

showPersonalFeed(
    BuildContext context, String name, String message, String time) {
  return Container(
    height: 180,
    width: 900,
    margin: EdgeInsets.only(right: 30, bottom: 20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(children: [
      ListTile(
        horizontalTitleGap: 4,
        leading: Container(
          height: 90,
          width: 90,
          child: CircleAvatar(
            // radius: 20,
            backgroundImage: AssetImage('images/profile.jpg'),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => viewUserProfile(),
              ),
            );
          },
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text(time),
      ),
      SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Text(message),
      ),
    ]),
  );
}

//dialogue pop ups
void showDialogBox(BuildContext context, String title, String messaage) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(messaage),
          actions: <Widget>[
            TextButton(
                child: Text('close'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      });
}
