import 'package:flutter/material.dart';
import 'package:notifier_app/screens/home/settings.dart';
import 'package:notifier_app/screens/services/auth.dart';
import 'package:notifier_app/screens/home/add_assignment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:notifier_app/screens/models/user.dart';
import 'package:notifier_app/screens/home/edit_assignment.dart';


class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: Settings(),
        );
      });
    }

    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Notifier'),
        actions: <Widget>[
          FlatButton.icon(onPressed: () async{
          await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('LogOut',
          style: TextStyle(
            color: Colors.white,
          ),
          )),
          FlatButton.icon(
              onPressed: () {
             _showSettingPanel();
          },
              icon: Icon(Icons.settings), label: Text("")),

        ],
      ),
      body: new StreamBuilder(
          stream: Firestore.instance.collection("Assignments").snapshots(),
          // ignore: missing_return
          builder: (context,snapshot){
            if(!snapshot.hasData){
              // ignore: missing_return
              return Container();
            }else{
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context,index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                   // print(user.uid);
                  //  print(ds['uid']);
                    if (user.uid.toString() == ds['uid']) {

   // print(ds['assignment']);

                      return new Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Card(

                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
                          child: Column(
                            children: <Widget>[
                              Text(ds['assignment'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(ds['subject'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6.0,),
                              Row(
                                children: <Widget>[
                                  Text('Due Date :',
                                      style: TextStyle(
                                        fontSize: 18.0,)
                                  ),
                                  SizedBox(width: 3.0,),
                                  Text(ds['dueDate'],
                                    style: TextStyle(
                                      fontSize: 18.0,)
                                    ,),
                                ],
                              ),
                              SizedBox(height: 6.0,),
                              Row(
                                children: <Widget>[
                                  Text('Due Time :',
                                      style: TextStyle(
                                        fontSize: 18.0,)
                                  ),
                                  SizedBox(width: 3.0,),
                                  Text(ds['dueTime'],
                                    style: TextStyle(
                                      fontSize: 18.0,)
                                    ,),
                                ],
                              ),
                              SizedBox(height: 6.0,),
                              Row(
                                children: <Widget>[
                                  Text('Done',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: ds['done'],
                                    onChanged: null,
                                  ),
                                  SizedBox(width: 15.0,),
                                  Text('Submit',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Checkbox(
                                    value: ds['submit'],
                                    onChanged: null,
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.0,),
                              Row(
                                children: <Widget>[
                                  FlatButton.icon(
                                      color: Colors.green[600],
                                      onPressed: (){
                                       Firestore.instance.collection('Assignments').document(ds.documentID).delete();
                                      },
                                      icon: Icon(Icons.delete),
                                      label: Text('Delete',
                                      style: TextStyle(
                                        color: Colors.white,
                                          fontSize: 18.0
                                      ),
                                      ),

                                  ),
                                  SizedBox(width: 15.0,),
                                  FlatButton.icon(
                                    color: Colors.green[600],
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EditAssignment(
                                          nassignment: ds['assignment'],
                                          nsubject:ds['subject'] ,
                                        ndueDate: ds['dueDate'],
                                        ndueTime: ds['dueTime'],
                                        ndone: ds['done'],
                                        nsubmit: ds['submit'],
                                        nuid: ds['uid'],
                                        ndocId: ds.documentID,)
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit),
                                    label: Text('Edit',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0
                                      ),
                                    ),

                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      // ignore: missing_return, missing_return
                      );
                   }else{
                      return Card();
                    }
                  }
              );

            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Assignment()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[600],
      ),
    );
  }
}
