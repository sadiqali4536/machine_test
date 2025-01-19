import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machine_test1/MVVM/view/Screen/home.dart';
import 'package:machine_test1/MVVM/view/Screen/login.dart';

class Authgate extends StatefulWidget {
  const Authgate({super.key});

  @override
  State<Authgate> createState() => _AuthgateState();
}

class _AuthgateState extends State<Authgate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
       builder: ( context, snapshot) { 
        if(snapshot.hasData){
          return HomePage();
        }else{
          return LoginPage();
        }
       },
    );
  }
}
