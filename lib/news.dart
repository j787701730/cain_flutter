import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationLoadingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    animationLoading = Tween(begin: 0.0, end: 1.0).animate(animationLoadingController);
    animationLoadingController.addListener(() {
//      print((animationLoadingController.value * (7 - 1 + 1) + 1).toInt());
      setState(() {});
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _refreshController.dispose();
    animationLoadingController.dispose();
  }

  _loading() {
    animationLoadingController.forward();
  }

  @override
  Widget build(BuildContext context) {
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
            fit: BoxFit.cover,
          )),
          child: Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Image.asset(
                    'images/icon_search.png',
                    width: 20,
                  )),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '搜索关键词',
                  style: TextStyle(color: Color(0xffB5A88E), fontSize: 16),
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
            animationLoadingController.reset();
            animationLoadingController.stop();
            _refreshController.refreshCompleted();
          },
          child: ListView(
            children: <Widget>[
              Container(
                color: Colors.greenAccent,
                height: 1000.0,
              ),
              Container(
                color: Colors.blue,
                height: 1000.0,
              )
            ],
          ),
          header: CustomHeader(
            height: 100,
            refreshStyle: RefreshStyle.Behind,
            builder: (c, m) {
              return Container(
                height: 200,
                child: Center(
                  child: Image.asset(
                      'images/head_loading${animationLoadingController == null ? 1 : (animationLoadingController.value * (8 - 1.01 + 1) + 1).toInt()}.png'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
