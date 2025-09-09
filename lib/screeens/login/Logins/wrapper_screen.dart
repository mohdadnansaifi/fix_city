import 'package:firebase_auth/firebase_auth.dart';
import 'package:fix_city/screeens/bottom/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'get_started.dart';

class wrapperScreen extends StatefulWidget {
  @override
  State<wrapperScreen> createState() => _wrapperScreenState();
}

class _wrapperScreenState extends State<wrapperScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,Snapshot){
          if(Snapshot.hasData){
            return BottomNavigationPage();
          }else{
            return getStartedpage();
          }
        });
  }
}