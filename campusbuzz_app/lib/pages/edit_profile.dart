import 'package:flutter/material.dart';
import 'package:campusbuzz_app/my_app_bar.dart';
import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/profile.dart';
import 'package:campusbuzz_app/pages/edit_user_info.dart';
import 'package:campusbuzz_app/functions/function.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:campusbuzz_app/functions/function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:campusbuzz_app/my_provider/providers.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

final _datePickerController = MyDatePickerController();
final _dateController = TextEditingController();

class MyEditPage extends StatefulWidget {
  const MyEditPage({super.key});

  @override
  State<MyEditPage> createState() => _MyEditPageState();
}

class _MyEditPageState extends State<MyEditPage> {
  // final _datePickerController = MyDatePickerController();
  // final _dateController = TextEditingController();
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
  void initState() {
    super.initState();
    // get the value from your provider
    // and set it to your a variable

    genderItem = Provider.of<MyProvider>(context, listen: false).gender;
    majorItem = Provider.of<MyProvider>(context, listen: false).major;
    residenceItem = Provider.of<MyProvider>(context, listen: false).residence;
  }

  @override
  Widget build(BuildContext context) {
    String user_email =
        Provider.of<MyProvider>(context, listen: false).user_email;
    
        // Provider.of<MyProvider>(context, listen: false).user_email;
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(right: 200),
              child: const Image(
                image: AssetImage('images/campusbuzz_logo.png'),
                fit: BoxFit.contain,
                height: kToolbarHeight * 1.1,
              ),
            ),
            Center(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(left: 250),
                  child: Text(
                    'My CampusBuzz Profile',
                    style: TextStyle(
                        fontSize: 20, color: Color.fromARGB(255, 212, 130, 34)),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
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
                  height: 520,
                  width: 520,
                  margin: EdgeInsets.only(top: 90),
                  child: Center(
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.grey),
                                  controller: student_id,
                                  decoration: InputDecoration(
                                    labelText: 'Student ID',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Student id field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: email,
                                  style: TextStyle(color: Colors.grey),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: first_name,
                                  style: TextStyle(color: Colors.grey),
                                  decoration:
                                      InputDecoration(labelText: 'First Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.grey),
                                  controller: last_name,
                                  decoration:
                                      InputDecoration(labelText: 'Last Name'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: YearGroup,
                                  decoration: InputDecoration(
                                    labelText: 'Year Group',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Text('Gender'),
                                    items: genderDropdown
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item, child: Text(item)))
                                        .toList(),
                                    value: genderItem,
                                    onChanged: (value) {
                                      setState(() {
                                        genderItem = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              // SizedBox(width: 10),
                              Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Text('Select Major'),
                                    items: majorDropdown
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item, child: Text(item)))
                                        .toList(),
                                    value: majorItem,
                                    onChanged: (value) {
                                      setState(() {
                                        majorItem = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                               Expanded(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    hint: Text('Residence Status'),
                                    items: residenceDropdown
                                        .map((item) => DropdownMenuItem<String>(
                                            value: item, child: Text(item)))
                                        .toList(),
                                    value: residenceItem,
                                    onChanged: (value) {
                                      setState(() {
                                        residenceItem = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: TextFormField(
                                  controller: DOB,
                                  decoration: InputDecoration(
                                    labelText: 'Date of Birth',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    await _datePickerController
                                        .selectDate(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: best_movie,
                                  decoration:
                                      InputDecoration(labelText: 'Best Movie'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: TextFormField(
                                  controller: best_food,
                                  decoration:
                                      InputDecoration(labelText: 'Best Food'),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                update(
                                  context,
                                  {
                                    "student_id": student_id.text,
                                    "first_name": first_name.text,
                                    "last_name": last_name.text,
                                    "email": email.text,
                                    "campus_residence": residenceItem,
                                    "DOB": DOB.text,
                                    "best_food": best_food.text,
                                    "best_movie": best_movie.text,
                                    "major": majorItem,
                                    "year_group": YearGroup.text,
                                    "gender": genderItem
                                  },
                                ).then((value) {
                                  //updating the provider so the user profile can update.
                                  Provider.of<MyProvider>(context,
                                          listen: false)
                                      .setFood(best_food.text);
                                  Provider.of<MyProvider>(context,
                                          listen: false).setMovie(best_movie.text);
                                  Provider.of<MyProvider>(context, listen: false)
                                      .setYearGroup(YearGroup.text);
                                  Provider.of<MyProvider>(context, listen: false)
                                      .setMajor(majorItem!);
                                  Provider.of<MyProvider>(context, listen: false)
                                      .setSex(genderItem!);
                                  Provider.of<MyProvider>(context, listen: false)
                                      .setResidence(residenceItem!);
                                  Provider.of<MyProvider>(context, listen: false)
                                      .setDateOfBirth(DOB.text);
                                  
                                });
                              },
                              icon: Icon(Icons.create),
                              label: Text('Edit Profile'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
