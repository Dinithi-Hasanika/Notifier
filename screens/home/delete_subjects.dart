import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:notifier_app/screens/models/user.dart';

class DeleteSubjects extends StatefulWidget {
  @override
  _DeleteSubjectsState createState() => _DeleteSubjectsState();
}

class _DeleteSubjectsState extends State<DeleteSubjects> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar :AppBar(
        backgroundColor: Colors.green[600],
        title: Text('Notifier'),),
      body: new StreamBuilder(
        stream: Firestore.instance.collection("Subjects").snapshots(),
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
                              Text(ds['subject'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 6.0,),
                              FlatButton.icon(
                                color: Colors.green[600],
                                onPressed: (){
                                  Firestore.instance.collection('Subjects').document(ds.documentID).delete();
                                },
                                icon: Icon(Icons.delete),
                                label: Text('Delete',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0
                                  ),
                                ),

                              ),
                            ],
                          )
                      ),
                    );
                    // ignore: missing_return, missing_return

                  }else{
                    return Card();
                  }
                }
            );

          }
        },
      ),
    );
  }
}
