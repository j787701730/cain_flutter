import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Simulator extends StatefulWidget {
  final props;

  Simulator(this.props);

  @override
  _SimulatorState createState() => _SimulatorState();
}

class _SimulatorState extends State<Simulator> with TickerProviderStateMixin {
  bool flag = true;

  bool show = false;
  String type = 'equipment';

  int _roleIndex = 0;

  bool showRoleSelect = false;

  List roles = [
    {'name': '野蛮人', 'img': 'berserker_man.png'},
    {'name': '圣教军', 'img': 'holysect_man.png'},
    {'name': '武僧', 'img': 'monk_man.png'},
    {'name': '猎魔人', 'img': 'hunting_man.png'},
    {'name': '巫医', 'img': 'witchdoctor_man.png'},
    {'name': '死灵法师', 'img': 'necromancer_man.png'},
    {'name': '魔法师', 'img': 'mage_man.png'},
  ];

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

  List topBtn = [
    {'name': '保存'},
    {'name': '读取'},
    {'name': '导入'},
    {'name': '重置'},
  ];

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
        body: flag
            ? Container(
                color: Color(0xffE8DAC5),
                child: Center(
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
                          color: Color(0xff938373), fontSize: ScreenUtil.getInstance().setSp(23)),
                    )
                  ],
                )),
              )
            : Stack(
                children: <Widget>[
                  Positioned(
                      left: 0,
                      top: 0,
                      height: height - MediaQuery.of(context).padding.top - 56,
                      width: width,
                      child: Container(
                        color: Color(0xffE8DAC5),
                        child: Container(
                          width: width,
                          height: height - MediaQuery.of(context).padding.top - 56,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'images/simulator_skill_bg.jpg',
                                  ),
                                  fit: BoxFit.fill)),
                        ),
                      )),
                  Positioned(
                      top: ScreenUtil.getInstance().setHeight(0), // 44
                      left: 0,
                      width: width,
                      height: height -
                          MediaQuery.of(context).padding.top -
                          56 -
                          ScreenUtil.getInstance().setHeight(0), // 44
                      child: Offstage(
                        offstage: type == 'skill',
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  alignment: Alignment.topCenter,
                                  image: AssetImage(
                                    'images/barbarian_bg.jpg',
                                  ),
                                  fit: BoxFit.fitWidth)),
                          child: Stack(
                            children: <Widget>[
                              // 头部
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(274),
                                  top: ScreenUtil.getInstance().setHeight(184),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(100),
                                  )),
                              // 肩部
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(150),
                                  top: ScreenUtil.getInstance().setHeight(220),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(130),
                                  )),
                              // 项链
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(400),
                                  top: ScreenUtil.getInstance().setHeight(250),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(84),
                                    height: ScreenUtil.getInstance().setHeight(84),
                                  )),
                              // 身躯
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(260),
                                  top: ScreenUtil.getInstance().setHeight(290),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(124),
                                    height: ScreenUtil.getInstance().setHeight(168),
                                  )),
                              // 手套
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(110),
                                  top: ScreenUtil.getInstance().setHeight(370),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(130),
                                  )),
                              // 护腕
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(436),
                                  top: ScreenUtil.getInstance().setHeight(370),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(130),
                                  )),
                              // 腰带
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(260),
                                  top: ScreenUtil.getInstance().setHeight(464),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(126),
                                    height: ScreenUtil.getInstance().setHeight(50),
                                  )),
                              // 左戒指
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(130),
                                  top: ScreenUtil.getInstance().setHeight(514),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(62),
                                    height: ScreenUtil.getInstance().setHeight(62),
                                  )),
                              // 右戒指
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(456),
                                  top: ScreenUtil.getInstance().setHeight(514),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(62),
                                    height: ScreenUtil.getInstance().setHeight(62),
                                  )),
                              // 裤子
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(274),
                                  top: ScreenUtil.getInstance().setHeight(524),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(130),
                                  )),
                              // 主武器
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(110),
                                  top: ScreenUtil.getInstance().setHeight(600),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(180),
                                  )),
                              // 鞋子
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(272),
                                  top: ScreenUtil.getInstance().setHeight(660),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(110),
                                  )),
                              // 副武器
                              Positioned(
                                  left: ScreenUtil.getInstance().setWidth(436),
                                  top: ScreenUtil.getInstance().setHeight(600),
                                  child: Container(
                                    color: Color(0x44000000),
                                    width: ScreenUtil.getInstance().setWidth(100),
                                    height: ScreenUtil.getInstance().setHeight(180),
                                  )),
                              Positioned(
                                  width: width,
                                  height: ScreenUtil.getInstance().setHeight(240),
                                  bottom: 0,
                                  left: 0,
                                  child: Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            alignment: Alignment.bottomCenter,
                                            image: AssetImage(
                                              'images/simulator_equipment_bottom_bg.jpg',
                                            ),
                                            fit: BoxFit.fitWidth)),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: ScreenUtil.getInstance().setHeight(42),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'images/simulator_skill_title_bg.png'),
                                                fit: BoxFit.fitHeight),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '卡奈魔盒威能',
                                              style: TextStyle(
                                                  color: Color(0xffA28B63),
                                                  fontSize: ScreenUtil.getInstance().setSp(22)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setHeight(18)),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(128),
                                                width: ScreenUtil.getInstance().setWidth(86),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/simulator_equipment_box_bg.png'))),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(130),
                                                width: ScreenUtil.getInstance().setWidth(86),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/simulator_equipment_box_bg.png'))),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(128),
                                                width: ScreenUtil.getInstance().setWidth(86),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/simulator_equipment_box_bg.png'))),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      top: ScreenUtil.getInstance().setHeight(190),
                      left: 0,
                      width: width,
                      height: height -
                          MediaQuery.of(context).padding.top -
                          56 -
                          ScreenUtil.getInstance().setHeight(44),
                      child: Offstage(
                          offstage: type == 'equipment',
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: ScreenUtil.getInstance().setHeight(42),
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil.getInstance().setHeight(16)),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/simulator_skill_title_bg.png'),
                                          fit: BoxFit.fitHeight)),
                                  child: Center(
                                    child: Text(
                                      '鼠标技能',
                                      style: TextStyle(
                                          color: Color(0xffA28B63),
                                          fontSize: ScreenUtil.getInstance().setSp(22)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil.getInstance().setWidth(6),
                                    right: ScreenUtil.getInstance().setWidth(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(6),
                                                  right: ScreenUtil.getInstance().setWidth(6),
                                                  top: ScreenUtil.getInstance().setHeight(9),
                                                  bottom: ScreenUtil.getInstance().setHeight(9)),
                                              width: ScreenUtil.getInstance().setWidth(101),
                                              height: ScreenUtil.getInstance().setHeight(114),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_detail_bg.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(205),
                                              height: ScreenUtil.getInstance().setHeight(93),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_right_bg.png'))),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(12),
                                                    top: ScreenUtil.getInstance().setHeight(10)),
                                                child: Text(
                                                  '选择技能',
                                                  style: TextStyle(
                                                      color: Color(0xffF5DA9C),
                                                      fontSize: ScreenUtil.getInstance().setSp(28)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(6),
                                                  right: ScreenUtil.getInstance().setWidth(6),
                                                  top: ScreenUtil.getInstance().setHeight(9),
                                                  bottom: ScreenUtil.getInstance().setHeight(9)),
                                              width: ScreenUtil.getInstance().setWidth(101),
                                              height: ScreenUtil.getInstance().setHeight(114),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_detail_bg.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(205),
                                              height: ScreenUtil.getInstance().setHeight(93),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_right_bg.png'))),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(12),
                                                    top: ScreenUtil.getInstance().setHeight(10)),
                                                child: Text(
                                                  '选择技能',
                                                  style: TextStyle(
                                                      color: Color(0xffF5DA9C),
                                                      fontSize: ScreenUtil.getInstance().setSp(28)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil.getInstance().setHeight(42),
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil.getInstance().setHeight(16),
                                      top: ScreenUtil.getInstance().setHeight(40)),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/simulator_skill_title_bg.png'),
                                          fit: BoxFit.fitHeight)),
                                  child: Center(
                                    child: Text(
                                      '动作条技能',
                                      style: TextStyle(
                                          color: Color(0xffA28B63),
                                          fontSize: ScreenUtil.getInstance().setSp(22)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil.getInstance().setWidth(6),
                                    right: ScreenUtil.getInstance().setWidth(6),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(6),
                                                  right: ScreenUtil.getInstance().setWidth(6),
                                                  top: ScreenUtil.getInstance().setHeight(9),
                                                  bottom: ScreenUtil.getInstance().setHeight(9)),
                                              width: ScreenUtil.getInstance().setWidth(101),
                                              height: ScreenUtil.getInstance().setHeight(114),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_detail_bg.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(205),
                                              height: ScreenUtil.getInstance().setHeight(93),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_right_bg.png'))),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(12),
                                                    top: ScreenUtil.getInstance().setHeight(10)),
                                                child: Text(
                                                  '选择技能',
                                                  style: TextStyle(
                                                      color: Color(0xffF5DA9C),
                                                      fontSize: ScreenUtil.getInstance().setSp(28)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(6),
                                                  right: ScreenUtil.getInstance().setWidth(6),
                                                  top: ScreenUtil.getInstance().setHeight(9),
                                                  bottom: ScreenUtil.getInstance().setHeight(9)),
                                              width: ScreenUtil.getInstance().setWidth(101),
                                              height: ScreenUtil.getInstance().setHeight(114),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_detail_bg.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(205),
                                              height: ScreenUtil.getInstance().setHeight(93),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_right_bg.png'))),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(12),
                                                    top: ScreenUtil.getInstance().setHeight(10)),
                                                child: Text(
                                                  '选择技能',
                                                  style: TextStyle(
                                                      color: Color(0xffF5DA9C),
                                                      fontSize: ScreenUtil.getInstance().setSp(28)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil.getInstance().setWidth(6),
                                    right: ScreenUtil.getInstance().setWidth(6),
                                  ),
                                  margin:
                                      EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(18)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(6),
                                                  right: ScreenUtil.getInstance().setWidth(6),
                                                  top: ScreenUtil.getInstance().setHeight(9),
                                                  bottom: ScreenUtil.getInstance().setHeight(9)),
                                              width: ScreenUtil.getInstance().setWidth(101),
                                              height: ScreenUtil.getInstance().setHeight(114),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_detail_bg.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(205),
                                              height: ScreenUtil.getInstance().setHeight(93),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_right_bg.png'))),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(12),
                                                    top: ScreenUtil.getInstance().setHeight(10)),
                                                child: Text(
                                                  '选择技能',
                                                  style: TextStyle(
                                                      color: Color(0xffF5DA9C),
                                                      fontSize: ScreenUtil.getInstance().setSp(28)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(6),
                                                  right: ScreenUtil.getInstance().setWidth(6),
                                                  top: ScreenUtil.getInstance().setHeight(9),
                                                  bottom: ScreenUtil.getInstance().setHeight(9)),
                                              width: ScreenUtil.getInstance().setWidth(101),
                                              height: ScreenUtil.getInstance().setHeight(114),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_detail_bg.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(205),
                                              height: ScreenUtil.getInstance().setHeight(93),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_right_bg.png'))),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(12),
                                                    top: ScreenUtil.getInstance().setHeight(10)),
                                                child: Text(
                                                  '选择技能',
                                                  style: TextStyle(
                                                      color: Color(0xffF5DA9C),
                                                      fontSize: ScreenUtil.getInstance().setSp(28)),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: ScreenUtil.getInstance().setHeight(16),
                                      top: ScreenUtil.getInstance().setHeight(40)),
                                  height: ScreenUtil.getInstance().setHeight(42),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage('images/simulator_skill_title_bg.png'),
                                          fit: BoxFit.fitHeight)),
                                  child: Center(
                                    child: Text(
                                      '被动技能',
                                      style: TextStyle(
                                          color: Color(0xffA28B63),
                                          fontSize: ScreenUtil.getInstance().setSp(22)),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(134),
                                              height: ScreenUtil.getInstance().setWidth(134),
                                              padding: EdgeInsets.only(
                                                top: ScreenUtil.getInstance().setWidth(20),
                                                right: ScreenUtil.getInstance().setWidth(24),
                                                left: ScreenUtil.getInstance().setWidth(24),
                                                bottom: ScreenUtil.getInstance().setWidth(28),
                                              ),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_passive.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(100)),
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '选择技能',
                                                style: TextStyle(
                                                    color: Color(0xffF5DA9C),
                                                    fontSize: ScreenUtil.getInstance().setSp(28)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(134),
                                              height: ScreenUtil.getInstance().setWidth(134),
                                              padding: EdgeInsets.only(
                                                top: ScreenUtil.getInstance().setWidth(20),
                                                right: ScreenUtil.getInstance().setWidth(24),
                                                left: ScreenUtil.getInstance().setWidth(24),
                                                bottom: ScreenUtil.getInstance().setWidth(28),
                                              ),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_passive.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(100)),
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '选择技能',
                                                style: TextStyle(
                                                    color: Color(0xffF5DA9C),
                                                    fontSize: ScreenUtil.getInstance().setSp(28)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(134),
                                              height: ScreenUtil.getInstance().setWidth(134),
                                              padding: EdgeInsets.only(
                                                top: ScreenUtil.getInstance().setWidth(20),
                                                right: ScreenUtil.getInstance().setWidth(24),
                                                left: ScreenUtil.getInstance().setWidth(24),
                                                bottom: ScreenUtil.getInstance().setWidth(28),
                                              ),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_passive.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(100)),
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '选择技能',
                                                style: TextStyle(
                                                    color: Color(0xffF5DA9C),
                                                    fontSize: ScreenUtil.getInstance().setSp(28)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: ScreenUtil.getInstance().setWidth(134),
                                              height: ScreenUtil.getInstance().setWidth(134),
                                              padding: EdgeInsets.only(
                                                top: ScreenUtil.getInstance().setWidth(20),
                                                right: ScreenUtil.getInstance().setWidth(24),
                                                left: ScreenUtil.getInstance().setWidth(24),
                                                bottom: ScreenUtil.getInstance().setWidth(28),
                                              ),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/simulator_skill_passive.png'),
                                                      fit: BoxFit.fill)),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(100)),
                                                  color: Color(0xff100E09),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '选择技能',
                                                style: TextStyle(
                                                    color: Color(0xffF5DA9C),
                                                    fontSize: ScreenUtil.getInstance().setSp(28)),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))),
                  Positioned(
                      left: 0,
                      top: 0,
                      width: width,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              color: Color(0xff44000000),
                              height: ScreenUtil.getInstance().setHeight(60),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(24)),
                                    child: Text(
                                      '默认方案',
                                      style: TextStyle(
                                          color: Color(0xffD6C5A3),
                                          fontSize: ScreenUtil.getInstance().setSp(22)),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: topBtn.map<Widget>((item) {
                                        return Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffB5A78D),
                                                  width: ScreenUtil.getInstance().setWidth(1)),
                                              borderRadius: BorderRadius.all(Radius.circular(4))),
                                          padding: EdgeInsets.only(
                                            left: ScreenUtil.getInstance().setWidth(8),
                                            right: ScreenUtil.getInstance().setWidth(8),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil.getInstance().setWidth(24)),
                                          child: Text(
                                            '${item['name']}',
                                            style: TextStyle(
                                                color: Color(0xffB5A88E),
                                                fontSize: ScreenUtil.getInstance().setSp(22)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(30),
                                  right: ScreenUtil.getInstance().setWidth(30),
                                  top: ScreenUtil.getInstance().setWidth(26)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showRoleSelect = true;
                                          });
                                        },
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                child: Image.asset(
                                                  'images/${roles[_roleIndex]['img']}',
                                                  width: ScreenUtil.getInstance().setWidth(72),
                                                ),
                                              ),
                                              Container(
                                                width: ScreenUtil.getInstance().setWidth(92),
                                                height: ScreenUtil.getInstance().setHeight(36),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/simulator_hero_name_bg.png'),
                                                        fit: BoxFit.fill)),
                                                child: Center(
                                                  child: Text(
                                                    '${roles[_roleIndex]['name']}',
                                                    style: TextStyle(
                                                        color: Color(0xffF5DA9C),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(20)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            type = 'equipment';
                                          });
                                        },
                                        child: Container(
                                          width: ScreenUtil.getInstance().setWidth(170),
                                          height: ScreenUtil.getInstance().setHeight(44),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                  image: AssetImage(type == 'equipment'
                                                      ? 'images/simulator_title_bg_on.png'
                                                      : 'images/simulator_title_bg_off.png'),
                                                  fit: BoxFit.fitHeight)),
                                          child: Center(
                                            child: Text(
                                              '装备',
                                              style: TextStyle(
                                                  color: Color(type == 'equipment'
                                                      ? 0xffF3D1A8
                                                      : 0xff867352),
                                                  fontSize: ScreenUtil.getInstance().setSp(20)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // skill
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            type = 'skill';
                                          });
                                        },
                                        child: Container(
                                          width: ScreenUtil.getInstance().setWidth(170),
                                          height: ScreenUtil.getInstance().setHeight(44),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                  image: AssetImage(type == 'skill'
                                                      ? 'images/simulator_title_bg_on.png'
                                                      : 'images/simulator_title_bg_off.png'),
                                                  fit: BoxFit.fitHeight)),
                                          child: Center(
                                            child: Text(
                                              '技能',
                                              style: TextStyle(
                                                  color: Color(
                                                      type == 'skill' ? 0xffF3D1A8 : 0xff867352),
                                                  fontSize: ScreenUtil.getInstance().setSp(20)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  Positioned(
                      top: 0,
                      left: 0,
                      width: width,
                      height: height - 56 - MediaQuery.of(context).padding.top,
                      child: Offstage(
                        offstage: !showRoleSelect,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showRoleSelect = false;
                            });
                          },
                          child: Container(
                            color: Color(0x44000000),
                            padding: EdgeInsets.only(
                                left: ScreenUtil.getInstance().setWidth(24),
                                right: ScreenUtil.getInstance().setWidth(24),
                                bottom: ScreenUtil.getInstance().setHeight(24)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _roleIndex = 0;
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                      color: Color(0xffE8DAC5),
                                        border:
                                            Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('野蛮人',style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _roleIndex = 1;
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE8DAC5),
                                        border:
                                        Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('圣教军',style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _roleIndex = 2;
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE8DAC5),
                                        border:
                                        Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('武僧',style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _roleIndex = 3;
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE8DAC5),
                                        border:
                                        Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('猎魔人',style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _roleIndex = 4;
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE8DAC5),
                                        border:
                                        Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('巫医',style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _roleIndex = 5;
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE8DAC5),
                                        border:
                                        Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('死灵法师',style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _roleIndex = 6;
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE8DAC5),
                                        border:
                                        Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('魔法师',style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showRoleSelect = false;
                                    });
                                  },
                                  child: Container(
                                    height: ScreenUtil.getInstance().setHeight(104),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE8DAC5),
                                        border:
                                        Border(bottom: BorderSide(color: Color(0xffC9BBA4),
                                            width: ScreenUtil.getInstance().setWidth(1)))),
                                    child: Center(
                                      child: Text('取消',style: TextStyle(
                                        color: Color(0xffB51610),
                                        fontSize: ScreenUtil.getInstance().setSp(30)
                                      ),),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                        ),
                      ))
                ],
              ),
      ),
    );
  }
}
