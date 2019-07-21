import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  image: AssetImage('images/icon_pgall_menuebg.png'), fit: BoxFit.cover)),
          child: Stack(
            children: <Widget>[
              Container(
                child: Image.asset('images/img_search.png'),
              ),
              Positioned(
                  top: 9,
                  left: 15,
                  child: Image.asset(
                    'images/icon_search.png',
                    width: 20,
                  )),
              Positioned(
                  top: 11,
                  left: 44,
                  child: Text(
                    '搜索关键词',
                    style: TextStyle(color: Color(0xffB5A88E), fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xffE8DAC5),
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
