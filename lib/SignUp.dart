import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'Movie.dart';
import 'DatabaseHelper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  var name1 = TextEditingController();
  var password = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var profession = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      controller: name1,
                      decoration: InputDecoration(
                          labelText: 'Name',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)
                          )
                      ),
                      validator: (value) {
                        if (value == null || (value!.isEmpty)) {
                          return "Name Field Cant Be Empty";
                        }
                      }
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)
                          )
                      ),
                      validator: (value) {
                        if (value == null || (value!.isEmpty)) {
                          return "Email Field Cant Be Empty";
                        }
                      }
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)
                          )
                      ),
                      validator: (value) {
                        if (value == null || (value!.isEmpty)) {
                          return "Password Field Cant Be Empty";
                        }
                      }
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                      controller: phone,
                      decoration: InputDecoration(
                          labelText: 'Phone no',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)
                          )
                      ),
                      validator: (value) {
                        if (value == null || (value!.isEmpty)) {
                          return "Phone_no Field Cant Be Empty";
                        }
                      }
                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                    controller: profession,
                    decoration: InputDecoration(
                        labelText: 'Profession',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        )
                    ),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      DatabaseHelper.insertItems(
                          name1.text, email.text, password.text, phone.text,
                          profession.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => LoginPage()
                      ));
                    }
                  },
                      child: Text("Sign up"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}