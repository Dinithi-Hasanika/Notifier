import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:notifier_app/screens/models/user.dart';

class EditAssignment extends StatefulWidget {

 final String nassignment;
 final String nsubject;
  final String ndueDate;
 final String ndueTime;
  bool ndone;
 bool nsubmit;
 final String nuid;
  final String ndocId;

  EditAssignment({this.nassignment,this.nsubject,this.ndueDate,this.ndueTime,this.ndone,this.nsubmit,this.nuid,this.ndocId});

  @override
  _EditAssignmentState createState() => _EditAssignmentState();
}

class _EditAssignmentState extends State<EditAssignment> {

  final _formKey = GlobalKey<FormState>();
  final dateFormat =  DateFormat("yyyy-MM-dd");
  final timeFormat = DateFormat("HH:mm");
  DateTime dates;
  DateTime timer;
  String assignment;
  String subject;
  String date;
  String times ;
  bool done = false;
  bool submit = false;

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
              child: Text('Assignment',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(

                    onChanged: (val){
                      setState(() {
                        assignment = val;
                      });
                    },
                    initialValue: widget.nassignment,
                    decoration: const InputDecoration(hintText: 'Assignment Name'),
                  ),
                  SizedBox(height: 15.0,),
                  TextFormField(
                    onChanged: (val){
                      setState(() {
                        subject = val;
                      });
                    },
                    initialValue: widget.nsubject,
                    decoration: const InputDecoration(hintText: 'Subject'),
                  ),
                  SizedBox(height: 15.0,),
                  DateTimeField(
                    format: dateFormat,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    onChanged: (val){
                      setState(() {
                        dates = val;
                        date = dates.toString().substring(0,10);
                      });
                      print(date.toString());
                    },
                    decoration: InputDecoration(hintText:'Due Date'),
                  ),
                  SizedBox(height: 15.0,),
                  DateTimeField(

                    format: timeFormat,
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      );
                      // print(time.toString());
                      return DateTimeField.convert(time);

                    },
                    decoration: InputDecoration(hintText:'Due Time'),
                    onChanged: (val){
                      setState(() {
                        timer = val;
                        times = timer.toString().substring(11,16);
                      });
                    },
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    children: <Widget>[
                      Text('Done',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Checkbox(
                        value:  widget.ndone,
                        onChanged: (bool val){
                          setState(() {
                            widget.ndone = val;
                          });
                        },
                      ),
                      SizedBox(width: 15.0,),
                      Text('Submit',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Checkbox(
                        value:  widget.nsubmit,
                        onChanged: (bool val){
                          setState(() {
                            widget.nsubmit = val;
                          });
                        },
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: () {
                      Firestore.instance.collection("Assignments").document(widget.ndocId).updateData({
                        'uid':user.uid,
                        'assignment': assignment ?? widget.nassignment,
                        'subject': subject ?? widget.nsubject,
                        'dueDate': date ?? widget.ndueDate,
                        'dueTime': times ?? widget.ndueTime,
                        'done' :  widget.ndone,
                        'submit':  widget.nsubmit,
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
