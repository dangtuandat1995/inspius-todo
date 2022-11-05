// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lorem_image_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoremImageInfoModel _$LoremImageInfoModelFromJson(Map<String, dynamic> json) =>
    LoremImageInfoModel(
      id: json['id'] as String,
      author: json['author'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      url: json['url'] as String,
      downloadUrl: json['download_url'] as String,
    );

Map<String, dynamic> _$LoremImageInfoModelToJson(
        LoremImageInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
      'download_url': instance.downloadUrl,
    };
