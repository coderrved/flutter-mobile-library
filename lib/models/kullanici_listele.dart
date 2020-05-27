import 'package:flutter/material.dart';
import 'package:kutuphane/models/users.dart';
import 'package:kutuphane/utils/database_helpers.dart';

class KullaniciListele extends StatefulWidget {
  @override
  _KullaniciListeleState createState() => _KullaniciListeleState();
}

class _KullaniciListeleState extends State<KullaniciListele> {

  List<Users> allUserList;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper;

  @override
  void initState() {
    super.initState();
    allUserList = List<Users>();
    databaseHelper = DatabaseHelper();
    databaseHelper.allUsers().then((mapListesi) {
      // Veritabanındaki kullanıcılar uygulama başlarken listeye atıldı.
      for (Map okunanMap in mapListesi) {
        allUserList.add(Users.fromMap(okunanMap));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcıları Listele"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: allUserList.length,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Card(
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(allUserList[index].id.toString(), style: TextStyle(fontSize: 18.0),),
                        margin: EdgeInsets.all(15.0),
                      ),
                      Container(
                        child: Text(allUserList[index].kullaniciAdi, style: TextStyle(fontSize: 18.0,), textAlign: TextAlign.center,),
                        //margin: EdgeInsets.symmetric(horizontal: 40.0),
                      ),
                      Container(
                        child: Text(allUserList[index].email, style: TextStyle(fontSize: 18.0), textAlign: TextAlign.right,),
                        // margin: EdgeInsets.fromLTRB(20, 10, 0, 10),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.add_circle, size: 25.0,),
                          onPressed: (){
                            print('islem basarili'); // Veritabani islemleri buraya gelecek.

                          },
                        ),
                        margin: EdgeInsets.all(10.0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

