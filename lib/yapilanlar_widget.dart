import 'dart:io';

import 'package:flutter/material.dart';

List<String> dosyadanOku() {
  var dosya = File("D:/data1.txt");
  return dosya.readAsLinesSync();
}

class YapilanlarWidget extends StatefulWidget {
  List<String>? kayitlar;

  YapilanlarWidget() {
    kayitlar = dosyadanOku();
  }

  @override
  State<YapilanlarWidget> createState() => _YapilanlarWidgetState();
}

class _YapilanlarWidgetState extends State<YapilanlarWidget> {
  void guncelle(index) {
    setState(() {
      var seciliKayit = widget.kayitlar![index];
      widget.kayitlar!.removeAt(index);
      var dosya = File("D:/data1.txt");
      var cikti = "";
      for (int i = 0; i < widget.kayitlar!.length; i++) {
        cikti += widget.kayitlar![i] + "\n";
      }
      dosya.writeAsStringSync(cikti);

      var yapilanlarDosyasi = File("D:/data0.txt");
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
