import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

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
//          child: EasyRefresh(
//            key: _easyRefreshKey,
//            refreshHeader: PhoenixHeader(
//              key: _headerKey,
//            ),
//            refreshFooter: PhoenixFooter(
//              key: _footerKey,
//            ),
        child: ListView(
          children: <Widget>[
            Container(
              height: 1000,
              child: Center(
                child: Text('1'),
              ),
            ),
          ],
        ),
//            onRefresh: () async {
//              await new Future.delayed(const Duration(seconds: 1), () {
//                if (!mounted) return;
////                setState(() {});
//              });
//            },
//            loadMore: () async {
//              await new Future.delayed(const Duration(seconds: 1), () {
//                if (!mounted) return;
////                setState(() {});
//              });
//            },
//          )
      ),
    );
  }
}
