import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Simulator extends StatefulWidget {
  final props;

  Simulator(this.props);

  @override
  _SimulatorState createState() => _SimulatorState();
}

class _SimulatorState extends State<Simulator> with TickerProviderStateMixin {
  bool flag = true;

  bool show = false;

  @override
  void initState() {
    super.initState();
    _ajax();
  }

  _ajax() async {
    await Future.delayed(Duration(seconds: 2), () {
      if (mounted)
        setState(() {
          flag = false;
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          title: Text(
            '模拟器',
            style: TextStyle(color: Color(0xffFFDF8E)),
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
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
                left: 0,
                top: 0,
                height: height - MediaQuery.of(context).padding.top - 56,
                width: width,
                child: Container(
                  color: Color(0xffE8DAC5),
                  child: flag
                      ? Center(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'images/head_loading1.png',
                              width: ScreenUtil.getInstance().setWidth(78),
                            ),
                            Container(
                              height: ScreenUtil.getInstance().setWidth(10),
                            ),
                            Text(
                              '正在前往大秘境...',
                              style: TextStyle(
                                  color: Color(0xff938373),
                                  fontSize: ScreenUtil.getInstance().setSp(23)),
                            )
                          ],
                        ))
                      : Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'images/simulator_skill_bg.jpg',
                                  ),
                                  fit: BoxFit.fill)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: ScreenUtil.getInstance().setHeight(64),
                              ),
                              Container(
                                height: height -
                                    -MediaQuery.of(context).padding.top -
                                    56 -
                                    ScreenUtil.getInstance().setHeight(150),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'images/barbarian_bg.jpg',
                                        ),
                                        fit: BoxFit.fill)),
                              )
                            ],
                          ),
                        ),
                )),
          ],
        ),
      ),
    );
  }
}
