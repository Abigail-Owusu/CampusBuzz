import 'package:flutter/material.dart';
import 'package:campusbuzz_app/my_app_bar.dart';
import 'package:campusbuzz_app/pages/home.dart';
import 'package:campusbuzz_app/pages/profile.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      backgroundColor: Colors.white,
      title: const Image(
        image: AssetImage('images/campusbuzz_logo.png'),
        fit: BoxFit.contain,
        height: kToolbarHeight * 1.1,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 80, top: 10, bottom: 10),
          child: Container(
            width: 300,
            height: 100,
            child: Center(
              child: TextFormField(
                
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    alignLabelWithHint: true,
                    hintText: 'search',
                    hintStyle: const TextStyle(
                      color: Colors.orange,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[500],
                      size: 20,
                    ),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.orange, // Change the outline color here
                        ),
                        borderRadius: BorderRadius.circular(20))),
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
                    MaterialPageRoute(builder: (context) => MyProfilePage()),
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
    );
  }
}
