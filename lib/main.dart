import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'news.dart';
import 'bbs.dart';
import 'tool.dart';
import 'my.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAIN Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//        primarySwatch: Colors.blue,
        primaryColor: Colors.black,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
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
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
          body: nav[_tabIndex],
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
                                  bottom: 0,
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
                                    bottom: 0,
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
                                    bottom: 0,
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
                                  _tabIndex == 3 ? 'images/btn_my_hover.png' : 'images/btn_my.png',
                                  fit: BoxFit.fitWidth,
                                ),
                                Positioned(
                                    width: width / 4,
                                    bottom: 0,
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
                    setState(() {
                      _tabIndex = index;
                    });
                  },
                ),
              )),
        ));
  }
}
