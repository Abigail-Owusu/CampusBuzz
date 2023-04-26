import 'package:flutter/material.dart';


class MyProvider extends ChangeNotifier{
  String student_id = "";
  String gender = "";
  String year_group = "";
  String user_email = "";
  String first_name = "";
  String last_name = "";
  String campus_residence = "";
  String DOB = "";
  String best_food = "";
  String best_movie = "";
  String major = "";


  //getters
  String get studentID => student_id;
  String get email => user_email;
  String get fname => first_name;
  String get lname => last_name;
  String get sex => gender;
  String get date => DOB;
  String get year => year_group;
  String get residence => campus_residence;
  String get food => best_food;
  String get movie => best_movie;
  String get course => major;



  //setters
  void setEmail(String email){
    user_email = email;
    notifyListeners();
  } 
  void setMajor(String course) {
    major = course;
    notifyListeners();
  } 
  void setStudentID(String studentID){
    student_id = studentID;
    notifyListeners();
  }
  void setFirstName(String fname) {
    first_name = fname;
    notifyListeners();
  }
  void setLastName(String lname) {
    last_name = lname;
    notifyListeners();
  }
  void setSex(String sex) {
    gender = sex;
    notifyListeners();
  }
  void setDateOfBirth(String date) {
    DOB = date;
    notifyListeners();
  }
  void setYearGroup(String year) {
    year_group = year;
    notifyListeners();
  }
  void setResidence(String residence) {
    campus_residence = residence;
    notifyListeners();
  }
  void setFood(String food) {
    best_food = food;
    notifyListeners();
  }
  void setMovie(String movie) {
    best_movie = movie;
    notifyListeners();
  }

}
