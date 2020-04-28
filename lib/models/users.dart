class Users{
  int _id;
  String _kullaniciAdi;
  String _sifre;
  String _email;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get sifre => _sifre;

  set sifre(String value) {
    _sifre = value;
  }

  String get kullaniciAdi => _kullaniciAdi;

  set kullaniciAdi(String value) {
    _kullaniciAdi = value;
  }

  Users(this._kullaniciAdi, this._sifre, this._email);

  Map<String, dynamic>toMap(){

    var map = Map<String, dynamic>();

    map['id']=_id;
    map['kullaniciAdi']=_kullaniciAdi;
    map['sifre']=_sifre;
    map['email']=_email;

    return map;

  }

  Users.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._kullaniciAdi = map['kullaniciAdi'];
    this._sifre = map['sifre'];
    this._email = map['email'];

  }

  @override
  String toString() {
    return 'Users{_id: $_id, _kullaniciAdi: $_kullaniciAdi, _sifre: $_sifre, _email: $_email}';
  }


}