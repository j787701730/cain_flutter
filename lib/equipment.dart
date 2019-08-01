import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  ScrollController _listController = ScrollController();

  bool flag = true;

  bool show = false;
  bool showEquip = true;

  Map equipMsg = {
    'name': '斧头',
    'image': 'diablo3db_49511_cn_items_axe_norm_base_01.png',
    'type': 1,
    'drop': 0,
    'level': 70,
    'equip_level': 70,
    'equip_type': '单手',
    'dps': '2345.0-2756.0', // 秒伤
    'dph': '(2345.0-2445.0)-(2756.0-2879.0)', // 伤害
    'attack_speed': '1.1',
    'dph2': '(2345.0-2445.0)-(2756.0-2879.0)',
    'magic': '4',
    'durable': '25-45',
    'legeffects': '攻击时有一定几率召唤出一名堕落者勇士的鬼魂。',
    'legeffects_value': 30,
    'story': '“在堕落一族的语言中，‘根扎尼库’意为人类屠杀者。”—迪卡德·凯恩'
  };

  // type 0=>普通 equipment_normal , 1=>魔法 equipment_magic,
  // 2=>稀有 equipment_rare, 3=>传奇 equipment_legendary , 4=>套装 equipment_set
  Map dropType = {0: '世界掉落', 1: '铁匠'};
  List colors = [0xffffffff, 0xff6969ff, 0xffffff00, 0xffff8000, 0xff00ff00];

  // type 0=>普通 equipment_normal , 1=>魔法 equipment_magic,
  // 2=>稀有 equipment_rare, 3=>传奇 equipment_legendary , 4=>套装 equipment_set
  List equipType = ['普通', '魔法', '稀有', '传奇', '套装'];
  Map data = {
    'one-handed': [
      {
        'name': '斧头',
        'image': 'diablo3db_49511_cn_items_axe_norm_base_01.png',
        'type': 0,
        'drop': 0,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '匕首',
        'image': 'diablo3db_49511_cn_items_dagger_norm_base_04_icon.png',
        'type': 1,
        'drop': 1,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '钉锤',
        'image': 'diablo3db_49511_cn_items_mace_normal_base_06.png',
        'type': 2,
        'drop': 0,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '长矛',
        'image': 'diablo3db_49511_cn_items_spear_norm_base_04_icon.png',
        'type': 3,
        'drop': 1,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '剑',
        'image': 'diablo3db_49511_cn_items_sword_norm_base_07.png',
        'type': 4,
        'drop': 1,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '祭祀刀',
        'image': 'diablo3db_49511_cn_items_ceremonialdagger_norm_base_01_icon.png',
        'type': 0,
        'drop': 1,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '拳套武器',
        'image': 'diablo3db_49511_cn_items_fistweapons_norm_base_04_icon.png',
        'type': 0,
        'drop': 0,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '重武器',
        'image': 'diablo3db_49511_cn_items_mightyweapon_1h_normal_unique_06.png',
        'type': 0,
        'drop': 0,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '连枷',
        'image': 'diablo3db_49511_cn_items_x1_flail_1h_norm_base_01.png',
        'type': 0,
        'drop': 0,
        'level': 70,
        'equip_level': 70
      },
      {
        'name': '镰刀',
        'image': 'diablo3db_49511_cn_items_p6_scythe_norm_base_01_icon.png',
        'type': 0,
        'drop': 0,
        'level': 70,
        'equip_level': 70
      },
    ]
  };

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

  seeEquipMsg(item) {
    setState(() {
      showEquip = false;
      equipMsg.addAll(item);
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
          title: Text('${widget.props['title']}',
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
                              controller: _listController,
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(24),
                                  right: ScreenUtil.getInstance().setWidth(24)),
                              children: data['one-handed'].map<Widget>((item) {
                                String bg = '';
                                // type 0=>普通 equipment_normal , 1=>魔法 equipment_magic,
                                // 2=>稀有 equipment_rare, 3=>传奇 equipment_legendary , 4=>套装 equipment_set
                                switch (item['type']) {
                                  case 0:
                                    bg = 'equipment_normal';
                                    break;
                                  case 1:
                                    bg = 'equipment_magic';
                                    break;
                                  case 2:
                                    bg = 'equipment_rare';
                                    break;
                                  case 3:
                                    bg = 'equipment_legendary';
                                    break;
                                  case 4:
                                    bg = 'equipment_set';
                                    break;
                                }
                                return GestureDetector(
                                  onTap: () {
                                    seeEquipMsg(item);
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
                                                  image: AssetImage('images/$bg.png'))),
                                          padding: EdgeInsets.all(4),
                                          child: Image.asset('equipment/${item['image']}'),
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
                                                  '${dropType[item['drop']]}',
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
                                                Text('物品等级·${item['level']}',
                                                    style: TextStyle(
                                                        color: Color(0xff9B8C73),
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(26))),
                                                Container(
                                                  width: ScreenUtil.getInstance().setWidth(20),
                                                ),
                                                Text('装备等级·${item['equip_level']}',
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
                                        image: AssetImage(
                                            'images/tooltip-title${equipMsg['type']}.png'))),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: Center(
                                        child: Text(
                                          equipMsg['name'],
                                          style: TextStyle(
                                              color: Color(colors[equipMsg['type']]),
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
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil.getInstance().setWidth(87),
                                          height: ScreenUtil.getInstance().setWidth(166),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil.getInstance().setWidth(12)),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(colors[equipMsg['type']])),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'images/bg${equipMsg['type']}.png'))),
                                          child: Image.asset('equipment/${equipMsg['image']}'),
                                        ),
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '${equipType[equipMsg['type']]}  ${widget.props['title']}',
                                                style: TextStyle(
                                                    color: Color(colors[equipMsg['type']]),
                                                    fontSize: ScreenUtil.getInstance().setSp(16)),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(24),
                                              ),
                                              RichText(
                                                  text: TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                  text: '${equipMsg['dps']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                                TextSpan(
                                                  text: '伤害/秒',
                                                  style: TextStyle(
                                                      color: Color(0xff8A8A8A),
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                              ])),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(20),
                                              ),
                                              RichText(
                                                  text: TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                  text: '${equipMsg['dph']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                                TextSpan(
                                                  text: '伤害',
                                                  style: TextStyle(
                                                      color: Color(0xff8A8A8A),
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                              ])),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(20),
                                              ),
                                              RichText(
                                                  text: TextSpan(children: <TextSpan>[
                                                TextSpan(
                                                  text: '${equipMsg['attack_speed']}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                                TextSpan(
                                                  text: '攻击速度',
                                                  style: TextStyle(
                                                      color: Color(0xff8A8A8A),
                                                      fontSize: ScreenUtil.getInstance().setSp(16)),
                                                ),
                                              ])),
                                            ],
                                          ),
                                        )),
                                        Container(
                                          child: Text(
                                            equipMsg['equip_type'],
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
                                          '${equipMsg['legeffects']}',
                                          style: TextStyle(
                                              color: Color(colors[equipMsg['type']]),
                                              fontSize: ScreenUtil.getInstance().setSp(16)),
                                        ),
                                        Text(
                                          '(${equipMsg['legeffects_value']}%)',
                                          style: TextStyle(
                                              color: Color(colors[equipMsg['type']]),
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
                                              color: Color(colors[equipMsg['type']]),
                                              fontSize: ScreenUtil.getInstance().setSp(16)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: ['伤害', '奥术伤害', '毒性伤害', '圣神伤害', '闪电伤害', '火焰伤害', '冰霜伤害']
                                        .map<Widget>((item) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil.getInstance().setWidth(22)),
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
                                              '${equipMsg['dph2']}点$item',
                                              style: TextStyle(
                                                  color: Color(colors[equipMsg['type']]),
                                                  fontSize: ScreenUtil.getInstance().setSp(16)),
                                            )
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
                                          '+${equipMsg['magic']}随机魔法属性',
                                          style: TextStyle(
                                              color: Color(colors[equipMsg['type']]),
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
                                      '需要等级 ${equipMsg['level']}',
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
                                      'ilvl ${equipMsg['level']}',
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
                                      '耐久：${equipMsg['durable']}',
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
                                      '${equipMsg['story']}',
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
