import 'package:campusbuzz_app/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/edit_profile.dart';
import 'package:campusbuzz_app/pages/edit_user_info.dart';
import 'package:campusbuzz_app/functions/function.dart';
import 'package:provider/provider.dart';
import 'package:campusbuzz_app/my_provider/providers.dart';
import 'package:campusbuzz_app/pages/login.dart';
import 'package:campusbuzz_app/pages/profile.dart';

final TextEditingController searchStudent = TextEditingController();

class viewOtherProfile extends StatefulWidget {
  final String email;

  const viewOtherProfile({super.key, required this.email});

  @override
  State<viewOtherProfile> createState() => _viewOtherProfileState();
}

class _viewOtherProfileState extends State<viewOtherProfile> {
  final List<String> residenceDropdown = ['on campus', 'off campus'];
  final List<String> genderDropdown = ['female', 'male'];
  final List<String> majorDropdown = [
    'Computer Science',
    'Computer Engineering',
    'Electrical Engineering',
    'Mechanical Engineering',
    'Business Administration',
    'Management Info. Systems',
  ];
  //dropdown variables
  String? genderItem;
  String? majorItem;
  String? residenceItem;

  String firstName = "";
  String lastName = "";
  String email = "";
  String gender = "";
  String bestFood = "";
  String bestMovie = "";
  String yearGroup = "";
  String campusResidence = "";
  String studentId = "";
  String major = "";
  String dOB = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController searchStudent = TextEditingController();
    return FutureBuilder<Map<String, dynamic>>(
        //passing email to retrieve data from firebase
        future: get_profile(widget.email),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data == null) {
              return const Scaffold(
                body: Center(
                  child: Text('No data was found'),
                ),
              );
            } else {
              firstName = snapshot.data!['first_name'] ?? '';
              lastName = snapshot.data!['last_name'] ?? '';
              email = snapshot.data!['email'] ?? '';
              gender = snapshot.data!['gender'] ?? '';
              bestMovie = snapshot.data!['best_movie'] ?? '';
              bestFood = snapshot.data!['best_food'] ?? '';
              yearGroup = snapshot.data!['year_group'] ?? '';
              campusResidence = snapshot.data!['campus_residence'] ?? '';
              studentId = snapshot.data!['student_id'] ?? '';
              major = snapshot.data!['major'] ?? '';
              dOB = snapshot.data!['DOB'] ?? '';
            }
          }

          return MaterialApp(
            home: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: const Image(
                    image: AssetImage('images/campusbuzz_logo.png'),
                    fit: BoxFit.contain,
                    height: kToolbarHeight * 1.1,
                  ),
                  actions: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 80, top: 10, bottom: 10),
                      child: Container(
                        width: 300,
                        height: 100,
                        child: Center(
                          child: Focus(
                            onFocusChange: (hasFocus) {
                              print('$hasFocus');
                              print('object');
                            },
                            child: TextFormField(
                              onFieldSubmitted: (input) {
                                print('onFieldSubmitted: $input');
                              },
                              // onEditingComplete: () {
                                // Send the request here
                                // print('searching for user');
                                // String email = searchStudent.text;
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => viewOtherProfile(
                                //             email: email,
                                // )),
                                // );
                              // },
                              controller: searchStudent,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                alignLabelWithHint: true,
                                hintText: 'search',
                                hintStyle: const TextStyle(color: Colors.orange),
                                prefixIcon: Icon(Icons.search,
                                    color: Colors.grey[500], size: 20),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors
                                        .orange, // Change the outline color here
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10.0,
                      width: 100.0,
                      margin: EdgeInsets.only(right: 100, top: 8, bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // navigate to the registration page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyProfilePage()),
                              );
                            },
                            child: Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.transparent,
                              primary: Colors.transparent,
                              elevation: 0,
                            ),
                          ),
                          Icon(
                            Icons.create,
                            color: Colors.grey[500],
                            size: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                body: Container(
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(left: 100),
                        color: Colors.orange,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('images/campusbuzz_logo.png'),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon:
                                              Icon(Icons.broadcast_on_personal),
                                          onPressed: () {},
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // navigate to the registration page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyHomePage()),
                                            );
                                          },
                                          child: Text(
                                            'Home',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.person),
                                          onPressed: () {},
                                          color: Colors.white,
                                          iconSize: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // navigate to the registration page
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyEditPage()),
                                            );
                                          },
                                          child: Text(
                                            'Profile',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.logout),
                                          onPressed: () {},
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyLoginPage()),
                                            );
                                          },
                                          child: Text(
                                            'Logout',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.flash_on),
                                        onPressed: () {},
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // navigate to the registration page
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage()),
                                          );
                                        },
                                        child: Text(
                                          'My Buzzes',
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            // color: Colors.orange,
                                            fontSize: 14,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 100, top: 80),
                            color: Colors.white,
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 80,
                                          backgroundImage:
                                              AssetImage("images/profile.jpg"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Student Id:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "DOB",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Email:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Residence Status",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Year Group:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Major:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Favorite Food:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Favorite Movie:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        firstName + " " + lastName,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        studentId,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        gender,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        dOB,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        email,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        campusResidence,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        yearGroup,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        major,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        bestFood,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        bestMovie,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Divider(
                              //   height: 10,
                              //   color: Colors.orange,
                              // ),
                            ]),
                          ),
                          Divider(
                            color: Colors.orange,
                          ),
                          Center(
                            child: Text(
                              "POSTS",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                )),
          );
        });
  }
}
