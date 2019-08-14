import 'dart:convert';

import 'package:cain_flutter/ProviderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'news_content.dart';
import 'news_list.dart';
import 'util.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController();

  AnimationController animationLoadingController;
  Animation animationLoading;

  List banner = [
    {
      "imageName": "暗黑3社区经理：17赛季将于8月18日结束",
      "redirectTo": 2,
      "redirectData": "173765140",
      "expireBeginTime": 1563171600000,
      "expireEndTime": 1565557560000,
      "showTime": 3,
      "imgUrl": "https://ok.166.net/cain-corner/post/2019-08-09/1565357709187_uonewt.jpg"
    },
    {
      "imageName": "壁纸分享：前路漫漫，求索的圣教军们",
      "redirectTo": 1,
      "redirectData": "147840",
      "expireBeginTime": 1563159000000,
      "expireEndTime": 1565837400000,
      "showTime": 3,
      "imgUrl": "https://ok.166.net/cain-corner/post/2019-08-09/1565354053822_1whvvp.jpg"
    },
    {
      "imageName": "2.6.6PTR开启：新赛季主题为三圣的意志",
      "redirectTo": 2,
      "redirectData": "173763020",
      "expireBeginTime": 1563180600000,
      "expireEndTime": 1565752260000,
      "showTime": 3,
      "imgUrl": "https://ok.166.net/cain-corner/post/2019-07-26/1564110173394_s0jtmt.jpg"
    },
    {
      "imageName": "预约暗黑手游 领取凯恩之角20周年专属奖励",
      "redirectTo": 3,
      "redirectData": "http://d.163.com/d163com/s/reservation",
      "expireBeginTime": 1541260800000,
      "expireEndTime": 1556557260000,
      "showTime": 6,
      "imgUrl": "https://ok.166.net/cain-corner/post/2018-11-04/1541262631121_627sng.jpg"
    }
  ];
  int page = 0;
  bool flag = true;

  List news = [
    {
      "id": 147870,
      "title": "从玩家的角度，谈谈“暗黑3需要做些什么”",
      "tips": "",
      "category": 1,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-14/1565755634582_souehw.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "秋仲琉璃子不语",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "秋仲琉璃子不语",
      "publishTime": 1565755200000,
      "sns": {"likeCount": 28, "commentCount": 34},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147868,
      "title": "社区经理讲述暗黑3未来：每个职业都有新套装",
      "tips": "",
      "category": 1,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-14/1565749082177_im1g4i.jpg",
        "",
        ""
      ],
      "listStyle": "3",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "秋仲琉璃子不语",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "秋仲琉璃子不语",
      "publishTime": 1565749860000,
      "sns": {"likeCount": 65, "commentCount": 82},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147869,
      "title": "由黑德里格锻造的游戏内“毕业神装”，你见过么？",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-14/1565749842382_xwpoll.png",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "薇薇安穷",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "薇薇安穷",
      "publishTime": 1565748600000,
      "sns": {"likeCount": 0, "commentCount": 23},
      "tid": "173767339",
      "fname": "新崔斯特姆",
      "replies": 23,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147867,
      "title": "游戏币换现金！？拍卖行时代的暗黑破坏神3",
      "tips": "",
      "category": 1,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-13/1565702309035_7uucsr.jpg",
        "",
        ""
      ],
      "listStyle": "3",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "秋仲琉璃子不语",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "秋仲琉璃子不语",
      "publishTime": 1565701800000,
      "sns": {"likeCount": 39, "commentCount": 52},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147866,
      "title": "八枚太古黄道，凑齐两个炸弹，可惜还是没用",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-13/1565692334992_nx4piz.png",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "且疯且癫且糊涂",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "且疯且癫且糊涂",
      "publishTime": 1565692200000,
      "sns": {"likeCount": 0, "commentCount": 51},
      "tid": "173767299",
      "fname": "新崔斯特姆",
      "replies": 51,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147865,
      "title": "每周话题：如果暗黑3也有怀旧服",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-13/1565676496778_qlvrlo.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "禅仙雪隐",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "禅仙雪隐",
      "publishTime": 1565676000000,
      "sns": {"likeCount": 0, "commentCount": 170},
      "tid": "173767246",
      "fname": "新崔斯特姆",
      "replies": 170,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147864,
      "title": "国服挑战秘境第112期：画蛇添足散件飞盾圣教军",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-13/1565663293981_ilfflf.png",
        "https://ok.166.net/cain-corner/post/2019-08-13/1565663294115_vwlfah.png",
        "https://ok.166.net/cain-corner/post/2019-08-13/1565663294248_g0xm5g.png"
      ],
      "listStyle": "2",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "秋仲琉璃子不语",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "秋仲琉璃子不语",
      "publishTime": 1565662800000,
      "sns": {"likeCount": 0, "commentCount": 49},
      "tid": "173767239",
      "fname": "新崔斯特姆",
      "replies": 49,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147863,
      "title": "《暗黑破坏神II》可能不会被高清重制",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-12/1565594891536_hkb11c.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "凯恩二世",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "凯恩二世",
      "publishTime": 1565594700000,
      "sns": {"likeCount": 0, "commentCount": 93},
      "tid": "173767112",
      "fname": "暗黑破坏神X",
      "replies": 93,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147862,
      "title": "极限通关：四人150层大秘境通关终极时间？",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-12/1565580692794_xjj93b.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "乜名",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "乜名",
      "publishTime": 1565580300000,
      "sns": {"likeCount": 0, "commentCount": 51},
      "tid": "173767035",
      "fname": "新崔斯特姆",
      "replies": 51,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147861,
      "title": "137层世界第一！蟹老板赛季圣教军单人飞盾秀",
      "tips": "",
      "category": 1,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-12/1565578589349_s9gfuf.jpg",
        "",
        ""
      ],
      "listStyle": "5",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "夜叶",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "夜叶",
      "publishTime": 1565577000000,
      "sns": {"likeCount": 18, "commentCount": 22},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147860,
      "title": "外媒知名编辑爆料：暗黑4最早将于2021年发售",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-07-03/1562140668451_khn19z.png",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "凯恩二世",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "凯恩二世",
      "publishTime": 1565501400000,
      "sns": {"likeCount": 0, "commentCount": 153},
      "tid": "173766890",
      "fname": "暗黑破坏神X",
      "replies": 153,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147859,
      "title": "动视暴雪Q2财报解读：继续强调对暗黑的投入",
      "tips": "",
      "category": 1,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-09/1565349111315_k6yjgk.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 177006,
        "nickname": "雪暴君",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=340145&size=big",
        "discuzUid": "340145",
        "groupId": 2,
        "authorName": "雪暴君",
        "title": "知名舅舅",
        "showMedalId": "-1",
        "showMedals": []
      },
      "authorId": 177006,
      "authorName": "雪暴君",
      "publishTime": 1565348400000,
      "sns": {"likeCount": 85, "commentCount": 63},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147858,
      "title": "荆棘死灵辅助蛮双人150层心得分享",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-09/1565332850627_jhac1m.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "牧者小天",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "牧者小天",
      "publishTime": 1565332200000,
      "sns": {"likeCount": 0, "commentCount": 43},
      "tid": "173766131",
      "fname": "暗影王国",
      "replies": 43,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147857,
      "title": "动视暴雪2019Q2财报：将加快制作新内容",
      "tips": "",
      "category": 1,
      "imgList": [
        "http://bbs-f.d.163.com/forum/201905/03/072410uvt070lzmmoa8pha.jpg.thumb.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "夜叶",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "夜叶",
      "publishTime": 1565323980000,
      "sns": {"likeCount": 60, "commentCount": 40},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147855,
      "title": "终于太古毕业了！还是两套绿色套装！",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-09/1565319067632_0xlyxm.png",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "智慧港光头男",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "智慧港光头男",
      "publishTime": 1565319000000,
      "sns": {"likeCount": 0, "commentCount": 79},
      "tid": "173766297",
      "fname": "新崔斯特姆",
      "replies": 79,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147856,
      "title": "蓝贴：十八赛季不会有类似银河之翼的赛季奖励",
      "tips": "",
      "category": 1,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-09/1565319590044_ct8dh2.png",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "夜叶",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "夜叶",
      "publishTime": 1565317200000,
      "sns": {"likeCount": 148, "commentCount": 87},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147854,
      "title": "凯恩之角死灵/法师版主招募，快来加入我们把！",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-05-06/1557130009006_luj3vv.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 141008,
        "nickname": "秋仲琉璃子不语",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=1849409&size=big",
        "discuzUid": "1849409",
        "groupId": 1,
        "authorName": "秋仲琉璃子不语",
        "title": "凯恩小编",
        "showMedalId": "55,23,269",
        "showMedals": [
          {"name": "珠宝大师", "image": "d3zhubao.gif", "description": "一颗蓝宝石", "medalid": "55"},
          {
            "name": "优秀版主",
            "image": "1604151644297ab31e2e0dd34492.gif",
            "description": "为人民服务",
            "medalid": "23"
          },
          {
            "name": "暗影之王",
            "image": "1707181611101f6a3935dcd4f409.gif",
            "description": "夺魂之镰死灵法师职业大师[3阶]",
            "medalid": "269"
          }
        ]
      },
      "authorId": 141008,
      "authorName": "秋仲琉璃子不语",
      "publishTime": 1565261400000,
      "sns": {"likeCount": 0, "commentCount": 48},
      "tid": "173766148",
      "fname": "暗影王国",
      "replies": 48,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147853,
      "title": "同人幻化：堪杜拉斯君王李奥瑞克",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-08/1565253274233_0vuxqb.jpg",
        "",
        ""
      ],
      "listStyle": "1",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "夜光灬蓝梦",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "夜光灬蓝梦",
      "publishTime": 1565253000000,
      "sns": {"likeCount": 0, "commentCount": 45},
      "tid": "173765756",
      "fname": "海德格铁匠铺",
      "replies": 45,
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147852,
      "title": "5分57秒！暗黑3赛季四人速刷150层实录",
      "tips": "",
      "category": 1,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-08/1565252392447_xnmcly.jpg",
        "",
        ""
      ],
      "listStyle": "5",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "夜叶",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "夜叶",
      "publishTime": 1565250000000,
      "sns": {"likeCount": 33, "commentCount": 56},
      "tid": "",
      "voteId": "",
      "photosId": ""
    },
    {
      "id": 147851,
      "title": "凯恩之角七夕活动：晒出给ta或自己的七夕礼物",
      "tips": "",
      "category": 2,
      "imgList": [
        "https://ok.166.net/cain-corner/post/2019-08-07/1565166208052_jjmtst.jpg",
        "",
        ""
      ],
      "listStyle": "3",
      "show": 1,
      "author": {
        "uid": 101055,
        "nickname": "夜叶",
        "avatar": "https://bbs-uc.d.163.com/avatar.php?uid=882345&size=big",
        "discuzUid": "882345",
        "groupId": 16,
        "authorName": "zhaosan2150",
        "title": "凯恩小编",
        "showMedalId": "177,262,158",
        "showMedals": [
          {"name": "暗黑3中国战网", "image": "d3china.gif", "description": "暗黑3国服纪念勋章", "medalid": "177"},
          {
            "name": "迪亚波罗",
            "image": "170123192643df159f9aca6efd5e.gif",
            "description": "暗黑二十周年活动绝版纪念勋章",
            "medalid": "262"
          },
          {"name": "HC达人", "image": "HC.gif", "description": "专家模式玩家", "medalid": "158"}
        ]
      },
      "authorId": 101055,
      "authorName": "zhaosan2150",
      "publishTime": 1565165400000,
      "sns": {"likeCount": 0, "commentCount": 215},
      "tid": "173766067",
      "fname": "山羊小丘酒馆",
      "replies": 215,
      "voteId": "",
      "photosId": ""
    }
  ];

  @override
  bool get wantKeepAlive => true;
  int startIndex = 0;

  @override
  void initState() {
    super.initState();
    _ajax();
    getBanner();
    getNews();
  }

  getBanner() {
    ajax(
        'https://cain-api.gameyw.netease.com/cain/app/queryImages?platform=0&imageType=1&version=1.6.2',
        (data) {
      if (mounted && data['code'] == 200) {
        setState(() {
          banner = data['data'];
        });
      }
    });
  }

  getNews() {
    ajax(
        'https://cain-api.gameyw.netease.com/cain/article/list?size=20&startIndex=${startIndex * 20}',
        (data) {
      if (mounted && data['code'] == 200) {
        if (startIndex == 0) {
          setState(() {
            news = data['list'];
          });
        } else {
          setState(() {
            news.addAll(data['list']);
          });
        }
      }
    });
  }

  _ajax() async {
    await Future.delayed(Duration(seconds: 2), () {
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
    precacheImage(AssetImage("images/head_loading1.png"), context);
    precacheImage(AssetImage("images/head_loading2.png"), context);
    precacheImage(AssetImage("images/head_loading3.png"), context);
    precacheImage(AssetImage("images/head_loading4.png"), context);
    precacheImage(AssetImage("images/head_loading5.png"), context);
    precacheImage(AssetImage("images/head_loading6.png"), context);
    precacheImage(AssetImage("images/head_loading7.png"), context);
    precacheImage(AssetImage("images/head_loading8.png"), context);
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
        child: flag
            ? Center(
                child: Image.asset(
                  'images/head_loading1.png',
                  width: ScreenUtil.getInstance().setWidth(78),
                ),
              )
            : SmartRefresher(
                controller: _refreshController,
//          onOffsetChange: _onOffsetChange,
                onRefresh: () async {
                  _loading();
                  await Future.delayed(Duration(milliseconds: 2000));
                  if (mounted)
                    setState(() {
                      startIndex = 0;
                      getNews();
                    });
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
                        children: <Widget>[CupertinoActivityIndicator(), Text('   载入中...')],
                      );
                    } else if (mode == LoadStatus.loading) {
                      body = Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[CupertinoActivityIndicator(), Text('   载入中...')],
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
                  await Future.delayed(Duration(milliseconds: 2000));
                  // if failed,use loadFailed(),if no data return,use LoadNodata()
                  if (mounted)
                    setState(() {
                      startIndex += 1;
                      getNews();
                    });
                  _refreshController.loadComplete();
                },
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: width / 700 * 320,
                      child: Swiper(
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Provider.of<ProviderModel>(context).changeTopBackground();
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new NewsContent({'type': '1'})),
                                  );
                                },
                                child: Image.network(
                                  "${banner[index]['imgUrl']}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned(
                                  bottom: 24,
                                  left: 10,
                                  width: width - 20,
                                  child: Text(
                                    banner[index]['imageName'],
                                    style: TextStyle(
                                        color: Color(0xffF5DA9C),
                                        fontSize: ScreenUtil.getInstance().setSp(30),
                                        fontFamily: 'SourceHanSansCN'),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ))
                            ],
                          );
                        },
                        itemCount: banner.length,
                        pagination: new SwiperPagination(
                            builder: RectSwiperPaginationBuilder(
                                size: const Size(22.0, 10.0),
                                activeSize: const Size(22.0, 10.0),
                                activeColor: Color(0xffF5DA9C),
                                color: Color(0x91908C87))),
//                  control: new SwiperControl(),
                      ),
                    ),
                    NewsList(news)
                  ],
                ),
              ),
      ),
    );
  }
}
