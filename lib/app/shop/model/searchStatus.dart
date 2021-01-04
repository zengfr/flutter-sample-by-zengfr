import 'package:json_annotation/json_annotation.dart';
import 'package:myweb/framework/core/appStatus.dart';
part 'searchStatus.g.dart';

@JsonSerializable()
class SearchStatus extends AppStatus {
  String provice;
  String city;
  String loc;
  int type;
  String channel;
  SearchStatus();
  @override
  List<Object> get props => [provice, city, loc, type, channel];

  SearchStatus copy() {
    return SearchStatus.fromJson(toJson());
  }

  factory SearchStatus.fromJson(Map<String, dynamic> json) =>
      _$SearchStatusFromJson(json);

  Map<String, dynamic> toJson() => _$SearchStatusToJson(this);
}
