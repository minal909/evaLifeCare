import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/list_idproof_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';

abstract class ListIdProofRemoteDataSource {
  Future<ListIdProofModel> getListIdProof({required ListIdProofParams params});
}

class ListIdProofRemoteDataSourceImpl implements ListIdProofRemoteDataSource {
  final Dio dio;

  ListIdProofRemoteDataSourceImpl({required this.dio});

  @override
  Future<ListIdProofModel> getListIdProof(
      {required ListIdProofParams params}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = 'id-proofs';
    final String finalurl = baseUrl + endUrl;

    try {
      // 404
      WidgetHelper.startLoading('');
      final response = await dio.get(finalurl,
          options: Options(headers: {'Authorization': 'Bearer $authToken'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        WidgetHelper.endLoading();
        return ListIdProofModel.fromJson(response.data);
      } else {
        WidgetHelper.endLoading();
      }

      // await dio.get('https://api.pub.dev/not-exist');
// ignore: nullable_type_in_catch_clause
    } on Exception catch (e) {
      WidgetHelper.endLoading();

      Fluttertoast.showToast(msg: "Somwthing went wrong!");

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
    }

    WidgetHelper.endLoading();

    throw ServerException();

    // final response = await dio.get(finalurl,
    //     options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    // if (response.statusCode == 200) {
    //   return ListIdProofModel.fromJson(response.data);
    // } else {
    //   throw ServerException();
    // }
  }
}
