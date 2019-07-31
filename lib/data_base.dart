import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data_base_equipment.dart';

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
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/fragment_tools_bg.jpg'), fit: BoxFit.fill),
            color: Color(0xffE8DAC5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new DataBaseEquipment()),
                  );
                },
                child: Container(
                  width: ScreenUtil.getInstance().setWidth(470),
                  height: ScreenUtil.getInstance().setHeight(84),
                  decoration: BoxDecoration(
                      color: Color(0xffB51610),
                      border: Border.all(
                          color: Color(0xffB5A88E), width: ScreenUtil.getInstance().setWidth(1)),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Center(
                    child: Text(
                      '装备数据库',
                      style: TextStyle(
                          color: Color(0xffF3D79A), fontSize: ScreenUtil.getInstance().setSp(34)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(12),
                    bottom: ScreenUtil.getInstance().setHeight(60)),
                child: Text(
                  '当前版本：2.6.5',
                  style: TextStyle(
                      color: Color(0xffB6A98F), fontSize: ScreenUtil.getInstance().setSp(22)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(60)),
                height: ScreenUtil.getInstance().setHeight(30),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/database_divider.png'))),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: ScreenUtil.getInstance().setWidth(470),
                  height: ScreenUtil.getInstance().setHeight(84),
                  decoration: BoxDecoration(
                      color: Color(0xffB51610),
                      border: Border.all(
                          color: Color(0xffB5A88E), width: ScreenUtil.getInstance().setWidth(1)),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Center(
                    child: Text(
                      '技能数据库',
                      style: TextStyle(
                          color: Color(0xffF3D79A), fontSize: ScreenUtil.getInstance().setSp(34)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(12),
                    bottom: ScreenUtil.getInstance().setHeight(60)),
                child: Text(
                  '当前版本：2.6.5',
                  style: TextStyle(
                      color: Color(0xffB6A98F), fontSize: ScreenUtil.getInstance().setSp(22)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(60)),
                height: ScreenUtil.getInstance().setHeight(30),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/database_divider.png'))),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: ScreenUtil.getInstance().setWidth(470),
                  height: ScreenUtil.getInstance().setHeight(84),
                  decoration: BoxDecoration(
                      color: Color(0xffB51610),
                      border: Border.all(
                          color: Color(0xffB5A88E), width: ScreenUtil.getInstance().setWidth(1)),
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Center(
                    child: Text(
                      '传奇宝石',
                      style: TextStyle(
                          color: Color(0xffF3D79A), fontSize: ScreenUtil.getInstance().setSp(34)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setHeight(12),
                ),
                child: Text(
                  '当前版本：2.6.5',
                  style: TextStyle(
                      color: Color(0xffB6A98F), fontSize: ScreenUtil.getInstance().setSp(22)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
