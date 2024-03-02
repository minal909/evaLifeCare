import 'package:dartz/dartz.dart';
import 'package:eva_life_care/core/params/params.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/order_total_entity.dart';
import 'package:eva_life_care/features/list_appointment/business/repositories/order_total_repository.dart';

import '../../../../../core/errors/failure.dart';

class GetOrderTotal {
  final OrderTotalRepository orderTotalRepository;

  GetOrderTotal({required this.orderTotalRepository});

  Future<Either<Failure, OrderTotalEntity>> call({
    required OrderTotalParams params,
  }) async {
    return await orderTotalRepository.getOrderTotal(orderTotalParams: params);
  }
}
