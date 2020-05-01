import 'package:flutter/material.dart';
import 'package:kutuphane/models/admin_sayfasi.dart';
import 'package:kutuphane/models/kayit.dart';
import 'package:kutuphane/models/users.dart';
import 'package:kutuphane/utils/database_helpers.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Users> allUserList;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper;
  String _name, _password;
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

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
    //ekle();

    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/library.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 60.0),
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Kemal Tahir Kütüphanesi ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 42.0,
                        fontFamily: 'RobotoMono',
                        backgroundColor: Colors.white54),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 0),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextFormField(
                    controller: _userNameController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Kullanıcı Adı',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                      ),
                      suffixIcon: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Şifre',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                      ),
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Kayıtlı değilseniz ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('asd');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'kayıt olun',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: RaisedButton(
                    color: Colors.black45,
                    child: Text(
                      "Giriş Yap",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () {
                      print('giris yapildi.');
                      print('ad: '+ _userNameController.text);
                      print('sifre: '+ _passwordController.text);
                      if (_formKey.currentState.validate()) {
                        if (allUserList.isEmpty) {
                          print("Böyle bir kullanici bulunamadı.");
                        } else {
                          var uzunluk = allUserList.length;
                          print('allUserList length: $uzunluk');
                          print('0. eleman adi: ' + allUserList[0].kullaniciAdi);
                          print('0. eleman sifre: ' + allUserList[0].sifre);
                          for(int i=0;i<allUserList.length;i++){
                            if (allUserList[i].kullaniciAdi == _userNameController.text && allUserList[i].sifre == _passwordController.text) {
                              _formKey.currentState.save();
                              print('basariyla giris yapildi.');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminSayfasi(),
                                ),
                              );
                            }else{
                              print("Kullanıcı adı veya şifre hatalı");
                            }
                          }
                        }
                      }
                    },
                  ),
                ),
                /*
                RaisedButton(
                  child: Text('Sil'),
                    onPressed: () {
                      _allUserListDelete(context);
                    },
                )

                 */
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _allUserListDelete(BuildContext context) async {
    await databaseHelper.allUserListDelete().then((silinenElemanSayisi) {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(silinenElemanSayisi.toString() + " kayıt silindi"),
          duration: Duration(seconds: 2),
        ),
      );

      setState(() {
        allUserList.clear();
      });
    });
  }
}

class CSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('3. sayfa'),
      ),
    );
  }
}
