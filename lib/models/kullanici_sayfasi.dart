import 'package:flutter/material.dart';
import 'package:kutuphane/models/zaman_atlama.dart';

import '../main.dart';
import 'kitap_al.dart';
import 'kitap_ekle.dart';
import 'kullanici_listele.dart';


class KullaniciSayfasi extends StatefulWidget {
  @override
  _KullaniciSayfasiState createState() => _KullaniciSayfasiState();
}

class _KullaniciSayfasiState extends State<KullaniciSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kullanici Sayfasi',
          style: TextStyle(color: Colors.black, fontSize: 22.0),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'Çıkış Yap',
                style: TextStyle(fontSize: 16.0, color: Colors.red),
              ),
            ),
            onTap: () {
              print('Çıkış yapılıyor...');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/user.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('Kitap Al');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KitapAl(),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'Kitap Al',
                    style:
                    TextStyle(fontSize: 18.0, color: Colors.orangeAccent),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Kitap Teslim Et');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZamanAtlama(),
                    ),
                  );
                },
                child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Kitap',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.orangeAccent),
                        ),
                        Text(
                          'Teslim',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.orangeAccent),
                        ),
                      ],
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
