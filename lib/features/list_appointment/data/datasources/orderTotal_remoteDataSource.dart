import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/list_appointment/data/models/order_total_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    // final response = await dio.post(finalurl,
    //     data: requestParameters,
    //     options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    // if (response.statusCode == 200) {
    //   return OrderTotalModel.fromJson(response.data);
    // } else {
    //   throw ServerException();
    // }

    try {
      // 404
      final response = await dio.post(finalurl,
          data: requestParameters,
          options: Options(headers: {'Authorization': 'Bearer $authToken'}));
      if (response.statusCode == 200 || response.statusCode == 201) {
        WidgetHelper.endLoading();
        return OrderTotalModel.fromJson(response.data);
      } else {
        WidgetHelper.endLoading();
      }

      // await dio.get('https://api.pub.dev/not-exist');
// ignore: nullable_type_in_catch_clause
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: "Unable to calculate order total!");

      WidgetHelper.endLoading();

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
    }

    WidgetHelper.endLoading();

    throw ServerException();
  }
}
