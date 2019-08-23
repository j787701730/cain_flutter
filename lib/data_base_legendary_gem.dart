import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'util.dart';

class DataBaseLegendaryGem extends StatefulWidget {
  final props;

  DataBaseLegendaryGem(this.props);

  @override
  _DataBaseLegendaryGemState createState() => _DataBaseLegendaryGemState();
}

class _DataBaseLegendaryGemState extends State<DataBaseLegendaryGem> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  bool flag = true;

  bool show = false;
  bool showEquip = true;

  List drop = ['世界掉落'];

  Map selectLegendaryGem = {};

  @override
  void initState() {
    super.initState();
    _ajax();
    _getInstanceGemList();
  }

  List gemList = [];

  _getInstanceGemList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String gemList1 = prefs.getString('gemList');
    if (gemList1 != null) {
      setState(() {
        gemList = jsonDecode(gemList1);
      });
    }
  }

  _getGemDetail(item) {
    setState(() {
      selectLegendaryGem.clear();
    });
    ajax(
        'https://cain-api.gameyw.netease.com/diablo3db-web/item/detail?identifier=${item['identifier']}',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          selectLegendaryGem = data['data'];
        });
      }
    });
  }

  _ajax() async {
    await Future.delayed(Duration(seconds: 1), () {
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
          title: Text('传奇宝石',
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
              color: Color(0xffE8DAC5),
              image: DecorationImage(
                  image: AssetImage('images/fragment_tools_bg.jpg'), fit: BoxFit.fill)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                  left: 0,
                  top: 0,
                  height: height - MediaQuery.of(context).padding.top - 56,
                  width: width,
                  child: Container(
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
                              print('onLoading');
                              await Future.delayed(Duration(milliseconds: 2000));
                              // if failed,use loadFailed(),if no data return,use LoadNodata()
                              if (mounted) setState(() {});
                              _refreshController.loadComplete();
                            },
                            child: gemList.isEmpty
                                ? Container()
                                : ListView(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(24),
                                        right: ScreenUtil.getInstance().setWidth(24)),
                                    children: gemList.map<Widget>((item) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            showEquip = false;
                                            _getGemDetail(item);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setHeight(24)),
                                          decoration: BoxDecoration(
                                              color: Color(0xffE3D4BF),
                                              border: Border.all(
                                                  color: Color(0xffB5A88E),
                                                  width: ScreenUtil.getInstance().setWidth(1)),
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
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image:
                                                            AssetImage('images/gem_icon_bg.png'))),
                                                margin: EdgeInsets.only(
                                                    right: ScreenUtil.getInstance().setWidth(12)),
                                                width: ScreenUtil.getInstance().setWidth(84),
                                                height: ScreenUtil.getInstance().setHeight(84),
                                                child: Image.network(
                                                  'https://ok.166.net/cain-corner/diablo3db/49512/cn/items/'
                                                  '${item['picIcon']}.png?imageView&type=webp&thumbnail=67x67',
//                                              fit: BoxFit.fill,
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment.center,
                                                        children: <Widget>[
                                                          Text(
                                                            '${item['name']}',
                                                            style: TextStyle(
                                                                color: Color(0xff3D2F1B),
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setSp(30)),
                                                          ),
                                                          Container(
                                                            width: ScreenUtil.getInstance()
                                                                .setWidth(10),
                                                          ),
                                                          Text('世界掉落',
                                                              style: TextStyle(
                                                                  color: Color(0xff9B8C73),
                                                                  fontSize: ScreenUtil.getInstance()
                                                                      .setSp(26))),
                                                        ],
                                                      ),
                                                      Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment.center,
                                                        children: <Widget>[
                                                          Text(
                                                            '物品等级·${item['itemLevel']}',
                                                            style: TextStyle(
                                                                color: Color(0xff9B8C73),
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setSp(26)),
                                                          ),
                                                          Container(
                                                            width: ScreenUtil.getInstance()
                                                                .setWidth(10),
                                                          ),
                                                          Text('装备等级·${item['requireLevel']}',
                                                              style: TextStyle(
                                                                  color: Color(0xff9B8C73),
                                                                  fontSize: ScreenUtil.getInstance()
                                                                      .setSp(26))),
                                                        ],
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                          ),
                  )),
              Positioned(
                  left: 0,
                  top: 0,
                  width: width,
                  height: height - MediaQuery.of(context).padding.top - 56,
                  child: Offstage(
                    offstage: showEquip,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showEquip = true;
                        });
                      },
                      child: selectLegendaryGem.isEmpty
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: 56 + ScreenUtil.getInstance().setHeight(20),
                                  bottom: ScreenUtil.getInstance().setHeight(146),
                                  left: ScreenUtil.getInstance().setWidth(70),
                                  right: ScreenUtil.getInstance().setWidth(70)),
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
                                        color: Color(0xff938373),
                                        fontSize: ScreenUtil.getInstance().setSp(23)),
                                  )
                                ],
                              )),
                            )
                          : Container(
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
                                                '${selectLegendaryGem['item']['name']}',
                                                style: TextStyle(
                                                    color: Color(0xffAE5A2A),
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
                                                    showEquip = true;
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
                                    Expanded(
                                        child: ListView(
                                      children: <Widget>[
                                        Container(
                                          padding:
                                              EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  width: ScreenUtil.getInstance().setWidth(87),
                                                  height: ScreenUtil.getInstance().setWidth(166),
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil.getInstance().setWidth(12)),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(0xffB07B38),
                                                          width:
                                                              ScreenUtil.getInstance().setWidth(2)),
                                                      borderRadius:
                                                          BorderRadius.all(Radius.circular(6)),
                                                      image: DecorationImage(
                                                          image: AssetImage('images/bg3.png'))),
                                                  child: Image.network(
                                                    'https://ok.166.net/cain-corner/diablo3db/49512/cn/items/'
                                                    '${selectLegendaryGem['item']['picIcon']}.png?imageView&type=webp&thumbnail=67x67',
                                                  )),
                                              Expanded(
                                                  child: Container(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil.getInstance().setHeight(14)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '${selectLegendaryGem['item']['quality']} ${selectLegendaryGem['item']['type']}',
                                                      style: TextStyle(
                                                          color: Color(0xff874621),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(16)),
                                                    ),
                                                    Container(
                                                      height:
                                                          ScreenUtil.getInstance().setHeight(24),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: ScreenUtil.getInstance().setHeight(24)),
                                                child: Text(
                                                  '${selectLegendaryGem['item']['type']}',
                                                  style: TextStyle(
                                                      color: Color(0xff8A8A8A),
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children:
                                              selectLegendaryGem['attrList'].map<Widget>((effects) {
                                            return Container(
                                              padding: EdgeInsets.only(
                                                left: ScreenUtil.getInstance().setWidth(20),
                                                right: ScreenUtil.getInstance().setWidth(20),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            ScreenUtil.getInstance().setWidth(12)),
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil.getInstance().setWidth(18)),
                                                    child: Image.asset(
                                                      'images/icons_primary.gif',
                                                      width: ScreenUtil.getInstance().setWidth(12),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Wrap(
                                                        children: <Widget>[
                                                          Html(
                                                            data: '${effects['text']}'
                                                                .replaceAll('<li', '<p')
                                                                .replaceAll('</li>', '</p>'),
                                                            defaultTextStyle: TextStyle(
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setWidth(16),
                                                                fontStyle: FontStyle.normal,
                                                                color: Color(0xff7A3F1D),
                                                                fontFamily: 'SourceHanSansCN'),
                                                            customTextStyle: (dom.Node node,
                                                                TextStyle baseStyle) {
                                                              if (node is dom.Element) {
                                                                switch (node.className) {
                                                                  case "d3-color-red":
                                                                    return baseStyle.merge(
                                                                        TextStyle(
                                                                            color: Colors.red,
                                                                            fontStyle:
                                                                                FontStyle.normal,
                                                                            fontWeight:
                                                                                FontWeight.normal));
                                                                    break;
                                                                }
                                                              }
                                                              return baseStyle;
                                                            },
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(20),
                                              right: ScreenUtil.getInstance().setWidth(20),
                                              bottom: ScreenUtil.getInstance().setHeight(12)),
                                          child: Text(
                                            '需要等级 ${selectLegendaryGem['item']['requireLevel']}',
                                            style: TextStyle(
                                                color: Color(0xffC7B377),
                                                fontSize: ScreenUtil.getInstance().setSp(16)),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(20),
                                              right: ScreenUtil.getInstance().setWidth(20),
                                              bottom: ScreenUtil.getInstance().setHeight(12)),
                                          child: Text(
                                            'ilvl：${selectLegendaryGem['item']['requireLevel']}',
                                            style: TextStyle(
                                                color: Color(0xffC7B377),
                                                fontSize: ScreenUtil.getInstance().setSp(16)),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(20),
                                              right: ScreenUtil.getInstance().setWidth(20),
                                              bottom: ScreenUtil.getInstance().setHeight(12)),
                                          child: Text(
                                            '${selectLegendaryGem['item']['backgroundText']}',
                                            style: TextStyle(
                                                color: Color(0xffC7B377),
                                                fontSize: ScreenUtil.getInstance().setSp(16)),
                                          ),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
