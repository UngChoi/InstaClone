import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CreatePage extends StatefulWidget {

  final FirebaseUser user;

  CreatePage(this.user);
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final texteditController = TextEditingController();

  File _image;

  @override
  void dispose(){
    texteditController.dispose();
    //이 컨트롤러도 직접 메모리 해제를 해줘야 한다
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(onPressed: _getImage,
          child: Icon(Icons.add_a_photo),),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.send),
          onPressed: (){
            final firebaseStorageRef = FirebaseStorage.instance
                .ref()
                .child('post')
                .child('${DateTime.now().millisecondsSinceEpoch}.png');
            //이름, 저장 파일 경로 지정
            final task = firebaseStorageRef.putFile(
              _image, StorageMetadata(contentType: 'image/png'));
            //put file로 이미지를 넣고 메타데이터 정보까지

            task.onComplete.then((value){
              var downloadUrl = value.ref.getDownloadURL();
                  //데이터의 주소, 다운로드 url
              downloadUrl.then((uri){
                //이미지가 다 올라 갔다 --> ㅈ디비에 올려야 한
                var doc = Firestore.instance.collection('post').document();
                //firebase에 post라는 컬렉션능ㄹ 만들고 문서를 만들겠다

                doc.setData(
                  {
                    'id' : doc.documentID,
                    'photoUrl' : uri.toString(),
                    'contents' : texteditController.text,
                    'email' : widget.user.email,
                    'displayName' : widget.user.displayName,
                    'userPhotoUrl' : widget.user.photoUrl
                  } // future void 형태로 리턴 된다
                ).then((onValue){
                  Navigator.pop(context);
                  //  현재 화면 닫는다
                });
                //map을 넣으라고 한다 --> JSON 형태로 넣는다

              });
            });

          },
        )
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _image == null ? Text('No Image') : Image.file(_image),
          TextField(
            controller: texteditController,
            //TextField를 이용하기 위해서 위에 final로 선언해 주고 controller 넣는
            decoration: InputDecoration(hintText: '내용을 입력하세요'),
          ),
        ],

      ),
    );
  }

  Future _getImage() async {
   File image = await ImagePicker.pickImage(source: ImageSource.gallery);
//사람이 선택할 때 까지 기다린다
   setState(() {
     _image = image;
   });

  }
}
