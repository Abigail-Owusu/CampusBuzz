import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/edit_profile.dart';
import 'package:campusbuzz_app/pages/edit_user_info.dart';
import 'package:campusbuzz_app/functions/function.dart';
import 'package:provider/provider.dart';
import 'package:campusbuzz_app/my_provider/providers.dart';
import 'package:campusbuzz_app/pages/login.dart';
class viewUserProfile extends StatefulWidget {
  const viewUserProfile({super.key});

  @override
  State<viewUserProfile> createState() => _viewUserProfileState();
}

class _viewUserProfileState extends State<viewUserProfile> {
    Stream<QuerySnapshot> postsStream =
      FirebaseFirestore.instance.collection('posts').snapshots();
  TextEditingController email = TextEditingController();
  TextEditingController student_id = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController major = TextEditingController();
  TextEditingController campus_residence = TextEditingController();
  TextEditingController best_food = TextEditingController();
  TextEditingController best_movie = TextEditingController();
  TextEditingController YearGroup = TextEditingController();
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

  String? genderItem;
  String? majorItem;
  String? residenceItem;
  @override
  Widget build(BuildContext context) {
    String user_email =
        Provider.of<MyProvider>(context, listen: false).user_email;
    String user_id = Provider.of<MyProvider>(context, listen: false).student_id;
    String fname = Provider.of<MyProvider>(context, listen: false).first_name;
    String lname = Provider.of<MyProvider>(context, listen: false).last_name;
    String sex = Provider.of<MyProvider>(context, listen: false).gender;
    String bd = Provider.of<MyProvider>(context, listen: false).DOB;
    String year = Provider.of<MyProvider>(context, listen: false).year_group;
    String residence =
        Provider.of<MyProvider>(context, listen: false).residence;
    String food = Provider.of<MyProvider>(context, listen: false).food;
    String movie = Provider.of<MyProvider>(context, listen: false).movie;
    String course = Provider.of<MyProvider>(context, listen: false).major;

    var fullName = fname + " " + lname;

    Future<Map<String, dynamic>> userData = get_profile(user_email);
    userData.then((value) {
      first_name.text = value['first_name'];
      last_name.text = value['last_name'];
      email.text = value['email'];
      gender.text = value['gender'];
      major.text = value['major'];
      campus_residence.text = value['campus_residence'];
      best_food.text = value['best_food'];
      best_movie.text = value['best_movie'];
      student_id.text = value['student_id'];
      DOB.text = value['DOB'];
      YearGroup.text = value['year_group'];
    });

    return MaterialApp(
      home: Scaffold(
          // appBar: AppBar(),
          body: Container(
        child: Row(children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 100),
              color: Colors.orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/campusbuzz_logo.png'),
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.broadcast_on_personal),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // navigate to the registration page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyHomePage()),
                                  );
                                },
                                child: const Text(
                                  'Home',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
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
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.person),
                                onPressed: () {},
                                color: Colors.white,
                                iconSize: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // navigate to the registration page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyEditPage()),
                                  );
                                },
                                child: const Text(
                                  'Profile',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
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
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.logout),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // navigate to the registration page
                                  user_email = "";
                                  fname = "";
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyLoginPage()),
                                  );
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
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
                              icon: const Icon(Icons.flash_on),
                              onPressed: () {},
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                // navigate to the registration page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage()),
                                );
                              },
                              child: const Text(
                                'My Buzzes',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
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
                  padding: const EdgeInsets.only(left: 100, top: 80),
                  color: Colors.white,
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    AssetImage("images/profile.jpg"),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyEditPage()),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                label: const Text('Edit Profile'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SingleChildScrollView(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
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
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              user_id,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              sex,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              bd,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              user_email,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              residence,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              year,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              course,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              food,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              movie,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                  ]),
                ),
                const Divider(
                  color: Colors.orange,
                )
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
