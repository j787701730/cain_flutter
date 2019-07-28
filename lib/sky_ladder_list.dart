import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 天梯榜
class SkyLadderList extends StatefulWidget {
  final props;

  SkyLadderList(this.props);

  @override
  _SkyLadderListState createState() => _SkyLadderListState();
}

class _SkyLadderListState extends State<SkyLadderList> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  bool flag = true;
  DateTime now = DateTime.now();

  bool showSelectBox = false;
  int skyLadderListLimit = 3;

  List skyLadderList = [
    {'ranking': 1, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 2, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 3, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 4, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 5, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 6, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 7, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 8, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 9, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 10, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 11, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 12, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 13, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 14, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 15, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 16, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 17, 'name': '馆长', 'floor': '128', 'time': '14:43'},
    {'ranking': 18, 'name': '馆长', 'floor': '128', 'time': '14:43'},
  ];

  List selectList = [
    {
      'type': '地区',
      'id': 1,
      'list': [
        {'id': 1, 'name': '全服'},
        {'id': 2, 'name': '国服'},
        {'id': 3, 'name': '亚服'},
        {'id': 4, 'name': '美服'},
        {'id': 5, 'name': '欧服'},
      ]
    },
    {
      'type': '赛季',
      'id': 2,
      'list': [
        {'id': 1, 'name': '全部'},
        {'id': 2, 'name': '现赛季'},
        {'id': 3, 'name': '现非赛季'},
        {'id': 4, 'name': '第1赛季'},
        {'id': 5, 'name': '第2赛季'},
        {'id': 6, 'name': '第3赛季'},
        {'id': 7, 'name': '第4赛季'},
        {'id': 8, 'name': '第5赛季'},
        {'id': 9, 'name': '第6赛季'},
        {'id': 10, 'name': '第7赛季'},
        {'id': 11, 'name': '第8赛季'},
        {'id': 12, 'name': '第9赛季'},
        {'id': 13, 'name': '第10赛季'},
        {'id': 14, 'name': '第11赛季'},
        {'id': 15, 'name': '第12赛季'},
        {'id': 16, 'name': '第13赛季'},
        {'id': 17, 'name': '第14赛季'},
        {'id': 18, 'name': '第15赛季'},
        {'id': 19, 'name': '第16赛季'},
        {'id': 20, 'name': '第17赛季'},
        {'id': 21, 'name': '非赛季14-1'},
        {'id': 22, 'name': '非赛季15-1'},
        {'id': 23, 'name': '非赛季15-2'},
        {'id': 24, 'name': '非赛季15-3'},
        {'id': 25, 'name': '非赛季15-4'},
        {'id': 26, 'name': '非赛季16-1'},
        {'id': 27, 'name': '非赛季16-2'},
        {'id': 28, 'name': '非赛季17-1'},
        {'id': 29, 'name': '非赛季17-2'},
        {'id': 30, 'name': '非赛季18-1'},
        {'id': 31, 'name': '非赛季19-1'},
      ]
    },
    {
      'type': '职业',
      'id': 3,
      'list': [
        {'id': 1, 'name': '单人'},
        {'id': 2, 'name': '野蛮人'},
        {'id': 3, 'name': '巫医'},
        {'id': 4, 'name': '武僧'},
        {'id': 5, 'name': '魔法师'},
        {'id': 6, 'name': '猎魔人'},
        {'id': 7, 'name': '圣教军'},
        {'id': 8, 'name': '死灵法师'},
        {'id': 9, 'name': '二人组队'},
        {'id': 10, 'name': '三人组队'},
        {'id': 11, 'name': '四人组队'},
      ]
    },
    {
      'type': '模式',
      'id': 4,
      'list': [
        {'id': 1, 'name': '普通'},
        {'id': 2, 'name': '专家'},
      ]
    },
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
                  width: ScreenUtil.getInstance().setWidth(30),
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
                                  '  更新时间:  ${now.year}/${now.month}/${now.day} ${now.hour}:${now.minute}',
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
                  child: flag
                      ? Center(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('images/head_loading1.png',width: ScreenUtil.getInstance().setWidth(78),),
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
                            await Future.delayed(Duration(milliseconds: 2000));
                            // if failed,use loadFailed(),if no data return,use LoadNodata()
                            if (mounted) setState(() {});
                            _refreshController.loadComplete();
                          },
                          child: ListView(
                            children: <Widget>[
                              Table(
                                  columnWidths: {
                                    0: FixedColumnWidth(width / 5),
                                    1: FixedColumnWidth(width / 5 * 2),
                                    2: FixedColumnWidth(width / 5),
                                    3: FixedColumnWidth(width / 5),
                                  },
                                  children: skyLadderList.map((item) {
                                    return TableRow(
                                        //第1行样式 添加背景色
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Color(0xffC5B7A1),
                                                    width: ScreenUtil.getInstance().setWidth(1)))),
                                        children: [
                                          //增加行高
//                                          {'ranking': 18, 'name': '馆长', 'floor': '128', 'time': '14:43'},
                                          Container(
                                            height: ScreenUtil.getInstance().setHeight(64),
                                            child: Center(
                                              child: Text(
                                                '${item['ranking']}',
                                                style: TextStyle(
                                                    color: Color(item['ranking'] < 4
                                                        ? 0xff3D2F1B
                                                        : 0xff9C8D75),
                                                    fontSize: ScreenUtil.getInstance().setSp(26)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: ScreenUtil.getInstance().setHeight(64),
                                            child: Center(
                                              child: Text(
                                                item['name'],
                                                style: TextStyle(
                                                    color: Color(item['ranking'] < 4
                                                        ? 0xffB51610
                                                        : 0xff6A5C41),
                                                    fontSize: ScreenUtil.getInstance().setSp(26)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: ScreenUtil.getInstance().setHeight(64),
                                            child: Center(
                                              child: Text(
                                                '${item['floor']}',
                                                style: TextStyle(
                                                    color: Color(item['ranking'] < 4
                                                        ? 0xff3D2F1B
                                                        : 0xff9C8D75),
                                                    fontSize: ScreenUtil.getInstance().setSp(26)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: ScreenUtil.getInstance().setHeight(64),
                                            child: Center(
                                              child: Text(
                                                '${item['time']}',
                                                style: TextStyle(
                                                    color: Color(item['ranking'] < 4
                                                        ? 0xff3D2F1B
                                                        : 0xff9C8D75),
                                                    fontSize: ScreenUtil.getInstance().setSp(26)),
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
                              child: ListView(
                                children: selectList.map<Widget>((item) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                      left: ScreenUtil.getInstance().setWidth(24),
                                      bottom: ScreenUtil.getInstance().setHeight(24),
//                                        right: ScreenUtil.getInstance().setWidth(24)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: selectList.indexOf(item) == 0
                                                  ? ScreenUtil.getInstance().setWidth(24)
                                                  : 0,
                                              bottom: ScreenUtil.getInstance().setHeight(24)),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: Text(
                                                item['type'],
                                                style: TextStyle(
                                                    color: Color(0xff3D2F1B),
                                                    fontSize: ScreenUtil.getInstance().setSp(30)),
                                              )),
                                              item['id'] == 2
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          skyLadderListLimit =
                                                              skyLadderListLimit == 3
                                                                  ? item['list'].length
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
                                                    )
                                                  : SizedBox(
                                                      width: 0,
                                                      height: 0,
                                                    ),
                                              Container(
                                                width: ScreenUtil.getInstance().setWidth(24),
                                              )
                                            ],
                                          ),
                                        ),
                                        Wrap(
                                          runSpacing: ScreenUtil.getInstance().setWidth(24),
                                          children: item['list'].map<Widget>((list) {
                                            return item['id'] == 2
                                                ? item['list'].indexOf(list) < skyLadderListLimit
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: ScreenUtil.getInstance()
                                                                .setWidth(24)),
                                                        decoration: BoxDecoration(
                                                            color: Color(list['id'] == 1
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
                                                            '${list['name']}',
                                                            style: TextStyle(
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setWidth(26),
                                                                color: Color(list['id'] == 1
                                                                    ? 0xffF4DA9C
                                                                    : 0xff6A5C41)),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            ScreenUtil.getInstance().setWidth(24)),
                                                    decoration: BoxDecoration(
                                                        color: Color(list['id'] == 1
                                                            ? 0xffB51610
                                                            : 0xffD0C4AC),
                                                        border: Border.all(
                                                            color: Color(0xff6A5C41),
                                                            width: ScreenUtil.getInstance()
                                                                .setWidth(1)),
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(6))),
                                                    width: (width -
                                                            ScreenUtil.getInstance()
                                                                .setWidth(48 + 48.0)) /
                                                        3,
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil.getInstance().setWidth(6),
                                                        bottom:
                                                            ScreenUtil.getInstance().setWidth(10)),
                                                    child: Center(
                                                      child: Text(
                                                        '${list['name']}',
                                                        style: TextStyle(
                                                            fontSize: ScreenUtil.getInstance()
                                                                .setWidth(26),
                                                            color: Color(list['id'] == 1
                                                                ? 0xffF4DA9C
                                                                : 0xff6A5C41)),
                                                      ),
                                                    ),
                                                  );
                                          }).toList(),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          height: ScreenUtil.getInstance().setHeight(84),
                          width: width,
                          child: Row(
                            children: <Widget>[
                              Container(
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
                              Container(
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
                              )
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
