import 'package:dartz/dartz.dart';
import 'package:eva_life_care/core/errors/failure.dart';
import 'package:eva_life_care/core/params/params.dart';
import 'package:eva_life_care/features/list_appointment/business/entities/order_total_entity.dart';

abstract class OrderTotalRepository {
  Future<Either<Failure, OrderTotalEntity>> getOrderTotal({
    required OrderTotalParams orderTotalParams,
  });
}
