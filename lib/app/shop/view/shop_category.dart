import 'package:flutter/material.dart';
import 'package:myweb/app/shop/controller/categoryBloc.dart';
import 'package:myweb/app/shop/model/category.dart';
import 'package:myweb/framework/app/appPage.dart';
import 'package:myweb/framework/core/appBlocBuilder.dart';
import 'package:myweb/framework/core/appBlocProvider.dart';

class ShopCategory extends AppPage {
  @override
  Widget build(BuildContext context) {
    AppBlocProvider<CategoryBloc> blocProvider = AppBlocProvider<CategoryBloc>(
      create: (context) => CategoryBloc(),
      child: AppBlocBuilder<CategoryBloc,Category>(
        builder:_buildCategory),
            );
            return blocProvider;
          }
        
          Widget _buildCategory(BuildContext context, Category state) {
            
  }
}