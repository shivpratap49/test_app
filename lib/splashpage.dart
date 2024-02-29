import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_app/main.dart';

class Splashpage extends StatefulWidget {
  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
 void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
    }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: Container(
                child: const Center(child: Text('Gradation System',style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,

                  decorationColor: Colors.white70,
                  decorationStyle: TextDecorationStyle.solid,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w100,
                ),
                ),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Image.asset("assets/images/EmblemN.png"),
              ),
            ),

          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Container(

                child: const Text("Developed By-",style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,

                  decorationColor: Colors.white70,
                  decorationStyle: TextDecorationStyle.solid,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start),

              ),
            ),
            Container(

              child: Center(child: Image.asset("assets/images/logo.png",fit: BoxFit.cover)),

            ),
          ],
        ),
      ),
  ],
      ),
    );
  }
}
