import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class My extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  List sets = [
    {'name': '我的符文', 'icon': 'icon_pgmy_post', 'id': 1},
    {'name': '我的收藏', 'icon': 'icon_pgmy_record', 'id': 2},
    {'name': '社区帖子', 'icon': 'icon_pgmy_comment', 'id': 3},
    {'name': '文章跟帖', 'icon': 'icon_pgmy_message', 'id': 4},
    {'name': '浏览记录', 'icon': 'icon_pgmy_save', 'id': 5},
    {'name': '设置', 'icon': 'icon_pgmy1_set', 'id': 6},
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil.getInstance().setWidth(65),
                  right: ScreenUtil.getInstance().setWidth(30)),
              alignment: Alignment.topRight,
              child: Image.asset(
                'images/my_message.png',
                height: ScreenUtil.getInstance().setHeight(44),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(24)),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/default_avatar.png',
                    width: ScreenUtil.getInstance().setWidth(130),
                  ),
                  Container(
                    width: ScreenUtil.getInstance().setWidth(24),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '点击登录',
                        style: TextStyle(
                            color: Color(0xffF5DA9C), fontSize: ScreenUtil.getInstance().setSp(34)),
                      ),
                      Container(
                        height: ScreenUtil.getInstance().setWidth(30),
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'images/img_medal_add.png',
                            width: ScreenUtil.getInstance().setWidth(36),
                          ),
                          Container(
                            width: ScreenUtil.getInstance().setWidth(12),
                          ),
                          Image.asset('images/img_medal_add.png',
                              width: ScreenUtil.getInstance().setWidth(36)),
                          Container(
                            width: ScreenUtil.getInstance().setWidth(12),
                          ),
                          Image.asset('images/img_medal_add.png',
                              width: ScreenUtil.getInstance().setWidth(36)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(30)),
              height: width / 1092 * 216,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('images/mine_hero_unbind_bg.png'))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(60)),
                    child: Text(
                      '个人英雄榜',
                      style: TextStyle(
                          color: Color(0xff3D2F1B), fontSize: ScreenUtil.getInstance().setSp(26)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(54)),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '请先登录   ',
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance().setWidth(22),
                              color: Color(0xffB5A88E)),
                        ),
                        Image.asset(
                          'images/next_right.png',
                          width: ScreenUtil.getInstance().setWidth(30),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/fragment_tools_bg.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter)),
              child: Column(
                children: sets.map<Widget>((item) {
                  return Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil.getInstance().setWidth(24),
                      right: ScreenUtil.getInstance().setWidth(24),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(20)),
                          child: Image.asset(
                            'images/${item['icon']}.png',
                            width: ScreenUtil.getInstance().setWidth(44),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.only(
                              top: ScreenUtil.getInstance().setWidth(20),
                              bottom: ScreenUtil.getInstance().setWidth(20)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xffC9BBA4),
                                      width: ScreenUtil.getInstance().setWidth(1)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '${item['name']}',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: ScreenUtil.getInstance().setSp(30)),
                              ),
                              Image.asset(
                                'images/next_right.png',
                                width: ScreenUtil.getInstance().setWidth(30),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
                }).toList(),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
