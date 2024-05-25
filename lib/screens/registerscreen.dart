// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartibe/Screens/LoginScreen.dart';
import 'package:smartibe/user.dart';
import 'package:smartibe/base_cilent.dart';

const List<String> list = <String>['Male', 'Female'];

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  BaseClient test = BaseClient();
  String dropdownValue = list.first;
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController gender = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backgsign.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                emailForm(),
                mySizebox(),
                mySizebox(),
                phonenumberForm(),
                mySizebox(),
                mySizebox(),
                userForm(),
                mySizebox(),
                mySizebox(),
                passwordForm(),
                mySizebox(),
                mySizebox(),
                confirmpasswordForm(),
                mySizebox(),
                mySizebox(),
                mySizebox(),
                registerButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        padding: EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 65, 45, 16),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextButton(
          onPressed: () {
            setState(() {
              User user = User(
                  email: email.text,
                  phone: phone.text,
                  username: username.text,
                  password: password.text,
                  gender: dropdownValue);
              test.post('register', user);
            });
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen());
            Navigator.of(context).push(materialPageRoute);
          },
          child: Text(
            'Sign Up',
            style: GoogleFonts.domine(
              textStyle: TextStyle(
                color: Color.fromARGB(255, 255, 199, 116),
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emailForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 208, 135),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 250.0,
          height: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Email',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 117, 87, 47),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget phonenumberForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 208, 135),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 250.0,
          height: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: TextField(
              controller: phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Phone Number',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.phone,
                    color: Color.fromARGB(255, 117, 87, 47),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget userForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 208, 135),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 250.0,
          height: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: TextField(
              controller: username,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Username',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.account_box_sharp,
                    color: Color.fromARGB(255, 117, 87, 47),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget passwordForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 208, 135),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 250.0,
          height: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Password',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 117, 87, 47),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget confirmpasswordForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 208, 135),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 250.0,
          height: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Confirm Password',
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 117, 87, 47),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget genderForm() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Color.fromARGB(255, 241, 208, 135),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }


  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );
}
