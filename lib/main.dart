import 'package:flutter/material.dart';
import 'package:kutuphane/models/users.dart';
import 'package:kutuphane/utils/database_helpers.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseHelper databaseHelper;
  String _name;

  @override
  void initState() {
    super.initState();
    allUserList = List<Users>();
    databaseHelper = DatabaseHelper();
    databaseHelper.allUsers().then((mapListesi) {   // Veritabanındaki kullanıcılar uygulama başlarken listeye atıldı.
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
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'kullanıcı adı boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _name = value;
                    },
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
                  child: TextField(
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
                            builder: (context) => Asayfasi(),
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
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        if(allUserList[0].kullaniciAdi == _name){
                          print('basariyla giris yapildi.');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CSayfasi(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  ekle() async{
    await databaseHelper.userEkle(Users('Vedat','ved','ved'));
    var sonuc = await databaseHelper.allUsers();
    debugPrint("Sonuc: " + sonuc[0]['kullaniciAdi']);
  }
}

class Asayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: TextField(
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
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                  child: TextField(
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin:
                  EdgeInsets.symmetric(horizontal: 30.0,vertical: 5.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Confirm Şifre',
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
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin:
                  EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0,
                      ),
                      suffixIcon: Icon(
                        Icons.mail,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 50,
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: RaisedButton(
                    color: Colors.black45,
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    onPressed: () {
                      print('giris yapildi.');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CSayfasi(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class CSayfasi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('3. sayfa'),
      ),
    );
  }

}
