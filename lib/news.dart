import 'package:flutter/material.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage('images/icon_pgall_menuebg.png'), fit: BoxFit.cover))),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
