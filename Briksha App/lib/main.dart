import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:briksha/screens/camera_screen.dart';

void main() async {
  runApp(GetMaterialApp(
    home: MyApp(
     
    ),
     debugShowCheckedModeBanner: false
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 6), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(color: Colors.white),
        Center(
          child: Column(
            children: <Widget>[
              Expanded(
                flex:1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height:MediaQuery.of(context).size.height * 0.35,
                      width:MediaQuery.of(context).size.width*0.65,
                      decoration: BoxDecoration(
                        
                        
                       image: DecorationImage(image:AssetImage('assets/briksha.png'),
                       fit: BoxFit.fill)
                      ),
                    ),
                     
                    
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
