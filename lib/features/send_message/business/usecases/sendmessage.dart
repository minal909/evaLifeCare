import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/send_message/business/entities/send_message_entity.dart';
import 'package:eva_life_care/features/send_message/business/repositories/send_message_repository.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';

class GetSendMessage {
  final SendMessageRepository sendMessageRepository;

  GetSendMessage({required this.sendMessageRepository});

  Future<Either<Failure, SendMessageEntity>> call({
    required SendMessageParams sendMessageParams,
  }) async {
    return await sendMessageRepository.getSendMessage(
        sendMessageParams: sendMessageParams);
  }
}
