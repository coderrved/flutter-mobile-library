import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kutuphane/models/kitaplar.dart';
import 'package:kutuphane/utils/database_helpers.dart';

class KitapAl extends StatefulWidget {
  @override
  _KitapAlState createState() => _KitapAlState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _KitapAlState extends State<KitapAl> {
  List<Kitaplar> allKitapList;
  List<Kitaplar> filteredKitapList;
  DatabaseHelper databaseHelper;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    allKitapList = List<Kitaplar>();
    databaseHelper = DatabaseHelper();
    databaseHelper.allKitaplar().then((mapListesi) {
      // Veritabanındaki kullanıcılar uygulama başlarken listeye atıldı.
      for (Map okunanMap in mapListesi) {
        allKitapList.add(Kitaplar.fromMap(okunanMap));
      }
      setState(() {
        filteredKitapList = allKitapList;
      });
    }).catchError((hata) => print("hata:" + hata));
  }

  void _filterCountries(value) {
    setState(() {
      filteredKitapList = allKitapList
          .where((country) =>
              country.kitapAdi.toLowerCase().contains(value.toLowerCase()) || country.isbnNo.contains(value))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSearching
            ? Text('Tüm Kitaplar')
            : TextField(
                onChanged: (value) {
                  _filterCountries(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Kitap Ara",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      filteredKitapList = allKitapList;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          padding: EdgeInsets.all(5),
          child: Card(
          child: filteredKitapList.length > 0
              ? ListView.builder(
                  itemCount: filteredKitapList.length,
                  itemBuilder: (BuildContext context, int index) {
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
                              child: Text(filteredKitapList[index].kitapSayisi, style: TextStyle(fontSize: 18.0),),
                              margin: EdgeInsets.all(15.0),
                            ),
                            Container(
                              child: Text(filteredKitapList[index].kitapAdi, style: TextStyle(fontSize: 18.0,), textAlign: TextAlign.center,),
                              //margin: EdgeInsets.symmetric(horizontal: 40.0),
                            ),
                            Container(
                              child: Text(filteredKitapList[index].isbnNo, style: TextStyle(fontSize: 18.0), textAlign: TextAlign.right,),
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
                  })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      ),
    );
  }
}
