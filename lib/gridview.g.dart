// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gridview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageBean _$ImageBeanFromJson(Map<String, dynamic> json) {
  return ImageBean(json['title'] as String, json['thumb'] as String,
      json['width'] as String, json['height'] as String);
}

Map<String, dynamic> _$ImageBeanToJson(ImageBean instance) => <String, dynamic>{
      'title': instance.title,
      'thumb': instance.thumb,
      'width': instance.width,
      'height': instance.height
    };

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) {
  return ImageResponse(
      json['total'] as int,
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : ImageBean.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ImageResponseToJson(ImageResponse instance) =>
    <String, dynamic>{'total': instance.total, 'list': instance.list};
