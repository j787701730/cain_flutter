import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  ScrollController _listController = ScrollController();

  bool flag = true;

  bool show = false;
  bool showEquip = true;

  List drop = ['世界掉落'];

  Map selectLegendaryGem = {};

  List legendaryGem = [
    {'image': 'ia_100002462.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100002633.png', 'name': '侍从宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100002769.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100002802.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100002870.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100002938.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100002972.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100003560.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100003595.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100003697.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100003823.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100003895.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004326.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004395.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004463.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004497.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004565.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004599.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004669.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_100004740.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_300002064.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
    {'image': 'ia_300002099.png', 'name': '免死宝石', 'drop': 0, 'level': 1, 'equip_level': 1},
  ];

  @override
  void initState() {
    super.initState();
    _ajax();
    _listController.addListener(() {
      setState(() {
        show = (200 < _listController.offset) ? true : false;
      });
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
    _listController.dispose();
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
                  width: ScreenUtil.getInstance().setWidth(30),
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
                            child: ListView(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(24),
                                  right: ScreenUtil.getInstance().setWidth(24)),
                              children: legendaryGem.map<Widget>((item) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showEquip = false;
                                      selectLegendaryGem = item;
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
                                                  image: AssetImage('images/gem_icon_bg.png'))),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil.getInstance().setWidth(12)),
                                          width: ScreenUtil.getInstance().setWidth(84),
                                          height: ScreenUtil.getInstance().setHeight(84),
                                          child: Image.asset(
                                            'legendarygem/${item['image']}',
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
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${item['name']}',
                                                      style: TextStyle(
                                                          color: Color(0xff3D2F1B),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(30)),
                                                    ),
                                                    Container(
                                                      width: ScreenUtil.getInstance().setWidth(10),
                                                    ),
                                                    Text('${drop[item['drop']]}',
                                                        style: TextStyle(
                                                            color: Color(0xff9B8C73),
                                                            fontSize: ScreenUtil.getInstance()
                                                                .setSp(26))),
                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '物品等级·${item['level']}',
                                                      style: TextStyle(
                                                          color: Color(0xff9B8C73),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(26)),
                                                    ),
                                                    Container(
                                                      width: ScreenUtil.getInstance().setWidth(10),
                                                    ),
                                                    Text('装备等级·${item['equip_level']}',
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
                                          '${selectLegendaryGem['name']}',
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
                                    padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
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
                                                  width: ScreenUtil.getInstance().setWidth(2)),
                                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                              image: DecorationImage(
                                                  image: AssetImage('images/bg3.png'))),
                                          child: Image.asset(
                                              'legendarygem/${selectLegendaryGem['image']}'),
                                        ),
                                        Expanded(
                                            child: Container(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setHeight(14)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '传奇 宝石',
                                                style: TextStyle(
                                                    color: Color(0xff874621),
                                                    fontSize: ScreenUtil.getInstance().setSp(16)),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(24),
                                              ),
//                                                  RichText(
//                                                      text: TextSpan(children: <TextSpan>[
//                                                        TextSpan(
//                                                          text: '${equipMsg['dps']}',
//                                                          style: TextStyle(
//                                                              color: Colors.white,
//                                                              fontSize: ScreenUtil.getInstance().setSp(16)),
//                                                        ),
//                                                        TextSpan(
//                                                          text: '伤害/秒',
//                                                          style: TextStyle(
//                                                              color: Color(0xff8A8A8A),
//                                                              fontSize: ScreenUtil.getInstance().setSp(16)),
//                                                        ),
//                                                      ])),
                                            ],
                                          ),
                                        )),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setHeight(24)),
                                          child: Text(
                                            '宝石',
                                            style: TextStyle(
                                                color: Color(0xff8A8A8A),
                                                fontSize: ScreenUtil.getInstance().setSp(16)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
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
                                          '传奇宝石',
                                          style: TextStyle(
                                              color: Color(0xff874621),
                                              fontSize: ScreenUtil.getInstance().setSp(16)),
                                        ),
//                                        Text(
//                                          '(${equipMsg['legeffects_value']}%)',
//                                          style: TextStyle(
//                                              color: Color(0xff874621),
//                                              fontSize: ScreenUtil.getInstance().setSp(16)),
//                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(20),
                                        right: ScreenUtil.getInstance().setWidth(20),
                                        bottom: ScreenUtil.getInstance().setHeight(12)),
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
                                          '可能有以下7个魔法属性中的一个',
                                          style: TextStyle(
                                              color: Color(0xff874621),
                                              fontSize: ScreenUtil.getInstance().setSp(16)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(20),
                                        right: ScreenUtil.getInstance().setWidth(20),
                                        bottom: ScreenUtil.getInstance().setHeight(12)),
                                    child: Text(
                                      '需要等级 ${selectLegendaryGem['level']}',
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
                                      'ilvl ${selectLegendaryGem['level']}',
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
                                      '涂德琴女士向仙塞島的工坊訂做了這顆寶石，她說：「我希望我的目標昏睡或醉倒。如果辦不到，動作遲緩也可以。」',
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
