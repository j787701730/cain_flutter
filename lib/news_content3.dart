import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsContent3 extends StatefulWidget {
  final props;

  NewsContent3(this.props);

  @override
  _NewsContent3State createState() => _NewsContent3State();
}

class _NewsContent3State extends State<NewsContent3> {

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
      child: WebviewScaffold(
//        backgroundColor: Colors.transparent,
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
                  width: ScreenUtil.getInstance().setWidth(42),
                ),
              ),
            ),
          ),
          title: Text(
            widget.props['title'],
            style: TextStyle(
                color: Color(0xffF5DA9C), fontSize: ScreenUtil.getInstance().setSp(28)),
          ),
          // type: 1=> 帖子 0 => 其他
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().setWidth(20),
                    right: ScreenUtil.getInstance().setWidth(20)),
                child: Image.asset(
                  'images/icon_title_more.png',
                  width: ScreenUtil.getInstance().setWidth(56),
                ))
          ],
        ),
        url: 'https://d.163.com/d163com/s/reservation',
      ),
    );
  }
}
