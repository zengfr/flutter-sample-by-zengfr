import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myweb/framework/util/fUtil.dart';
import '../core/appBundle.dart';

typedef Widget HandlerFunc(
    BuildContext context, Map<String, List<String>> parameters);

typedef Widget PageBuilderFunc(AppBundle bundle);

class AppRouters {
  static FluroRouter router = FluroRouter();
  static setupPageRoutes(Map<String, PageBuilder> routers,
      {TransitionType transitionType = TransitionType.inFromRight}) {
    routers.forEach((path, pb) {
      router.define(path,
          handler: pb.getHandler(), transitionType: transitionType);
    });
  }

  static setupPageRoute(String path, PageBuilder pb,
      {TransitionType transitionType = TransitionType.inFromRight}) {
    router.define(path,
        handler: pb.getHandler(), transitionType: transitionType);
  }

  static setupRoutes(Map<String, Handler> routers,
      {TransitionType transitionType = TransitionType.inFromRight}) {
    routers.forEach((path, handler) {
      router.define(path, handler: handler, transitionType: transitionType);
    });
  }
}

////
///Map<String, PageBuilder> pageRoutes = {
///RouteConstant.CAR_DETAIL_PAGE:
///PageBuilder(builder: (bundle) => CarDetailPage(bundle: bundle,)),
///////////
class PageBuilder {
  final PageBuilderFunc builder;
  HandlerFunc handlerFunc;

  PageBuilder({this.builder}) {
    this.handlerFunc = (context, _) {
      var param = ModalRoute.of(context).settings.arguments;
      if (param.runtimeType == String) {
        AppBundle bundle = AppBundle();
        bundle.put(FUtil.instance.getUrlParams(param));
        return this.builder(bundle);
      } else
        return this.builder(param as AppBundle);
    };
  }

  Handler getHandler() {
    return Handler(handlerFunc: this.handlerFunc);
  }
}
