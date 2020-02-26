import 'package:flutter/material.dart';

class BGImage extends StatelessWidget {

  final String path;

  BGImage({this.path});

  @override
  Widget build(BuildContext context) {
    return Image.asset(path,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover);
  }
}
