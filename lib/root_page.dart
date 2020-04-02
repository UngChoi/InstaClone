import 'package:flutter/material.dart';
import 'loading_page.dart';
import 'login_page.dart';
import 'tab_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged, // 변경됬을 때
      //변경된 상태에 따라 스냅샷이 흘러 들어올 수 있도록(근데 안들어오는거 같은데)
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return LoadingPage();
        }
        else{
          if(snapshot.hasData){
            return TabPage(snapshot.data);
          }
          else{
            return LoginPage();
          }
        }

      },
    );
  }
}
