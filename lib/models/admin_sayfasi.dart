import 'package:flutter/material.dart';
import 'package:kutuphane/main.dart';
import 'package:kutuphane/models/kullanici_listele.dart';
import 'package:kutuphane/models/zaman_atlama.dart';

import 'kitap_ekle.dart';

class AdminSayfasi extends StatefulWidget {
  @override
  _AdminSayfasiState createState() => _AdminSayfasiState();
}

class _AdminSayfasiState extends State<AdminSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Admin Panel',
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
            image: AssetImage("assets/images/admin.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('Kitap Ekle');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KitapEkle(),
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
                    'Kitap Ekle',
                    style:
                        TextStyle(fontSize: 18.0, color: Colors.orangeAccent),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Zaman Atla');
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
                          'Zaman',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.orangeAccent),
                        ),
                        Text(
                          'Atlama',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.orangeAccent),
                        ),
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () {
                  print('Kullanıcıları Listele');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KullaniciListele(),
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
                          'Kullanıcıları',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.orangeAccent),
                        ),
                        Text(
                          'Listele',
                          style: TextStyle(
                              fontSize: 18.0, color: Colors.orangeAccent),
                        )
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
