import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_html/flutter_html.dart';
import 'util.dart';

class NewsContent1 extends StatefulWidget {
  final props;

  NewsContent1(this.props);

  @override
  _NewsContent1State createState() => _NewsContent1State();
}

class _NewsContent1State extends State<NewsContent1> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  ScrollController _listController = ScrollController();

  bool flag = true;

  Map comments = {};

  Map msg = {};

  bool show = false;

  @override
  void initState() {
    super.initState();
    _ajax();
    _getContent();
    _getComments();
    _listController.addListener(() {
      setState(() {
        show = (200 < _listController.offset) ? true : false;
      });
    });
  }

  _getContent() async {
    ajax(
        'https://cain-api.gameyw.netease.com/cain/article/detail?id=${widget.props['tid']}&sid=be08e07dc5814d1b88b0ed086f00b4e4__vD1S%252FPEqu3rDFtc40pd99Q%253D%253D&ts=1565834507&uf=6a70b030-fc8f-4988-87ef-9c89c586d77e&ab=b9a9d68aa9e2c20d224654225c62267549&ef=aad5d398b9213b771eb58aa8a87c5c0092',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          msg = data['data'];
        });
      }
    });
  }

  _getComments() {
    ajax(
        'https://cain-api.gameyw.netease.com//cain/comment/list?aid=${widget.props['tid']}&timestamp=9223372036854775807&size=20&withRootCount=false&withHotComment=true&sid=8196b3f17a5642519ad0c46fd649bfa8__vD1S%252FPEqu3rDFtc40pd99Q%253D%253D&ts=1565920571&uf=9be20621-b9eb-4a0a-8057-71ff65f81111&ab=17e5a22d7430db58d7ee354532f440b3c0&ef=d7ed9b07a5f0439c97b55727198658629f',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          comments = data;
        });
      }
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

  // todo: 只实现了一种评论
  commentsLayout(data) {
    return Column(
      children: data.map<Widget>((item) {
        DateTime time;
        time = DateTime.fromMillisecondsSinceEpoch(item['createTime']);
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
                  child: ClipOval(
                    child: Image.network(
                      '${item['user']['avatar']}',
                      width: ScreenUtil.getInstance().setWidth(70),
                      height: ScreenUtil.getInstance().setWidth(70),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(12)),
                ),
                Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      '${item['user']['nickname']}',
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
                                          '${item['location']}',
                                          style: TextStyle(
                                              color: Color(0xffABA191),
                                              fontSize: ScreenUtil.getInstance().setSp(20)),
                                        ),
                                        Container(
                                          width: ScreenUtil.getInstance().setWidth(20),
                                        ),
                                        Text(
                                          '${time.year}/${time.month}/${time.day} ${time.hour}:${time.minute}:${time.second}',
                                          style: TextStyle(
                                              color: Color(0xffABA191),
                                              fontSize: ScreenUtil.getInstance().setSp(20)),
                                        )
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '${item['likeCount']} ',
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
                            '${item['content']}',
                            style: TextStyle(
                                color: Color(0xff6A5C41),
                                fontSize: ScreenUtil.getInstance().setSp(30)),
                          ),
                        ),
                        item['replyContent'] != null 
                            ? Container(
                          margin: EdgeInsets.only(
                            top: ScreenUtil.getInstance().setHeight(6)
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xffE2D4BE),
                              border: Border.all(
                                  color: Color(0xffD5C7B1),
                                  width: ScreenUtil.getInstance().setSp(1)
                              )
                          ),
                          padding: EdgeInsets.all(
                              ScreenUtil.getInstance().setWidth(24)
                          ),
                          child: RichText(text: TextSpan(
                              text: '@${item['replyUser']['nickname']}:', style: TextStyle(
                              color: Color(0xffE6A048),
                              fontSize:
                              ScreenUtil.getInstance()
                                  .setSp(26)),
                              children: <TextSpan>[
                                TextSpan(text: '${item['replyContent']}', style: TextStyle(
                                    color: Color(0xff141210)),
                                )
                              ]
                          )),
                        ) : Container()
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
    DateTime time;
    if (msg.isNotEmpty) {
      time = DateTime.fromMillisecondsSinceEpoch(msg['publishTime']);
    }
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
                      ClipOval(
                        child: Image.network(
                          '${msg['author']['avatar']}',
                          width: ScreenUtil.getInstance().setWidth(30),
                        ),
                      ),
                      Container(
                        width: ScreenUtil.getInstance().setWidth(12),
                      ),
                      Text(
                        '${msg['authorName']}',
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
                  child: msg.isEmpty
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
                              msg.isNotEmpty && msg['content'] != null
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
                                              '${msg['title']}',
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
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      '${msg['author']['avatar']}',
                                                      width: ScreenUtil.getInstance().setWidth(60),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: ScreenUtil.getInstance().setWidth(12)),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      RichText(
                                                          text: TextSpan(
                                                              text: '${msg['authorName']}',
                                                              style: TextStyle(
                                                                  color: Color(0xffE79425),
                                                                  fontSize: ScreenUtil.getInstance()
                                                                      .setSp(26)),
                                                              children: <TextSpan>[
                                                            TextSpan(
                                                                text: '  ${msg['author']['title']}',
                                                                style: TextStyle(
                                                                    color: Color(0xffC9BCA4)))
                                                          ])),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: ScreenUtil.getInstance()
                                                                .setHeight(6)),
                                                        child: Text(
                                                            '${time.year}/${time.month}/${time.day} ${time.hour}:${time.minute}:${time.second}',
                                                            style: TextStyle(
                                                                color: Color(0xffB5A88E),
                                                                fontSize: ScreenUtil.getInstance()
                                                                    .setSp(20))),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Html(
                                            data:
                                                '${msg['content']}'.replaceAll('height="auto"', ''),
                                            defaultTextStyle: TextStyle(
                                                fontSize: ScreenUtil.getInstance().setSp(30)),
                                          ),
                                          msg['photosView'] != null &&
                                                  msg['photosView']['photos'] != null
                                              ? Column(
                                                  children: msg['photosView']['photos']
                                                      .map<Widget>((photo) {
                                                    return Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: ScreenUtil.getInstance()
                                                              .setWidth(24)),
                                                      width: width -
                                                          ScreenUtil.getInstance().setWidth(48),
                                                      child: Image.network(
                                                        '${photo['img']}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  }).toList(),
                                                )
                                              : Container(),
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
                                  '热门跟帖',
                                  style: TextStyle(
                                      color: Color(0xff877964),
                                      fontSize: ScreenUtil.getInstance().setSp(22)),
                                ),
                              ),
                              comments.isNotEmpty
                                  ? commentsLayout(comments['hotList'])
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
                                  '最新跟帖',
                                  style: TextStyle(
                                      color: Color(0xff877964),
                                      fontSize: ScreenUtil.getInstance().setSp(22)),
                                ),
                              ),
                              comments.isNotEmpty ? commentsLayout(comments['list']) : Container(),
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
