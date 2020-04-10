import 'package:coronavirus/Utils/authService.dart';
import 'package:coronavirus/Utils/localStorage.dart';
import 'package:coronavirus/screens/HomeScreen/homeScreen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeApp().then((val) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  initializeApp() async {
    await Storage.initialize();

    authService.googleSignIn();
    Storage.setlocal("Local", []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}