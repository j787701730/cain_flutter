import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:reorderables/reorderables.dart';

class LiftingArtifacts extends StatefulWidget {
  @override
  _LiftingArtifactsState createState() => _LiftingArtifactsState();
}

class _LiftingArtifactsState extends State<LiftingArtifacts> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  bool flag = true;
  bool showRoles = true;

  List colors = [
    0xff6B83BD,
    0xff936AB0,
    0xffE79222,
  ];

  List content = [
    {
      'title': '【2.6.5】版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'keyWords': [
        '冲层',
        '范围输出',
        '操作感强',
      ],
    },
    {
      'title': '【2.6.5】版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'keyWords': [
        '冲层',
        '打击感',
        '爆发力',
      ],
    },
    {
      'title': '【2.6.5】版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'keyWords': [
        '冲层',
        '范围输出',
        '操作简便',
      ],
    },
    {
      'title': '【2.6.5】版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'keyWords': [
        '冲层',
        '范围输出',
        '风卷云卷',
      ],
    },
    {
      'title': '【2.6.5】版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'keyWords': [
        '冲层',
        '范围输出',
        '操作感强',
      ],
    },
    {
      'title': '【2.6.5】版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'keyWords': [
        '冲层',
        '范围输出',
        '操作感强',
      ],
    },
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

  int roleIndex = 1;
  OverlayEntry overlayEntry;

  LayerLink layerLink = new LayerLink();

  @override
  void initState() {
    super.initState();
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
                  width: ScreenUtil.getInstance().setWidth(30),
                ),
              ),
            ),
          ),
          title: Text('提升神器',
              style: TextStyle(
                color: Color(0xffFFDF8E),
              )),
        ),
        body: Container(
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
                            margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(24)),
                            decoration: BoxDecoration(
                                color: id == roleIndex ? Color(0xffB51610) : Colors.transparent,
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  width: ScreenUtil.getInstance().setWidth(1),
                                  color: id == roleIndex ? Color(0xffB51610) : Color(0xff6A5C41),
                                )),
                            width:
                                ScreenUtil.getInstance().setWidth(item['name'].length * 28 + 48.0),
                            child: Center(
                              child: Text(
                                item['name'],
                                style: TextStyle(
                                    color: id == roleIndex ? Color(0xffF3D699) : Color(0xff6A5C41),
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
                    : SmartRefresher(
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
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(24),
                              right: ScreenUtil.getInstance().setWidth(24)),
                          children: content.map<Widget>((item) {
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffB5A88E),
                                      width: ScreenUtil.getInstance().setWidth(1)),
                                  borderRadius: BorderRadius.all(Radius.circular(6))),
                              padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(24)),
                              margin:
                                  EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(24)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                        color: Color(0xff3D2F1B),
                                        fontSize: ScreenUtil.getInstance().setSp(30)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: ScreenUtil.getInstance().setHeight(10),
                                        bottom: ScreenUtil.getInstance().setHeight(10)),
                                    child: Wrap(
                                      spacing: ScreenUtil.getInstance().setWidth(16),
                                      children: item['keyWords'].map<Widget>((keyWord) {
                                        int idx = item['keyWords'].indexOf(keyWord);
                                        return Container(
                                          decoration: BoxDecoration(
                                              color: Color(colors[idx]),
                                              borderRadius: BorderRadius.all(Radius.circular(4))),
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(12),
                                              right: ScreenUtil.getInstance().setWidth(12)),
                                          child: Text(
                                            keyWord,
                                            style: TextStyle(
                                                color: Color(0xffF0D79C),
                                                fontSize: ScreenUtil.getInstance().setSp(24)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Text(
                                    item['author'],
                                    style: TextStyle(
                                        color: Color(0xff9B8C74),
                                        fontSize: ScreenUtil.getInstance().setSp(24)),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
