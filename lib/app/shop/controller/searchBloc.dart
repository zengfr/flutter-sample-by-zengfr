import 'package:myweb/app/shop/model/searchStatus.dart';
import 'package:myweb/framework/core/appBloc.dart';

 
class SearchBloc extends AppBloc<SearchStatus> {

  SearchBloc() : super(new SearchStatus()..type=2);
}
