import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:reorderables/reorderables.dart';

class DataBaseSkill extends StatefulWidget {
  @override
  _DataBaseSkillState createState() => _DataBaseSkillState();
}

class _DataBaseSkillState extends State<DataBaseSkill>
    with TickerProviderStateMixin, SingleTickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;
  TabController _tabController;
  bool flag = true;
  bool showRoles = true;

  bool activeSkillsShow = true;
  bool passiveSkillsShow = true;

  List colors = [
    0xff6B83BD,
    0xff936AB0,
    0xffE79222,
  ];

  List roles = [
    {'name': '野蛮人', 'img': 'berserker_man.png', 'id': 1},
    {'name': '圣教军', 'img': 'holysect_man.png', 'id': 2},
    {'name': '武僧', 'img': 'monk_man.png', 'id': 3},
    {'name': '猎魔人', 'img': 'hunting_man.png', 'id': 4},
    {'name': '巫医', 'img': 'witchdoctor_man.png', 'id': 5},
    {'name': '死灵法师', 'img': 'necromancer_man.png', 'id': 6},
    {'name': '魔法师', 'img': 'mage_man.png', 'id': 7},
  ];

  Map attributes = {
    'wl': '物理',
    'hy': '火焰',
    'sd': '闪电',
    'bh': '冰寒',
    'ds': '毒素',
    'mf': '秘法',
    'ss': '神圣',
  };

  List activeSkills = [
    {
      'image': 'berserker_man/ia_1300000060.png',
      'name': '猛击',
      'level': '1',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000074.png',
      'name': '顺劈斩',
      'level': '3',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000081.png',
      'name': '大地践踏',
      'level': '4',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000088.png',
      'name': '痛割',
      'level': '5',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
    {
      'image': 'berserker_man/ia_1300000067.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
      'rune': [
        'rune_a_light.png',
        'rune_b_light.png',
        'rune_c_light.png',
        'rune_d_light.png',
        'rune_e_light.png',
      ]
    },
  ];
  List passiveSkills = [
    {
      'image': 'berserker_man/ia_1400000057.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
    },
    {
      'image': 'berserker_man/ia_1400000057.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
    },
    {
      'image': 'berserker_man/ia_1400000059.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
    },
    {
      'image': 'berserker_man/ia_1400000061.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
    },
    {
      'image': 'berserker_man/ia_1400000063.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
    },
    {
      'image': 'berserker_man/ia_1400000065.png',
      'name': '先祖之锤',
      'level': '2',
      'attributes': 'wl',
    },
  ];

  int roleIndex = 1;
  OverlayEntry overlayEntry;

  LayerLink layerLink = new LayerLink();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _ajax();
  }

  _ajax() async {
    await Future.delayed(Duration(seconds: 1), () {
      if (mounted)
        setState(() {
          flag = false;
        });
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (mounted)
      setState(() {
        var row = roles.removeAt(oldIndex);
        roles.insert(newIndex, row);
      });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    if (animationLoadingController != null) {
      animationLoadingController.dispose();
    }
    if (showRoles == false) {
      overlayEntry.remove();
    }
  }

  _loading() {
    animationLoadingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    animationLoading = Tween(begin: 0.0, end: 1.0).animate(animationLoadingController);
    animationLoadingController.addListener(() {
//      print((animationLoadingController.value * (7 - 1 + 1) + 1).toInt());
      if (mounted) setState(() {});
    });

    animationLoadingController.addStatusListener((AnimationStatus status) {
//      print('new ${animationLoadingController.status}');
      if (status == AnimationStatus.completed) {
        animationLoadingController.reset();
        animationLoadingController.forward();
        //当动画在开始处停止再次从头开始执行动画
      } else if (status == AnimationStatus.dismissed) {
        animationLoadingController.forward();
      }
    });
    animationLoadingController.forward();
  }

  close() {
    if (overlayEntry != null) {
      overlayEntry.remove();
    }
    if (mounted)
      setState(() {
        showRoles = !showRoles;
      });
  }

  activeSkillsBox(width) {
    return SmartRefresher(
        controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
        onRefresh: () async {
          _loading();
          await Future.delayed(Duration(milliseconds: 2000));
          if (mounted) setState(() {});
          animationLoadingController.reset();
          animationLoadingController.stop();
          _refreshController.refreshCompleted();
        },
        enablePullUp: true,
        header: CustomHeader(
          refreshStyle: RefreshStyle.Behind,
          builder: (c, m) {
            return Container(
              child: Center(
                child: Image.asset(
                  'images/head_loading${animationLoadingController == null ? 1 : (animationLoadingController.value * (8 - 1.01 + 1) + 1).toInt()}.png',
                  width: ScreenUtil.getInstance().setWidth(78),
                  height: ScreenUtil.getInstance().setWidth(84),
                ),
              ),
            );
          },
        ),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[CupertinoActivityIndicator(), Text('   载入中...')],
              );
            } else if (mode == LoadStatus.loading) {
              body = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[CupertinoActivityIndicator(), Text('   载入中...')],
              );
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 60.0,
              child: Center(child: body),
            );
          },
        ),
        onLoading: () async {
          // monitor network fetch
          await Future.delayed(Duration(milliseconds: 2000));
          // if failed,use loadFailed(),if no data return,use LoadNodata()
          if (mounted) setState(() {});
          _refreshController.loadComplete();
        },
        child: ListView(
//      controller: _listController,
          padding: EdgeInsets.only(
              left: ScreenUtil.getInstance().setWidth(24),
              right: ScreenUtil.getInstance().setWidth(24)),
          children: activeSkills.map<Widget>((item) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  activeSkillsShow = false;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(24)),
                decoration: BoxDecoration(
                    color: Color(0xffE3D4BF),
                    border: Border.all(
                        color: Color(0xffB5A88E), width: ScreenUtil.getInstance().setWidth(1)),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().setWidth(24),
                    top: ScreenUtil.getInstance().setWidth(24),
                    right: ScreenUtil.getInstance().setWidth(24),
                    bottom: ScreenUtil.getInstance().setWidth(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(12)),
                      width: ScreenUtil.getInstance().setWidth(84),
                      height: ScreenUtil.getInstance().setHeight(84),
                      child: Image.asset(
                        'skills/${item['image']}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Text(
                                  '${item['name']}',
                                  style: TextStyle(
                                      color: Color(0xff3D2F1B),
                                      fontSize: ScreenUtil.getInstance().setSp(30)),
                                ),
                                Container(
                                  width: ScreenUtil.getInstance().setWidth(10),
                                ),
                                Text('属性·${attributes[item['attributes']]}',
                                    style: TextStyle(
                                        color: Color(0xff9B8C73),
                                        fontSize: ScreenUtil.getInstance().setSp(26))),
                                Container(
                                  width: ScreenUtil.getInstance().setWidth(10),
                                ),
                                Text('等级·${item['level']}',
                                    style: TextStyle(
                                        color: Color(0xff9B8C73),
                                        fontSize: ScreenUtil.getInstance().setSp(26))),
                              ],
                            ),
                            Container(
                              height: ScreenUtil.getInstance().setHeight(6),
                            ),
                            Wrap(
                              children: item['rune'].map<Widget>((rune) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    right: ScreenUtil.getInstance().setWidth(10)
                                  ),
                                  width: ScreenUtil.getInstance().setWidth(40),
                                  height: ScreenUtil.getInstance().setHeight(40),
                                  child: Image.asset(
                                    'images/$rune',
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }

  passiveSkillsBox(width) {
    return SmartRefresher(
        controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
        onRefresh: () async {
          _loading();
          await Future.delayed(Duration(milliseconds: 2000));
          if (mounted) setState(() {});
          animationLoadingController.reset();
          animationLoadingController.stop();
          _refreshController.refreshCompleted();
        },
        enablePullUp: true,
        header: CustomHeader(
          refreshStyle: RefreshStyle.Behind,
          builder: (c, m) {
            return Container(
              child: Center(
                child: Image.asset(
                  'images/head_loading${animationLoadingController == null ? 1 : (animationLoadingController.value * (8 - 1.01 + 1) + 1).toInt()}.png',
                  width: ScreenUtil.getInstance().setWidth(78),
                  height: ScreenUtil.getInstance().setWidth(84),
                ),
              ),
            );
          },
        ),
        footer: CustomFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[CupertinoActivityIndicator(), Text('   载入中...')],
              );
            } else if (mode == LoadStatus.loading) {
              body = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[CupertinoActivityIndicator(), Text('   载入中...')],
              );
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 60.0,
              child: Center(child: body),
            );
          },
        ),
        onLoading: () async {
          // monitor network fetch
          await Future.delayed(Duration(milliseconds: 2000));
          // if failed,use loadFailed(),if no data return,use LoadNodata()
          if (mounted) setState(() {});
          _refreshController.loadComplete();
        },
        child: ListView(
//      controller: _listController,
          padding: EdgeInsets.only(
              left: ScreenUtil.getInstance().setWidth(24),
              right: ScreenUtil.getInstance().setWidth(24)),
          children: passiveSkills.map<Widget>((item) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  passiveSkillsShow = false;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(24)),
                decoration: BoxDecoration(
                    color: Color(0xffE3D4BF),
                    border: Border.all(
                        color: Color(0xffB5A88E), width: ScreenUtil.getInstance().setWidth(1)),
                    borderRadius: BorderRadius.all(Radius.circular(6))),
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().setWidth(24),
                    top: ScreenUtil.getInstance().setWidth(24),
                    right: ScreenUtil.getInstance().setWidth(24),
                    bottom: ScreenUtil.getInstance().setWidth(24)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(12)),
                      width: ScreenUtil.getInstance().setWidth(84),
                      height: ScreenUtil.getInstance().setHeight(84),
                      child: Image.asset(
                        'skills/${item['image']}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: <Widget>[
                            Text(
                              '${item['name']}',
                              style: TextStyle(
                                  color: Color(0xff3D2F1B),
                                  fontSize: ScreenUtil.getInstance().setSp(30)),
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(10),
                            ),
                            Text('属性·${attributes[item['attributes']]}',
                                style: TextStyle(
                                    color: Color(0xff9B8C73),
                                    fontSize: ScreenUtil.getInstance().setSp(26))),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(10),
                            ),
                            Text('等级·${item['level']}',
                                style: TextStyle(
                                    color: Color(0xff9B8C73),
                                    fontSize: ScreenUtil.getInstance().setSp(26))),
                          ],
                        ),
