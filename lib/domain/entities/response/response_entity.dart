import 'package:equatable/equatable.dart';
import 'package:flutter_user_list/domain/entities/response/support_entity.dart';
import 'package:flutter_user_list/domain/entities/user/user_entity.dart';

class ResponseEntity extends Equatable {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserEntity> data;
  final SupportEntity support;

  const ResponseEntity({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [page, perPage, total, totalPages, data, support];
}
