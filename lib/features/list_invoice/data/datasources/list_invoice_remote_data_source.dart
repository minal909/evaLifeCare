import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:eva_life_care/core/connection/network_info.dart';
import 'package:eva_life_care/features/list_invoice/data/models/list_invoice_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

abstract class ListInvoiceRemoteDataSource {
  Future<ListInvoiceModel> getListInvoice(
      {required ListInvoiceParams listInvoiceParams});
}

class ListInvoiceRemoteDataSourceImpl implements ListInvoiceRemoteDataSource {
  final Dio dio;

  ListInvoiceRemoteDataSourceImpl({required this.dio});

  @override
  Future<ListInvoiceModel> getListInvoice(
      {required ListInvoiceParams listInvoiceParams}) async {
    Dio dio = Dio();
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    String endUrl =
        'invoices?client_id=$clientID&branch_id=$branchID&name=${listInvoiceParams.name}&mobile=${listInvoiceParams.mobile}';
    final String finalurl = baseUrl + endUrl;
    bool isConnected =
        await NetworkInfoImpl(DataConnectionChecker()).isConnected;
    !isConnected ? WidgetHelper.endLoading() : null;
    final response = await dio.get(finalurl,
        options: Options(headers: {'Authorization': 'Bearer $authToken'}));

    if (response.statusCode == 404) {
      listInvoiceParams.isFilter
          ? Fluttertoast.showToast(
              msg: 'Data not found!', gravity: ToastGravity.TOP)
          : null;
      WidgetHelper.endLoading();
    } else if (response.statusMessage.toString() == "failed!") {
      Fluttertoast.showToast(msg: 'No data available! !');
    } else if (response.statusCode == 200) {
      listInvoiceParams.isFilter
          ? Fluttertoast.showToast(
              msg: 'Data found!', gravity: ToastGravity.TOP)
          : null;
      WidgetHelper.endLoading();

      return ListInvoiceModel.fromJson(response.data);
    }
    WidgetHelper.endLoading();

    {
      WidgetHelper.endLoading();

      throw ServerException();
    }
  }
}
