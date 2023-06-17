import 'package:flutter/material.dart';
import 'Movie.dart';
import 'DatabaseHelper.dart';
import 'SignUp.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  var name1=TextEditingController();
  var password=TextEditingController();
  var email=TextEditingController();
  var b="false";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:Text("Login") ,),
      body: Center(
          child: Padding(
          padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
        children: [
        TextFormField(
        controller:name1,
        decoration: InputDecoration(
        labelText: 'Name',
        enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
        )
        ),
          validator: (value){
            if(value ==null||(value!.isEmpty)){
              return "Name Field Cant Be Empty";
            }
          },
        ),
          SizedBox(height: 15,),
          TextFormField(
              controller:email,
              decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)
                  )
              ),
              validator: (value) {
                if (value == null||(value!.isEmpty)) {
                  return "Email Field Cant Be Empty";
                }
              }
          ),

          SizedBox(height: 15,),
        TextFormField(
        controller:password,
        decoration: InputDecoration(
        labelText: 'Password',
        enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black)
        )
        ),
          validator: (value) {
            if (value == null||(value!.isEmpty)) {
              return "Password Field Cant Be Empty";
            }
          }
        ),


        SizedBox(height: 15,),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  check(name1.text,email.text,password.text);

                  }

              }, child: Text("Login")),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>SignUp()));
              }, child: Text("Sign Up")),
            ],
          )
        ]
        ),
      )
      )
      )
      ),
    )
    ;
  }
 Future<void> check(String name,String email,String pass) async{

    final data=await DatabaseHelper.readData();
    for(int i=0;i<data.length;i++){
      print(data[i]['email_id']+data[i]['password']+data[i]['name']);
      if(data[i]['email_id']==email.toString() && data[i]['password']==pass.toString() && data[i]['name']==name.toString()){
       Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>Movie(name: name, email: email)));
        break;
      }
    }

 }
}
