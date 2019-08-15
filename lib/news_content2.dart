import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsContent2 extends StatefulWidget {
  final props;

  NewsContent2(this.props);

  @override
  _NewsContent2State createState() => _NewsContent2State();
}

class _NewsContent2State extends State<NewsContent2> with TickerProviderStateMixin {
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

  List comments = [
    {
      'comment': 'App 1.6.2版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'level': '',
      'num': 9527,
      'address': '四川省成都市'
    },
    {
      'comment': 'App 1.6.2版本上线：模拟器迭代与太古装备展示',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'level': '',
      'num': 9527,
      'address': '四川省成都市'
    }
  ];

  Map msg = {};

  Map ursInfo = {};

  bool show = false;

  @override
  void initState() {
    super.initState();
    _ajax();
    _getContent();
    _listController.addListener(() {
      setState(() {
        show = (200 < _listController.offset) ? true : false;
      });
    });
  }

  _getContent() async {
    FormData formData = new FormData.from({'tid': widget.props['tid'], 'page': 1});
    try {
      Response response;
      response = await Dio().post(
        "https://bbs.d.163.com/api/mobile/index.php?module=viewthread&version=163&ppp=15&charset=utf-8&ts=1565771447&uf=8404d63c-7427-4b0c-8cc3-5b41b939d365&ab=dc2530864dc3281b1ab405dd4295f47c1e&ef=64c290e0d028c31a98fb08da7e27b800af",
        data: formData,
        options: Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded"),
        ),
      );
      if (mounted) {
        setState(() {
          msg = response.data;
        });
        List users = [];
        for (int i = 0; i < response.data['Variables']['postlist'].length; i++) {
          users.add(response.data['Variables']['postlist'][i]['authorid']);
        }

        FormData formData2 = new FormData.from({'discuzUids': users.join(',')});
        Response response2;
        response2 = await Dio().post(
          "https://cain-api.gameyw.netease.com/cain/userCenter/ursInfo?ts=1565849472&uf=ea04cc80-6d79-4479-83e0-c6bcf12b8c9d&ab=b954a22f9d0e6171bacc98f26330679d92&ef=f907482886b9272ebada43e1750812f892",
          data: formData2,
          options: Options(
            contentType: ContentType.parse("application/x-www-form-urlencoded"),
          ),
        );
        if (mounted) {
          setState(() {
            ursInfo = response2.data['data'];
          });
        }
      }
    } catch (e) {
      return print(e);
    }
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

