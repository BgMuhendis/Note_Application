import 'dart:async';
import 'dart:io';
import 'package:kalici_depolama/models/notUygulamasi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;
  static DatabaseHelper _databaseHelper;
  String _tablo="notTable";
  String _id="id";
  String _baslik="baslik";
  String  _aciklama="aciklama";
  String _tarih="tarih";

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      print("oluşturuldu");
      return _databaseHelper;
      
    } else {
      print("zaten vardı");
      return _databaseHelper;
    }
  }
  DatabaseHelper._internal();
  Future<Database> _getDatabase() async {
    if (_database == null) {
      print("dbolu sturulacak");
      _database = await _initializeDatabase();
      return _database;
    } else {
      print("db var");
      return _database;
    }
  }

  _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbPath = join(klasor.path, "not.db");
    print("DB path:" + dbPath);

    var notDb=openDatabase(dbPath, version: 1, onCreate: _createDB);
    return notDb;
  }

  FutureOr<void> _createDB(Database db, int version) async{
    print("create db metodu calıstı");
    await  db.execute("CREATE TABLE $_tablo($_id INTEGER PRIMARY KEY AUTOINCREMENT ,$_baslik TEXT ,$_aciklama TEXT ,$_tarih TEXT )");
  }
  Future<int> notEkle(Notlar notlar) async {
    var db=await _getDatabase();
    var result=await db.insert(_tablo , notlar.dbYaz() , nullColumnHack: "$_id");
    print("not db ye eklendi"+result.toString());
    return result;
  }
  Future<List<Map<String ,dynamic>>> butunNotlar() async{
    var db= await _getDatabase();
    var sonuc=await db.query(_tablo , orderBy: '$_id DESC');
    return sonuc;
  }
  Future<int> notSil(int id) async{
    var db= await _getDatabase();
    var sonuc=await db.delete(_tablo , where:'$_id  = ? ', whereArgs:[id]);
    return sonuc;
  }
  Future<int> notlariSil() async{
    var db =await _getDatabase();
    var sonuc=await db.delete(_tablo);
    return sonuc;
  }
}
