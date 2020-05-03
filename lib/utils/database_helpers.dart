
import 'dart:async';
import 'dart:io';
import 'package:kutuphane/models/users.dart';
import 'package:kutuphane/models/kitaplar.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static DatabaseHelper _databaseHelper;
  static Database _database;

  String _userTablosu = 'users';
  String _kitapTablosu = 'kitaplar';
  String _kitapId = 'kitapId';
  String _kitapAdi = 'kitapAdi';
  String _isbnNo = 'isbnNo';
  String _kitapSayisi= 'kitapSayisi';
  String _id = 'id';
  String _kullaniciAdi = 'kullaniciAdi';
  String _sifre = 'sifre';
  String _email = 'email';

  DatabaseHelper._internal();

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      print("DATA BASE HELPER NULL, OLUSTURULACAK");
      _databaseHelper =  DatabaseHelper._internal();
      return _databaseHelper;
    }else{
      print("DATA BASE HELPER NULL DEGIL");
      return _databaseHelper;
    }

  }

  Future<Database> _getDatabase() async{
    if(_database == null){
      print("DATA BASE NESNESI NULL, OLUSTURULACAK");
     _database = await _initializeDatabase();
     return _database;
    }else{
      print("DATA BASE NESNESI NULL DEĞİL");
      return _database;
    }
  }

  _initializeDatabase() async{

    Directory klasor = await getApplicationDocumentsDirectory();
    String path = join(klasor.path, "users.db");
    print('Olusan veritabanının yolu: $path');

    var userDB = await openDatabase(path, version: 2, onCreate: _createDB);
    return userDB;
}

void _createDB(Database db, int version) async{
    print("CREATE TABLE OLUSTURULUYOR");
    await db.execute("CREATE TABLE $_userTablosu ($_id INTEGER PRIMARY KEY AUTOINCREMENT, $_kullaniciAdi TEXT, $_sifre TEXT, $_email TEXT )");
    await db.execute("CREATE TABLE $_kitapTablosu ($_kitapId INTEGER PRIMARY KEY AUTOINCREMENT, $_kitapAdi TEXT, $_isbnNo TEXT, $_kitapSayisi TEXT )");
}

Future<int> userEkle(Users users) async{
    var db = await _getDatabase();
    var sonDeger = await db.insert(_userTablosu, users.toMap());
    print("ogrenci dbye eklendi: $sonDeger");
    return sonDeger;
}

  Future<int> kitapEkle(Kitaplar kitaplar) async{
    var db = await _getDatabase();
    var sonDeger = await db.insert(_kitapTablosu, kitaplar.toMap());
    print("kitaplar dbye eklendi: $sonDeger");
    return sonDeger;
  }
  Future<List<Map<String, dynamic>>> allUsers() async{
    var db = await _getDatabase();
    var sonuc = db.query(_userTablosu, orderBy: '$_id DESC');
    return sonuc;
  }
  Future<List<Map<String, dynamic>>> allKitaplar() async{
    var db = await _getDatabase();
    var sonuc = db.query(_kitapTablosu, orderBy: '$_kitapId DESC');
    return sonuc;
  }

  Future<int> usersGuncelle(Users users) async{
    var db = await _getDatabase();
    var sonuc = db.update(_userTablosu, users.toMap(), where: '$_id = ?', whereArgs: [users.id]);
    return sonuc;
  }

  Future<int> userSil(int id) async{

    var db = await _getDatabase();
    var sonuc = db.delete(_userTablosu, where: '$_id = ?' , whereArgs: [id]);
    return sonuc;

  }

  Future<int> allUserListDelete() async{

    var db = await _getDatabase();
    var sonuc = db.delete(_userTablosu);
    return sonuc;

  }
}

