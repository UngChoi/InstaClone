import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final FirebaseUser user;

  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Clon', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),

      body : _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child : SafeArea(
          child : SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('Instgram에 오신 것을 환영합니다', style : TextStyle(fontSize : 24.0)),
                  Padding(padding: EdgeInsets.all(8.0),),
                  Text('사진과 동영상을 보려면 팔로우하세요', ),
                  Padding(padding: EdgeInsets.all(16.0),),
                  SizedBox(
                    width : 260.0,
                    child: Card(
                      elevation: 4.0,
                      child : Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(4.0),),
                          SizedBox(width : 80, height : 80, child : CircleAvatar(backgroundImage : NetworkImage(user.photoUrl))),
                          Padding(padding : EdgeInsets.all(8.0)),
                          Text(user.email, style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(user.displayName),
                          //교체할 부분
                          Padding(padding : EdgeInsets.all(8.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width : 70.0,
                                height : 70.0,
                                child: Image.network('https://postfiles.pstatic.net/MjAyMDAzMjJfMTAg/MDAxNTg0ODYyMjg2NTE0.ZNjXiIuDyejjZu2kkW8qXeuqnO95mdeGxgj__R-0MZog.pKha6Ekmo_kodZhqq4INsNj8_vw5gDulBje-tuSUDjcg.JPEG.dndrb0210/1.jpg?type=w773',fit: BoxFit.cover ,),
                              ),
                              Padding(padding: EdgeInsets.all(1.0),),
                              SizedBox(
                                width : 70.0,
                                height : 70.0,
                                child: Image.network('https://postfiles.pstatic.net/MjAyMDAzMjJfOTAg/MDAxNTg0ODYyMjg2NTg2.SudlrKaaQx1RTsmKgY_MIR3f8r0R32g2jd7EFtYEsykg.DyQriU_QlK2bG_wYvGrW-LUev07q6UIXWYjOIUTB1osg.JPEG.dndrb0210/3.jpg?type=w773',fit: BoxFit.cover),
                              ),
                              Padding(padding: EdgeInsets.all(1.0),),

                              SizedBox(
                                width : 70.0,
                                height : 70.0,
                                child: Image.network('https://postfiles.pstatic.net/MjAyMDAzMjJfMTQw/MDAxNTg0ODYyMjg2NTg5.BW6SoNVNPNAbMDLxDpdqtOnfJNdoitDsw8px0SavF9Ig.FUEgYiD4dqzTHSUMTo9JHh9YVaq-S0UH0u9KGTDrhEMg.JPEG.dndrb0210/6.jpg?type=w773',fit: BoxFit.cover),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(4.0),),
                          Text('Facebook 친구'),
                          Padding(padding: EdgeInsets.all(4.0),),
                          RaisedButton(
                            child: Text('팔로우'),
                            textColor: Colors.white,
                            color: Colors.blueAccent,
                            onPressed: (){},
                          ),
                          Padding(padding: EdgeInsets.all(4.0),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      )
    );
  }
}
