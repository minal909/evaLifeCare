import 'package:eva_life_care/features/send_message/data/models/sendmessage_model.dart';

class SendMessageEntity {
  String status;
  String message;
  Result result;
  SendMessageEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  get isEmpty => null;
}
