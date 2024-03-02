import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/send_message/business/entities/send_message_entity.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

abstract class SendMessageRepository {
  Future<Either<Failure, SendMessageEntity>> getSendMessage({
    required SendMessageParams sendMessageParams,
  });
}
