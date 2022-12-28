import 'dart:io';

import 'package:flutter/material.dart';

List<String> dosyadanOku() {
  var dosya = File("D:/data0.txt");
  return dosya.readAsLinesSync();
}

class YapilacaklarWidget extends StatefulWidget {
  List<String>? kayitlar;

  YapilacaklarWidget() {
    kayitlar = dosyadanOku();
  }

  @override
  State<YapilacaklarWidget> createState() => _YapilacaklarWidgetState();
}

class _YapilacaklarWidgetState extends State<YapilacaklarWidget> {
  void guncelle(index) {
    setState(() {
      var seciliKayit = widget.kayitlar![index];
      widget.kayitlar!.removeAt(index);
      var dosya = File("D:/data0.txt");
      var cikti = "";
      for (int i = 0; i < widget.kayitlar!.length; i++) {
        cikti += widget.kayitlar![i] + "\n";
      }
      dosya.writeAsStringSync(cikti);

      var yapilanlarDosyasi = File("D:/data1.txt");
      yapilanlarDosyasi.writeAsString(seciliKayit + "\n",
          mode: FileMode.append);
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.kayitlar = dosyadanOku();
    });

    return ListView.builder(
      itemCount: widget.kayitlar!.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(widget.kayitlar![index]),
        onTap: () => guncelle(index),
      ),
    );
  }
}
