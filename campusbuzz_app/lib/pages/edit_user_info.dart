
import 'package:campusbuzz_app/functions/function.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_picker/date_time_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';


TextEditingController DOB = TextEditingController();
class UserEditForm extends StatefulWidget {
  const UserEditForm({super.key});

  @override
  State<UserEditForm> createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
   final _datePickerController = MyDatePickerController();
   final _dateController = TextEditingController();
   TextEditingController email = TextEditingController();
   TextEditingController password = TextEditingController();
   TextEditingController student_id = TextEditingController();
   TextEditingController first_name = TextEditingController();
   TextEditingController last_name = TextEditingController();
   TextEditingController gender = TextEditingController();
   TextEditingController major = TextEditingController();
   TextEditingController campus_residence = TextEditingController();
   TextEditingController best_food = TextEditingController();
   TextEditingController best_movie = TextEditingController();
   
   TextEditingController YearGroup = TextEditingController();

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
                    decoration: InputDecoration(labelText: 'Student ID'),
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
                      labelText: 'Ashesi Mail',
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
                    decoration: InputDecoration(labelText: 'First Name'),
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
                    decoration: InputDecoration(labelText: 'Last Name'),
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
                    controller: gender,
                    decoration: InputDecoration(labelText: 'Gender'),
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
                      labelText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: YearGroup,
                    decoration: InputDecoration(labelText: 'Year Group '),
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
                    controller: major,
                    decoration: InputDecoration(labelText: 'Major'),
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
                    controller: campus_residence,
                    decoration: InputDecoration(labelText: 'Campus Residence'),
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
                    decoration: InputDecoration(labelText: 'Best Movie'),
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
                    decoration: InputDecoration(labelText: 'Best Food'),
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
                      "campus_residence": campus_residence.text,
                      "DOB": DOB.text,
                      "password": password.text,
                      "best_food": best_food.text,
                      "best_movie": best_movie.text,
                      "major": major.text,
                      "year_group": YearGroup.text,
                      "gender": gender.text
                    },
                  );
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
