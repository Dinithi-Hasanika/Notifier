import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/widgets.dart';
//import 'package:notifier_app/screens/home/add_assignment.dart';
import 'package:notifier_app/screens/models/user.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){

    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged.map( _userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(String email, String password) async{
    try{

      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      return null;
    }
  }

  Future signOut () async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
    Future signInWithEmailAndPassword(String email, String password) async{

      try{
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
      }catch(e){

      }
    }


  }
