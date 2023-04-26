import 'package:campusbuzz_app/functions/function.dart';
import 'package:campusbuzz_app/my_provider/providers.dart';
import 'package:campusbuzz_app/pages/profile.dart';
import 'package:campusbuzz_app/pages/viewOtherUsers.dart';
import 'package:campusbuzz_app/pages/view_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:campusbuzz_app/my_app_bar.dart';
import 'package:campusbuzz_app/pages/edit_profile.dart';
import 'package:campusbuzz_app/pages/login.dart';
import 'package:campusbuzz_app/pages/myBuzzes.dart';
import 'package:provider/provider.dart';

TextEditingController post = TextEditingController();
TextEditingController searchStudent = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  //realtime function to get the posts
  Stream<QuerySnapshot> postsStream =
      FirebaseFirestore.instance.collection('posts').snapshots();

  //list of posts
  // List<dynamic> postList = [];

//initialising the state of the feed page
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String email = Provider.of<MyProvider>(context, listen: false).user_email;
    String fname = Provider.of<MyProvider>(context, listen: false).first_name;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: const EdgeInsets.only(right: 900),
          child: const Image(
            image: AssetImage('images/campusbuzz_logo.png'),
            fit: BoxFit.contain,
            height: kToolbarHeight * 1.1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 80, top: 10, bottom: 10),
            child: Container(
              width: 300,
              height: 100,
              child: Center(
                child: TextFormField(
                  controller: searchStudent,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    alignLabelWithHint: true,
                    hintText: 'search',
                    hintStyle: const TextStyle(color: Colors.orange),
                    prefixIcon:
                        Icon(Icons.search, color: Colors.grey[500], size: 20),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.orange, // Change the outline color here
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    // Send the request here
                    print('searching for user');
                    String email = searchStudent.text;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewOtherProfile(
                                email: email,
                              )),
                    );
                    searchStudent.clear();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(128, 128, 128, 0.5)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            // image: DecorationImage(
                            // image: AssetImage('images/profile.jpg'),
                            // ),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.only(left: 8, top: 60),
                          height: 100,
                          width: 250,
                        ),
                        Positioned(
                          top: 100,
                          left: 30,
                          child: Center(
                            // alignment: Alignment.center,
                            child: Text(
                              email,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 250,
                      height: 330,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(top: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),

                        height: 400,
                        // width: 300,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon:
                                              const Icon(Icons.broadcast_on_personal),
                                          onPressed: () {},
                                          color: Colors.orange,
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
                                                  builder: (context) =>
                                                      const MyHomePage()),
                                            );
                                          },
                                          child: const Text(
                                            'Home',
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
                                          color: Colors.orange,
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
                                                  builder: (context) =>
                                                      const viewUserProfile()),
                                            );
                                          },
                                          child: const Text(
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
                                          color: Colors.orange,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // navigate to the registration page
                                            email = "";
                                            fname = "";
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MyLoginPage()),
                                              (route) => false,
                                            );
                                          },
                                          child: const Text(
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
                                        icon: const Icon(Icons.flash_on),
                                        onPressed: () {},
                                        color: Colors.orange,
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
                                                builder: (context) =>
                                                    const MyBuzzesPage()),
                                          );
                                        },
                                        child: const Text(
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
                    )
                  ],
                )),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 20, top: 20),
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text(
                        'New Buzzes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.orange),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 50,
                        width: 880,
                        child: TextFormField(
                          controller: post,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              // border: OutlineInputBorder(),
                              hintText: "  What's on your mind, " + fname + "?",
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  // code to handle button press
                                  String message = post.text;
                                  if(message != ""){
                                    createPost(context, email, post.text);
                                    post.clear();
                                  }
                                },
                                color: Colors.orange,
                              )),
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: postsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData) {
                        return const Padding(
                          padding: EdgeInsets.only(top:200),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          ),
                        );
                      }
                      final postList = snapshot.data!.docs;

                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var post in postList.reversed)
                                if (post["email"] == email)
                                  showPersonalFeed(
                                    context,
                                    post['email'],
                                    post['post'],
                                    post['time_posted'],
                                  )
                                else
                                  showFeed(context, post['email'], post['post'],
                                      post["time_posted"])
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
