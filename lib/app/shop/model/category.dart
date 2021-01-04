import 'package:json_annotation/json_annotation.dart';
import 'package:myweb/framework/core/appStatus.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends AppStatus {
  int id;
  String name;
  int pId;
  String img;
  List<Category> childs;
  Category();
  @override
  List<Object> get props => [id, name, pId, img, childs];
  Category copy() {
    return Category.fromJson(toJson());
  }

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  //序列化,Map<String, dynamic> toJson() => _$*ToJson(this);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
