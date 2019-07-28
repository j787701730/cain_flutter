import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsContent extends StatefulWidget {
  final props;

  NewsContent(this.props);

  @override
  _NewsContentState createState() => _NewsContentState();
}

class _NewsContentState extends State<NewsContent> with TickerProviderStateMixin {
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

  bool show = false;

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
              alignment: Alignment.topCenter,
              image: AssetImage('images/title_bar_bg.jpg'))),
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
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil.getInstance().setWidth(30),
                              bottom: ScreenUtil.getInstance().setHeight(30)),
                          child: Text(
                            content['title'],
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
                          margin:
                          EdgeInsets.only(bottom: ScreenUtil.getInstance().setWidth(12)),
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
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(12)),
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
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil.getInstance().setWidth(24)),
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
