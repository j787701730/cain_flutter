import 'package:cain_flutter/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'ProviderModel.dart';
import 'bbs.dart';
import 'my.dart';
import 'news.dart';
import 'tool.dart';

void main() {
  final counter = ProviderModel();
  runApp(
    Provider<String>.value(
      value: 'cain',
      child: ChangeNotifierProvider.value(
        value: counter,
        child: MyApp(),
      ),
    ),
  );
}

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPage createState() => new _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  bool isStartHomePage = false;

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("images/head_loading1.png"), context);
    // TODO: implement build
    return new GestureDetector(
      onTap: goToHomePage, //设置页面点击事件
//      child: Image.asset(
//        "images/iplay_start.jpg",
//        fit: BoxFit.cover,
//      ), //此处fit: BoxFit.cover用于拉伸图片,使图片铺满全屏
      child: Container(
        color: Color(0xffE8DAC5),
        child: Center(
          child: Image.asset('images/head_loading1.png'),
        ),
      ),
    );
  }

  //页面初始化状态的方法
  @override
  void initState() {
    super.initState();
    //开启倒计时
    countDown();
  }

  void countDown() {
    //设置倒计时三秒后执行跳转方法
    var duration = new Duration(milliseconds: 100);
    new Future.delayed(duration, goToHomePage);
  }

  void goToHomePage() {
    //如果页面还未跳转过则跳转页面
    if (!isStartHomePage) {
      //跳转主页 且销毁当前页面
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new MyHomePage()),
          (Route<dynamic> rout) => false);
      isStartHomePage = true;
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAIN Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        primarySwatch: Colors.blue,
          primaryColor: Color(0xff141410),
          platform: TargetPlatform.iOS,
          fontFamily: 'SourceHanSansCN',
          textTheme: TextTheme()),
      home: MyHomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // 自己要补个文件 localizations.dart
        ChineseCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        //此处
        const Locale('zh', 'CH'),
        const Locale('en', 'US'),
      ],
    );
  }
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create(
      {MaterialInkController controller,
      RenderBox referenceBox,
      Offset position,
      Color color,
      TextDirection textDirection,
      bool containedInkWell = false,
      rectCallback,
      BorderRadius borderRadius,
      ShapeBorder customBorder,
      double radius,
      onRemoved}) {
    return new NoSplash(
      controller: controller,
      referenceBox: referenceBox,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
  })  : assert(controller != null),
        assert(referenceBox != null),
        super(
          controller: controller,
          referenceBox: referenceBox,
        );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _tabIndex = 0;
  DateTime _lastPressedAt; //上次点击时间

  List nav = [News(), Bbs(), Tool(), My()];
  var _pageController = PageController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void _pageChanged(int index) {
//    print('_pageChanged');
    if (mounted)
      setState(() {
        if (_tabIndex != index) _tabIndex = index;
      });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage('images/${Provider.of<ProviderModel>(context).topBackground}'))),
      child: WillPopScope(
          onWillPop: () async {
            Toast.show("再按一次退出app", context, duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressedAt = DateTime.now();
              return false;
            }
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
            body: PageView.builder(
                //要点1
                physics: NeverScrollableScrollPhysics(),
                //禁止页面左右滑动切换
                controller: _pageController,
                onPageChanged: _pageChanged,
                //回调函数
                itemCount: nav.length,
                itemBuilder: (context, index) => nav[index]),
            bottomNavigationBar: Theme(
                data: ThemeData(splashFactory: NoSplashFactory(), highlightColor: Color(0xffff)),
                child: Container(
                  height: width / 4 * 98 / 186 + 1,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: AssetImage('images/icon_pgall_menuebg.png'), fit: BoxFit.cover)),
                  child: BottomNavigationBar(
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Color(0x00ffffff),
                    selectedItemColor: Color(0xffFFDF8E),
                    unselectedItemColor: Color(0xffB39972),
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          backgroundColor: Color(0x00ffffff),
                          icon: Container(
                            width: width / 4,
                            child: Stack(
                              children: <Widget>[
                                Image.asset(
                                  _tabIndex == 0
                                      ? 'images/btn_news_hover.png'
                                      : 'images/btn_news.png',
                                  fit: BoxFit.fitWidth,
                                ),
                                Positioned(
                                    width: width / 4,
                                    bottom: 2,
                                    child: Center(
                                      child: Text(
                                        '资讯',
                                        style: TextStyle(
                                            color: _tabIndex == 0
                                                ? Color(0xffFFDF8E)
                                                : Color(0xffB39972),
                                            fontSize: 10),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          title: Text(
                            '资讯',
                          )),
                      BottomNavigationBarItem(
                          icon: Container(
                              width: width / 4,
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    _tabIndex == 1
                                        ? 'images/btn_bbs_hover.png'
                                        : 'images/btn_bbs.png',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Positioned(
                                      width: width / 4,
                                      bottom: 2,
                                      child: Center(
                                        child: Text(
                                          '社区',
                                          style: TextStyle(
                                              color: _tabIndex == 1
                                                  ? Color(0xffFFDF8E)
                                                  : Color(0xffB39972),
                                              fontSize: 10),
                                        ),
                                      ))
                                ],
                              )),
                          title: Text('社区')),
                      BottomNavigationBarItem(
                          icon: Container(
                              width: width / 4,
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    _tabIndex == 2
                                        ? 'images/btn_tool_hover.png'
                                        : 'images/btn_tool.png',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Positioned(
                                      width: width / 4,
                                      bottom: 2,
                                      child: Center(
                                        child: Text(
                                          '工具',
                                          style: TextStyle(
                                              color: _tabIndex == 2
                                                  ? Color(0xffFFDF8E)
                                                  : Color(0xffB39972),
                                              fontSize: 10),
                                        ),
                                      ))
                                ],
                              )),
                          title: Text('')),
                      BottomNavigationBarItem(
                          icon: Container(
                              width: width / 4,
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    _tabIndex == 3
                                        ? 'images/btn_my_hover.png'
                                        : 'images/btn_my.png',
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Positioned(
                                      width: width / 4,
                                      bottom: 2,
                                      child: Center(
                                        child: Text(
                                          '我',
                                          style: TextStyle(
                                              color: _tabIndex == 3
                                                  ? Color(0xffFFDF8E)
                                                  : Color(0xffB39972),
                                              fontSize: 10),
                                        ),
                                      ))
                                ],
                              )),
                          title: Text('我')),
                    ],
                    currentIndex: _tabIndex,
                    onTap: (index) {
                      if (mounted)
                        setState(() {
                          _tabIndex = index;
                        });
                      _pageController.jumpToPage(index);
                      if (index == 3) {
                        Provider.of<ProviderModel>(context)
                            .changeTopBackground(bg: 'bg_pgmy_header.jpg');
                      } else {
                        Provider.of<ProviderModel>(context).changeTopBackground();
                      }
                    },
                  ),
                )),
          )),
    );
  }
}
