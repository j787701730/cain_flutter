import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataBase extends StatefulWidget {
  @override
  _DataBaseState createState() => _DataBaseState();
}

// 数据库
class _DataBaseState extends State<DataBase> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffE8DAC5),
          image: DecorationImage(
              alignment: Alignment.topCenter, image: AssetImage('images/title_bar_bg.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(
//                left: ScreenUtil.getInstance().setWidth(24),
//                right: ScreenUtil.getInstance().setWidth(24),
                  ),
              child: Center(
                child: Image.asset(
                  'images/back.png',
                  width: ScreenUtil.getInstance().setWidth(30),
                ),
              ),
            ),
          ),
          title: Text('数据库',
              style: TextStyle(
                color: Color(0xffFFDF8E),
              )),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().setWidth(20),
                    right: ScreenUtil.getInstance().setWidth(20)),
                child: Center(
                  child: Text('搜索', style: TextStyle(color: Color(0xffFFDF8E), fontSize: 20)),
                ))
          ],
        ),
        body: Container(
          color: Color(0xffE8DAC5),
        ),
      ),
    );
  }
}
