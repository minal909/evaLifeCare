import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/list_appointment/data/models/order_total_model.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

abstract class OrderTotalRemoteDataSource {
  Future<OrderTotalModel> getOrderTotal({
    required OrderTotalParams params,
  });
}

class OrderTotalRemoteDataSourceImpl implements OrderTotalRemoteDataSource {
  final Dio dio;

  OrderTotalRemoteDataSourceImpl({required this.dio});

  @override
  Future<OrderTotalModel> getOrderTotal(
      {required OrderTotalParams params}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    final Map<String, dynamic> requestParameters = {
      "order_subtotal": params.ordersubtotal,
      "discount_applications": params.discountApplication
    };
    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = 'order-totals';
    final String finalurl = baseUrl + endUrl;
    final response = await dio.post(finalurl,
        data: requestParameters,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 200) {
      return OrderTotalModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
