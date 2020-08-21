import 'package:flutter/material.dart';
import 'package:notifier_app/screens/home/add_subject.dart';
import 'package:notifier_app/screens/home/delete_subjects.dart';
import 'package:notifier_app/screens/home/view_subjects.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton.icon(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubjectForm()),
            );
          },
              icon: Icon(Icons.add), label: Text('Add Subject',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          FlatButton.icon(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewSubjects()),
            );
          },
              icon: Icon(Icons.subject), label: Text('Show my Subjects',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          FlatButton.icon(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DeleteSubjects()),
            );
          },
              icon: Icon(Icons.delete), label: Text('Delete Subjects',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
