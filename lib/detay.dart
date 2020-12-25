import 'package:flutter/material.dart';

class Detay extends StatelessWidget {
  String baslik;
  String aciklama;
  String tarih;
  
  Detay(this.baslik, this.aciklama, this.tarih);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "${baslik.toUpperCase()}",
        textAlign: TextAlign.center,
      )),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
               
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("$tarih  | ${aciklama.length} karakter" ,style: TextStyle(fontSize:13 ,color:Colors.grey),),
                    Text("${baslik.toUpperCase()}" ,style: TextStyle(fontSize:25, fontWeight:FontWeight.bold),),
                    Text(" $aciklama" ,style: TextStyle(fontSize:18,  ),textAlign: TextAlign.center,),
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
