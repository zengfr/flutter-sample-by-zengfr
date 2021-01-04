import 'package:flutter/material.dart';
import 'package:myweb/framework/app/appWebView.dart';
import 'package:myweb/framework/widget/appTopBar.dart';

class ShopHomePage extends StatefulWidget {
  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  Map<String, String> tabs = {
    "新闻": "http://www.baidu.com/?",
    "历史": "http://news.baidu.com/?3",
    "图片": "http://map.baidu.com/?4",
    "历史2": "http://image.baidu.com/?3",
    "图片2": "4",
    "历史3": "3",
    "图片3": "4",
    "历史4": "3",
    "图片4": "4"
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,//为false的时候会影响leading，actions、titile组件，导致向上偏移
        title: _buildTopBar(context),
        bottom: TabBar(
          isScrollable: true,//允许左右滚动
          indicatorColor: Colors.white,//选中下划线的颜色
            //生成Tab菜单
            controller: _tabController,
            tabs: tabs.entries.map((e) => Tab(text: e.key)).toList()),
      ),
      body: TabBarView(
        //physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: tabs.entries.map((e) {
          //创建Tab页
          return Container(
            alignment: Alignment.center,
            child: AppWebView( src:e.value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return AppTopBar(
      centerTitle: '搜索',
      isBack: true,
      actionName: '菜单',
      leftChild: Container(child: Icon(Icons.menu,size: 28,),
      //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
      rightChild: Container(
        child: Row(
          children: [
            Icon(
              Icons.message,size: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '消息',
            )
          ],
        ),
      ),
      onSearch: () {},
      onPressed: () {},
      // isBack: false,
    );
  }
}
