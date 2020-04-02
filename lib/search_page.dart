import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'create_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_post_page.dart';

class SearchPage extends StatefulWidget {

  final FirebaseUser user;
  SearchPage(this.user);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildbody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage(widget.user)));
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildbody() {
    return StreamBuilder(
      stream: Firestore.instance.collection('post').snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        var items = snapshot.data.documents ?? [];
        //null이 아니도록 설정
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, items[index]);
      },

    );
      },
      //저 post 밑에 내용이 변경이 되면 데이터 흐름이 다시 들어오면서 작동한다
    );
  }

  Widget _buildListItem(context, document) {
    return Hero(
      tag : document['photoUrl'],
      child: Material(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return DetailPostPage(document);
            }));
          },
          child: Image.network(
              document['photoUrl'],
              fit : BoxFit.cover),
        ),
      ),
    );
  }
}
