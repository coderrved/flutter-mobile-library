import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class KitapEkle extends StatefulWidget {
  @override
  _KitapEkleState createState() => _KitapEkleState();
}

class _KitapEkleState extends State<KitapEkle> {
  File pickedImage;
  List kelimeleriTut = new List();
  String ISBNtut;
  bool isImageLoaded = false;
  final _kitapAdi = TextEditingController();

  RegExp _isbn10Maybe = RegExp(r'^(?:[0-9]{9}X|[0-9]{10})$');

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
      if (kelimeleriTut[i].toString() == 'ISBN:') {
        ISBNtut = kelimeleriTut[i + 1];
        print('ISBN numarası: ' + ISBNtut);
        RegExp isbnCekenRegExp = RegExp(
            r'^(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+$'); // ISBN numarasi için regex
        final match = isbnCekenRegExp.stringMatch(ISBNtut);
        String gereksizleriKaldir = match.replaceAll(RegExp(r'[\s-]+'), '');
        print('son durumda isbn: ' + gereksizleriKaldir);
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
        body: Center(
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
                            onPressed: (){
                              print('Kitap kaydet');
                            },
                            child: Text('Kitap Kayıt'),
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
        ));
  }
}
