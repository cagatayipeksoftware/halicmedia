import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halicmedia/screens/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData(textTheme: GoogleFonts.poppinsTextTheme());
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 70, top: 150),
              child:
                  Center(child: Image(image: AssetImage("assets/logo.png")))),
          Text(
            "Yeni Aktivitelerden Haberdar Olmaya ",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 18,
            )),
          ),
          Center(
            child: Text(
              "Hazır Mısın?",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.red)),
            ),
          ),
          SizedBox(height: 100,),
      
          InkWell(
            onTap: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignupScreen()));},
            child: Container(
              child: Text(
                "Katıl!",
                style: GoogleFonts.poppins(textStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
              ),
              width:MediaQuery.of(context).size.width/2,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12,),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: Color.fromARGB(255, 255, 17, 0)),
            ),
          ),
        ],
      ),
    ));
  }
}
