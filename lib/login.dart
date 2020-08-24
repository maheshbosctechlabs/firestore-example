import 'package:firebase_example/homepage.dart';
import 'package:firebase_example/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: _onLogIn,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Theme.of(context).buttonColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onLogIn() async {
    final user = await UserRepository().login(_emailController.text, _passwordController.text);
    final pref = await SharedPreferences.getInstance();
    pref.setString('loggedInUserId', user.id);
    pref.setString('loggedInUserName', user.name);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
  }
}
