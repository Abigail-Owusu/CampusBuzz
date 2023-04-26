import 'package:campusbuzz_app/functions/function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController student_id = TextEditingController();
final TextEditingController first_name = TextEditingController();
final TextEditingController last_name = TextEditingController();
final TextEditingController gender = TextEditingController();
final TextEditingController major = TextEditingController();
final TextEditingController campus_residence = TextEditingController();
final TextEditingController best_food = TextEditingController();
final TextEditingController best_movie = TextEditingController();
final TextEditingController DOB = TextEditingController();
final TextEditingController YearGroup = TextEditingController();

class UserInfoForm extends StatefulWidget {
  const UserInfoForm({super.key});

  @override
  State<UserInfoForm> createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final _datePickerController = MyDatePickerController();
  // final _dateController = TextEditingController();


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
    return Center(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: student_id,
                    decoration: InputDecoration(labelText: 'Student ID *'),
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
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email *',
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
                    controller: first_name,
                    decoration: InputDecoration(labelText: 'First Name *'),
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
                    controller: last_name,
                    decoration: InputDecoration(labelText: 'Last Name *'),
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
                    decoration: InputDecoration(labelText: 'Year Group *'),
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
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'Password *',
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
                      hint: Text('Gender *'),
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
                
                SizedBox(width: 30),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text('Select Major *'),
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
                      hint: Text('Resident Status *'),
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
                // SizedBox(width: 30),
                Expanded(
                 
                  child: TextFormField(
                    controller: DOB,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth *',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    onTap: () async {
                      await _datePickerController.selectDate(context);
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
                    decoration: InputDecoration(labelText: 'Best Movie *'),
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
                    decoration: InputDecoration(labelText: 'Best Food *'),
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
            Container(
              margin: EdgeInsets.only(top: 50),
              child: ElevatedButton.icon(
                onPressed: () {
                  profile(
                    context,
                    {
                      "student_id": student_id.text,
                      "first_name": first_name.text,
                      "last_name": last_name.text,
                      "email": email.text,
                      "campus_residence": residenceItem,
                      "DOB": DOB.text,
                      "password": password.text,
                      "best_food": best_food.text,
                      "best_movie": best_movie.text,
                      "major": majorItem,
                      "year_group": YearGroup.text,
                      "gender": genderItem
                    },
                  );
                },
                icon: Icon(Icons.create),
                label: Text('Create'),
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
    );
  }
}

class MyDatePickerController {
  

  Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      DOB.text = DateFormat('yyyy-MM-dd').format(picked);
    }

    return picked;
  }
}
