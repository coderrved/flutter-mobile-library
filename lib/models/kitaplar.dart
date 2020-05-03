class Kitaplar{
  int _kitapId;
  String _kitapAdi;
  String _isbnNo;
  String _kitapSayisi;

  int get kitapId => _kitapId;

  set kitapId(int value) {
    _kitapId = value;
  }

  String get kitapAdi => _kitapAdi;

  set kitapAdi(String value) {
    _kitapAdi = value;
  }

  String get isbnNo => _isbnNo;

  set isbnNo(String value) {
    _isbnNo = value;
  }

  String get kitapSayisi => _kitapSayisi;

  set kitapSayisi(String value) {
    _kitapSayisi = value;
  }

  Kitaplar(this._kitapAdi, this._isbnNo, this._kitapSayisi);

  Map<String, dynamic>toMap(){

    var map = Map<String, dynamic>();

    map['kitapId']=_kitapId;
    map['kitapAdi']=_kitapAdi;
    map['isbnNo']=_isbnNo;
    map['kitapSayisi']=_kitapSayisi;

    return map;

  }

  Kitaplar.fromMap(Map<String, dynamic> map){
    this._kitapId = map['kitapId'];
    this._kitapAdi = map['kitapAdi'];
    this._isbnNo = map['isbnNo'];
    this._kitapSayisi = map['kitapSayisi'];

  }

  @override
  String toString() {
    return 'Kitaplar{_kitapId: $_kitapId, _kitapAdi: $_kitapAdi, _isbnNo: $_isbnNo, _kitapSayisi: $_kitapSayisi}';
  }
}