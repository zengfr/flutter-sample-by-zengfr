import 'package:flutter/material.dart';
import 'package:myweb/app/shop/controller/searchBloc.dart';
import 'package:myweb/framework/app/appPage.dart';
import 'package:myweb/framework/core/appBlocProvider.dart';

class SearchGridPage extends AppPage {
  @override
  Widget build(BuildContext context) {
    AppBlocProvider<SearchBloc> blocProvider = AppBlocProvider<SearchBloc>(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: new AppBar(
          title: new Text('搜索结果'),
        ),
        body: _buildSearchGrid(context),
      ),
    );
    return blocProvider;
  }
}

Widget _buildSearchGrid(BuildContext context) {
  return new GridView.count(
    crossAxisCount: 2,
    children: new List.generate(100, (index) {
      return new Center(
        child: new Text(
          'Item $index',
          style: Theme.of(context).textTheme.headline5,
        ),
      );
    }),
  );
}
