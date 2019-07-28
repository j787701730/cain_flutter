import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'news_content.dart';

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
  List content = [
    {
      'title': '打假，这是个假的',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 0
    },
    {
      'title': '填坑完毕：精英怪及秘境守卫技能伤害查询表2.4.1版（4月27日小更新）',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 1
    },
    {
      'title': '耐玩，让暗黑3找到自己的游戏灵魂------写在暗黑3夺魂之镰资料片前',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 0,
      'is_essence': 1
    },
    {
      'title': '［新手试水］［独家翻译］凯恩之书 全卷',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 0,
      'is_essence': 0
    },
    {
      'title': '打假，这是个假的',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 0
    },
    {
      'title': '填坑完毕：精英怪及秘境守卫技能伤害查询表2.4.1版（4月27日小更新）',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 1
    },
    {
      'title': '耐玩，让暗黑3找到自己的游戏灵魂------写在暗黑3夺魂之镰资料片前',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 0,
      'is_essence': 1
    },
    {
      'title': '［新手试水］［独家翻译］凯恩之书 全卷',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 0,
      'is_essence': 0
    },
  ];

  List content2 = [
    {
      'title': '你可能还不知道的暗黑3常用小技巧，多年经验和大部分人都不知道的冷知识大百科',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 0
    },
    {
      'title': '献给那些准备传奇幻化的朋友，传奇造型独特性调查（多图）已更新',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 1
    },
    {
      'title': '事了拂衣，挥手兹去，网路无声，吾思有痕。',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 0,
      'is_essence': 1
    },
    {
      'title': '你可能还不知道的暗黑3常用小技巧，多年经验和大部分人都不知道的冷知识大百科',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 0
    },
    {
      'title': '献给那些准备传奇幻化的朋友，传奇造型独特性调查（多图）已更新',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 1,
      'is_essence': 1
    },
    {
      'title': '事了拂衣，挥手兹去，网路无声，吾思有痕。',
      'author': '秋仲琉璃子不语',
      'create_date': '5个小时前',
      'avatar': 'default_avatar.png',
      'visits': 9527,
      'is_hot': 0,
      'is_essence': 1
    },
  ];

  _contentCon(item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new NewsContent({})),
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
                item['is_hot'] == 1
                    ? TextSpan(
                        text: ' 热 ',
                        style: TextStyle(
                            color: Color(0xffF4DA9C),
                            backgroundColor: Color(0xffB51610),
                            fontSize: ScreenUtil.getInstance().setSp(22),
                            fontFamily: 'SourceHanSansCN'))
                    : TextSpan(text: ''),
                item['is_hot'] == 1 ? TextSpan(text: '  ') : TextSpan(text: ''),
                item['is_essence'] == 1
                    ? TextSpan(
                        text: ' 精 ',
                        style: TextStyle(
                            color: Color(0xffF4DA9C),
                            backgroundColor: Color(0xffE79222),
                            fontSize: ScreenUtil.getInstance().setSp(22),
                            fontFamily: 'SourceHanSansCN'))
                    : TextSpan(),
                item['is_essence'] == 1 ? TextSpan(text: '  ') : TextSpan(text: ''),
                TextSpan(
                  text: '${item['title']}',
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
                            color: Color(0xff6A5C41), fontSize: ScreenUtil.getInstance().setSp(22)),
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
                        item['create_date'],
                        style: TextStyle(
                            color: Color(0xffB5A88E), fontSize: ScreenUtil.getInstance().setSp(22)),
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
                        '${item['visits']}',
                        style: TextStyle(
                            color: Color(0xffB5A88E), fontSize: ScreenUtil.getInstance().setSp(22)),
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
  double fixedHeight;

  @override
  void initState() {
    super.initState();
    _ajax();
    _listController.addListener(() {
      setState(() {
        show = (top < _listController.offset) ? true : false;
        fixed = (fixedHeight > _listController.offset) ? true : false;
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
    fixedHeight = width / 912 * 480 -
        MediaQuery.of(context).padding.top -
        56 +
        ScreenUtil.getInstance().setHeight(84.0 + 60 * topListLength);
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xff000000),
            ),
            child: flag
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
                                children: content.map<Widget>((item) {
                                  return _contentCon(item);
                                }).toList(),
                              ),
                            ),
                          ),
                          Offstage(
                            offstage: _tabIndex == 0,
                            child: Container(
                              color: Color(0xffE8DAC5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: content2.map<Widget>((item) {
                                  return _contentCon(item);
                                }).toList(),
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
                  )),
          fixed
              ? Positioned(
                  child: SizedBox(),
                )
              : Positioned(
                  left: 0,
                  top: MediaQuery.of(context).padding.top + 56,
                  height: 56,
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
