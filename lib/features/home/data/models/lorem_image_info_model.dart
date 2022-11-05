import 'package:json_annotation/json_annotation.dart';
import 'package:todo_firestore/features/home/domain/entities/lorem_image_info.dart';

part 'lorem_image_info_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LoremImageInfoModel extends LoremImageInfo {
  const LoremImageInfoModel({
    required super.id,
    required super.author,
    required super.width,
    required super.height,
    required super.url,
    required super.downloadUrl,
  });

  factory LoremImageInfoModel.fromJson(Map<String, dynamic> json) =>
      _$LoremImageInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoremImageInfoModelToJson(this);
}
