import 'package:firebase_example/login.dart';
import 'package:firebase_example/signup.dart';
import 'package:flutter/material.dart';

class EntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
              FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ));
                  },
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                      color: Theme.of(context).buttonColor,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
