import 'package:flutter/gestures.dart';
import 'package:kutuphane/utils/database_helpers.dart';
import 'package:flutter/material.dart';
import 'package:kutuphane/models/users.dart';

import 'admin_sayfasi.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  String _name;
  String _email;
  String _password;
  String _confirmPassword;
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  DatabaseHelper _databaseHelper;
  List<Users> allUserList;

  @override
  void initState() {
    super.initState();
    allUserList = List<Users>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.allUsers().then((mapListesi) {
      // Veritabanındaki kullanıcılar uygulama başlarken listeye atıldı.
      for (Map okunanMap in mapListesi) {
        allUserList.add(Users.fromMap(okunanMap));
      }
      setState(() {});
    }).catchError((hata) => print("hata:" + hata));
  }

  Widget _buildName() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        validator: (String value) {
          if (value.length < 3) {
            return "3 karakterden kucuk olamaz";
          }
          return null;
        },
        onSaved: (String value) {
          _name = value;
        },
        style: TextStyle(color: Colors.black, fontSize: 22.0),
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
    );
  }

  Widget _buildPassword() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      child: TextFormField(
        controller: _passwordController,
        validator: (String sifre) {
          if (sifre.length < 3) {
            return 'Sifre 3 karakterden kucuk olamaz';
          }
          return null;
        },
        onSaved: (String value) {
          _password = value;
        },
        obscureText: true,
        style: TextStyle(color: Colors.black, fontSize: 22.0),
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
    );
  }

  Widget _buildConfirmPassword() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      child: TextFormField(
        validator: (String confirmSifre) {
          if (confirmSifre != _passwordController.text) {
            return 'Sifre eslesemedi.';
          }
          return null;
        },
        onSaved: (String value) {
          _confirmPassword = value;
        },
        obscureText: true,
        style: TextStyle(color: Colors.black, fontSize: 22.0),
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
    );
  }

  Widget _buildEmail() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
      child: TextFormField(
        validator: (String email) {
          if (email.isEmpty) {
            return 'email zorunlu';
          }
          return null;
        },
        onSaved: (String value) {
          _email = value;
        },
        style: TextStyle(color: Colors.black, fontSize: 22.0),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                _buildName(),
                _buildPassword(),
                _buildConfirmPassword(),
                _buildEmail(),
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
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      print(_name);
                      print(_email);
                      print(_password);
                      print(_confirmPassword);
                      _userEkle(Users(_name, _password, _email));
                      print(allUserList.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminSayfasi(),
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

  void _userEkle(Users users) async {
    var eklenenYeniUserinIDsi = await _databaseHelper.userEkle(users);
    users.id = eklenenYeniUserinIDsi;
    if (eklenenYeniUserinIDsi > 0) {
      setState(() {
        allUserList.insert(0, users);
      });
    }
  }
}
