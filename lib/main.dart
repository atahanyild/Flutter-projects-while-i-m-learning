import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/*
buglar:
klavye açılınca textfield kapanıyor
listeye fazla ekleme yapınca bug oluyor
*/ 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  RxString eklemeYapilacak = "meyve".obs;

  var meyveler = ["elma", "armut", "muz"].obs;

  var sehirler = ["istanbul", "ankara", "köln"].obs;

  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(eklemeYapilacak + "homepage");
    return Scaffold(
      appBar: AppBar(title: Text("List Manager")),
      body: Center(
          child: Column(
        children: [
          UstMenu(eklenecek: eklemeYapilacak),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShowList(baslik: "Meyveler", liste: meyveler),
                  ShowList(baslik: "Şehirler", liste: sehirler),
                ],
              ),
            ],
          ),
          eklemeBolumu(eklenecek: eklemeYapilacak,meyveler:meyveler,sehirler: sehirler,controller: controller),
        ],
      )),
    );
  }
}

class ShowList extends StatelessWidget {
  ShowList(
      {super.key,
      required var this.baslik,
      required var this.liste});
  var liste;
  final String baslik;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(7),
      child: Obx(()=>Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            baslik + ":",
            textScaleFactor: 3,
          ),
          for (var i in liste)
            //Obx(()=>
            Text(
              i,
              textScaleFactor: 2,
            ),
           // )
        ],
      ),
   )
       );
  }
}

class UstMenu extends StatefulWidget {
  UstMenu({super.key, required RxString this.eklenecek});
  RxString eklenecek;

  @override
  State<UstMenu> createState() => _UstMenuState();
}

class _UstMenuState extends State<UstMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Hangisine ekleme yapmak istiyorsunuz?",
            textScaleFactor: 1.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    widget.eklenecek.value = "meyve";

                    print(widget.eklenecek);
                  },
                  child: Text("Meyveler")),
              ElevatedButton(
                  onPressed: () {
                    widget.eklenecek.value = "şehir";
                    print(widget.eklenecek);
                  },
                  child: Text("Şehirler")),
            ],
          ),
        ],
      ),
    );
  }
}

class eklemeBolumu extends StatefulWidget {
  eklemeBolumu({super.key, required RxString this.eklenecek, required List<String> this.meyveler,required List<String> this.sehirler, required TextEditingController this.controller});
  RxString eklenecek;
  List<String> meyveler;
  List<String> sehirler;
  TextEditingController controller;
  @override
  State<eklemeBolumu> createState() => _eklemeBolumuState();
}

class _eklemeBolumuState extends State<eklemeBolumu> {
  @override
  Widget build(BuildContext context) {
    print(widget.eklenecek + "eklemebolumu");
    return Container(
      child: Column(
        children: [
          Obx(() => Text("Eklenecek yeni  ${widget.eklenecek}")),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 300, child: TextField(controller: widget.controller,)),
              ElevatedButton(onPressed: () {
              if(widget.eklenecek=="meyve"&&widget.controller.text!=null){
                widget.meyveler.add(widget.controller.text);
              }
              else if(widget.eklenecek=="şehir"&&widget.controller.text!=null){
                widget.sehirler.add(widget.controller.text);
              }
              }, child: Text("Ekle"))
            ],
          )
        ],
      ),
    );
  }
}