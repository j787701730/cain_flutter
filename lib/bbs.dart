import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bbs_content.dart';
import 'util.dart';

class Bbs extends StatefulWidget {
  @override
  _BbsState createState() => _BbsState();
}

class _BbsState extends State<Bbs> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getDiscuzList();
  }

  List discuzList = [];
  Map variables = {};

  _getDiscuzList() {
    _loading();
    ajax(
        'https://cain-api.gameyw.netease.com/cain/discuz/discuz_model_v2/list/center/1?sid=d09dad18179e42de82d369daec8b11b4__vD1S%252FPEqu3rDFtc40pd99Q%253D%253D&ts=1565927596&uf=4d20262a-7004-4abe-95d6-04a163797a2e&ab=7bfda2314833cebec5f24e6edd76e430eb&ef=143c7db3956865f9713b2eda60f66fdb48',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          discuzList = data['data']['discuzList'];
        });
      }
      animationLoadingController.reset();
      animationLoadingController.stop();
      _refreshController.refreshCompleted();
    });

    ajax(
        'https://bbs.d.163.com/api/mobile/index.php?version=163&module=onlineusernum&ts=1565927924&uf=25fa639a-635d-4376-885a-bd4897df91c1&ab=4c93b21a7e14c406b083caebaf61a481b0&ef=a7a1ea0e6b7b9c648689dfaf65a760df0d',
        (data) {
      if (mounted) {
        setState(() {
          variables = data['Variables'];
        });
      }
    });
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
        child: discuzList.isEmpty
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
                        color: Color(0xff938373), fontSize: ScreenUtil.getInstance().setSp(23)),
                  )
                ],
              ))
            : SmartRefresher(
                controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
                onRefresh: () async {
                  _getDiscuzList();
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
                            '  ${variables.isNotEmpty ? variables['onlineusernum'] : 9527}人在线',
                            style: TextStyle(
                                fontSize: ScreenUtil.getInstance().setSp(22),
                                color: Color(0xffB5A88E)),
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: discuzList.map<Widget>((item) {
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
                                '${item['type']['typeName']}',
                                style: TextStyle(
                                    color: Color(0xff483A26),
                                    fontSize: ScreenUtil.getInstance().setSp(22)),
                              ),
                            ),
                            Wrap(
                              runSpacing: ScreenUtil.getInstance().setWidth(24),
                              children: item['detailList'].map<Widget>((list) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new BbsContent({'title': list['modelName']})),
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
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(24)),
                                    width: (width - ScreenUtil.getInstance().setWidth(72)) / 2,
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Image.network(
                                            '${list['iconUrl']}',
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
                                                          list['modelName'],
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                              fontSize: ScreenUtil.getInstance()
                                                                  .setSp(25),
                                                              color: Color(0xff3D2F1B)),
                                                        )),
                                                    Container(
                                                      child: Text(
                                                        '${list['todayPosts']}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil.getInstance().setSp(18),
                                                            color: Color(0xffB51610)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  child: Text(
                                                    list['modelDesc'],
                                                    style: TextStyle(
                                                        fontSize:
                                                            ScreenUtil.getInstance().setSp(22),
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
