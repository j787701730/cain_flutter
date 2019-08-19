import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'util.dart';

// 天梯榜
class SkyLadderList extends StatefulWidget {
  final props;

  SkyLadderList(this.props);

  @override
  _SkyLadderListState createState() => _SkyLadderListState();
}

class _SkyLadderListState extends State<SkyLadderList> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  DateTime now = DateTime.now();

  bool showSelectBox = false;
  int skyLadderListLimit = 3;

  Map selectInfo = {};
  List listInfo = [];
  int page = 20;

  String serverType = '';
  String season = '';
  String modeType = '0';
  String mysticType = '0';

  @override
  void initState() {
    super.initState();
    _getSelectInfo();
    _getListInfo();
  }

  _getSelectInfo() {
    ajax('https://cain-api.gameyw.netease.com/worldhero-web/app_api/queryConfig', (data) {
      if (mounted && data['code'] == 0) {
        setState(() {
          selectInfo = data['info'];
        });
      }
    });
  }

  _getListInfo() {
    ajax(
        'https://cain-api.gameyw.netease.com/worldhero-web/app_api/mystic/$page/20?serverType=$serverType&season=$season&modeType=$modeType&mysticType=$mysticType',
        (data) {
      _refreshController.loadComplete();
      if (mounted && data['code'] == 0) {
        if (page == 20) {
          setState(() {
            listInfo = data['info'];
          });
        } else {
          setState(() {
            listInfo.addAll(data['info']);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
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
          title: Text(
            '天梯榜',
            style: TextStyle(color: Color(0xffFFDF8E)),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
                left: 0,
                top: 0,
                height: ScreenUtil.getInstance().setHeight(162),
                width: width,
                child: Stack(
                  children: <Widget>[
                    Container(
                      color: Color(0xffE8DAC5),
                      padding: EdgeInsets.only(
                          left: ScreenUtil.getInstance().setWidth(24),
                          right: ScreenUtil.getInstance().setWidth(24),
                          top: ScreenUtil.getInstance().setHeight(27),
                          bottom: ScreenUtil.getInstance().setHeight(26)),
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
                                  selectInfo.isEmpty
                                      ? '  更新时间:  ${now.year}/${now.month}/${now.day} ${now.hour}:${now.minute}'
                                      : '  更新时间:  ${selectInfo['collectVersion']}'
                                          .replaceAll('-', '/'),
                                  style: TextStyle(
                                      fontSize: ScreenUtil.getInstance().setSp(22),
                                      color: Color(0xff6F6146)),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showSelectBox = !showSelectBox;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(20),
                                  right: ScreenUtil.getInstance().setWidth(20),
                                  top: ScreenUtil.getInstance().setHeight(4),
                                  bottom: ScreenUtil.getInstance().setHeight(4)),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffB51610),
                                      width: ScreenUtil.getInstance().setWidth(1)),
                                  borderRadius: BorderRadius.all(Radius.circular(6))),
                              child: Text(
                                '筛选',
                                style: TextStyle(
                                    fontSize: ScreenUtil.getInstance().setSp(24),
                                    color: Color(0xffB51610)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        height: ScreenUtil.getInstance().setHeight(64),
                        child: Table(columnWidths: {
                          0: FixedColumnWidth(width / 5),
                          1: FixedColumnWidth(width / 5 * 2),
                          2: FixedColumnWidth(width / 5),
                          3: FixedColumnWidth(width / 5),
                        }, children: [
                          TableRow(
                              //第1行样式 添加背景色
                              decoration: BoxDecoration(
                                color: Color(0xffD0C4AC),
                              ),
                              children: [
                                //增加行高
                                Container(
                                  height: ScreenUtil.getInstance().setHeight(64),
                                  child: Center(
                                    child: Text(
                                      '排名',
                                      style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(26)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil.getInstance().setHeight(64),
                                  child: Center(
                                    child: Text(
                                      'BATTLETAG',
                                      style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(26)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil.getInstance().setHeight(64),
                                  child: Center(
                                    child: Text(
                                      '层数',
                                      style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(26)),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: ScreenUtil.getInstance().setHeight(64),
                                  child: Center(
                                    child: Text(
                                      '时间',
                                      style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(26)),
                                    ),
                                  ),
                                )
                              ]),
                        ]))
                  ],
                )),
            Positioned(
                left: 0,
                top: ScreenUtil.getInstance().setHeight(162),
                height: height -
                    ScreenUtil.getInstance().setHeight(96 + 162.0) -
                    MediaQuery.of(context).padding.top -
                    56,
                width: width,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffE8DAC5),
                      image: DecorationImage(
                          image: AssetImage('images/fragment_tools_bg.jpg'), fit: BoxFit.fill)),
                  child: listInfo.isEmpty
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
                          enablePullUp: true,
                          enablePullDown: false,
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
                            setState(() {
                              page += 20;
                              _getListInfo();
                            });
                          },
                          child: ListView(
                            children: <Widget>[
                              listInfo.isEmpty
                                  ? Container()
                                  : Table(
                                      columnWidths: {
                                          0: FixedColumnWidth(width / 5),
                                          1: FixedColumnWidth(width / 5 * 2),
                                          2: FixedColumnWidth(width / 5),
                                          3: FixedColumnWidth(width / 5),
                                        },
                                      children: listInfo.map((item) {
                                        return TableRow(
                                            //第1行样式 添加背景色
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        color: Color(0xffC5B7A1),
                                                        width:
                                                            ScreenUtil.getInstance().setWidth(1)))),
                                            children: [
                                              //增加行高
//                                          {'ranking': 18, 'name': '馆长', 'floor': '128', 'time': '14:43'},
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(64),
                                                child: Center(
                                                  child: Text(
                                                    '${listInfo.indexOf(item) + 1}',
                                                    style: TextStyle(
                                                        color: Color(listInfo.indexOf(item) < 3
                                                            ? 0xff3D2F1B
                                                            : 0xff9C8D75),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(20)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(64),
                                                child: Center(
                                                  child: Text(
                                                    item['battleTag'],
                                                    style: TextStyle(
                                                        color: Color(listInfo.indexOf(item) < 3
                                                            ? 0xffB51610
                                                            : 0xff6A5C41),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(20)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(64),
                                                child: Center(
                                                  child: Text(
                                                    '${item['mysticTier']}',
                                                    style: TextStyle(
                                                        color: Color(listInfo.indexOf(item) < 3
                                                            ? 0xff3D2F1B
                                                            : 0xff9C8D75),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(20)),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(64),
                                                child: Center(
                                                  child: Text(
                                                    '${item['costTime']}'
                                                        .substring(0, item['costTime'].indexOf('.'))
                                                        .replaceAll('分', ':'),
                                                    style: TextStyle(
                                                        color: Color(listInfo.indexOf(item) < 3
                                                            ? 0xff3D2F1B
                                                            : 0xff9C8D75),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(20)),
                                                  ),
                                                ),
                                              )
                                            ]);
                                      }).toList())
                            ],
                          ),
                        ),
                )),
            Positioned(
                left: 0,
                bottom: 0,
                width: width,
                child: Container(
                  height: ScreenUtil.getInstance().setHeight(96),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/icon_pgall_menuebg.png'), fit: BoxFit.cover)),
                  child: Center(
                    child: Text(
                      '绑定你的英雄，立即查看的排名   去绑定>>',
                      style: TextStyle(
                          color: Color(0xffB5A88E), fontSize: ScreenUtil.getInstance().setSp(28)),
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                top: ScreenUtil.getInstance().setWidth(162 - 64.0),
                height: height -
                    ScreenUtil.getInstance().setHeight(162 - 64.0) -
                    MediaQuery.of(context).padding.top -
                    56,
                width: width,
                child: Offstage(
                  offstage: !showSelectBox,
                  child: Container(
                    color: Color(0xffD0C4AC),
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Positioned(
                            left: 0,
                            top: 0,
                            width: width,
                            height: (height -
                                ScreenUtil.getInstance().setHeight(162 - 64.0 + 84) -
                                MediaQuery.of(context).padding.top -
                                56),
                            child: Container(
                              child: selectInfo.isEmpty
                                  ? Container()
                                  : ListView(
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(24),
                                              bottom: ScreenUtil.getInstance().setHeight(24),
                                              top: ScreenUtil.getInstance().setHeight(24),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Expanded(
                                                      child: Text(
                                                    '地区',
                                                    style: TextStyle(
                                                        color: Color(0xff3D2F1B),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(30)),
                                                  )),
                                                  Container(
                                                    width: ScreenUtil.getInstance().setWidth(24),
                                                  ),
                                                ]),
                                                Wrap(
                                                  runSpacing: ScreenUtil.getInstance().setWidth(24),
                                                  children: selectInfo['serverTypeList']
                                                      .map<Widget>((list) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          serverType = list['code'].toString();
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: ScreenUtil.getInstance()
                                                                .setWidth(24)),
                                                        decoration: BoxDecoration(
//                                                          String serverType = '';
                                                            color: Color(list['code'].toString() ==
                                                                    serverType
                                                                ? 0xffB51610
                                                                : 0xffD0C4AC),
                                                            border: Border.all(
                                                                color: Color(0xff6A5C41),
                                                                width: ScreenUtil.getInstance()
                                                                    .setWidth(1)),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(6))),
                                                        width: (width -
                                                                ScreenUtil.getInstance()
                                                                    .setWidth(48 + 48.0)) /
                                                            3,
                                                        padding: EdgeInsets.only(
                                                            top: ScreenUtil.getInstance()
                                                                .setWidth(6),
                                                            bottom: ScreenUtil.getInstance()
                                                                .setWidth(10)),
                                                        child: Center(
                                                          child: Text(
                                                            '${list['type']}',
                                                            style: TextStyle(
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setWidth(26),
                                                                color: Color(
                                                                    list['code'].toString() ==
                                                                            serverType
                                                                        ? 0xffF4DA9C
                                                                        : 0xff6A5C41)),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            )),
                                        Container(
                                            padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(24),
                                              bottom: ScreenUtil.getInstance().setHeight(24),
                                              top: ScreenUtil.getInstance().setHeight(24),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '赛季',
                                                        style: TextStyle(
                                                            color: Color(0xff3D2F1B),
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(30)),
                                                      )),
                                                  GestureDetector(
                                                    onTap: () {
                                                      print(selectInfo['seasonList'].length);
                                                      setState(() {
                                                        skyLadderListLimit = skyLadderListLimit == 3
                                                            ? selectInfo['seasonList'].length
                                                            : 3;
                                                      });
                                                    },
                                                    child: Container(
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '历史赛季',
                                                            style: TextStyle(
                                                                color: Color(0xffB51610),
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setSp(24)),
                                                          ),
                                                          Image.asset(
                                                            'images/rank_filter_down.png',
                                                            width: ScreenUtil.getInstance()
                                                                .setWidth(24),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: ScreenUtil.getInstance().setWidth(24),
                                                  ),
                                                ]),
                                                Wrap(
                                                  runSpacing: ScreenUtil.getInstance().setWidth(24),
                                                  children:
                                                      selectInfo['seasonList'].map<Widget>((list) {
                                                    return selectInfo['seasonList'].indexOf(list) <
                                                            skyLadderListLimit
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                season = list['code'].toString();
                                                              });
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets.only(
                                                                  right: ScreenUtil.getInstance()
                                                                      .setWidth(24)),
                                                              decoration: BoxDecoration(
//                                                                String season = '';
                                                                  color: Color(
                                                                      list['code'].toString() ==
                                                                              season
                                                                          ? 0xffB51610
                                                                          : 0xffD0C4AC),
                                                                  border: Border.all(
                                                                      color: Color(0xff6A5C41),
                                                                      width:
                                                                          ScreenUtil.getInstance()
                                                                              .setWidth(1)),
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(6))),
                                                              width: (width -
                                                                      ScreenUtil.getInstance()
                                                                          .setWidth(48 + 48.0)) /
                                                                  3,
                                                              padding: EdgeInsets.only(
                                                                  top: ScreenUtil.getInstance()
                                                                      .setWidth(6),
                                                                  bottom: ScreenUtil.getInstance()
                                                                      .setWidth(10)),
                                                              child: Center(
                                                                child: Text(
                                                                  '${list['type']}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          ScreenUtil.getInstance()
                                                                              .setWidth(26),
                                                                      color: Color(
                                                                          list['code'].toString() ==
                                                                                  season
                                                                              ? 0xffF4DA9C
                                                                              : 0xff6A5C41)),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox();
                                                  }).toList(),
                                                )
                                              ],
                                            )),
                                        Container(
                                            padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(24),
                                              bottom: ScreenUtil.getInstance().setHeight(24),
                                              top: ScreenUtil.getInstance().setHeight(24),
                                            ),
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Expanded(
                                                      child: Text(
                                                    '职业',
                                                    style: TextStyle(
                                                        color: Color(0xff3D2F1B),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(30)),
                                                  )),
                                                  Container(
                                                    width: ScreenUtil.getInstance().setWidth(24),
                                                  ),
                                                ]),
                                                Wrap(
                                                  runSpacing: ScreenUtil.getInstance().setWidth(24),
                                                  children: selectInfo['mysticTypeList']
                                                      .map<Widget>((list) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          mysticType = list['code'].toString();
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: ScreenUtil.getInstance()
                                                                .setWidth(24)),
                                                        decoration: BoxDecoration(
//                                                          String mysticType = '0';
                                                            color: Color(list['code'].toString() ==
                                                                    mysticType
                                                                ? 0xffB51610
                                                                : 0xffD0C4AC),
                                                            border: Border.all(
                                                                color: Color(0xff6A5C41),
                                                                width: ScreenUtil.getInstance()
                                                                    .setWidth(1)),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(6))),
                                                        width: (width -
                                                                ScreenUtil.getInstance()
                                                                    .setWidth(48 + 48.0)) /
                                                            3,
                                                        padding: EdgeInsets.only(
                                                            top: ScreenUtil.getInstance()
                                                                .setWidth(6),
                                                            bottom: ScreenUtil.getInstance()
                                                                .setWidth(10)),
                                                        child: Center(
                                                          child: Text(
                                                            '${list['type']}',
                                                            style: TextStyle(
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setWidth(26),
                                                                color: Color(
                                                                    list['code'].toString() ==
                                                                            mysticType
                                                                        ? 0xffF4DA9C
                                                                        : 0xff6A5C41)),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            )),
                                        Container(
                                            padding: EdgeInsets.only(
                                              left: ScreenUtil.getInstance().setWidth(24),
                                              bottom: ScreenUtil.getInstance().setHeight(24),
                                              top: ScreenUtil.getInstance().setHeight(24),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Expanded(
                                                      child: Text(
                                                    '模式',
                                                    style: TextStyle(
                                                        color: Color(0xff3D2F1B),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(30)),
                                                  )),
                                                  Container(
                                                    width: ScreenUtil.getInstance().setWidth(24),
                                                  ),
                                                ]),
                                                Wrap(
                                                  runSpacing: ScreenUtil.getInstance().setWidth(24),
                                                  children:
                                                      selectInfo['modeList'].map<Widget>((list) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          modeType = list['code'].toString();
                                                        });
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: ScreenUtil.getInstance()
                                                                .setWidth(24)),
                                                        decoration: BoxDecoration(
                                                            //  String modeType = '0';
                                                            color: Color(
                                                                list['code'].toString() == modeType
                                                                    ? 0xffB51610
                                                                    : 0xffD0C4AC),
                                                            border: Border.all(
                                                                color: Color(0xff6A5C41),
                                                                width: ScreenUtil.getInstance()
                                                                    .setWidth(1)),
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(6))),
                                                        width: (width -
                                                                ScreenUtil.getInstance()
                                                                    .setWidth(48 + 48.0)) /
                                                            3,
                                                        padding: EdgeInsets.only(
                                                            top: ScreenUtil.getInstance()
                                                                .setWidth(6),
                                                            bottom: ScreenUtil.getInstance()
                                                                .setWidth(10)),
                                                        child: Center(
                                                          child: Text(
                                                            '${list['type']}',
                                                            style: TextStyle(
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setWidth(26),
                                                                color: Color(
                                                                    list['code'].toString() ==
                                                                            modeType
                                                                        ? 0xffF4DA9C
                                                                        : 0xff6A5C41)),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          height: ScreenUtil.getInstance().setHeight(84),
                          width: width,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showSelectBox = !showSelectBox;
                                  });
                                },
                                child: Container(
                                  width: width / 2,
                                  child: Center(
                                    child: Text(
                                      '取消',
                                      style: TextStyle(
                                          color: Color(0xff3D2F1B),
                                          fontSize: ScreenUtil.getInstance().setSp(30)),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showSelectBox = !showSelectBox;
                                      page = 20;
                                      _getListInfo();
                                    });
                                  },
                                  child: Container(
                                    width: width / 2,
                                    color: Color(0xffB51610),
                                    child: Center(
                                      child: Text(
                                        '确定',
                                        style: TextStyle(
                                            color: Color(0xffF5DA9C),
                                            fontSize: ScreenUtil.getInstance().setSp(30)),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
