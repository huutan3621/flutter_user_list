import 'package:json_annotation/json_annotation.dart';

part 'support_model.g.dart';

@JsonSerializable()
class SupportModel {
  final String url;
  final String text;

  SupportModel({
    required this.url,
    required this.text,
  });

  factory SupportModel.fromJson(Map<String, dynamic> json) =>
      _$SupportModelFromJson(json);

  Map<String, dynamic> toJson() => _$SupportModelToJson(this);
}
