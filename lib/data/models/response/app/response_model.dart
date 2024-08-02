import 'package:flutter_user_list/data/models/response/app/support_model.dart';
import 'package:flutter_user_list/data/models/response/user/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  final int? page;
  final int? perPage;
  final int? total;
  final int? totalPages;
  final List<UserModel>? data;
  final SupportModel? support;

  ResponseModel({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
