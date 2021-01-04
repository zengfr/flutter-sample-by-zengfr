import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myweb/framework/app/appRouters.dart';
import 'package:myweb/framework/ext/options.dart';

import 'appScreen.dart';

class AppNav extends StatefulWidget {
  List<NavigationIconView> navigationViews;
  AppNav({ Key key,this.navigationViews }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AppNavState();
  }
}

/*
 * 关联State子类的实例
 * 继承State：StatefulWidget（有状态的控件）逻辑和内部状态
 * 继承TickerProviderStateMixin，提供Ticker对象
 */
class _AppNavState extends State<AppNav> with TickerProviderStateMixin {
  // 类成员，存储底部导航栏的当前选择
  int _currentIndex = 0;

  // 类成员，存储NavigationIconView类的列表
  List<NavigationIconView> _navigationViews;
  /*
   * 在对象插入到树中时调用
   *  框架将为它创建的每个State（状态）对象调用此方法一次
   * 覆盖此方法可以实现此对象被插入到树中的位置的初始化
   * 或用于配置此对象上的控件的位置的初始化
   */
  @override
  void initState() {
    // 调用父类的内容
    super.initState();
    _navigationViews = widget.navigationViews;

    // 循环调用存储NavigationIconView类的列表的值
    for (NavigationIconView view in _navigationViews) {
      view.init(this);
      // 每次动画控制器的值更改时调用侦听器
      view.controller.addListener(_rebuild);
    }
    // 底部导航栏当前选择的动画控制器的值为1.0
    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  // 释放此对象使用的资源
  @override
  void dispose() {
    // 调用父类的内容
    super.dispose();
    // 循环调用存储NavigationIconView类的列表中的项
    for (NavigationIconView view in _navigationViews)
      // 调用此方法后，对象不再可用
      view.controller.dispose();
  }

  // 动画控制器的值更改时的操作
  void _rebuild() {
    // 通知框架此对象的内部状态已更改
    setState(() {
      // 重建，以便为视图创建动画
    });
  }

  // 建立过渡堆栈
  Widget _buildTransitionsStack(BuildContext context,BottomNavigationBarType _barType) {
    // 局部变量，存储不透明度转换的列表
    final List<FadeTransition> transitions = <FadeTransition>[];
    // 循环调用存储NavigationIconView类的列表的值
    for (NavigationIconView view in _navigationViews) {
      //view.item.backgroundColor=Theme.of(context).bottomNavigationBarTheme.backgroundColor;
      // 在存储不透明度转换的列表中添加transition函数的返回值
      transitions.add(view.transition(_barType, context));
    }
    // 对存储不透明度转换的列表进行排序
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      // aValue：a的动画值
      double aValue = aAnimation.value;
      // bValue：b的动画值
      double bValue = bAnimation.value;
      /*
       * 将aValue与bValue进行比较
       *  返回一个负整数，aValue排序在bValue之前
       *  返回一个正整数，aValue排序在bValue之后
       */
      return aValue.compareTo(bValue);
    });
    // 返回值，创建层叠布局控件
    return new Stack(children: transitions);
  }

  // 覆盖此函数以构建依赖于动画的当前状态的控件
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppOptionsCubit, AppOptions>(builder: _build);
  }

  Widget _build(BuildContext context, AppOptions options) {
    final BottomNavigationBarType _barType = options.bottomNavBarType;
    // 局部变量，创建底部导航栏
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
        /*
       * 在底部导航栏中布置的交互项：迭代存储NavigationIconView类的列表
       *  返回此迭代的每个元素的底部导航栏项目
       *  创建包含此迭代的元素的列表
       */
        items: _navigationViews
            .map((NavigationIconView navigationView) => navigationView.item)
            .toList(),
        // 当前活动项的索引：存储底部导航栏的当前选择
        currentIndex: _currentIndex,
        // 底部导航栏的布局和行为：存储底部导航栏的布局和行为
        type: _barType,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        // 当点击项目时调用的回调
        onTap: (int index) {
          // 通知框架此对象的内部状态已更改
          setState(() {
            // 当前选择的底部导航栏项目，开始反向运行此动画
            _navigationViews[_currentIndex].controller.reverse();
            // 更新存储底部导航栏的当前选择
            _currentIndex = index;
            // 当前选择的底部导航栏项目，开始向前运行此动画
            _navigationViews[_currentIndex].controller.forward();
          });
        });
    // 实现基本的质感设计视觉布局结构
    return new Scaffold(
      // 主要内容
      body: new Center(
          // 主要内容：_buildTransitionsStack函数的返回值
          child: _buildTransitionsStack(context,_barType)),
      // 水平的按钮数组，沿着程序的底部显示
      bottomNavigationBar: botNavBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 20,
        ),
        onPressed: () {
          AppRouters.router.navigateTo(context, "/options",
              transition: TransitionType.fadeIn);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// 创建类，自定义图标，继承StatelessWidget（无状态的控件）
class CustomIcon extends StatelessWidget {
  // 覆盖此函数以构建依赖于动画的当前状态的控件
  @override
  Widget build(BuildContext context) {
    // 获取当前图标主题，创建与此图标主题相同的图标主题
    final IconThemeData iconTheme = IconTheme.of(context);
    // 返回值，创建一个容器控件
    return new Container(
        // 围绕子控件的填充：每个边都偏移4.0
        margin: const EdgeInsets.all(4.0),
        // 容器宽度：图标主题的宽度减8.0
        width: iconTheme.size - 8.0,
        // 容器高度：图标主题的高度减8.0
        height: iconTheme.size - 8.0,
        // 子控件的装饰：创建一个装饰
        decoration: new BoxDecoration(
            // 背景颜色：图标主题的颜色
            color: iconTheme.color));
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: BoxDecoration(
          border: Border.all(color: iconTheme.color, width: 2.0),
        ));
  }
}