  // todo: 只实现了一种评论
  commentsLayout() {
    return Column(
      children: comments.map<Widget>((item) {
        return Container(
          padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(24),
            right: ScreenUtil.getInstance().setWidth(24),
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().setHeight(36),
                bottom: ScreenUtil.getInstance().setHeight(36)),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color(0xffCABCA5), width: ScreenUtil.getInstance().setWidth(1)))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'images/${item['avatar']}',
                    width: ScreenUtil.getInstance().setWidth(70),
                  ),
                  margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(12)),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item['author'],
                                      style: TextStyle(
                                          color: Color(0xffE79425),
                                          fontSize: ScreenUtil.getInstance().setSp(26)),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          color: Color(0xffABA191),
                                          size: ScreenUtil.getInstance().setSp(30),
                                        ),
                                        Text(
                                          item['address'],
                                          style: TextStyle(
                                              color: Color(0xffABA191),
                                              fontSize: ScreenUtil.getInstance().setSp(24)),
                                        ),
                                        Container(
                                          width: ScreenUtil.getInstance().setWidth(24),
                                        ),
                                        Text(
                                          item['create_date'],
                                          style: TextStyle(
                                              color: Color(0xffABA191),
                                              fontSize: ScreenUtil.getInstance().setSp(24)),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '${item['num']} ',
                                    style: TextStyle(
                                        color: Color(0xffABA191),
                                        fontSize: ScreenUtil.getInstance().setSp(24)),
                                  ),
                                  Image.asset(
                                    'images/icon_comment_zan.png',
                                    width: ScreenUtil.getInstance().setWidth(36),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Text(
                            item['comment'],
                            style: TextStyle(
                                color: Color(0xff6A5C41),
                                fontSize: ScreenUtil.getInstance().setSp(30)),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        );
      }).toList(),
    );
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
          title: Container(
            child: show
                ? Row(
                    children: <Widget>[
                      Image.asset(
                        'images/${content['avatar']}',
                        width: ScreenUtil.getInstance().setWidth(40),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(12),
                      ),
                      Text(
                        content['author'],
                        style: TextStyle(
                            color: Color(0xffF5DA9C), fontSize: ScreenUtil.getInstance().setSp(28)),
                      )
                    ],
                  )
                : Text(''),
          ),
          // type: 1=> 帖子 0 => 其他
          actions: <Widget>[
            widget.props['type'] == '1'
                ? Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(8),
                            right: ScreenUtil.getInstance().setWidth(8),
                            top: ScreenUtil.getInstance().setHeight(0),
                            bottom: ScreenUtil.getInstance().setHeight(2)),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xffF4DA9C),
                                width: ScreenUtil.getInstance().setWidth(1)),
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          '只看楼主',
                          style: TextStyle(
                            color: Color(0xffF4DA9C),
                            fontSize: ScreenUtil.getInstance().setSp(22),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                              left: ScreenUtil.getInstance().setWidth(20),
                              right: ScreenUtil.getInstance().setWidth(20)),
                          child: Image.asset(
                            'images/icon_title_more.png',
                            width: ScreenUtil.getInstance().setWidth(56),
                          ))
                    ],
                  )
                : SizedBox()
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
                left: 0,
                top: 0,
                height: height -
                    ScreenUtil.getInstance().setHeight(96) -
                    MediaQuery.of(context).padding.top -
                    56,
                width: width,
                child: Container(
                  color: Color(0xffE8DAC5),
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
                            _getContent();
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
                            height: 60,
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
                            children: <Widget>[
                              ursInfo.isNotEmpty
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil.getInstance().setWidth(24),
                                          right: ScreenUtil.getInstance().setWidth(24)),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil.getInstance().setWidth(30),
                                                bottom: ScreenUtil.getInstance().setHeight(30)),
                                            child: Text(
                                              '${msg['Variables']['thread']['subject']}',
                                              style: TextStyle(
                                                  fontSize: ScreenUtil.getInstance().setSp(30),
                                                  color: Color(0xff000000)),
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
                                            margin: EdgeInsets.only(
                                                bottom: ScreenUtil.getInstance().setWidth(12)),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Image.network(
                                                    '${ursInfo[msg['Variables']['postlist'][0]['authorid']]['avatar']}',
                                                    width: ScreenUtil.getInstance().setWidth(60),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: ScreenUtil.getInstance().setWidth(12)),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '${msg['Variables']['postlist'][0]['author']}',
                                                            style: TextStyle(
                                                                color: Color(0xffE79425),
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setSp(26)),
                                                          ),
                                                          Wrap(
//                                                        http://bbs.d.163.com/static/image/common/appmedal/d3char.gif.png
                                                            children: ursInfo[msg['Variables']
                                                                        ['postlist'][0]['authorid']]
                                                                    ['showMedals']
                                                                .map<Widget>((item) {
                                                              return Container(
                                                                width: ScreenUtil.getInstance()
                                                                    .setWidth(26),
                                                                height: ScreenUtil.getInstance()
                                                                    .setWidth(26),
                                                                child: Image.network(
                                                                    'https://bbs.d.163.com/static/image/common/appmedal/${item['image']}.png'),
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: ScreenUtil.getInstance()
                                                                .setHeight(6)),
                                                        child: Text(
                                                            '${ursInfo[msg['Variables']['postlist'][0]['authorid']]['title']}  ${msg['Variables']['postlist'][0]['dateline']}',
                                                            style: TextStyle(
                                                                color: Color(0xffB5A88E),
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setSp(26))),
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
                                                        '  ${msg['Variables']['thread']['views']}',
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
                                          Container(
                                            child: Html(
                                              data: '${msg['Variables']['postlist'][0]['message']}'
                                                  .replaceAll('height="auto"', ''),
                                              defaultTextStyle: TextStyle(
                                                  fontSize: ScreenUtil.getInstance().setSp(26)),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil.getInstance().setHeight(24),
                                                bottom: ScreenUtil.getInstance().setHeight(24)),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(Icons.edit),
                                                Text('点评')
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffE2D4BE),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: msg['Variables']['comments'].keys.map<Widget>((item) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: msg['Variables']['comments'][item].map<Widget>((comment) {
                                                        return Wrap(
                                                          children: <Widget>[
                                                            RichText(text: TextSpan(
                                                              text: '${comment['author']}',
                                                                style: TextStyle(
                                                                  color: Color(0xffE6A048),
                                                                  fontSize: ScreenUtil.getInstance().setSp(24)
                                                                ),
                                                              children: <TextSpan>[
                                                                TextSpan(
                                                                  text: '：${comment['comment']}',
                                                                  style: TextStyle(
                                                                      color: Color(0xff141210)
                                                                  ),
                                                                )
                                                              ]
                                                            )),
                                                          ],
                                                        );
                                                    }).toList(),
                                                  );
                                              }).toList(),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil.getInstance().setHeight(24),
                                                bottom: ScreenUtil.getInstance().setHeight(24)),
                                            child: Center(
                                              child: Image.asset('images/database_divider.png'),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                bottom: ScreenUtil.getInstance().setHeight(24)),
                                            child: Center(
                                              child: Text(
                                                '｛来源：凯恩之角｝',
                                                style: TextStyle(
                                                    color: Color(0xffB5A88E),
                                                    fontSize: ScreenUtil.getInstance().setSp(26)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffDED0BB),
                                    border: Border(
                                        top: BorderSide(
                                            color: Color(0xffD5C8B2),
                                            width: ScreenUtil.getInstance().setWidth(2)),
                                        bottom: BorderSide(
                                            color: Color(0xffD5C8B2),
                                            width: ScreenUtil.getInstance().setWidth(2)))),
                                padding: EdgeInsets.only(
                                    bottom: ScreenUtil.getInstance().setHeight(4),
                                    top: ScreenUtil.getInstance().setHeight(4),
                                    left: ScreenUtil.getInstance().setWidth(24)),
                                child: Text(
                                  '最新跟帖 7',
                                  style: TextStyle(
                                      color: Color(0xff877964),
                                      fontSize: ScreenUtil.getInstance().setSp(22)),
                                ),
                              ),
                              commentsLayout(),
                              Container(
                                height: ScreenUtil.getInstance().setHeight(24),
                              )
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
                          image: AssetImage('images/rank_bottom_bg.jpg'), fit: BoxFit.cover)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: ScreenUtil.getInstance().setWidth(30),
                                top: ScreenUtil.getInstance().setWidth(2)),
                            height: ScreenUtil.getInstance().setHeight(70),
                            width: width / 3 * 2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('images/bg_comment_edit_text.png'),
                                    fit: BoxFit.fill)),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: '已有168条回复',
                                  hintStyle: TextStyle(
                                      color: Color(0xff766D5A),
                                      fontSize: ScreenUtil.getInstance().setSp(28))),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(24),
                            right: ScreenUtil.getInstance().setWidth(24)),
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: Image.asset(
                                'images/icon_bottom_flow.png',
                                width: ScreenUtil.getInstance().setWidth(56),
                              ),
                              margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(24)),
                            ),
                            Container(
                              child: Image.asset(
                                'images/icon_detail_share.png',
                                width: ScreenUtil.getInstance().setWidth(56),
                              ),
                              margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(24)),
                            ),
                            Container(
                              child: Image.asset(
                                'images/icon_detail_collect.png',
                                width: ScreenUtil.getInstance().setWidth(56),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
