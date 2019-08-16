import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'data_base.dart';
import 'lifting_artifact.dart';
import 'simulator.dart';
import 'sky_ladder_list.dart';
import 'util.dart';

class Tool extends StatefulWidget {
  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<Tool> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  bool flag = true;
  DateTime now = DateTime.now();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _ajax();
    _getDiabloToolsIndexConfig();
  }

  Map diabloToolsIndexConfig = {};

  Map info = {};

  _getDiabloToolsIndexConfig() {
    _loading();
    ajax(
        'http://cain-api.gameyw.netease.com/cain/diabloToolsIndexConfig/list?sid=d09dad18179e42de82d369daec8b11b4__vD1S%252FPEqu3rDFtc40pd99Q%253D%253D&ts=1565942557&uf=d7931789-3330-43e1-8579-b46ee63c9e07&ab=2f1b73e97ae70deb7914725cf3622e0005&ef=97677f5b7ac5e4c3bf2749ac18863f604e',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          diabloToolsIndexConfig = data;
        });
      }
      if (mounted) setState(() {});
      animationLoadingController.reset();
      animationLoadingController.stop();
      _refreshController.refreshCompleted();
    });

    ajax(
        'http://cain-api.gameyw.netease.com/worldhero-web/app_api/queryConfig?ts=1565942556&uf=a2c41190-bb2d-45fb-8c07-aa794b390cb6&ab=373a0b296574db9d61acb3e651c9ebd692&ef=96b4b82b17610d79c34d458f34671cfa7c',
        (data) {
      if (mounted && data['code'] == 0) {
        setState(() {
          info = data['info'];
        });
      }
    });
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
    _refreshController.dispose();
    if (animationLoadingController != null) {
      animationLoadingController.dispose();
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    int count = 0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          '工具',
          style: TextStyle(color: Color(0xffFFDF8E)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Color(0xffE8DAC5),
            image: DecorationImage(
                image: AssetImage('images/fragment_tools_bg.jpg'), fit: BoxFit.cover)),
        child: diabloToolsIndexConfig.isEmpty
            ? Center(
                child: Image.asset(
                  'images/head_loading1.png',
                  width: ScreenUtil.getInstance().setWidth(78),
                ),
              )
            : SmartRefresher(
                controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
                onRefresh: () async {
                  _getDiabloToolsIndexConfig();
                },
                header: CustomHeader(
                  refreshStyle: RefreshStyle.Behind,
                  builder: (c, m) {
                    return Container(
                      child: Center(
                        child: Image.asset(
                          'images/head_loading'
                          '${animationLoadingController == null ? 1 : (animationLoadingController.value * (8 - 1.01 + 1) + 1).toInt()}.png',
                          width: ScreenUtil.getInstance().setWidth(78),
                          height: ScreenUtil.getInstance().setWidth(84),
                        ),
                      ),
                    );
                  },
                ),
                child: ListView(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => new SkyLadderList({})),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(24),
                            right: ScreenUtil.getInstance().setWidth(24),
                            top: ScreenUtil.getInstance().setHeight(30),
                            bottom: ScreenUtil.getInstance().setHeight(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'images/tools_user_time.png',
                                    width: ScreenUtil.getInstance().setWidth(24),
                                  ),
                                  Text(
                                    info.isEmpty
                                        ? '  更新时间:  ${now.year}/${now.month}/${now.day} ${now.hour}:${now.minute}'
                                        : '  更新时间:  ${info['collectVersion']}'.replaceAll('-', '/'),
                                    style: TextStyle(
                                        fontSize: ScreenUtil.getInstance().setSp(22),
                                        color: Color(0xff6F6146)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('天梯榜详情',
                                      style: TextStyle(
                                          fontSize: ScreenUtil.getInstance().setSp(22),
                                          color: Color(0xffB51610))),
                                  Image.asset(
                                    'images/tools_next.png',
                                    width: ScreenUtil.getInstance().setWidth(22),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: width / 728 * 258,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'images/tools_user_bg.png',
                              ),
                              fit: BoxFit.cover)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/tools_add_icon.png',
                            width: ScreenUtil.getInstance().setWidth(84),
                          ),
                          Text(
                            '  登录并绑定英雄，即可查看天梯成绩',
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(26),
                                color: Color(0xff3D2F1B)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(24),
                          top: ScreenUtil.getInstance().setWidth(24),
                          bottom: ScreenUtil.getInstance().setWidth(48)),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'images/notification_bg_normal.9.png',
                            width: ScreenUtil.getInstance().setWidth(16),
                          ),
                          Text(
                            '  全服最强',
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setWidth(30),
                                color: Color(0xff3D2F1B)),
                          )
                        ],
                      ),
                    ),
                    diabloToolsIndexConfig.isNotEmpty && info.isNotEmpty
                        ? Wrap(
                            runSpacing: ScreenUtil.getInstance().setWidth(20),
                            children:
                                diabloToolsIndexConfig['serverMysticInfo'].keys.map<Widget>((key) {
                              count += 1;
                              var item = diabloToolsIndexConfig['serverMysticInfo'][key];
                              String name = '';

                              for (int i = 0; i < info['mysticTypeList'].length; i++) {
                                if (item[0]['mysticType'].toString() ==
                                    info['mysticTypeList'][i]['code'].toString()) {
                                  name = info['mysticTypeList'][i]['type']
                                      .toString()
                                      .replaceAll('组队', '');
                                  break;
                                }
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new SkyLadderList({})),
                                  );
                                },
                                child: Container(
                                  width: (width - ScreenUtil.getInstance().setWidth(72)) / 2,
                                  margin:
                                      EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(24)),
                                  padding: EdgeInsets.all(
                                    ScreenUtil.getInstance().setWidth(15),
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffB5A88E)),
                                      borderRadius: BorderRadius.all(Radius.circular(6))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          children: <Widget>[
                                            Image.asset(
                                              'images/tools_${count}_ic.png',
                                              width: ScreenUtil.getInstance().setWidth(24),
                                            ),
                                            Text(
//                                              serverTypeList  serverType=0
                                              ' ${info['serverTypeList'][item[0]['serverType'] + 1]['type']}'
                                              '${name}第一',
                                              style: TextStyle(
                                                  fontSize: ScreenUtil.getInstance().setSp(26),
                                                  color: Color(0xff6A5C41)),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: ScreenUtil.getInstance().setHeight(24.0 * 3 + 30),
                                          child: RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Color(0xff96886E),
                                                      fontSize: ScreenUtil.getInstance().setSp(24)),
                                                  children: item.map<TextSpan>((battleTag) {
                                                    return TextSpan(
                                                        text: '${battleTag['battleTag']}');
                                                  }).toList()))

