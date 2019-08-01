import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DataBaseLegendaryGem extends StatefulWidget {
  final props;

  DataBaseLegendaryGem(this.props);

  @override
  _DataBaseLegendaryGemState createState() => _DataBaseLegendaryGemState();
}

class _DataBaseLegendaryGemState extends State<DataBaseLegendaryGem> with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  ScrollController _listController = ScrollController();

  bool flag = true;

  bool show = false;
  bool showEquip = true;

  List drop = ['世界掉落'];

  Map selectLegendaryGem = {};

  List legendaryGem = [
    {
      'image': 'ia_100002462.png',
      'name': '猩红灵魂碎片',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '这好像就是令人闻之色变的猩红灵魂石的一部分。但这不可能啊……那东西很久以前就被毁掉了。'
    },
    {
      'image': 'ia_100002633.png',
      'name': '闪耀冰晶',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story':
          '冒险者们曾经对一种能将敌人冻在原地的板条链甲赞叹不已。有个病怏怏的名叫钟逸洛的宝石匠人听见了这些传说，并决定要切割出一种有着同样效果的宝石。“我有自己的独门秘笈，等着瞧吧。”人们听到她这样喃喃自语。'
    },
    {
      'image': 'ia_100002769.png',
      'name': '波亚斯基的芯片',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story':
          '这块被称为“芯片”的宝石碎块，是一个叫波亚斯基的老头在一处地下密室中发现的。是他把这块碎片打磨成了如今这样一副美丽的珠宝。它会伤害那些试图谋害其主人的恶徒，而且一旦嵌进了镶孔，就再也不会掉落下来。'
    },
    {
      'image': 'ia_100002802.png',
      'name': '毁伤之御',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '果子山人氏周青设计了一种宝石，它可以将物理攻击所造成的痛楚感转移到一个秘密的地方。当被问起那些伤害都被转移到哪里去了时，她只是笑笑地说了一句“罪有应得、大快人心”。'
    },
    {
      'image': 'ia_100002870.png',
      'name': '受罚者之灾',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '在马萨伊尔落败后，学者迪亚德拉开始周游世界。她研究了仙塞的宝石切割技术，并将他们的秘诀带回了威斯特玛。受罚者之灾就是她在威斯特玛工作间里出品的第一块宝石。'
    },
    {
      'image': 'ia_100002938.png',
      'name': '火牛羚砂囊',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '如果将火牛羚的砂囊放进调配得当的炼金术试剂中，会激发出极不寻常的属性，因此这种动物在很久之前就被猎杀得灭绝了。'
    },
    {
      'image': 'ia_100002972.png',
      'name': '转煞秘石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '仙塞人氏传阳君设计了一种宝石，它可以将魔法能量从目标身上转移到他的死对头—周青的工坊中。他在神秘地失踪前，制造了若干颗此宝石。'
    },
    {
      'image': 'ia_100003560.png',
      'name': '太极石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '“只要能量足够，任何人都拥有无穷的可能性。”—高阶祭司贝伊科'
    },
    {
      'image': 'ia_100003595.png',
      'name': '囤宝者的恩惠',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '“据说有一位贪婪的女王派手下去收集财宝，并给他们配备了镶有宝石的装备，以便捞到更多的珠宝。据说‘囤宝者的恩惠’就是这样一种宝石。”—阿卜杜·哈兹尔'
    },
    {
      'image': 'ia_100003697.png',
      'name': '至简之力',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '“拳练千遍，其功自见。”—女尊者莲·拉斯姆森'
    },
    {
      'image': 'ia_100003823.png',
      'name': '贼神的复仇之石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '传说这颗宝石是贼神所制，用于折磨逃跑的敌人。但又有其它的传说声称贼神从未存在过。'
    },
    {
      'image': 'ia_100003895.png',
      'name': '免死宝石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '艾葛罗德的群峰之中，时常可以发现宝石。据说这些宝石发出的和谐音律能在战斗中阻挡死亡的到来。'
    },
    {
      'image': 'ia_100004326.png',
      'name': '侍从宝石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '这颗宝石的核心拥有强大的力量，能与主人的追随者分享。'
    },
    {
      'image': 'ia_100004395.png',
      'name': '活力宝石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story':
          '“有人说这块石头的力量源自于其主人的生命力，每次使用都会折损使用者的寿命。但在我看来，只要能从战场上活下来就足够了，明天的事还是留给明天去操心吧。”—著名战士勒纳拉斯在其过世的前一天如是说'
    },
    {
      'image': 'ia_100004463.png',
      'name': '迅捷勾玉',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '“你不用比敌人强壮，只要身心敏捷即可。”—善德女王'
    },
    {
      'image': 'ia_100004497.png',
      'name': '银河，织星者之泪',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story':
          '“相传，有一对情人每一年就会来到银河的两岸一次。无数的喜鹊会筑起一道鹊桥，好让两人可以相会。别离的时候，他们的泪水会洒满大地。这颗银河宝石就是他们的泪水。蕴藏其中的悲伤与愤怒，只会影响宝石周围的人。”—学者黄素珍'
    },
    {
      'image': 'ia_100004565.png',
      'name': '增痛宝石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '仙塞岛最美丽的宝石工匠香宜制作了这颗珠宝，以纪念她的前任恋人。她越是生气，工作的速度就越快，所以这颗宝石一下子就做好了。直到她测试了宝石的实际效果之后，她的怒气才消。'
    },
    {
      'image': 'ia_100004599.png',
      'name': '剧毒宝石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '仙塞的制毒师们都在传，有个病怏怏的名叫钟逸洛的宝石匠人，他会跑到制毒师的工作室里大喊“总有一天我会让你们所有人都失业！我说到做到！”'
    },
    {
      'image': 'ia_100004669.png',
      'name': '闪电华冠',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story':
          '疯女人艾瑞阿妮认为她能切出一块宝石，给她编织一顶用闪电形成的帽子。“闪电啊，”有人听到她在喃喃自语“降临我的头顶！”数周后人们发现了她的尸体，头发没了，手里还握着这颗宝石。'
    },
    {
      'image': 'ia_100004740.png',
      'name': '自在宝石',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '这颗闪烁着微光的宝石，能激发起人实现远大抱负的理想。'
    },
    {
      'image': 'ia_300002064.png',
      'name': '困者之灾',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '涂德琴女士委托仙塞工坊制作了这颗宝石，她说“我要我的目标昏睡或醉倒。实在办不到的话，动作迟缓也行。”'
    },
    {
      'image': 'ia_300002099.png',
      'name': '强者之灾',
      'drop': 0,
      'level': 1,
      'equip_level': 1,
      'story': '“没有什么能比眼见强大的敌人死在自己脚下更激励人心。”—仙塞宝石名匠，安多米尔·楚'
    },
  ];

  @override
  void initState() {
    super.initState();
    _ajax();
    _listController.addListener(() {
      setState(() {
        show = (200 < _listController.offset) ? true : false;
      });
    });
  }

  _ajax() async {
    await Future.delayed(Duration(seconds: 1), () {
      if (mounted)
        setState(() {
          flag = false;
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    _listController.dispose();
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
          title: Text('传奇宝石',
              style: TextStyle(
                color: Color(0xffFFDF8E),
              )),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(
                    left: ScreenUtil.getInstance().setWidth(20),
                    right: ScreenUtil.getInstance().setWidth(20)),
                child: Center(
                  child: Text('搜索', style: TextStyle(color: Color(0xffFFDF8E), fontSize: 20)),
                ))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              color: Color(0xffE8DAC5),
              image: DecorationImage(
                  image: AssetImage('images/fragment_tools_bg.jpg'), fit: BoxFit.fill)),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                  left: 0,
                  top: 0,
                  height: height - MediaQuery.of(context).padding.top - 56,
                  width: width,
                  child: Container(
                    child: flag
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
                                    color: Color(0xff938373),
                                    fontSize: ScreenUtil.getInstance().setSp(23)),
                              )
                            ],
                          ))
                        : SmartRefresher(
                            controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
                            onRefresh: () async {
                              _loading();
                              await Future.delayed(Duration(milliseconds: 2000));
                              if (mounted) setState(() {});
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
                                    children: <Widget>[
                                      CupertinoActivityIndicator(),
                                      Text('   载入中...')
                                    ],
                                  );
                                } else if (mode == LoadStatus.loading) {
                                  body = Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      CupertinoActivityIndicator(),
                                      Text('   载入中...')
                                    ],
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
                              print('onLoading');
                              await Future.delayed(Duration(milliseconds: 2000));
                              // if failed,use loadFailed(),if no data return,use LoadNodata()
                              if (mounted) setState(() {});
                              _refreshController.loadComplete();
                            },
                            child: ListView(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil.getInstance().setWidth(24),
                                  right: ScreenUtil.getInstance().setWidth(24)),
                              children: legendaryGem.map<Widget>((item) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showEquip = false;
                                      selectLegendaryGem = item;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil.getInstance().setHeight(24)),
                                    decoration: BoxDecoration(
                                        color: Color(0xffE3D4BF),
                                        border: Border.all(
                                            color: Color(0xffB5A88E),
                                            width: ScreenUtil.getInstance().setWidth(1)),
                                        borderRadius: BorderRadius.all(Radius.circular(6))),
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(24),
                                        top: ScreenUtil.getInstance().setWidth(24),
                                        right: ScreenUtil.getInstance().setWidth(24),
                                        bottom: ScreenUtil.getInstance().setWidth(24)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage('images/gem_icon_bg.png'))),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil.getInstance().setWidth(12)),
                                          width: ScreenUtil.getInstance().setWidth(84),
                                          height: ScreenUtil.getInstance().setHeight(84),
                                          child: Image.asset(
                                            'legendarygem/${item['image']}',
//                                              fit: BoxFit.fill,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${item['name']}',
                                                      style: TextStyle(
                                                          color: Color(0xff3D2F1B),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(30)),
                                                    ),
                                                    Container(
                                                      width: ScreenUtil.getInstance().setWidth(10),
                                                    ),
                                                    Text('${drop[item['drop']]}',
                                                        style: TextStyle(
                                                            color: Color(0xff9B8C73),
                                                            fontSize: ScreenUtil.getInstance()
                                                                .setSp(26))),
                                                  ],
                                                ),
                                                Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '物品等级·${item['level']}',
                                                      style: TextStyle(
                                                          color: Color(0xff9B8C73),
                                                          fontSize:
                                                              ScreenUtil.getInstance().setSp(26)),
                                                    ),
                                                    Container(
                                                      width: ScreenUtil.getInstance().setWidth(10),
                                                    ),
                                                    Text('装备等级·${item['equip_level']}',
                                                        style: TextStyle(
                                                            color: Color(0xff9B8C73),
                                                            fontSize: ScreenUtil.getInstance()
                                                                .setSp(26))),
                                                  ],
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  )),
              Positioned(
                  left: 0,
                  top: 0,
                  width: width,
                  height: height - MediaQuery.of(context).padding.top - 56,
                  child: Offstage(
                    offstage: showEquip,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showEquip = true;
                        });
                      },
                      child: Container(
                        color: Color(0x99000000),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 56 + ScreenUtil.getInstance().setHeight(20),
                              bottom: ScreenUtil.getInstance().setHeight(146),
                              left: ScreenUtil.getInstance().setWidth(70),
                              right: ScreenUtil.getInstance().setWidth(70)),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff1C1B19),
                                  width: ScreenUtil.getInstance().setWidth(1)),
                              color: Color(0xff000000)),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: ScreenUtil.getInstance().setHeight(52),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage('images/tooltip-title5.png'))),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      child: Center(
                                        child: Text(
                                          '${selectLegendaryGem['name']}',
                                          style: TextStyle(
                                              color: Color(0xffAE5A2A),
                                              fontSize: ScreenUtil.getInstance().setSp(24)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: ScreenUtil.getInstance().setWidth(24),
                                        top: ScreenUtil.getInstance().setHeight(10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showEquip = true;
                                            });
                                          },
                                          child: Image.asset(
                                            'images/equipment_detail_close.png',
                                            width: ScreenUtil.getInstance().setWidth(32),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(ScreenUtil.getInstance().setWidth(20)),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: ScreenUtil.getInstance().setWidth(87),
                                          height: ScreenUtil.getInstance().setWidth(166),
                                          margin: EdgeInsets.only(
                                              right: ScreenUtil.getInstance().setWidth(12)),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffB07B38),
                                                  width: ScreenUtil.getInstance().setWidth(2)),
                                              borderRadius: BorderRadius.all(Radius.circular(6)),
                                              image: DecorationImage(
                                                  image: AssetImage('images/bg3.png'))),
                                          child: Image.asset(
                                              'legendarygem/${selectLegendaryGem['image']}'),
                                        ),
                                        Expanded(
                                            child: Container(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setHeight(14)),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                '传奇 宝石',
                                                style: TextStyle(
                                                    color: Color(0xff874621),
                                                    fontSize: ScreenUtil.getInstance().setSp(16)),
                                              ),
                                              Container(
                                                height: ScreenUtil.getInstance().setHeight(24),
                                              ),
