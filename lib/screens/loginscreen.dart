import 'package:flutter/material.dart';
import 'package:smartibe/Screens/RegisterScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartibe/devicebt.dart';
import 'package:smartibe/screens/allsensor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/backglogin.png'),
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
                mySizebox(),
                userForm(),
                mySizebox(),
                passwordForm(),
                mySizebox(),
                mySizebox(),
                loginButton(),
                mySizebox(),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[forgetpassword(), clickhereButton()],
    );
  }

  Widget userForm() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 241, 208, 135),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 250.0,
          height: 40.0,
          child: const Padding(
            padding: EdgeInsets.only(left: 2.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Username',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 5.0),
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
            color: const Color.fromARGB(255, 241, 208, 135),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          width: 250.0,
          height: 40.0,
          child: const Padding(
            padding: EdgeInsets.only(left: 2.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Password',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 5.0),
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

  Widget clickhereButton() {
    return Container(
      child: TextButton(
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => RegisterScreen());
          Navigator.of(context).push(materialPageRoute);
        },
        child: Text(
          "click here",
          style: GoogleFonts.domine(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 157, 57, 32),
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 65, 45, 16),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            MaterialPageRoute materialPageRoute = MaterialPageRoute(
                builder: (BuildContext context) => const AllSensor());
            Navigator.of(context).push(materialPageRoute);
          },
          child: Text(
            '    Login    ',
            style: GoogleFonts.domine(
              textStyle: const TextStyle(
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

  Widget forgetpassword() {
    return Container(
      child: Text(
        'Forget Password',
        style: GoogleFonts.domine(
          textStyle: const TextStyle(
              color: Color.fromARGB(255, 101, 82, 27), fontSize: 16.0),
        ),
      ),
    );
  }

  SizedBox mySizebox() => const SizedBox(
        width: 8.0,
        height: 16.0,
      );
}
