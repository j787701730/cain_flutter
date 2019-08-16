import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'util.dart';

import 'news_content2.dart';

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
  bool fixed = true;
  int _tabIndex = 0;

  Widget _contentCon(item, type) {
    return item['displayorder'] == '1'
        ? Container()
        : GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new NewsContent2({'type': '1', 'tid': "${item['tid']}"})),
              );
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil.getInstance().setWidth(24),
                  right: ScreenUtil.getInstance().setWidth(24),
                  top: ScreenUtil.getInstance().setHeight(24),
                  bottom: ScreenUtil.getInstance().setHeight(24)),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color(0xffC9BBA4), width: ScreenUtil.getInstance().setWidth(1)))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: <TextSpan>[
                      item['special'] == '1'
                          ? TextSpan(
                              text: ' 热 ',
                              style: TextStyle(
                                  color: Color(0xffF4DA9C),
                                  backgroundColor: Color(0xffB51610),
                                  fontSize: ScreenUtil.getInstance().setSp(22),
                                  fontFamily: 'SourceHanSansCN'))
                          : TextSpan(text: ''),
                      item['special'].toString() == '1' ? TextSpan(text: '  ') : TextSpan(text: ''),
                      type == 2
                          ? TextSpan(
                              text: ' 精 ',
                              style: TextStyle(
                                  color: Color(0xffF4DA9C),
                                  backgroundColor: Color(0xffE79222),
                                  fontSize: ScreenUtil.getInstance().setSp(22),
                                  fontFamily: 'SourceHanSansCN'))
                          : TextSpan(),
                      type == 2 ? TextSpan(text: '  ') : TextSpan(text: ''),
                      TextSpan(
                        text: '${item['subject']}',
                        style: TextStyle(
                          color: Color(0xff3F311D),
                          fontSize: ScreenUtil.getInstance().setSp(30),
                          fontFamily: 'SourceHanSansCN',
                        ),
                      )
                    ]),
                  ),
                  Container(
                    height: ScreenUtil.getInstance().setHeight(46),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'images/ic_editor.png',
                              width: ScreenUtil.getInstance().setWidth(24),
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(6),
                            ),
                            Text(
                              item['author'],
                              style: TextStyle(
                                  color: Color(0xff6A5C41),
                                  fontSize: ScreenUtil.getInstance().setSp(22)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'images/icon_bbs_time.png',
                              width: ScreenUtil.getInstance().setWidth(24),
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(6),
                            ),
                            Text(
                              '${item['lastpost']}'.replaceAll('&nbsp;', ''),
                              style: TextStyle(
                                  color: Color(0xffB5A88E),
                                  fontSize: ScreenUtil.getInstance().setSp(22)),
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(60),
                            ),
                            Image.asset(
                              'images/ic_news_list_comment.png',
                              width: ScreenUtil.getInstance().setWidth(24),
                            ),
                            Container(
                              width: ScreenUtil.getInstance().setWidth(6),
                            ),
                            Text(
                              '${item['views']}',
                              style: TextStyle(
                                  color: Color(0xffB5A88E),
                                  fontSize: ScreenUtil.getInstance().setSp(22)),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }

  int topListLength = 3;

  bool show = false;
  double top;
  double fixedHeight;

  @override
  void initState() {
    super.initState();
    _ajax();
    _getBbs();
    _listController.addListener(() {
      setState(() {
        show = (top < _listController.offset) ? true : false;
        fixed = (fixedHeight > _listController.offset) ? true : false;
      });
    });
  }

  Map variables = {};
  Map variables2 = {};

  _getBbs() {
    ajax(
        'https://bbs.d.163.com/api/mobile/index.php?version=163&module=forumdisplay&charset=utf-8&digest=1&hidesticky=0&tpp=15&fid=${widget.props['fid']}&page=1&filter&orderby&ts=1565936290&uf=421d9f6e-5cff-4347-896c-8566d5302886&ab=af1c468cded2ab111a41ca0a4f18d45dbe&ef=cd7a1ae29beb4d59b62c46308fa2c73df9',
        (data) {
      if (mounted) {
        setState(() {
          variables = data['Variables'];
        });
      }
    });
  }

  _getBbs2() {
    ajax(
        'https://bbs.d.163.com/api/mobile/index.php?version=163&module=forumdisplay&charset=utf-8&digest=1&hidesticky=0&tpp=15&fid=${widget.props['fid']}&page=1&filter=digest&orderby&ts=1565936470&uf=f14d331c-aa95-4ce1-8b7c-b65abbbe2593&ab=904f039d9d8d3ffcfb51e48d7c63253498&ef=d99d5889ed50ea30be4f6183c6a43b01dc',
        (data) {
      if (mounted) {
        setState(() {
          variables2 = data['Variables'];
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    top = width / 912 * 480 - MediaQuery.of(context).padding.top - 56;
    fixedHeight = width / 912 * 480 -
        MediaQuery.of(context).padding.top -
        56 +
        ScreenUtil.getInstance().setHeight(84.0 + 84 + 60 * topListLength);

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff000000),
            ),
            child: variables.isEmpty
                ? Scaffold(
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      elevation: 0,
                      child: Image.asset(
                        'images/btn_pgbbs_list_write.png',
                        width: ScreenUtil.getInstance().setWidth(90),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
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
                    floatingActionButton: FloatingActionButton(
                      onPressed: () {},
                      elevation: 0,
                      child: Image.asset(
                        'images/btn_pgbbs_list_write.png',
                        width: ScreenUtil.getInstance().setWidth(90),
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                    backgroundColor: Colors.transparent,
                    body: SmartRefresher(
                      controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
                      onRefresh: () async {
                        _getBbs();
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
                            color: Color(0xffE8DAC5),
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
                                        '版主：${variables['forum']['moderators'].join('、')}',
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
                                            '主题 ${variables['forum']['threadcount']}',
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
                                            '今日 ${variables['forum']['todayposts']}',
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
                            child: variables['forum_threadlist'] != null
                                ? Column(
                                    children: variables['forum_threadlist'].map<Widget>((item) {
                                      return item['displayorder'].toString() == '1'
                                          ? Container(
                                              height: ScreenUtil.getInstance().setHeight(60),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                top: BorderSide(
                                                    color: variables['forum_threadlist']
                                                                .indexOf(item) ==
                                                            0
                                                        ? Colors.transparent
                                                        : Color(0xffC9BBA4),
                                                    width: ScreenUtil.getInstance().setWidth(1)),
                                              )),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: ScreenUtil.getInstance().setWidth(6),
                                                        right:
                                                            ScreenUtil.getInstance().setWidth(6)),
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            ScreenUtil.getInstance().setWidth(16)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color(0xffB51610),
                                                            width: ScreenUtil.getInstance()
                                                                .setWidth(1)),
                                                        borderRadius:
                                                            BorderRadius.all(Radius.circular(4))),
                                                    child: Text(
                                                      '置顶',
                                                      style: TextStyle(
                                                          color: Color(0xffB51610),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(18)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '${item['subject']}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Color(0xff4D4945),
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(26)),
                                                      ))
                                                ],
                                              ),
                                            )
                                          : Container();
                                    }).toList(),
                                  )
                                : Container(),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                topListLength = topListLength == 3 ? 4 : 3;
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
                            height: ScreenUtil.getInstance().setWidth(15),
                            color: Color(0xffE0D3BD),
                          ),
                          Container(
                            color: Color(0xffE8DAC5),
                            padding: EdgeInsets.only(
                                left: ScreenUtil.getInstance().setWidth(24),
                                right: ScreenUtil.getInstance().setWidth(24)),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color(0xffA99B83),
                                          width: ScreenUtil.getInstance().setWidth(1)))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: ScreenUtil.getInstance().setWidth(12),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          _getBbs();
                                          setState(() {
                                            _tabIndex = 0;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setWidth(18),
                                              bottom: ScreenUtil.getInstance().setWidth(18)),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: _tabIndex == 0
                                                          ? Color(0xffB51610)
                                                          : Colors.transparent,
                                                      width:
                                                          ScreenUtil.getInstance().setWidth(4)))),
                                          child: Center(
                                            child: Text(
                                              '全部',
                                              style: TextStyle(
                                                  fontSize: ScreenUtil.getInstance().setSp(30),
                                                  color: Color(
                                                      _tabIndex == 0 ? 0xffB51610 : 0xff6A5C41)),
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    width: ScreenUtil.getInstance().setHeight(32),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          _getBbs2();
                                          setState(() {
                                            _tabIndex = 1;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setWidth(18),
                                              bottom: ScreenUtil.getInstance().setWidth(18)),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: _tabIndex == 1
                                                          ? Color(0xffB51610)
                                                          : Colors.transparent,
                                                      width:
                                                          ScreenUtil.getInstance().setWidth(4)))),
                                          child: Center(
                                            child: Text(
                                              '精华',
                                              style: TextStyle(
                                                  fontSize: ScreenUtil.getInstance().setSp(30),
                                                  color: Color(
                                                      _tabIndex == 1 ? 0xffB51610 : 0xff6A5C41)),
                                            ),
                                          ),
                                        ),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(32)),
                                    height: ScreenUtil.getInstance().setHeight(36),
                                    color: Color(0xffA99B83),
                                    width: ScreenUtil.getInstance().setWidth(1),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: ScreenUtil.getInstance().setWidth(24)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                '回复时间',
                                                style: TextStyle(
                                                    fontSize: ScreenUtil.getInstance().setSp(22),
                                                    color: Color(0xffB5A88E)),
                                              ),
                                              Image.asset(
                                                'images/community_sort.png',
                                                width: ScreenUtil.getInstance().setWidth(24),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Offstage(
                            offstage: _tabIndex == 1,
                            child: Container(
                                color: Color(0xffE8DAC5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: variables['forum_threadlist'].map<Widget>((item) {
                                    return _contentCon(item, 1);
                                  }).toList(),
                                )),
                          ),
                          Offstage(
                            offstage: _tabIndex == 0,
                            child: Container(
                              color: Color(0xffE8DAC5),
                              child: variables2.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: variables2['forum_threadlist'].map<Widget>((list) {
                                        return _contentCon(list, 2);
                                      }).toList(),
                                    )
                                  : Container(
                                      color: Color(0xffE8DAC5),
                                      height: height,
                                    ),
                            ),
                          ),
                          Container(
                            color: Color(0xffE8DAC5),
                            height: ScreenUtil.getInstance().setHeight(24),
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
                  height: MediaQuery.of(context).padding.top + 56,
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
                              width: ScreenUtil.getInstance().setWidth(42),
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
                  )),
          fixed
              ? Positioned(
                  child: SizedBox(),
                )
              : Positioned(
                  left: 0,
                  top: MediaQuery.of(context).padding.top + 56,
                  width: width,
                  child: Container(
                    color: Color(0xffE8DAC5),
                    padding: EdgeInsets.only(
                        left: ScreenUtil.getInstance().setWidth(24),
                        right: ScreenUtil.getInstance().setWidth(24)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffA99B83),
                                  width: ScreenUtil.getInstance().setWidth(1)))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenUtil.getInstance().setWidth(12),
                          ),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _tabIndex = 0;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil.getInstance().setWidth(18),
                                      bottom: ScreenUtil.getInstance().setWidth(18)),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: _tabIndex == 0
                                                  ? Color(0xffB51610)
                                                  : Colors.transparent,
                                              width: ScreenUtil.getInstance().setWidth(4)))),
                                  child: Center(
                                    child: Text(
                                      '全部',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                          fontSize: ScreenUtil.getInstance().setSp(30),
                                          color: Color(_tabIndex == 0 ? 0xffB51610 : 0xff6A5C41)),
                                    ),
                                  ),
                                ),
                              )),
                          Container(
                            width: ScreenUtil.getInstance().setHeight(32),
                          ),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _tabIndex = 1;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil.getInstance().setWidth(18),
                                      bottom: ScreenUtil.getInstance().setWidth(18)),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: _tabIndex == 1
                                                  ? Color(0xffB51610)
                                                  : Colors.transparent,
                                              width: ScreenUtil.getInstance().setWidth(4)))),
                                  child: Center(
                                    child: Text(
                                      '精华',
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          decoration: TextDecoration.none,
                                          fontSize: ScreenUtil.getInstance().setSp(30),
                                          color: Color(_tabIndex == 1 ? 0xffB51610 : 0xff6A5C41)),
                                    ),
                                  ),
                                ),
                              )),
                          Container(
                            margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(32)),
                            height: ScreenUtil.getInstance().setHeight(36),
                            color: Color(0xffA99B83),
                            width: ScreenUtil.getInstance().setWidth(1),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(24)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '回复时间',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            decoration: TextDecoration.none,
                                            fontSize: ScreenUtil.getInstance().setSp(22),
                                            color: Color(0xffB5A88E)),
                                      ),
                                      Image.asset(
                                        'images/community_sort.png',
                                        width: ScreenUtil.getInstance().setWidth(24),
                                      )
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
