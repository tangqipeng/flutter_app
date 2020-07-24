import 'package:json_annotation/json_annotation.dart';
part 'image_entity.g.dart';

@JsonSerializable()
class ImageBean extends Object {
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'thumb')
  String thumb;
  @JsonKey(name: 'width')
  String width;
  @JsonKey(name: 'height')
  String height;


  ImageBean(this.title, this.thumb, this.width, this.height);

  factory ImageBean.fromJson(Map<String, dynamic> json) => _$ImageBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ImageBeanToJson(this);

}
@JsonSerializable()
class ImageResponse extends Object {
  int total;
  List<ImageBean> list;


  ImageResponse(this.total, this.list);

  factory ImageResponse.fromJson(Map<String, dynamic> json) => _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);


}
