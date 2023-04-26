import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:campusbuzz_app/my_app_bar.dart';
import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/profile.dart';
import 'package:campusbuzz_app/pages/edit_profile.dart';
import 'package:campusbuzz_app/pages/view_profile.dart';
import 'package:campusbuzz_app/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:campusbuzz_app/my_provider/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCn69gGzOjziTcRM7Y1ZS0glkM3KAb6M50",
      authDomain: "ashesisocialapp.firebaseapp.com",
      projectId: "ashesisocialapp",
      storageBucket: "ashesisocialapp.appspot.com",
      messagingSenderId: "565525106168",
      appId: "1:565525106168:web:7175b6c4227108360c5a0d",
      measurementId: "G-L1Z7Q5T5WJ",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyProvider>(
      create: (_) => MyProvider(),
      child: MaterialApp(
        title: 'CampusBuzz',
        debugShowCheckedModeBanner: false,
        home: MyLoginPage(),
        routes: {
          '/create-profile': (context) => const MyProfilePage(),
          '/edit-profile': (context) => const MyEditPage(),
          '/home': (context) => const MyHomePage(),
          '/login': (context) => const MyLoginPage(),
          '/view-profile': (context) => const viewUserProfile(),
        },
      ),
    );
  }
}
