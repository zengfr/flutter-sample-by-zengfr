import 'package:flutter/material.dart';
import 'package:myweb/framework/app/appScreen.dart';
import 'package:myweb/framework/app/appRouters.dart';
import 'package:myweb/framework/core/appBundle.dart';

import 'view/map_page.dart';
import 'view/search_page.dart';
import 'view/search_result.dart';
import 'view/shop_nav.dart';
 
 
class ShopApp extends AppScreen {
  @override
  Map<String, PageBuilder> get allRouters {
    var pageRoutes = {
      
      '/1': PageBuilder(
          builder: (bundle) =>ShopNav(
                bundle: bundle,
              )),
      '/2': PageBuilder(builder: (bundle) => ShopNav(bundle: bundle)),
      '/3': PageBuilder(builder: (bundle) => ShopNav(bundle: bundle)),
      '/search': PageBuilder(builder: (bundle) => new SearchPage()),
      '/search/result': PageBuilder(builder: (bundle) => new SearchGridPage()),
      '/map':PageBuilder(builder: (bundle) => new MapPage(bundle: bundle)),
    };
    return pageRoutes;
    
  }

  @override
  Widget get homePage => ShopNav(bundle: AppBundle(),);

  @override
  String get title => 'test 11';
}

