import 'package:flutter/material.dart';
import 'dart:io';

class LargeImagePage extends StatefulWidget {
  const LargeImagePage({Key key, this.imgpath}) : super(key: key);

  final String imgpath;
  @override
  _LargeImagePageState createState() => _LargeImagePageState();
}

class _LargeImagePageState extends State<LargeImagePage> {
  @override
  Widget build(BuildContext context) {
    File imFile = File(widget.imgpath);
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Center(
            child: Image.file(imFile),
          ),
        ));
  }
}
