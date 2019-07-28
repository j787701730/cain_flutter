import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BbsContent extends StatefulWidget {
  final props;

  BbsContent(this.props);

  @override
  _BbsContentState createState() => _BbsContentState();
}

class _BbsContentState extends State<BbsContent> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  ScrollController _listController = ScrollController();

  bool flag = true;
  Map content = {
    'title': 'App 1.6.2版本上线：模拟器迭代与太古装备展示',
    'author': '秋仲琉璃子不语',
    'create_date': '5个小时前',
    'avatar': 'default_avatar.png',
    'level': '',
    'visits': 9527,
    'imgs': [
      'new1_1',
      'new1_2',
      'new1_3',
      'new2',
      'new3_1',
      'new3_2',
      'new3_3',
      'new4',
      'new5',
    ],
  };

  List topList = [
    {
      'title': 'App 1.6.2版本上线：模拟器迭代与太古装备展示',
    },
    {
      'title': '开额之角对硬件宏的原则声明',
    },
    {
      'title': '新崔斯特姆版规 v2.05 发帖前必读',
    },
    {
      'title': '凯恩之角论坛新手导航 提升用户等级权限指南',
    },
  ];

  int topListLength = 3;

  bool show = false;
  double top;

  @override
  void initState() {
    super.initState();
    _ajax();
    _listController.addListener(() {
      setState(() {
        show = (top < _listController.offset) ? true : false;
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
    top = width / 912 * 480 - MediaQuery.of(context).padding.top - 56;
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff000000),
            ),
            child: flag
                ? Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffE8DAC5),
                      ),
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
                              fontSize: ScreenUtil.getInstance().setSp(23),
                            ),
                          )
                        ],
                      )),
                    ))
                : Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SmartRefresher(
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
                        print('onLoading');
                        await Future.delayed(Duration(milliseconds: 2000));
                        // if failed,use loadFailed(),if no data return,use LoadNodata()
                        if (mounted) setState(() {});
                        _refreshController.loadComplete();
                      },
                      child: ListView(
                        controller: _listController,
                        children: <Widget>[
                          Container(
                            height: width / 912 * 480,
                            decoration: BoxDecoration(
                                color: Color(0xffE8DAC5),
                                image: DecorationImage(
                                  //community_background  title_bar_bg
                                  alignment: Alignment.topCenter,
                                  image: AssetImage('images/community_background_2.jpg'),
                                )),
                            padding: EdgeInsets.only(top: 110),
                            child: Container(
                              padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(24)),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.props['title'],
                                        style: TextStyle(
                                            color: Color(0xffF5DA9C),
                                            fontSize: ScreenUtil.getInstance().setSp(50)),
                                      ),
                                      Container(
                                        height: ScreenUtil.getInstance().setHeight(24),
                                      ),
                                      Text(
                                        '版主：明月、禅仙',
                                        style: TextStyle(
                                            color: Color(0xff746B5B),
                                            fontSize: ScreenUtil.getInstance().setSp(22)),
                                      )
                                    ],
                                  )),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            '主题 397839',
                                            style: TextStyle(
                                                color: Color(0xffB5A88E),
                                                fontSize: ScreenUtil.getInstance().setSp(22)),
                                          ),
                                        ),
                                        Container(
                                          height: ScreenUtil.getInstance().setWidth(14),
                                        ),
                                        Container(
                                          child: Text(
                                            '今日 9527',
                                            style: TextStyle(
                                                color: Color(0xffB5A88E),
                                                fontSize: ScreenUtil.getInstance().setSp(22)),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Color(0xffE8DAC5),
                            padding: EdgeInsets.only(
                                left: ScreenUtil.getInstance().setWidth(24),
                                right: ScreenUtil.getInstance().setWidth(24)),
                            child: Column(
                              children: topList.map<Widget>((item) {
                                return topList.indexOf(item) < topListLength
                                    ? Container(
                                        height: ScreenUtil.getInstance().setHeight(60),
                                        decoration: BoxDecoration(
                                            border: Border(
                                          top: BorderSide(
                                              color: topList.indexOf(item) == 0
                                                  ? Colors.transparent
                                                  : Color(0xffC9BBA4),
                                              width: ScreenUtil.getInstance().setWidth(1)),
                                        )),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: ScreenUtil.getInstance().setWidth(6),
                                                  right: ScreenUtil.getInstance().setWidth(6)),
                                              margin: EdgeInsets.only(
                                                  right: ScreenUtil.getInstance().setWidth(16)),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xffB51610),
                                                      width: ScreenUtil.getInstance().setWidth(1)),
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(4))),
                                              child: Text(
                                                '置顶',
                                                style: TextStyle(
                                                    color: Color(0xffB51610),
                                                    fontSize: ScreenUtil.getInstance().setSp(18)),
                                              ),
                                            ),
                                            Expanded(
                                                child: Text(
                                              item['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Color(0xff4D4945),
                                                  fontSize: ScreenUtil.getInstance().setSp(26)),
                                            ))
                                          ],
                                        ),
                                      )
                                    : Container();
                              }).toList(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                topListLength = topListLength == 3 ? topList.length : 3;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil.getInstance().setHeight(24),
                                  bottom: ScreenUtil.getInstance().setHeight(24)),
                              decoration: BoxDecoration(
                                  color: Color(0xffE8DAC5),
                                  border: Border(
                                      top: BorderSide(
                                          color: Color(0xffC9BBA4),
                                          width: ScreenUtil.getInstance().setWidth(1)))),
                              child: Center(
                                child: Image.asset(
                                  topListLength == 3
                                      ? 'images/community_top_list_arr.png'
                                      : 'images/community_top_list_arr_up.png',
                                  width: ScreenUtil.getInstance().setWidth(36),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  color: Color(0xffA99B83),
                                  width: ScreenUtil.getInstance().setWidth(2)),
                              bottom: BorderSide(
                                  color: Color(0xffA99B83),
                                  width: ScreenUtil.getInstance().setWidth(2)),
                            )),
                            padding: EdgeInsets.only(
                                top: ScreenUtil.getInstance().setHeight(12),
                                bottom: ScreenUtil.getInstance().setHeight(12)),
                            margin: EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(12)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Image.asset(
                                    'images/${content['avatar']}',
                                    width: ScreenUtil.getInstance().setWidth(60),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  padding:
                                      EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(12)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        content['author'],
                                        style: TextStyle(
                                            color: Color(0xffE79425),
                                            fontSize: ScreenUtil.getInstance().setSp(26)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: ScreenUtil.getInstance().setHeight(6)),
                                        child: Text(content['create_date'],
                                            style: TextStyle(
                                                color: Color(0xffB5A88E),
                                                fontSize: ScreenUtil.getInstance().setSp(26))),
                                      ),
                                    ],
                                  ),
                                )),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.remove_red_eye,
                                        color: Color(0xffB5A88E),
                                      ),
                                      Text(
                                        '  ${content['visits']}',
                                        style: TextStyle(
                                          color: Color(0xffB5A88E),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: content['imgs'].map<Widget>((item) {
                              return Container(
                                margin:
                                    EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(24)),
                                width: width - ScreenUtil.getInstance().setWidth(48),
                                child: Image.asset(
                                  'images/$item.jpg',
                                  fit: BoxFit.cover,
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          flag
              ? Positioned(
                  child: SizedBox(),
                )
              : Positioned(
                  left: 0,
                  top: 0,
                  height: 56,
                  width: width,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(show ? 'images/community_background_title.jpg' : ''),
                            fit: BoxFit.fill)),
                    child: AppBar(
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
                      title: Container(
                        margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(40)),
                        height: 56,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('images/img_search.png'),
                          fit: BoxFit.fill,
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
                  ))
        ],
      ),
    );
  }
}
