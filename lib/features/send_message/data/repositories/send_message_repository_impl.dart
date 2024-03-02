import 'package:dartz/dartz.dart';
import 'package:eva_life_care/features/send_message/business/repositories/send_message_repository.dart';
import 'package:eva_life_care/features/send_message/data/datasources/send_message_remote_data_source.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../models/sendmessage_model.dart';

class SendMessageRepositoryImpl implements SendMessageRepository {
  final SendMessageRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SendMessageRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SendMessage>> getSendMessage(
      {required SendMessageParams sendMessageParams}) async {
    if (await networkInfo.isConnected!) {
      try {
        SendMessage remoteSendMessage = await remoteDataSource.getSendMessage(
            sendMessageParams: sendMessageParams);

        return Right(remoteSendMessage);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      return Left(ServerFailure(errorMessage: 'This is a cache exception'));
    }
  }
}
