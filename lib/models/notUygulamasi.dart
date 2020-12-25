class Notlar{
  int _id;
  String _baslik;
  String _aciklama;
  String _tarih;

  int get id=>_id;

  set id(int value){
    _id=value;
  }
    String get baslik=>_baslik;

  set baslik(String value){
    _baslik=value;
  }
    String get aciklama=>_aciklama;

  set aciklama(String value){
    _aciklama=value;
  }
      String get tarih=>_tarih;

  set tarih(String value){
    _tarih=value;
  }


  Notlar(this._baslik,this._aciklama , this._tarih);
  Notlar.withID(this._id,this._baslik,this._aciklama,this._tarih);

  Map<String, dynamic> dbYaz(){
    var map=Map<String ,dynamic>();
    map["id"]=_id;
    map["baslik"]=_baslik;
    map["aciklama"]=_aciklama;
    map["tarih"]=_tarih;
    return map;
  } 
  Notlar.dbOku(Map<String ,dynamic> map){
    this._id=map["id"];
    this._baslik=map["baslik"];
    this._aciklama=map["aciklama"];
    this._tarih=map["tarih"];


  }

}
