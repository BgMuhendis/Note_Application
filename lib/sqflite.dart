import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:kalici_depolama/detay.dart';
import 'package:kalici_depolama/units/database_helper.dart';

import 'models/notUygulamasi.dart';

class SqfliteIslemleri extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SqfliteIslemiState();
}

class _SqfliteIslemiState extends State<SqfliteIslemleri> {
  String baslik;
  String aciklama;
  var formKey = GlobalKey<FormState>();
  DatabaseHelper _databaseHelper;
  List<Notlar> tumNotlar;
  DateTime nowToday;
  TimeOfDay nowTime;
  static int value = 0;

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    tumNotlar = List<Notlar>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.butunNotlar().then((value) {
      for (Map readNotes in value) {
        setState(() {
          tumNotlar.add(Notlar.dbOku(readNotes));
        });
      }
      print(tumNotlar.length.toString());
    }).catchError((error) => print("Error:" + error));
  }

  @override
  Widget build(BuildContext context) {
    nowToday = DateTime.now();
    nowTime = TimeOfDay.now();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("NOT DEFTERİ"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            _notunuEkle(Notlar(
                baslik,
                aciklama,
                nowToday.day.toString() +
                    "/" +
                    nowToday.month.toString() +
                    "/" +
                    nowToday.year.toString() +
                    " " +
                    nowTime.hour.toString() +
                    ":" +
                    nowTime.minute.toString()));
          }
        },
        child: Icon(Icons.note_add),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // fomrları tutan yer

            Container(
              padding: EdgeInsets.all(20),
              color: Colors.amber.shade200,
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      maxLength: 20,
                      decoration: InputDecoration(
                        labelText: "Başlık",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 3)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 3)),
                      ),
                      validator: (value) {
                        if (value.length > 0) {
                          return null;
                        } else {
                          return "Başlık kısmı boş geçilemez";
                        }
                      },
                      onSaved: (newValue) {
                        baslik = newValue;
                      },
                    ),
                    TextFormField(
                      maxLength: 100,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Açıklama",
                        labelStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 3)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.brown, width: 3)),
                      ),
                      validator: (value) {
                        if (value.length > 0) {
                          return null;
                        } else {
                          return "Açıklama kısmı boş geçilemez";
                        }
                      },
                      onSaved: (newValue) {
                        aciklama = newValue;
                      },
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.purple, width: 4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                margin: EdgeInsets.only(left: 5),
                                width: 100,
                                height: 50,
                                child: RaisedButton(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.note_add),
                                      Text(
                                        "EKLE",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  color: Colors.yellow,
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      formKey.currentState.save();
                                      _notunuEkle(Notlar(
                                          baslik,
                                          aciklama,
                                          nowToday.day.toString() +
                                              "/" +
                                              nowToday.month.toString() +
                                              "/" +
                                              nowToday.year.toString() +
                                              " " +
                                              nowTime.hour.toString() +
                                              ":" +
                                              nowTime.minute.toString()));
                                    }
                                  },
                                )),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                height: 50,
                                margin: EdgeInsets.only(left: 25),
                                alignment: Alignment.center,
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "Eklenen Notlar: ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        )),
                                    TextSpan(
                                        text: "${tumNotlar.length}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple,
                                        )),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),

            //listeleri tutacak yer
            Expanded(
              // color: Colors.pink.shade200,
              child: ListView.builder(
                itemCount: tumNotlar.length,
                itemBuilder: _listElemanlariOlustur,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listElemanlariOlustur(BuildContext context, int index) {
    value++;
    return Dismissible(
      key: Key(value.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        _notunuSil(tumNotlar[index].id, index);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.brown, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.all(8),
        child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detay(tumNotlar[index].baslik,
                      tumNotlar[index].aciklama, tumNotlar[index].tarih))),
          leading: CircleAvatar(
            child: Text(
              tumNotlar[index].baslik[0].toUpperCase(),
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.brown,
          ),
          title: Text(tumNotlar[index].baslik),
          subtitle: Text("Zaman: " + tumNotlar[index].tarih),
          trailing: GestureDetector(
            onTap: () {
              _notunuSil(tumNotlar[index].id, index);
            },
            child: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }

  void _notunuEkle(Notlar notlar) async {
    var newNotId = await _databaseHelper.notEkle(notlar);
    if (newNotId > 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("${notlar.baslik} başlıklı not eklendi"),
      ));

      setState(() {
        tumNotlar.insert(0, notlar);
        baslik = "";
        aciklama = "";
      });
    }
  }

  void _notunuSil(int value, int index) async {
    var result = await _databaseHelper.notSil(value);
    if (result >= 0) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("${tumNotlar[index].baslik} başlıklı not silindi"),
      ));
      setState(() {
        tumNotlar.removeAt(index);
        baslik = "";
        aciklama = "";
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Problem Çıktı"),
      ));
    }
  }
}
