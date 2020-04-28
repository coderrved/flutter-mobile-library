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

  DatabaseHelper databaseHelper;
  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }



  @override
  Widget build(BuildContext context) {

    var aa = DatabaseHelper();
    aa.userEkle(Users("vedat","vedat","vedat@ved"));
    aa.userEkle(Users("dilay","vedat","vedat@ved"));
    aa.userEkle(Users("cigdem","vedat","vedat@ved"));
    aa.userEkle(Users("annem","vedat","vedat@ved"));
    aa.userEkle(Users("babam","vedat","vedat@ved"));

    


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
  
  ekle() async{
    databaseHelper.userEkle(Users('Vedat','ved','ved'));
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
