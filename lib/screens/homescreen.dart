import 'package:flutter/material.dart';
import 'package:smartibe/screens/LoginScreen.dart';
import 'package:smartibe/screens/PositionxyScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var text = '5 m';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1,
        heightFactor: 1,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    mySizebox(),
                    mySizebox(),
                    showButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[registerButton(), mySizebox(), loginButton()],
    );
  }

  Widget loginButton() {
    return Container(
      child: TextButton(
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen());
          Navigator.of(context).push(materialPageRoute);
        },
        child: Text(
          'Login',
          style: GoogleFonts.merriweather(
            textStyle: const TextStyle(
                color: Color.fromARGB(255, 40, 117, 17), fontSize: 18.0),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget registerButton() {
    return Container(
      child: TextButton(
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(
              builder: (BuildContext context) => PositionxyScreen ());
          Navigator.of(context).push(materialPageRoute);
        },
        child: Text(
          "Sign Up",
          style: GoogleFonts.merriweather(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 40, 117, 17),
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  SizedBox mySizebox() => const SizedBox(
        width: 8.0,
        height: 16.0,
      );
}
