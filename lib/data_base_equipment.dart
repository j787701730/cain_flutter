import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'equipment.dart';
import 'util.dart';

class DataBaseEquipment extends StatefulWidget {
  @override
  _DataBaseEquipmentState createState() => _DataBaseEquipmentState();
}

class _DataBaseEquipmentState extends State<DataBaseEquipment>
    with TickerProviderStateMixin, SingleTickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _getArmorsList();
    _tabController = TabController(length: 2, vsync: this);
  }

  Map armorsList = {};

  _getArmorsList() {
    ajax('https://cain-api.gameyw.netease.com/diablo3db-web/item/meta', (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          armorsList = data;
        });
      }
    });
  }

  equipItem(width, data) {
    return Container(
      child: Column(
        children: data.keys.map<Widget>((key) {
          var item = data[key];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: ScreenUtil.getInstance().setHeight(24),
                    bottom: ScreenUtil.getInstance().setHeight(44)),
                width: width,
                height: ScreenUtil.getInstance().setHeight(78),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/equipment_title_bg.png'), fit: BoxFit.fitHeight)),
                child: Center(
                  child: Text(
                    '${item['name']}',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().setSp(26), color: Color(0xff3D2F1B)),
                  ),
                ),
              ),
              Wrap(
                children: item['list'].map<Widget>((list) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(builder: (context) => new Equipment({'item': list})),
                      );
                    },
                    child: Container(
                      width: width / 4,
                      margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setHeight(48)),
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(24),
                          right: ScreenUtil.getInstance().setWidth(24)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: width / 4 - ScreenUtil.getInstance().setWidth(48),
                            height: width / 4 - ScreenUtil.getInstance().setWidth(48),
                            padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(6)),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/equipment_weapon_bg.png'),
                                    fit: BoxFit.fill)),
                            child: Image.network(
                              'https://ok.166.net/cain-corner/diablo3db/49512/cn/items/${list['typeKey']}.png?imageView&type=webp&thumbnail=86x86',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(8)),
                            child: Text(
                              '${list['type']}',
                              style: TextStyle(
                                  color: Color(0xff3D2F1B),
                                  fontSize: ScreenUtil.getInstance().setSp(26)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          );
        }).toList(),
      ),
    );
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
          title: Text('装备数据库',
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
                  image: AssetImage('images/fragment_tools_bg.jpg'), fit: BoxFit.fill)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                  left: 0,
                  top: ScreenUtil.getInstance().setHeight(96),
                  height: height -
                      ScreenUtil.getInstance().setHeight(96) -
                      MediaQuery.of(context).padding.top -
                      56,
                  width: width,
                  child: Container(
//                    color: Color(0xffE8DAC5),
                    child: armorsList.isEmpty
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
                                    children: <Widget>[
                                      CupertinoActivityIndicator(),
                                      Text('   载入中...')
                                    ],
                                  );
                                } else if (mode == LoadStatus.loading) {
                                  body = Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CupertinoActivityIndicator(),
                                      Text('   载入中...')
                                    ],
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
                            child: Container(
                              height: height -
                                  ScreenUtil.getInstance().setHeight(96) -
                                  MediaQuery.of(context).padding.top -
                                  56,
                              child: TabBarView(
                                physics: NeverScrollableScrollPhysics(),
                                controller: _tabController,
                                children: <Widget>[
//                                  equipmentBox(width, weapons),
//                                  equipmentBox(width, armor),
                                  // 武器
                                  ListView(
                                    children: <Widget>[
                                      equipItem(width, armorsList['weaponsList']),
                                    ],
                                  ),
                                  // 护甲
                                  ListView(
                                    children: <Widget>[
                                      equipItem(width, armorsList['armorsList']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                  )),
              Positioned(
                  left: 0,
                  top: 0,
                  width: width,
                  height: ScreenUtil.getInstance().setHeight(96),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xffC5B7A0),
                                width: ScreenUtil.getInstance().setWidth(1)))),
                    height: ScreenUtil.getInstance().setHeight(96),
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
                                  labelStyle:
                                      TextStyle(fontSize: ScreenUtil.getInstance().setSp(32)),
                                  indicatorWeight: ScreenUtil.getInstance().setWidth(4),
                                  indicatorColor: Color(0xffB51610),
                                  indicatorPadding: EdgeInsets.only(
                                      bottom: ScreenUtil.getInstance().setHeight(-2)),
                                  tabs: <Tab>[
                                    Tab(
                                      text: "武器",
                                    ),
                                    Tab(
                                      text: "护甲",
                                    ),
                                  ]),
                            )),
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
                            '定位',
                            style: TextStyle(
                                color: Color(0xffB51610),
                                fontSize: ScreenUtil.getInstance().setSp(23)),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
