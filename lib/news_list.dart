import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';

class NewsList extends StatefulWidget {
  final page;

  NewsList(this.page);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List news = [
    {
      'imgs': [
        'new1_1',
        'new1_2',
        'new1_3',
      ],
      'title': 'App 1.6.2版本上线：模拟器迭代与太古装备展示',
      'type': '1', // 1 帖子, 0 无
      'show': '3', // 3 三列, 2 右图, 1 全图
      'author': '秋仲琉璃子不语',
      'source': '新崔斯特姆',
      'num': 119
    },
    {
      'imgs': [
        'new2',
      ],
      'title': '卡达拉的传奇装备回收计划第十六期',
      'type': '1', // 1 帖子, 0 无
      'show': '2', // 3 三列, 2 右图, 1 全图
      'author': '卡达拉',
      'source': '',
      'num': 22
    },
    {
      'imgs': [
        'new3_1',
        'new3_2',
        'new3_3',
      ],
      'title': '十七赛季国服天梯观察：一骑绝尘棒棒糖，5分通关双黑奥',
      'type': '1', // 1 帖子, 0 无
      'show': '3', // 3 三列, 2 右图, 1 全图
      'author': 'mediumdog',
      'source': '新崔斯特姆',
      'num': 119
    },
    {
      'imgs': [
        'new4',
      ],
      'title': '暗黑讲堂vol.3录像回顾：挑战失败的原因就是漏球！',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '卡达拉',
      'source': '',
      'num': 221
    },
    {
      'imgs': [
        'new5',
      ],
      'title': '暴雪联合创始人Frank Pearce离职，挥别28年暴雪生涯',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '卡达拉',
      'source': '不朽之地',
      'num': 221
    },
    {
      'imgs': [
        'new6',
      ],
      'title': '天下第一又来了：猎魔人火多重120层实战视频分享',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '卡光贼溜的萌新',
      'source': '探险者工会',
      'num': 221
    },
    {
      'imgs': [
        'new7',
      ],
      'title': 'Diablo传说·诅咒宝石：崔斯特姆旧事提（上）',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '克里斯勇度',
      'source': '',
      'num': 21
    },
    {
      'imgs': [
        'new8',
      ],
      'title': '84秒116层！死灵法师魂法队极限速刷展示',
      'type': '0', // 1 帖子, 0 无
      'show': '1', // 3 三列, 2 右图, 1 全图
      'author': '千年小啊黎',
      'source': '',
      'num': 221
    },
  ];
  List temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    temp = jsonDecode(jsonEncode(news));
  }

  @override
  void didUpdateWidget(NewsList oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.page < widget.page) {
      setState(() {
        news.addAll(temp);
      });
    }
  }

  _title(item) {
    return item['type'] == '1'
        ? RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                  text: ' 帖子 ',
                  style: TextStyle(
                      color: Color(0xff6A5C41),
                      backgroundColor: Color(0xffCABDA4),
                      fontSize: ScreenUtil.getInstance().setSp(22),
                      fontFamily: 'SourceHanSansCN')),
              TextSpan(
                text: '  ${item['title']}',
                style: TextStyle(
                  color: Color(0xff3F311D),
                  fontSize: ScreenUtil.getInstance().setSp(30),
                  fontFamily: 'SourceHanSansCN',
                ),
              )
            ]),
          )
        : RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(children: <TextSpan>[
              TextSpan(
                text: '${item['title']}',
                style: TextStyle(
                  color: Color(0xff3F311D),
                  fontSize: ScreenUtil.getInstance().setSp(30),
                  fontFamily: 'SourceHanSansCN',
                ),
              )
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: news.map<Widget>((item) {
        return Container(
          margin: EdgeInsets.only(
            left: ScreenUtil.getInstance().setWidth(24),
            right: ScreenUtil.getInstance().setWidth(24),
          ),
          padding: EdgeInsets.only(
              top: ScreenUtil.getInstance().setHeight(36),
              bottom: ScreenUtil.getInstance().setHeight(36)),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Color(0xffC9BBA4), width: ScreenUtil.getInstance().setWidth(1)))),
          child: item['show'] == '2'
              ? Container(
                  height: ScreenUtil.getInstance().setHeight(60.0 + 86),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(30)),
                            child: Column(
                              children: <Widget>[
                                _title(item),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.getInstance().setHeight(24)),
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
                                                fontSize: ScreenUtil.getInstance().setSp(22),
                                                color: Color(0xffBDB096)),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: ScreenUtil.getInstance().setHeight(24)),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.asset(
                                            'images/ic_news_list_comment.png',
                                            width: ScreenUtil.getInstance().setWidth(24),
                                          ),
                                          Container(
                                            width: ScreenUtil.getInstance().setWidth(6),
                                          ),
                                          Text('${item['num']}评论',
                                              style: TextStyle(
                                                  fontSize: ScreenUtil.getInstance().setSp(22),
                                                  color: Color(0xffBDB096)))
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6.0),
                              child: Image.asset(
                                'images/${item['imgs'][0]}.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _title(item),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: item['imgs'].map<Widget>((img) {
                        return Container(
                          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(10)),
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
                          width: item['imgs'].length == 3
                              ? (width - ScreenUtil.getInstance().setWidth(72)) / 3
                              : width - ScreenUtil.getInstance().setWidth(48),
                          height: item['imgs'].length == 3
                              ? ScreenUtil.getInstance().setWidth(120)
                              : ScreenUtil.getInstance().setHeight(240),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6.0),
                            child: Image.asset(
                              'images/$img.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(10)),
                          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(24)),
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
                                    fontSize: ScreenUtil.getInstance().setSp(22),
                                    color: Color(0xffBDB096)),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(24)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'images/ic_news_list_comment.png',
                                width: ScreenUtil.getInstance().setWidth(24),
                              ),
                              Container(
                                width: ScreenUtil.getInstance().setWidth(6),
                              ),
                              Text('${item['num']}评论',
                                  style: TextStyle(
                                      fontSize: ScreenUtil.getInstance().setSp(22),
                                      color: Color(0xffBDB096)))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
        );
      }).toList(),
    );
  }
}
