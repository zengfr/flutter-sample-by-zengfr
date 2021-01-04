import 'dart:ui';

class FStyle {
  static FConstant fConstant = FConstant();
  static FColor fColor = FColor();
  static FString fString = FString();
}

class FConstant {
  double topBarHeight = 45;
  double bottomBarHeight = 54;
  int designWidth = 360; //设计稿宽度
  double searchTxtFieldHeight = 34;
}

class FString {
  String homeSearchBarHint = '搜一搜';
  String pinweiTitle = '发现';
  String pinweigoFindTxt = '去发现';
  String cartTitle = '购物车';
  String allSelectedTxt = '全选';
  String goPayTxt = '去结算';
  String totalSumTxt = "合计";

  String searchBtTxt = '搜索';
  String searchHotTxt = '热门搜索';
}

class FColor {
  Color themeColor = Color.fromRGBO(132, 95, 63, 1.0);
  Color floorTitleColor = Color.fromRGBO(51, 51, 51, 1);
  Color searchBarBgColor = Color.fromRGBO(240, 240, 240, 1.0);
  Color searchBarTxtColor = Color(0xFFCDCDCD);
  Color divideLineColor = Color.fromRGBO(245, 245, 245, 1.0);
  Color categoryDefaultColor = Color(0xFF666666);
  Color priceColor = Color.fromRGBO(182, 9, 9, 1.0);
  Color pinweicorverSubtitleColor = Color.fromRGBO(153, 153, 153, 1.0);

  Color get pinweicorverBtbgColor => themeColor;
  Color pinweicorverBtTxtColor = Color(0xFFFFFFFF);
  Color tabtxtColor = Color.fromRGBO(88, 88, 88, 1.0);
  Color cartDisableColor = Color.fromRGBO(221, 221, 221, 1.0);
  Color cartItemChangenumBtColor = Color.fromRGBO(153, 153, 153, 1.0);
  Color cartItemCountTxtColor = Color.fromRGBO(102, 102, 102, 1.0);
  Color cartBottomBgColor = Color(0xFFFFFFFF);

  Color get goPayBtBgColor => this.themeColor;
  Color goPayBtTxtColor = Color(0xFFFFFFFF);
  Color searchAppBarBgColor = Color(0xFFFFFFFF);

  Color bottomBarbgColor = Color.fromRGBO(250, 250, 250, 1.0);

  Color searchRecomendDividerColor = Color(0xFFdedede);
}
