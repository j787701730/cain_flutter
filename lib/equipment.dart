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

  // type 0=>普通 equipment_normal , 1=>魔法 equipment_magic,
  // 2=>稀有 equipment_rare, 3=>传奇 equipment_legendary , 4=>套装 equipment_set
  Map dropType = {'0': '世界掉落', '1': '铁匠'};

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
        'type': 0
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
                                return Container(
                                  padding: EdgeInsets.only(
                                    left: ScreenUtil.getInstance().setWidth(18),
                                    right: ScreenUtil.getInstance().setWidth(18),
                                    top: ScreenUtil.getInstance().setHeight(24),
                                    bottom: ScreenUtil.getInstance().setHeight(24)
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(6)),
                                    border: Border.all(
                                      color: Color(0xffB5A88E),
                                      width: ScreenUtil.getInstance().setWidth(1)
                                    ),
                                    color: Color(0xffE3D4BF)
                                  ),
                                  margin: EdgeInsets.only(
                                    bottom: ScreenUtil.getInstance().setHeight(24)
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: ScreenUtil.getInstance().setWidth(84),
                                        height: ScreenUtil.getInstance().setWidth(84),
                                        decoration: BoxDecoration(
                                            image:
                                                DecorationImage(image: AssetImage('images/$bg.png'))),
                                        padding: EdgeInsets.all(4),
                                        child: Image.asset('equipment/${item['image']}'),
                                      ),
                                      Expanded(
                                          child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text(item['name']),
                                              Container(width: ScreenUtil.getInstance().setWidth(20),),
                                              Text('${dropType[item['drop']]}')
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[],
                                          )
                                        ],
                                      ))
                                    ],
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
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