//                          Wrap(
//                            children: item['rune'].map<Widget>((rune) {
//                              return Container(
//                                width: ScreenUtil.getInstance().setWidth(40),
//                                height: ScreenUtil.getInstance().setHeight(40),
//                                child: Image.asset('images/$rune}',fit: BoxFit.fill,),
//                              );
//                            }).toList(),
//                          )
                      ],
                    ))
                  ],
                ),
              ),
            );
          }).toList(),
        ));
  }

  createSelectPopupWindow(width, height, top) {
    overlayEntry = new OverlayEntry(builder: (context) {
      return Positioned(
        width: width,
        height: height,
        top: 0,
        child: new CompositedTransformFollower(
//          offset: Offset(0.0, 0),
          link: layerLink,
          child: new Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: close,
              child: Container(
//                margin: EdgeInsets.only(top: top + 56 + ScreenUtil.getInstance().setWidth(120)),
                width: width,
                height: height - MediaQuery.of(context).padding.top,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: close,
                      child: Container(
                        color: Colors.transparent,
                        width: width,
                        height: top + 56 + ScreenUtil.getInstance().setHeight(120),
                      ),
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(24),
                          bottom: ScreenUtil.getInstance().setHeight(24)),
                      color: Color(0xffD0C4AC),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setHeight(24),
                                bottom: ScreenUtil.getInstance().setHeight(24)),
                            child: Text(
                              '长按可以编辑排序',
                              style: TextStyle(
                                  fontSize: ScreenUtil.getInstance().setSp(22),
                                  color: Color(0xff6A5C41)),
                            ),
                          ),
                          ReorderableWrap(
                            onReorder: _onReorder,
//                                      onNoReorder: (int index) {
//                                        //this callback is optional
//                                        debugPrint(
//                                            '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
//                                      },
//                                      onReorderStarted: (int index) {
//                                        //this callback is optional
//                                        debugPrint(
//                                            '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
//                                      },
                            runSpacing: ScreenUtil.getInstance().setWidth(24),
                            spacing: ScreenUtil.getInstance().setWidth(24),
                            children: roles.map<Widget>((item) {
                              int id = item['id'];
                              return GestureDetector(
                                onTap: () {
                                  close();
                                  if (mounted)
                                    setState(() {
                                      roleIndex = id;
                                    });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          id == roleIndex ? Color(0xffB51610) : Color(0xffD0C4AC),
                                      borderRadius: BorderRadius.all(Radius.circular(4)),
                                      border: Border.all(
                                        width: ScreenUtil.getInstance().setWidth(1),
                                        color:
                                            id == roleIndex ? Color(0xffB51610) : Color(0xff6A5C41),
                                      )),
                                  padding: EdgeInsets.only(
                                      bottom: ScreenUtil.getInstance().setHeight(4),
                                      top: ScreenUtil.getInstance().setWidth(4)),
                                  width: ScreenUtil.getInstance()
                                      .setWidth(item['name'].length * 28 + 48.0),
                                  child: Align(
                                    child: Text(
                                      item['name'],
                                      style: TextStyle(
                                          color: id == roleIndex
                                              ? Color(0xffF3D699)
                                              : Color(0xff6A5C41),
                                          fontSize: ScreenUtil.getInstance().setSp(26)),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      color: Color(0x9e000000),
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    return overlayEntry;
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
                  width: ScreenUtil.getInstance().setWidth(42),
                ),
              ),
            ),
          ),
          title: Text('技能数据库',
              style: TextStyle(
                color: Color(0xffFFDF8E),
              )),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/fragment_tools_bg.jpg'), fit: BoxFit.fill),
                color: Color(0xffE8DAC5),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: ScreenUtil.getInstance().setHeight(120),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: ListView(
                          padding: EdgeInsets.only(
                              top: ScreenUtil.getInstance().setHeight(36),
                              left: ScreenUtil.getInstance().setWidth(24),
                              bottom: ScreenUtil.getInstance().setHeight(36)),
                          scrollDirection: Axis.horizontal,
                          children: roles.map<Widget>((item) {
                            int id = item['id'];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  roleIndex = id;
                                });
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(24)),
                                decoration: BoxDecoration(
                                    color: id == roleIndex ? Color(0xffB51610) : Colors.transparent,
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                      width: ScreenUtil.getInstance().setWidth(1),
                                      color:
                                          id == roleIndex ? Color(0xffB51610) : Color(0xff6A5C41),
                                    )),
                                width: ScreenUtil.getInstance()
                                    .setWidth(item['name'].length * 28 + 48.0),
                                child: Center(
                                  child: Text(
                                    item['name'],
                                    style: TextStyle(
                                        color:
                                            id == roleIndex ? Color(0xffF3D699) : Color(0xff6A5C41),
                                        fontSize: ScreenUtil.getInstance().setSp(26)),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )),
                        GestureDetector(
                          onTap: () {
                            if (showRoles) {
                              overlayEntry = createSelectPopupWindow(
                                  width, height, MediaQuery.of(context).padding.top);
                              Overlay.of(context).insert(overlayEntry);
                            } else {
                              overlayEntry.remove();
                            }
                            setState(() {
                              showRoles = !showRoles;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: ScreenUtil.getInstance().setWidth(20),
                                right: ScreenUtil.getInstance().setWidth(20)),
                            child: Image.asset(
                              showRoles
                                  ? 'images/community_top_list_arr.png'
                                  : 'images/community_top_list_arr_up.png',
                              width: ScreenUtil.getInstance().setWidth(44),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: width,
                    height: height -
                        56 -
                        MediaQuery.of(context).padding.top -
                        ScreenUtil.getInstance().setHeight(120),
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
                            height: 400,
                            width: width,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(7)),
                                  height: ScreenUtil.getInstance().setHeight(80),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: Color(0xffC5B7A1),
                                              width: ScreenUtil.getInstance().setWidth(1)),
                                          bottom: BorderSide(
                                              color: Color(0xffC5B7A1),
                                              width: ScreenUtil.getInstance().setWidth(1)))),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(14),
                                                  right: ScreenUtil.getInstance().setWidth(14)),
                                              child: TabBar(
                                                  controller: _tabController,
                                                  labelColor: Color(0xffB51610),
                                                  unselectedLabelColor: Color(0xff6A5C41),
                                                  labelStyle: TextStyle(
                                                      fontSize: ScreenUtil.getInstance().setSp(32)),
                                                  indicatorWeight:
                                                      ScreenUtil.getInstance().setWidth(4),
                                                  indicatorColor: Color(0xffB51610),
                                                  indicatorPadding: EdgeInsets.only(
                                                      bottom:
                                                          ScreenUtil.getInstance().setHeight(-2)),
                                                  tabs: <Tab>[
                                                    Tab(
                                                      text: "主动",
                                                    ),
                                                    Tab(
                                                      text: "被动",
                                                    ),
                                                  ]))),
                                      Container(
                                        height: ScreenUtil.getInstance().setHeight(36),
                                        width: ScreenUtil.getInstance().setWidth(1),
                                        color: Color(0xffC7B9A2),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil.getInstance().setWidth(40),
                                            right: ScreenUtil.getInstance().setWidth(40)),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xffB51610),
                                                width: ScreenUtil.getInstance().setWidth(1)),
                                            borderRadius: BorderRadius.all(Radius.circular(4))),
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil.getInstance().setWidth(24),
                                            right: ScreenUtil.getInstance().setWidth(24),
                                            top: ScreenUtil.getInstance().setHeight(4),
                                            bottom: ScreenUtil.getInstance().setHeight(4)),
                                        child: Text(
                                          '全部',
                                          style: TextStyle(
                                              color: Color(0xffB51610),
                                              fontSize: ScreenUtil.getInstance().setSp(23)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 300,
                                  child: TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _tabController,
                                    children: <Widget>[
                                      activeSkillsBox(width),
                                      passiveSkillsBox(width)
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Positioned(
                left: 0,
                top: 0,
                width: width,
                height: height - MediaQuery.of(context).padding.top - 56,
                child: Offstage(
                  offstage: activeSkillsShow,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        activeSkillsShow = true;
                      });
                    },
                    child: Container(
                      color: Color(0x99000000),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 56 + ScreenUtil.getInstance().setHeight(20),
                            bottom: ScreenUtil.getInstance().setHeight(146),
                            left: ScreenUtil.getInstance().setWidth(70),
                            right: ScreenUtil.getInstance().setWidth(70)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff1C1B19),
                                width: ScreenUtil.getInstance().setWidth(1)),
                            color: Color(0xff000000)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: ScreenUtil.getInstance().setHeight(52),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/tooltip-title5.png'))),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Text(
                                        '主动技能',
                                        style: TextStyle(
                                            color: Color(0xffD1C5B2),
                                            fontSize: ScreenUtil.getInstance().setSp(24)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: ScreenUtil.getInstance().setWidth(24),
                                      top: ScreenUtil.getInstance().setHeight(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            activeSkillsShow = true;
                                          });
                                        },
                                        child: Image.asset(
                                          'images/equipment_detail_close.png',
                                          width: ScreenUtil.getInstance().setWidth(32),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Expanded(child: ListView())
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: 0,
                width: width,
                height: height - MediaQuery.of(context).padding.top - 56,
                child: Offstage(
                  offstage: passiveSkillsShow,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        passiveSkillsShow = true;
                      });
                    },
                    child: Container(
                      color: Color(0x99000000),
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 56 + ScreenUtil.getInstance().setHeight(20),
                            bottom: ScreenUtil.getInstance().setHeight(146),
                            left: ScreenUtil.getInstance().setWidth(70),
                            right: ScreenUtil.getInstance().setWidth(70)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff1C1B19),
                                width: ScreenUtil.getInstance().setWidth(1)),
                            color: Color(0xff000000)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: ScreenUtil.getInstance().setHeight(52),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/tooltip-title5.png'))),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: Text(
                                        '被动技能',
                                        style: TextStyle(
                                            color: Color(0xffD1C5B2),
                                            fontSize: ScreenUtil.getInstance().setSp(24)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: ScreenUtil.getInstance().setWidth(24),
                                      top: ScreenUtil.getInstance().setHeight(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            passiveSkillsShow = true;
                                          });
                                        },
                                        child: Image.asset(
                                          'images/equipment_detail_close.png',
                                          width: ScreenUtil.getInstance().setWidth(32),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            Expanded(child: ListView())
                          ],
                        ),
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
