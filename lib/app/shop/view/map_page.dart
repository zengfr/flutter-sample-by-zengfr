import 'package:myweb/framework/app/appWebView.dart';
import 'package:myweb/framework/core/appBundle.dart';

class MapPage extends AppWebView {
  AppBundle bundle;

  MapPage({this.bundle}) {
    this.src = _buildUrl();
  }

  String _buildUrl() {
    String url = 'https://www.oschina.net/?';
    if (this.bundle?.getString("p") != null) {
      url += this.bundle?.getString("p");
    }
    return url;
  }
}
