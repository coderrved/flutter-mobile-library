import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:kutuphane/models/kitaplar.dart';
import 'package:kutuphane/utils/database_helpers.dart';

class KitapEkle extends StatefulWidget {
  @override
  _KitapEkleState createState() => _KitapEkleState();
}

class _KitapEkleState extends State<KitapEkle> {

  DatabaseHelper _databaseHelper;
  List<Kitaplar> allKitapList;
  String gereksizleriKaldirr;
  @override
  void initState() {
    super.initState();
    allKitapList = List<Kitaplar>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.allKitaplar().then((mapListesi) {
      // Veritabanındaki kullanıcılar uygulama başlarken listeye atıldı.
      for (Map okunanMap in mapListesi) {
        allKitapList.add(Kitaplar.fromMap(okunanMap));
      }
      setState(() {});
    }).catchError((hata)=>print("hata:"+hata));
  }

  File pickedImage;
  List kelimeleriTut = new List();
  String ISBNtut;
  bool isImageLoaded = false;
  final _kitapAdi = TextEditingController();
  static String sonISBN = '';

  Future pickImage() async {
    var tempStore = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      pickedImage = tempStore;
      isImageLoaded = true;
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          print(word.text);
          kelimeleriTut.add(word.text);
        }
      }
    }
    for (int i = 0; i < kelimeleriTut.length; i++) {
      print('kelime: ' + kelimeleriTut[i]);
      bool isbn = kelimeleriTut[i].toString().startsWith("ISBN");
      if(isbn == true){
            gereksizleriKaldirr = kelimeleriTut[i].replaceAll(RegExp(r'[\s-:.,:]+'), ''); // ISBN içerisinde okuma hatalarından kaynaklı noktalı işaretler varsa onları çıkar
            print('ISBN kelimesinin son hali: ' + gereksizleriKaldirr);
      }
      if (gereksizleriKaldirr == 'ISBN') {
        ISBNtut = kelimeleriTut[i + 1];
        print('ISBN numarası: ' + ISBNtut);
        sonISBN = ISBNtut.replaceAll(RegExp(r'[\s-]+'), '');
        print('son durumda isbn: ' + sonISBN);
        setState(() {

        });
        break;
      }
    }
  }

  Future decode() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(pickedImage);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      print(readableCode.displayValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
         child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              isImageLoaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 200.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(pickedImage),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: TextFormField(
                            controller: _kitapAdi,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Kitap Ekle',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                          color: Colors.black45,
                          child: Text(
                            "Kitap Kayıt Et",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                          onPressed: () {
                            print('kitap kaydedildi.');
                            _kitapEkle(Kitaplar(_kitapAdi.text,sonISBN,'1'));
                            print(allKitapList.toString());
                          },
                        ),
                        )
                      ],
                    )
                  : Container(),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Pick an image'),
                onPressed: pickImage,
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Read Text'),
                onPressed: readText,
              ),
              RaisedButton(
                child: Text('Read Bar Code'),
                onPressed: decode,
              )
            ],
          ),
         ),
        )
    );
  }
  void _kitapEkle(Kitaplar kitaplar) async{
    var eklenenYeniKitabinIDsi = await _databaseHelper.kitapEkle(kitaplar);
    kitaplar.kitapId = eklenenYeniKitabinIDsi;
    if(eklenenYeniKitabinIDsi>0){
      setState(() {
        allKitapList.insert(0, kitaplar);
      });
    }
  }
}
