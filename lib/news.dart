import 'package:cain_flutter/ProviderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'news_content1.dart';
import 'news_content2.dart';
import 'news_content3.dart';
import 'news_list.dart';
import 'util.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  List banner = [];
  int page = 0;
  bool flag = true;

  List news = [];

  @override
  bool get wantKeepAlive => true;
  int startIndex = 0;

  @override
  void initState() {
    super.initState();
    getBanner();
    getNews();
  }

  getBanner() {
    ajax(
        'https://cain-api.gameyw.netease.com/cain/app/queryImages?platform=0&imageType=1&version=1.6.2',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          banner = data['data'];
        });
      }
    });
  }

  getNews() {
    ajax(
        'https://cain-api.gameyw.netease.com/cain/article/list?size=20&startIndex=${startIndex * 20}',
        (data) {
      if (mounted && data['code'] == 200) {
        if (startIndex == 0) {
          setState(() {
            news = data['list'];
          });
        } else {
          setState(() {
            news.addAll(data['list']);
          });
        }
      }
    });
  }

//  _ajax() async {
//    await Future.delayed(Duration(seconds: 2), () {
//      if (mounted)
//        setState(() {
//          flag = false;
//        });
//    });
//  }

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
        child: banner.isEmpty && news.isEmpty
            ? Center(
                child: Image.asset(
                  'images/head_loading1.png',
                  width: ScreenUtil.getInstance().setWidth(78),
                ),
              )
            : SmartRefresher(
                controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
                onRefresh: () async {
                  _loading();
                  getBanner();
                  await Future.delayed(Duration(milliseconds: 2000));
                  if (mounted)
                    setState(() {
                      startIndex = 0;
                      getNews();
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
                      startIndex += 1;
                      getNews();
                    });
                  _refreshController.loadComplete();
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: width / 700 * 320,
                      child: Swiper(
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Provider.of<ProviderModel>(context).changeTopBackground();
                                  switch (banner[index]['redirectTo']) {
                                    case 1:
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => new NewsContent1({
                                                  'type': '1',
                                                  'tid': "${banner[index]['redirectData']}"
                                                })),
                                      );
                                      break;
                                    case 2:
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => new NewsContent2({
                                                  'type': '1',
                                                  'tid': "${banner[index]['redirectData']}"
                                                })),
                                      );
                                      break;
                                    case 3:
                                      Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => new NewsContent3({
                                                  'type': '1',
                                                  'tid': "${banner[index]['redirectData']}",
                                                  'title': "${banner[index]['imageName']}"
                                                })),
                                      );
                                      break;
                                  }
                                },
                                child: Image.network(
                                  "${banner[index]['imgUrl']}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                  bottom: 24,
                                  left: 10,
                                  width: width - 20,
                                  child: Text(
                                    banner[index]['imageName'],
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
