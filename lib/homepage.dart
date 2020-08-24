import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final pref = snapshot.data;
              final userName = pref.getString('loggedInUserName');
              return Text(
                'Hi ' + userName,
                style: TextStyle(
                  fontSize: 20,
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
