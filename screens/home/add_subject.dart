import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:notifier_app/screens/models/user.dart';



class SubjectForm extends StatefulWidget {
  @override
  _SubjectFormState createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  final _formKey = GlobalKey<FormState>();
  String subject;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar :AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Notifier'),),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0,),
            Center(
              child: Text('Add Subject',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Form(
              key: _formKey ,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        subject = val;
                      });
                    },
                    decoration: const InputDecoration(hintText: 'Subject'),
                  ),
                  SizedBox(height: 15.0,),
                  RaisedButton(
                    onPressed: () {
                      Firestore.instance.collection("Subjects").document().setData({
                        'uid':user.uid,
                        'subject': subject,

                      });
                      Navigator.pop(context);
                    },
                    child: Text('Add',
                      style: TextStyle(
                        color: Colors.white,
                      ),),
                    color: Colors.green[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