//                                        Text(
//                                          '${item[0]['mysticTier']}层',
//                                          style: TextStyle(
//                                              color: Color(0xff96886E),
//                                              fontSize: ScreenUtil.getInstance().setSp(24)),
//                                        ),
                                          ),
                                      Container(
                                        child: Text(
                                          '${item[0]['mysticTier']}层',
                                          style: TextStyle(
                                              color: Color(0xffB51610),
                                              fontSize: ScreenUtil.getInstance().setSp(36)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setHeight(32),
                        bottom: ScreenUtil.getInstance().setHeight(32),
                        left: ScreenUtil.getInstance().setHeight(24),
                        right: ScreenUtil.getInstance().setHeight(24),
                      ),
                      height: ScreenUtil.getInstance().setHeight(1),
                      color: Color(0xff94856D),
                    ),
                    Column(
                      children: diabloToolsIndexConfig['list'].reversed.map<Widget>((item) {
                        return item['name'] == '天梯榜'
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  if (item['id'].toString() == '10') {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => new Simulator({})),
                                    );
                                  } else if (item['id'].toString() == '9') {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(builder: (context) => new DataBase()),
                                    );
                                  } else if (item['id'].toString() == '1') {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => new LiftingArtifacts()),
                                    );
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    bottom: ScreenUtil.getInstance().setHeight(20),
                                    left: ScreenUtil.getInstance().setHeight(24),
                                    right: ScreenUtil.getInstance().setHeight(24),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xffB5A88E),
                                        width: ScreenUtil.getInstance().setWidth(1)),
                                    color: Color(0xffD0C4AC),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: ScreenUtil.getInstance().setWidth(14),
                                      right: ScreenUtil.getInstance().setWidth(14),
                                      top: ScreenUtil.getInstance().setWidth(8),
                                      bottom: ScreenUtil.getInstance().setWidth(8)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Image.asset(
                                            'images/${item['name'] == '模拟器' ? 'icon_tools_simulator' : item['name'] == '数据库' ? 'icon_tools_database' : item['name'] == '提升神器' ? 'tools_promotion_tool' : ''}.png',
                                            width: ScreenUtil.getInstance().setWidth(72),
                                          ),
                                          Text(
                                            item['name'],
                                            style: TextStyle(
                                                fontSize: ScreenUtil.getInstance().setSp(26),
                                                color: Color(0xff6A5C41)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            '${item['title']}',
                                            style: TextStyle(
                                                fontSize: ScreenUtil.getInstance().setSp(22),
                                                color: Color(0xff998C72)),
                                          ),
                                          item['state'] == '1'
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      left: ScreenUtil.getInstance().setWidth(10)),
                                                  child: Image.asset(
                                                    'images/btn_pgbbs_details_page2.png',
                                                    width: ScreenUtil.getInstance().setWidth(14),
                                                  ),
                                                )
                                              : SizedBox()
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                      }).toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
