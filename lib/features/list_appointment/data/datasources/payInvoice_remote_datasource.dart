import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/features/Routes/routeNames.dart';
import 'package:eva_life_care/features/list_appointment/data/models/payInvoice_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:eva_life_care/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

var statusCodeIs;

abstract class PayInvoiceRemoteDataSource {
  Future<PayInvoiceModel> getPayInvoice({
    required PayInvoiceParams params,
  });
}

class PayInvoiceRemoteDataSourceImpl implements PayInvoiceRemoteDataSource {
  final Dio dio;

  PayInvoiceRemoteDataSourceImpl({required this.dio});

  @override
  Future<PayInvoiceModel> getPayInvoice(
      {required PayInvoiceParams params}) async {
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    final Map<String, dynamic> requestParameters = {
      "appointment_id": params.aptid,
      "client_id": params.clientid,
      "branch_id": params.brancid,
      "patient_id": params.patientid,
      "datetime_generated": params.datetimegenerated,
      "datetime_due": params.datetimedue,
      "datetime_updated": params.datetimeupdated,
      "billing_address": params.billingaddress,
      "mobile": params.mobile,
      "order_subtotal": params.orderSubtotal,
      "discount_applications": params.discountApplication,
      "tax_rate": params.taxrate,
      "tax_amount": params.taxamount,
      "order_total": params.ordertotal,
      "discount_amount": params.discAmount
    };
    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl = 'invoice/payment';
    final String finalurl = baseUrl + endUrl;
    WidgetHelper.startLoading('');

    final response = await dio.post(finalurl,
        data: requestParameters,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));
    statusCodeIs = response.statusCode;

    Future.delayed(const Duration(seconds: 2), () {
      if (statusCodeIs == 200 || statusCodeIs == 201) {
        WidgetHelper.endLoading();

        Fluttertoast.showToast(msg: "Payment completed!");
      } else {
        WidgetHelper.endLoading();

        Fluttertoast.showToast(msg: "Payment failed!");
      }
    });

    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Payment done!");

      navigatorKey.currentState!.pushNamed(listappointmentspage);
      return PayInvoiceModel.fromJson(response.data);
    } else {
      WidgetHelper.endLoading();

      throw ServerException();
    }
  }
}
