import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homescreen.dart';

class SplahScreen extends StatefulWidget {
  const SplahScreen({super.key});

  @override
  State<SplahScreen> createState() => _SplahScreenState();
}

class _SplahScreenState extends State<SplahScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    });
  }
  
  @override
  Widget build(BuildContext context) {

    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('images/splash_pic.jpg',
              fit: BoxFit.cover,
              height: height*0.6,
              //width: width*0.9,
            ),

            SizedBox(height: height*0.04,),
            Text('TOP HEADLINES',style: GoogleFonts.anton(letterSpacing: 0.6,color: Colors.grey.shade700),),
            SizedBox(height: height*0.04,),

            SpinKitChasingDots(
              size: 40,
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