// 创建类，导航图标视图
class NavigationIconView {
  // 导航图标视图的构造函数
  NavigationIconView({
    @required Widget page,
    // 控件参数，传递图标
    Widget icon,
    Widget activeIcon,
    // 控件参数，传递标题
    String title,
    // 控件参数，传递颜色
    Color color,
    /*
     * Ticker提供者
     *  由类实现的接口，可以提供Ticker对象
     *    Ticker对象：每个动画帧调用它的回调一次
     */
    TickerProvider vsync,
  })  : _page = page,
        // 接收传递的颜色
        _color = color,
        // 创建底部导航栏项目
        item = new BottomNavigationBarItem(
          // 项目的图标
          icon: icon,
          activeIcon: activeIcon,
          // 项目的标题
          label: title,
          backgroundColor: color
        );

  final Widget _page;
  // 类成员，存储颜色
  final Color _color;
  // 类成员，底部导航栏项目
  final BottomNavigationBarItem item;
  // 类成员，动画控制器
  AnimationController controller;
  // 类成员，曲线动画
  CurvedAnimation _animation;
  void init(TickerProvider vsync) {
// 创建动画控制器
    controller = new AnimationController(
      // 动画持续的时间长度：默认情况下主题更改动画的持续时间
      duration: kThemeAnimationDuration,
      // 垂直同步
      vsync: vsync,
    );
    // 创建曲线动画
    _animation = new CurvedAnimation(
      // 应用曲线动画的动画
      parent: controller,
      /*
         * 正向使用的曲线：
         *  从0.5
         *  到1.0结束
         *  应用的曲线：快速启动并缓和到最终位置的曲线
         */
      curve: new Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  /*
   * 类函数，过渡转换
   *  BottomNavigationBarType：定义底部导航栏的布局和行为
   *  BuildContext：处理控件树中的控件
   */
  FadeTransition transition(
      BottomNavigationBarType type, BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    // 局部变量，存储图标颜色
    Color iconColor;
    // 如果底部导航栏的位置和大小在点击时会变大
    if (type == BottomNavigationBarType.shifting) {
      // 存储颜色作为图标颜色
      iconColor = _color;
      
    } else {
      /*
       * 保存质感设计主题的颜色和排版值：
       *  使用ThemeData来配置主题控件
       *  使用Theme.of获取当前主题
       */

      /*
       * 如果程序整体主题的亮度很高（需要深色文本颜色才能实现可读的对比度）
       *  就返回程序主要部分的背景颜色作为图标颜色
       *  否则返回控件的前景颜色作为图标颜色
       */
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }
    // 返回值，创建不透明度转换
    return new FadeTransition(
        // 控制子控件不透明度的动画
        opacity: _animation,
        // 子控件：创建滑动转换过渡
        child: new SlideTransition(
            /*
         * 控制子控件位置的动画
         *  开始值和结束值之间的线性插值<以尺寸的分数表示的偏移量>
         *    （1.0，0.0）表示Size的右上角
         *    （0.0，1.0）表示Size的左下角
         */
            position: new Tween<Offset>(
              // 此变量在动画开头的值
              begin: const Offset(0.0, 0.02),
              // 此变量在动画结尾处的值：左上角
              end: Offset.zero,
            ).animate(_animation), //  返回给定动画，该动画接受由此对象确定的值
            // 子控件：创建控制子控件的颜色，不透明度和大小的图标主题
            child: new IconTheme(
              // 用于子控件中图标的颜色，不透明度和大小
              data: new IconThemeData(
                // 图标的默认颜色
                color: iconColor,
                // 图标的默认大小
                size: 120.0,
              ),
              // 子控件
              child: _page,
            )));
  }
}
