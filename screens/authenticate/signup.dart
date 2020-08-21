import 'package:flutter/material.dart';
import 'package:notifier_app/screens/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;

  SignUp({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Notifier'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),

        child: Column(
          children: <Widget>[SizedBox(height: 15.0,),Center(
            child: Text('SIGN UP',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          Form(
          key: _formKey,
            child: Column(
              children: <Widget>[SizedBox(height: 15.0,),
              TextFormField(
                validator: (val)=> val.isEmpty ? 'Enter valid email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
                decoration: const InputDecoration(hintText: 'Email'),
              ),
                SizedBox(height: 15.0,),
                TextFormField(
                  validator: (val)=> val.length < 6 ? 'Password should of length 6 or more' : null,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Password'),
                  obscureText: true,

                ),
                SizedBox(height: 15.0,),
                RaisedButton(
                  onPressed: () async{
    if(_formKey.currentState.validate()){
      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
      print(result);
    }
                  },
                  child: Text('SignUp',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                  color: Colors.green[600],
                ),

              ],
            ) ,
          ),
            SizedBox(height: 15.0,),
            Row(
              children: <Widget>[
                Text('Already a user?'),
                SizedBox(width: 15.0,),
                FlatButton(
                  onPressed: (){
                    widget.toggleView();

                  },
                  child: Text('SignIn',
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                  color: Colors.green[600],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