//                                                  RichText(
//                                                      text: TextSpan(children: <TextSpan>[
//                                                        TextSpan(
//                                                          text: '${equipMsg['dps']}',
//                                                          style: TextStyle(
//                                                              color: Colors.white,
//                                                              fontSize: ScreenUtil.getInstance().setSp(16)),
//                                                        ),
//                                                        TextSpan(
//                                                          text: '伤害/秒',
//                                                          style: TextStyle(
//                                                              color: Color(0xff8A8A8A),
//                                                              fontSize: ScreenUtil.getInstance().setSp(16)),
//                                                        ),
//                                                      ])),
                                            ],
                                          ),
                                        )),
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil.getInstance().setHeight(24)),
                                          child: Text(
                                            '宝石',
                                            style: TextStyle(
                                                color: Color(0xff8A8A8A),
                                                fontSize: ScreenUtil.getInstance().setSp(16)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      bottom: ScreenUtil.getInstance().setWidth(12),
                                      left: ScreenUtil.getInstance().setWidth(20),
                                      right: ScreenUtil.getInstance().setWidth(20),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          'images/icons_primary.gif',
                                          width: ScreenUtil.getInstance().setWidth(12),
                                        ),
                                        Container(
                                          width: ScreenUtil.getInstance().setWidth(12),
                                        ),
                                        Text(
                                          '传奇宝石',
                                          style: TextStyle(
                                              color: Color(0xff874621),
                                              fontSize: ScreenUtil.getInstance().setSp(16)),
                                        ),
//                                        Text(
//                                          '(${equipMsg['legeffects_value']}%)',
//                                          style: TextStyle(
//                                              color: Color(0xff874621),
//                                              fontSize: ScreenUtil.getInstance().setSp(16)),
//                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(20),
                                        right: ScreenUtil.getInstance().setWidth(20),
                                        bottom: ScreenUtil.getInstance().setHeight(12)),
                                    child: Row(
                                      children: <Widget>[
                                        Image.asset(
                                          'images/icons_primary.gif',
                                          width: ScreenUtil.getInstance().setWidth(12),
                                        ),
                                        Container(
                                          width: ScreenUtil.getInstance().setWidth(12),
                                        ),
                                        Text(
                                          '可能有以下7个魔法属性中的一个',
                                          style: TextStyle(
                                              color: Color(0xff874621),
                                              fontSize: ScreenUtil.getInstance().setSp(16)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(20),
                                        right: ScreenUtil.getInstance().setWidth(20),
                                        bottom: ScreenUtil.getInstance().setHeight(12)),
                                    child: Text(
                                      '需要等级 ${selectLegendaryGem['level']}',
                                      style: TextStyle(
                                          color: Color(0xffC7B377),
                                          fontSize: ScreenUtil.getInstance().setSp(16)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(20),
                                        right: ScreenUtil.getInstance().setWidth(20),
                                        bottom: ScreenUtil.getInstance().setHeight(12)),
                                    child: Text(
                                      'ilvl：${selectLegendaryGem['level']}',
                                      style: TextStyle(
                                          color: Color(0xffC7B377),
                                          fontSize: ScreenUtil.getInstance().setSp(16)),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: ScreenUtil.getInstance().setWidth(20),
                                        right: ScreenUtil.getInstance().setWidth(20),
                                        bottom: ScreenUtil.getInstance().setHeight(12)),
                                    child: Text(
                                      '${selectLegendaryGem['story']}',
                                      style: TextStyle(
                                          color: Color(0xffC7B377),
                                          fontSize: ScreenUtil.getInstance().setSp(16)),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
