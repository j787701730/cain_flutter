import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'news_content.dart';

class NewsList extends StatefulWidget {
  final news;

  NewsList(this.news);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  void initState() {
    super.initState();
  }

  _title(item) {
    return item['category'] == '2'
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
      children: widget.news.map<Widget>((item) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new NewsContent({'type': '${item['category']}'})),
              );
            },
            child: Container(
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
              child: item['listStyle'] == '1' || item['listStyle'] == '5'
                  ? Container(
                      height: ScreenUtil.getInstance().setHeight(60.0 + 86),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: Container(
                                padding:
                                    EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(30)),
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
                                                item['authorName'],
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
                                              Text('${item['sns']['commentCount']}评论',
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
                                  child: Image.network(
                                    '${item['imgList'][0]}',
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
                        item['listStyle'] == '3' || item['listStyle'] == '6'
                            ? Row(
                                // 大图
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil.getInstance().setHeight(10)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    width: width - ScreenUtil.getInstance().setWidth(48),
                                    height: ScreenUtil.getInstance().setHeight(240),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.network(
                                        item['imgList'][0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                // 3图
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: item['imgList'].map<Widget>((img) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil.getInstance().setHeight(10)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    width: (width - ScreenUtil.getInstance().setWidth(72)) / 3,
                                    height: ScreenUtil.getInstance().setWidth(120),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.network(
                                        '$img',
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
                                    item['authorName'],
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
                                  Text('${item['sns']['commentCount']}评论',
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
            ));
      }).toList(),
    );
  }
}
