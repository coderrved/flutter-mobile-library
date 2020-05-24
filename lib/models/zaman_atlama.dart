import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZamanAtlama extends StatefulWidget {
  @override
  _ZamanAtlamaState createState() => _ZamanAtlamaState();
}

class _ZamanAtlamaState extends State<ZamanAtlama> {

  final _time = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Zaman Atlama",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: new GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Zaman Atlama Bölümü", style: TextStyle(color: Colors.orangeAccent, fontSize: 22.0),),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                child: TextFormField(
                  controller: _time,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Zaman Atla',
                    hintStyle: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 22.0,
                    ),
                    suffixIcon: Icon(
                      Icons.access_time,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                color: Colors.white54,
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Text("Zaman Atlat",style: TextStyle(color: Colors.orangeAccent, fontSize: 22.0,),),
                onPressed: (){
                  
                  print("zaman atladıldı");
                },
              )
            ],
          )
        ),
      ),
    );
  }
}
