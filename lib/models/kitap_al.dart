import 'package:flutter/material.dart';
import 'package:kutuphane/models/kitaplar.dart';
import 'package:kutuphane/utils/database_helpers.dart';

class KitapAl extends StatefulWidget {
  @override
  _KitapAlState createState() => _KitapAlState();
}

class _KitapAlState extends State<KitapAl> {

  List<Kitaplar> tumKitaplarList;
  DatabaseHelper databaseHelper;
  List<int> kitapSay;
  List<String> kitapAdi;


  @override
  void initState() {
    super.initState();
    tumKitaplarList = List<Kitaplar>();
    databaseHelper = DatabaseHelper();
    databaseHelper.allUsers().then((mapListesi) {
      // Veritabanındaki kullanıcılar uygulama başlarken listeye atıldı.
      for (Map okunanMap in mapListesi) {
        tumKitaplarList.add(Kitaplar.fromMap(okunanMap));
      }
      for(int k=0;k<tumKitaplarList.length;k++){
        print(tumKitaplarList[k]);
      }
      kitapSay = List.generate(tumKitaplarList.length, (index)=>index);
      kitapAdi = List.generate(tumKitaplarList.length, (index)=> "$index" );

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: kitapSay.map(
              (oAnkiEleman) => Column(
                children: <Widget>[
                  Container(
                    child: Card(
                      margin: EdgeInsets.all(12.0),
                      color: Colors.orangeAccent,
                      elevation: 10,
                      child: ListTile(
                        title: Text(tumKitaplarList[oAnkiEleman].toString()),
                        trailing: Icon(Icons.add_circle),
                      ),
                    ),
                  )
                ],
              )
          ).toList(),
        ),
      ),
    );
  }
}

/*
child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Card(
                    margin: EdgeInsets.all(12.0),
                    color: Colors.orangeAccent,
                    elevation: 10,
                    child: ListTile(
                      title: Text("Deneme yazisi"),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  child: Card(
                    margin: EdgeInsets.all(12.0),
                    color: Colors.orangeAccent,
                    elevation: 10,
                    child: ListTile(
                      title: Text("Deneme yazisi"),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
 */
