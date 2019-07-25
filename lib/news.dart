import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'news_list.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  List banner = [
    {'img': 'banner1', 'title': 'App 1.6.2版本上线：模拟器迭代与太古装备展示'},
    {'img': 'banner2', 'title': '晒成绩，夺头衔！十七赛季全民大秘境挑战赛启动'},
    {'img': 'banner3', 'title': '暗黑“3”分钟第二十六期：赛季专属巫医散件吹箭'},
    {'img': 'banner4', 'title': '多玛之书：老圣教军的怀念'},
    {'img': 'banner5', 'title': '曾经的暗黑破坏神之父，现在怎么样了？'},
  ];
  int page = 0;
  bool flag = true;

  List temp = [
    {
      'imgs': [
        'new1_1',
        'new1_2',
        'new1_3',
      ],
      'title': 'App 1.6.2版本上线：模拟器迭代与太古装备展示',
      'type': '1', // 1 帖子, 0 无
      'show': '3', // 3 三列, 2 右图, 1 全图
      'author': '秋仲琉璃子不语',
      'source': '新崔斯特姆',
      'num': 119
    },
    {
      'imgs': [
        'new2',
      ],
      'title': '卡达拉的传奇装备回收计划第十六期',
      'type': '1', // 1 帖子, 0 无
      'show': '2', // 3 三列, 2 右图, 1 全图
      'author': '卡达拉',
      'source': '',
      'num': 22
    },
    {
      'imgs': [
        'new3_1',
        'new3_2',
        'new3_3',
      ],
      'title': '十七赛季国服天梯观察：一骑绝尘棒棒糖，5分通关双黑奥',
      'type': '1', // 1 帖子, 0 无
      'show': '3', // 3 三列, 2 右图, 1 全图
      'author': 'mediumdog',
      'source': '新崔斯特姆',
      'num': 119
    },
    {
      'imgs': [
        'new4',
      ],
      'title': '暗黑讲堂vol.3录像回顾：挑战失败的原因就是漏球！',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '卡达拉',
      'source': '',
      'num': 221
    },
    {
      'imgs': [
        'new5',
      ],
      'title': '暴雪联合创始人Frank Pearce离职，挥别28年暴雪生涯',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '卡达拉',
      'source': '不朽之地',
      'num': 221
    },
    {
      'imgs': [
        'new6',
      ],
      'title': '天下第一又来了：猎魔人火多重120层实战视频分享',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '卡光贼溜的萌新',
      'source': '探险者工会',
      'num': 221
    },
    {
      'imgs': [
        'new7',
      ],
      'title': 'Diablo传说·诅咒宝石：崔斯特姆旧事提（上）',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '克里斯勇度',
      'source': '',
      'num': 21
    },
    {
      'imgs': [
        'new8',
      ],
      'title': '84秒116层！死灵法师魂法队极限速刷展示',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '千年小啊黎',
      'source': '',
      'num': 221
    },
  ];
  List news = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    news = jsonDecode(jsonEncode(temp));
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
    // TODO: implement dispose
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
    precacheImage(AssetImage("images/head_loading1.png"), context);
    precacheImage(AssetImage("images/head_loading2.png"), context);
    precacheImage(AssetImage("images/head_loading3.png"), context);
    precacheImage(AssetImage("images/head_loading4.png"), context);
    precacheImage(AssetImage("images/head_loading5.png"), context);
    precacheImage(AssetImage("images/head_loading6.png"), context);
    precacheImage(AssetImage("images/head_loading7.png"), context);
    precacheImage(AssetImage("images/head_loading8.png"), context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Container(
          height: 56,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/img_search.png'),
            fit: BoxFit.contain,
          )),
          child: Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Image.asset(
                    'images/icon_search.png',
                    width: 16,
                  )),
              Container(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  '搜索关键词',
                  style: TextStyle(color: Color(0xffB5A88E), fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xffE8DAC5),
        child: flag
            ? Center(
                child: Image.asset('images/head_loading1.png'),
              )
            : SmartRefresher(
                controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
                onRefresh: () async {
                  _loading();
                  await Future.delayed(Duration(milliseconds: 2000));
                  if (mounted)
                    setState(() {
                      news = jsonDecode(jsonEncode(temp));
                    });
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
                  if (mounted)
                    setState(() {
                      news.addAll(temp);
                    });
                  _refreshController.loadComplete();
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: width / 640 * 260,
                      child: Swiper(
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              new Image.asset(
                                "images/${banner[index]['img']}.jpg",
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                  bottom: 24,
                                  left: 10,
                                  width: width - 20,
                                  child: Text(
                                    banner[index]['title'],
                                    style: TextStyle(
                                        color: Color(0xffF5DA9C),
                                        fontSize: ScreenUtil.getInstance().setSp(30),
                                        fontFamily: 'SourceHanSansCN'),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                            ],
                          );
                        },
                        itemCount: banner.length,
                        pagination: new SwiperPagination(
                            builder: RectSwiperPaginationBuilder(
                                size: const Size(22.0, 10.0),
                                activeSize: const Size(22.0, 10.0),
                                activeColor: Color(0xffF5DA9C),
                                color: Color(0x91908C87))),
//                  control: new SwiperControl(),
                      ),
                    ),
                    NewsList(news)
                  ],
                ),
              ),
      ),
    );
  }
}
