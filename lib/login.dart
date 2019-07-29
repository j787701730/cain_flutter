import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  String loginName = '';
  String password = '';

  FocusNode _loginFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _loginFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ScreenUtil.instance = ScreenUtil(width: 640, height: 1136)..init(context);
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffE8DAC5),
          image: DecorationImage(
              alignment: Alignment.topCenter, image: AssetImage('images/title_bar_bg.jpg'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(
//                left: ScreenUtil.getInstance().setWidth(24),
//                right: ScreenUtil.getInstance().setWidth(24),
                  ),
              child: Center(
                child: Image.asset(
                  'images/back.png',
                  width: ScreenUtil.getInstance().setWidth(30),
                ),
              ),
            ),
          ),
          title: Text('登录', style: TextStyle(color: Color(0xffFFDF8E))),
          // type: 1=> 帖子 0 => 其他
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().setWidth(20),
                    right: ScreenUtil.getInstance().setWidth(20)),
                child: Center(
                  child: Text('安全中心', style: TextStyle(color: Color(0xffFFDF8E), fontSize: 20)),
                ))
          ],
        ),
        body: GestureDetector(
          onTap: () {
            _loginFocusNode.unfocus();
            _passwordFocusNode.unfocus();
          },
          child: Container(
            color: Color(0xffE8DAC5),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setWidth(84),
                      left: ScreenUtil.getInstance().setWidth(50),
                      right: ScreenUtil.getInstance().setWidth(50)),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xffB5A88E), width: ScreenUtil.getInstance().setWidth(1)),
                      color: Color(0xffD9CBB5),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  height: ScreenUtil.getInstance().setHeight(84),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil.getInstance().setWidth(68),
                        child: Center(
                          child: Image.asset('images/icon_login_account.png'),
                        ),
                      ),
                      Container(
                        height: ScreenUtil.getInstance().setHeight(52),
                        width: ScreenUtil.getInstance().setWidth(1),
                        margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(14)),
                        color: Color(0xff6A5C41),
                      ),
                      Expanded(
                          flex: 1,
                          child: TextField(
                            focusNode: _loginFocusNode,
                            controller: TextEditingController.fromValue(TextEditingValue(
                                // 设置内容
                                text: '$loginName',
                                selection: TextSelection.fromPosition(TextPosition(
                                    affinity: TextAffinity.downstream, offset: '$loginName'.length))
                                // 保持光标在最后
                                )),
                            decoration: InputDecoration(
                                hintText: '网易邮箱或手机号',
                                hintStyle: TextStyle(
                                  color: Color(0xff766D5A),
                                  fontSize: ScreenUtil.getInstance().setSp(25),
                                ),
                                border: InputBorder.none),
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                loginName = val;
                              });
                            },
                            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(25)),
                          )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            loginName = '';
                          });
                        },
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(50),
                          child: Offstage(
                            offstage: loginName == '',
                            child: Image.asset(
                              'images/img_pgsearch_close.png',
                              width: ScreenUtil.getInstance().setWidth(24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setWidth(36),
                      left: ScreenUtil.getInstance().setWidth(50),
                      right: ScreenUtil.getInstance().setWidth(50)),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xffB5A88E), width: ScreenUtil.getInstance().setWidth(1)),
                      color: Color(0xffD9CBB5),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  height: ScreenUtil.getInstance().setHeight(84),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenUtil.getInstance().setWidth(68),
                        child: Center(
                          child: Image.asset('images/icon_login_password.png'),
                        ),
                      ),
                      Container(
                        height: ScreenUtil.getInstance().setHeight(52),
                        width: ScreenUtil.getInstance().setWidth(1),
                        margin: EdgeInsets.only(right: ScreenUtil.getInstance().setWidth(14)),
                        color: Color(0xff6A5C41),
                      ),
                      Expanded(
                          flex: 1,
                          child: TextField(
                            focusNode: _passwordFocusNode,
                            controller: TextEditingController.fromValue(TextEditingValue(
                                // 设置内容
                                text: '$password',
                                selection: TextSelection.fromPosition(TextPosition(
                                    affinity: TextAffinity.downstream, offset: '$password'.length))
                                // 保持光标在最后
                                )),
                            decoration: InputDecoration(
                                hintText: '密码',
                                hintStyle: TextStyle(
                                  color: Color(0xff766D5A),
                                  fontSize: ScreenUtil.getInstance().setSp(25),
                                ),
                                border: InputBorder.none),
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                password = val;
                              });
                            },
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(25)),
                          )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            password = '';
                          });
                        },
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(50),
                          child: Offstage(
                            offstage: password == '',
                            child: Image.asset(
                              'images/img_pgsearch_close.png',
                              width: ScreenUtil.getInstance().setWidth(24),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Toast.show('忘记密码', context, gravity: Toast.CENTER);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              right: ScreenUtil.getInstance().setWidth(10),
                              left: ScreenUtil.getInstance().setWidth(10)),
                          child: Offstage(
                            offstage: false,
                            child: Text(
                              '忘记密码',
                              style: TextStyle(
                                  color: Color(0xffE79222),
                                  fontSize: ScreenUtil.getInstance().setSp(22)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _loginFocusNode.unfocus();
                    _passwordFocusNode.unfocus();
                    if (loginName == '') {
                      Toast.show('请输入账号', context, gravity: Toast.CENTER);
                    }
                    if (password == '') {
                      Toast.show('请输入密码', context, gravity: Toast.CENTER);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil.getInstance().setWidth(84),
                        left: ScreenUtil.getInstance().setWidth(84),
                        right: ScreenUtil.getInstance().setWidth(84)),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xffA89A84), width: ScreenUtil.getInstance().setWidth(1)),
                        color: Color(0xffCF786A),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    height: ScreenUtil.getInstance().setHeight(84),
                    child: Center(
                      child: Text(
                        '登录',
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance().setSp(34), color: Color(0xffF4DA9C)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: ScreenUtil.getInstance().setWidth(14),
                      left: ScreenUtil.getInstance().setWidth(84),
                      right: ScreenUtil.getInstance().setWidth(84)),
                  child: Center(
                    child: Text(
                      '注册网易邮箱账号',
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().setSp(22), color: Color(0xffE79222)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
