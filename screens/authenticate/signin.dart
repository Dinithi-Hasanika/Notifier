import 'package:flutter/material.dart';
import 'package:notifier_app/screens/services/auth.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

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
            child: Text('SIGN IN',
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
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                    decoration: const InputDecoration(hintText: 'Email'),
                  ),
                  SizedBox(height: 15.0,),
                  TextFormField(
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
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    },
                    child: Text('SignIn',
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
                Text('Not have an account?'),
                SizedBox(width: 15.0,),
                FlatButton(
                  onPressed: (){
                    widget.toggleView();
                    print('hii');
                  },
                  child: Text('SignUp',
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
