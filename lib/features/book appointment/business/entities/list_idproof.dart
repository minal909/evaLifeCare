import 'package:eva_life_care/features/book%20appointment/data/models/list_idproof_model.dart';

class ListIdProofEntity {
  String status;
  String message;
  List<Result> result;
  ListIdProofEntity({
    required this.status,
    required this.message,
    required this.result,
  });

  get isEmpty => null;
}
