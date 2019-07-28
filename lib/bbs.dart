import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'bbs_content.dart';

class Bbs extends StatefulWidget {
  @override
  _BbsState createState() => _BbsState();
}

class _BbsState extends State<Bbs> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  AnimationController animationLoadingController;
  Animation animationLoading;

  List bbs = [
    {
      'title': '庇护之地',
      'list': [
        {'icon': 'a_03.png', 'title': '新崔斯特姆', 'desc': '暗黑3综合讨论', 'count': '169'},
        {'icon': 'a_05.png', 'title': '不朽之地', 'desc': '暗黑手游综合讨论', 'count': '4'},
        {'icon': 'a_09.png', 'title': '战网', 'desc': '全球战网信息交流', 'count': '4'},
        {'icon': 'a_10.png', 'title': '主机', 'desc': '主机版讨论区', 'count': '4'},
      ]
    },
    {
      'title': '燃烧地狱',
      'list': [
        {'icon': 'a_13.png', 'title': '硬汉之路', 'desc': '专家模式讨论', 'count': '169'},
        {'icon': 'a_14.png', 'title': '海德格铁匠铺', 'desc': '晒装与幻化评估', 'count': '4'},
        {'icon': 'a_17.png', 'title': '探险者公会', 'desc': '成就党集结地', 'count': '4'},
      ]
    },
    {
      'title': '英雄驿站',
      'list': [
        {'icon': 'a_19.png', 'title': '暗影王国', 'desc': '死亡只是开始', 'count': '169'},
        {'icon': 'a_20.png', 'title': '哈洛加斯', 'desc': '晒装与幻化评估', 'count': '4'},
        {'icon': '20_03.png', 'title': '无形之地', 'desc': '成就党集结地', 'count': '4'},
        {'icon': '20_05.png', 'title': '复仇者营地', 'desc': '恶魔不绝猎杀不休', 'count': '169'},
        {'icon': '20_09.png', 'title': '天空寺院', 'desc': '愿精气带给你平衡', 'count': '4'},
        {'icon': '20_10.png', 'title': '仙塞学院', 'desc': '掌控元素之力', 'count': '4'},
        {'icon': '20_13.png', 'title': '勇者圣殿', 'desc': '圣光净化一切', 'count': '4'},
      ]
    },
    {
      'title': '灼沙旅店',
      'list': [
        {'icon': '20_15.png', 'title': '山羊小丘酒馆', 'desc': '传说中的水区', 'count': '999+'},
        {'icon': '20_16.png', 'title': '卡迪安城邦', 'desc': '文学艺术创作', 'count': '4'},
      ]
    },
    {
      'title': '高阶天堂',
      'list': [
        {'icon': '20_19.png', 'title': '安格里斯议会', 'desc': '讨论意见反馈', 'count': '2'},
      ]
    },
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
      body: Container(
        color: Color(0xffE8DAC5),
        child: SmartRefresher(
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
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setHeight(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/ic_editor.png'),
                    Text(
                      '  9527人在线',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(22), color: Color(0xffB5A88E)),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: bbs.map<Widget>((item) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: ScreenUtil.getInstance().setWidth(24),
                            top: ScreenUtil.getInstance().setHeight(24)),
                        width: width,
                        color: Color(0xffD9CBB5),
                        padding: EdgeInsets.only(
                            left: ScreenUtil.getInstance().setWidth(24),
                            top: ScreenUtil.getInstance().setHeight(5),
                            bottom: ScreenUtil.getInstance().setHeight(5)),
                        child: Text(
                          item['title'],
                          style: TextStyle(
                              color: Color(0xff483A26),
                              fontSize: ScreenUtil.getInstance().setSp(22)),
                        ),
                      ),
                      Wrap(
                        runSpacing: ScreenUtil.getInstance().setWidth(24),
                        children: item['list'].map<Widget>((list) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => new BbsContent({'title': list['title']})),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xffB5A88E),
                                      width: ScreenUtil.getInstance().setWidth(1)),
                                  borderRadius: BorderRadius.all(Radius.circular(6))),
                              padding: EdgeInsets.only(
                                  top: ScreenUtil.getInstance().setHeight(20),
                                  bottom: ScreenUtil.getInstance().setHeight(20),
                                  left: ScreenUtil.getInstance().setWidth(16),
                                  right: ScreenUtil.getInstance().setWidth(16)),
                              margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(24)),
                              width: (width - ScreenUtil.getInstance().setWidth(72)) / 2,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Image.asset(
                                      'bbs/${list['icon']}',
                                      width: ScreenUtil.getInstance().setWidth(60),
                                      height: ScreenUtil.getInstance().setHeight(60),
                                    ),
                                    margin: EdgeInsets.only(
                                        right: ScreenUtil.getInstance().setWidth(10)),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    list['title'],
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(25),
                                                        color: Color(0xff3D2F1B)),
                                                  )),
                                              Container(
                                                child: Text(
                                                  '${list['count']}',
                                                  style: TextStyle(
                                                      fontSize: ScreenUtil.getInstance().setSp(18),
                                                      color: Color(0xffB51610)),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            child: Text(
                                              list['desc'],
                                              style: TextStyle(
                                                  fontSize: ScreenUtil.getInstance().setSp(22),
                                                  color: Color(0xff74664B)),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  );
                }).toList(),
              ),
              Container(
                height: ScreenUtil.getInstance().setHeight(24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
