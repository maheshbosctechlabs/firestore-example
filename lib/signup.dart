import 'package:firebase_example/homepage.dart';
import 'package:firebase_example/models/user_model.dart';
import 'package:firebase_example/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController;
  TextEditingController _nameController;
  TextEditingController _passwordController;
  String _gender;
  TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _contactController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Contact No'),
                keyboardType: TextInputType.number,
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: _gender,
                items: ['Male', 'Female']
                    .map(
                      (e) => DropdownMenuItem<String>(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: _onSignUp,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Theme.of(context).buttonColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSignUp() async {
    final documentref = await UserRepository().signUp(
      UserModel(
        contact: _contactController.text,
        email: _emailController.text,
        gender: _gender,
        name: _nameController.text,
        password: _passwordController.text
      )
    );
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('loggedInUserId', documentref.id);
    prefs.setString('loggedInUserName', _nameController.text);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(),), (route) => false);
  }
}
