import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'util.dart';

class Equipment extends StatefulWidget {
  final props;

  Equipment(this.props);

  @override
  _EquipmentState createState() => _EquipmentState();
}

class _EquipmentState extends State<Equipment> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  bool showEquip = true;

  Map titleBg = {
    'Normal': 'images/tooltip-title0.png',
    'Magic': 'images/tooltip-title1.png',
    'Rare': 'images/tooltip-title2.png',
    'Legendary': 'images/tooltip-title3.png',
    'Set': 'images/tooltip-title4.png',
  };

//  String bg = 'equipment_normal';
//  switch (item['qualityKey']) {
//  case 'Normal':
//  bg = 'equipment_normal';
//  break;
//  case 'Magic':
//  bg = 'equipment_magic';
//  break;
//  case 'Rare':
//  bg = 'equipment_rare';
//  break;
//  case 'Legendary':
//  bg = 'equipment_legendary';
//  break;
//  case 'Set':
//  bg = 'equipment_set';
//  break;
//  }

  Map eBg = {
    'Normal': 'images/equipment_normal.png',
    'Magic': 'images/equipment_magic.png',
    'Rare': 'images/equipment_rare.png',
    'Legendary': 'images/equipment_legendary.png',
    'Set': 'images/equipment_set.png',
  };

  Map equipBg = {
    'Normal': 'images/bg0.png',
    'Magic': 'images/bg1.png',
    'Rare': 'images/bg2.png',
    'Legendary': 'images/bg3.png',
    'Set': 'images/bg4.png',
  };

  Map colors = {
//    'Normal': 0xffffffff,
    'Normal': 0xffffffff,
    'Magic': 0xff6969ff,
    'Rare': 0xffffff00,
    'Legendary': 0xffff8000,
    'Set': 0xff00ff00
  };

  // ];

  @override
  void initState() {
    super.initState();
    _getInstanceEquipmentList();
  }

  List equipItems = [];

  _getInstanceEquipmentList() async {
    setState(() {
      equipItems.clear();
    });
    List temp = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String equipmentList = prefs.getString('equipmentList');
    if (equipmentList != null) {
      for (var o in jsonDecode(equipmentList)) {
        if (o['parentTypeKey'] == widget.props['item']['parentTypeKey'] &&
            o['typeKey'] == widget.props['item']['typeKey']) {
          temp.add(o);
        }
      }
      if (mounted) {
        setState(() {
          equipItems = temp;
        });
      }
    }
  }

  Map equipDetail = {};

  _getEquipDetail(item) {
    setState(() {
      showEquip = false;
      equipDetail.clear();
    });
    ajax(
        'https://cain-api.gameyw.netease.com/diablo3db-web/item/detail?identifier=${item['identifier']}',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          equipDetail = data['data'];
        });
      }
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
          title: Text('${widget.props['item']['type']}',
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
                  top: ScreenUtil.getInstance().setWidth(126),
                  height: height -
                      MediaQuery.of(context).padding.top -
                      56 -
                      ScreenUtil.getInstance().setWidth(126),
                  width: width,
                  child: Container(
                    child: equipItems.isEmpty
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
                            child: ListView(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(24),
                                  right: ScreenUtil.getInstance().setWidth(24)),
                              children: equipItems.map<Widget>((item) {
                                return GestureDetector(
                                  onTap: () {
                                    _getEquipDetail(item);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(18),
                                        right: ScreenUtil.getInstance().setWidth(18),
                                        top: ScreenUtil.getInstance().setHeight(24),
                                        bottom: ScreenUtil.getInstance().setHeight(24)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        border: Border.all(
                                            color: Color(0xffB5A88E),
                                            width: ScreenUtil.getInstance().setWidth(1)),
                                        color: Color(0xffE3D4BF)),
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil.getInstance().setHeight(24)),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil.getInstance().setWidth(10)),
                                          width: ScreenUtil.getInstance().setWidth(84),
                                          height: ScreenUtil.getInstance().setWidth(84),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage('${eBg[item['qualityKey']]}'))),
                                          padding: EdgeInsets.all(10),
                                          child: Image.network(
                                            'https://ok.166.net/cain-corner/diablo3db/49512/cn/items/${item['picIcon']}.png?'
                                            'imageView&type=webp&thumbnail=76x76',
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  item['name'],
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil.getInstance().setSp(30),
                                                      color: Color(0xff3D2F1B)),
                                                ),
                                                Container(
                                                  width: ScreenUtil.getInstance().setWidth(20),
                                                ),
                                                Text(
                                                  item['originKey'] == null ? '世界掉落' : '铁匠',
                                                  style: TextStyle(
                                                      color: Color(0xff9B8C73),
                                                      fontSize: ScreenUtil.getInstance().setSp(26)),
                                                )
                                              ],
                                            ),
                                            Container(
                                              height: ScreenUtil.getInstance().setHeight(6),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text('物品等级·${item['itemLevel']}',
                                                    style: TextStyle(
                                                        color: Color(0xff9B8C73),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(26))),
                                                Container(
                                                  width: ScreenUtil.getInstance().setWidth(20),
                                                ),
                                                Text('装备等级·${item['requireLevel']}',
                                                    style: TextStyle(
                                                        color: Color(0xff9B8C73),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(26)))
                                              ],
                                            )
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil.getInstance().setHeight(40),
                        margin: EdgeInsets.only(
                            top: ScreenUtil.getInstance().setHeight(36),
                            bottom: ScreenUtil.getInstance().setHeight(50)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffB51610),
                                width: ScreenUtil.getInstance().setWidth(1)),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(24),
                          right: ScreenUtil.getInstance().setWidth(24),
                        ),
                        child: Center(
                          child: Text(
                            '筛选',
                            style: TextStyle(
                                color: Color(0xffB51610),
                                fontSize: ScreenUtil.getInstance().setSp(23)),
                          ),
                        ),
                      )
                    ],
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
                      child: equipDetail.isEmpty
                          ? Container()
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
                                              image: AssetImage(
                                                  '${titleBg[equipDetail['item']['itemClassKey']]}'))),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            child: Center(
                                              child: Text(
                                                equipDetail['item']['name'],
                                                style: TextStyle(
                                                    color: Color(colors[equipDetail['item']
                                                        ['itemClassKey']]),
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
                                            children: <Widget>[
                                              Container(
                                                width: ScreenUtil.getInstance().setWidth(87),
                                                height: ScreenUtil.getInstance().setWidth(166),
                                                margin: EdgeInsets.only(
                                                    right: ScreenUtil.getInstance().setWidth(12)),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(colors[equipDetail['item']
                                                            ['itemClassKey']]),
                                                        width:
                                                            ScreenUtil.getInstance().setWidth(2)),
                                                    borderRadius:
                                                        BorderRadius.all(Radius.circular(6)),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            '${equipBg[equipDetail['item']['itemClassKey']]}'))),
                                                child: Image.network(
                                                  'https://ok.166.net/cain-corner/diablo3db/49512/cn/items/${equipDetail['item']['picIcon']}.png?'
                                                  'imageView&type=webp&thumbnail=76x76',
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '${equipDetail['item']['itemClass']}  ${equipDetail['item']['type']}',
                                                      style: TextStyle(
                                                          color: Color(colors[equipDetail['item']
                                                              ['itemClassKey']]),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(16)),
                                                    ),
                                                    Container(
                                                      height:
                                                          ScreenUtil.getInstance().setHeight(24),
                                                    ),
                                                    RichText(
                                                        text: TextSpan(children: <TextSpan>[
                                                      TextSpan(
                                                        text: '${equipDetail['item']['lowDps']} - '
                                                            '${equipDetail['item']['highDps']} ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(16)),
                                                      ),
                                                      TextSpan(
                                                        text: '伤害/秒',
                                                        style: TextStyle(
                                                            color: Color(0xff8A8A8A),
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(16)),
                                                      ),
                                                    ])),
                                                    Container(
                                                      height:
                                                          ScreenUtil.getInstance().setHeight(20),
                                                    ),
                                                    RichText(
                                                        text: TextSpan(children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            '(${equipDetail['item']['low1Damage']} - ${equipDetail['item']['high1Damage']}) - '
                                                            '(${equipDetail['item']['low2Damage']} - ${equipDetail['item']['high2Damage']}) ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(16)),
                                                      ),
                                                      TextSpan(
                                                        text: '伤害',
                                                        style: TextStyle(
                                                            color: Color(0xff8A8A8A),
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(16)),
                                                      ),
                                                    ])),
                                                    Container(
                                                      height:
                                                          ScreenUtil.getInstance().setHeight(20),
                                                    ),
                                                    RichText(
                                                        text: TextSpan(children: <TextSpan>[
                                                      TextSpan(
                                                        text: '${equipDetail['item']['lowAps']} ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(16)),
                                                      ),
                                                      TextSpan(
                                                        text: '攻击速度',
                                                        style: TextStyle(
                                                            color: Color(0xff8A8A8A),
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(16)),
                                                      ),
                                                    ])),
                                                  ],
                                                ),
                                              )),
                                              Container(
                                                child: Text(
                                                  '${equipDetail['item']['slot']}',
                                                  style: TextStyle(
                                                      color: Color(0xff8A8A8A),
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        equipDetail['attrList'].isEmpty
                                            ? Container()
                                            : Column(
                                                children:
                                                    equipDetail['attrList'].map<Widget>((item) {
                                                  return Container(
                                                    padding: EdgeInsets.only(
                                                      bottom: ScreenUtil.getInstance().setWidth(12),
                                                      left: ScreenUtil.getInstance().setWidth(20),
                                                      right: ScreenUtil.getInstance().setWidth(20),
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Image.asset(
                                                          'images/icons_primary.gif',
                                                          width:
                                                              ScreenUtil.getInstance().setWidth(12),
                                                        ),
                                                        Container(
                                                          width:
                                                              ScreenUtil.getInstance().setWidth(12),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Html(
                                                            data: '${item['text']}'
                                                                .replaceAll('<li', '<p')
                                                                .replaceAll('</li>', '</p>'),
                                                            defaultTextStyle: TextStyle(
                                                                color: Color(colors['Magic']),
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setSp(16)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                        equipDetail['item']['origin'] == null
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.only(
                                                  bottom: ScreenUtil.getInstance().setWidth(12),
                                                  left: ScreenUtil.getInstance().setWidth(20),
                                                  right: ScreenUtil.getInstance().setWidth(20),
                                                ),
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'images/icons_primary.gif',
                                                      width: ScreenUtil.getInstance().setWidth(12),
                                                    ),
                                                    Container(
                                                      width: ScreenUtil.getInstance().setWidth(12),
                                                    ),
                                                    Text(
                                                      '来源：${equipDetail['item']['origin']}',
                                                      style: TextStyle(
                                                          color: Color(0xffAF9E69),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(16)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        equipDetail['suit'] == null
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(24)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        '${equipDetail['suit']['name']}',
                                                        style: TextStyle(
                                                            color: Color(colors[equipDetail['item']
                                                                ['itemClassKey']]),
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(16)),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: equipDetail['suit']['parts']
                                                          .map<Widget>((item) {
                                                        return Container(
                                                          padding: EdgeInsets.only(
                                                              left: ScreenUtil.getInstance()
                                                                  .setWidth(24)),
                                                          child: Text('${item['name']}',
                                                              style: TextStyle(
                                                                  color: Color(0xffAF9E69),
                                                                  fontSize: ScreenUtil.getInstance()
                                                                      .setSp(16))),
                                                        );
                                                      }).toList(),
                                                    )
                                                  ],
                                                ),
                                              ),
                                        equipDetail['setAttrList'] == null
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(24)),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: equipDetail['setAttrList']
                                                      .map<Widget>((item) {
                                                    return Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(
                                                              '(${item['bonusNumParts']}) 套装',
                                                              style: TextStyle(
                                                                  color: Color(0xffAF9E69),
                                                                  fontSize: ScreenUtil.getInstance()
                                                                      .setSp(16))),
                                                        ),
                                                        Html(
                                                          data: '${item['text']}'
                                                              .replaceAll('<li', '<p')
                                                              .replaceAll('</li>', '</p>'),
                                                          padding: EdgeInsets.only(
                                                              left: ScreenUtil.getInstance()
                                                                  .setWidth(24)),
                                                          defaultTextStyle: TextStyle(
                                                              color: Color(0xff838383),
                                                              fontSize: ScreenUtil.getInstance()
                                                                  .setSp(16)),
                                                        )
                                                      ],
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(20),
                                              right: ScreenUtil.getInstance().setWidth(20),
                                              bottom: ScreenUtil.getInstance().setHeight(12)),
                                          child: Text(
                                            '需要等级 ${equipDetail['item']['requireLevel']}',
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
                                            'ilvl ${equipDetail['item']['itemLevel']}',
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
                                            '耐久：${equipDetail['item']['lowDurability']} - ${equipDetail['item']['highDurability']}',
                                            style: TextStyle(
                                                color: Color(0xffC7B377),
                                                fontSize: ScreenUtil.getInstance().setSp(16)),
                                          ),
                                        ),
                                        equipDetail['item']['story'] == null
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.only(
                                                    left: ScreenUtil.getInstance().setWidth(20),
                                                    right: ScreenUtil.getInstance().setWidth(20),
                                                    bottom: ScreenUtil.getInstance().setHeight(12)),
                                                child: Text(
                                                  '${equipDetail['item']['story']}',
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
