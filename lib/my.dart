import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setWidth(65),
                  right: ScreenUtil.getInstance().setWidth(30)),
              alignment: Alignment.topRight,
              child: Image.asset('images/my_message.png'),
            ),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(24)),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/default_avatar.png',
                    width: ScreenUtil.getInstance().setWidth(130),
                  ),
                  Container(
                    width: ScreenUtil.getInstance().setWidth(24),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '点击登录',
                        style: TextStyle(
                            color: Color(0xffF5DA9C), fontSize: ScreenUtil.getInstance().setSp(34)),
                      ),
                      Container(
                        height: ScreenUtil.getInstance().setWidth(30),
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'images/img_medal_add.png',
                            width: ScreenUtil.getInstance().setWidth(36),
                          ),
                          Container(
                            width: ScreenUtil.getInstance().setWidth(12),
                          ),
                          Image.asset('images/img_medal_add.png',
                              width: ScreenUtil.getInstance().setWidth(36)),
                          Container(
                            width: ScreenUtil.getInstance().setWidth(12),
                          ),
                          Image.asset('images/img_medal_add.png',
                              width: ScreenUtil.getInstance().setWidth(36)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
