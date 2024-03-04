import 'package:dio/dio.dart';
import 'package:eva_life_care/features/book%20appointment/data/models/book_apt_model.dart';
import 'package:eva_life_care/features/skeleton/widgets/loader.dart';
import 'package:eva_life_care/features/user%20authentication/presentation/providers/log_in_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

bool profile = false;

abstract class BookAppointmentRemoteDataSource {
  Future<BookAppointmentModel> getBookAppointment(
      {required BookAppointmentParams bookAppointmentParams});
}

class BookAppointmentRemoteDataSourceImpl
    implements BookAppointmentRemoteDataSource {
  final Dio dio;

  BookAppointmentRemoteDataSourceImpl({required this.dio});

  @override
  Future<BookAppointmentModel> getBookAppointment(
      {required BookAppointmentParams bookAppointmentParams}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int clientId = prefs.getInt('clientId')!.toInt();

    String token = prefs.getString('authToken').toString();
    String endUrl = 'appointment/book';
    final String finalurl = baseUrl + endUrl;

// Filter out null or unchanged values from optionalParameters
    // optionalParameters.removeWhere(
    // (key, value) => value == null || requiredParameters[key] == value);

// Combine required and optional parameters to create the final request body

    // Existing parameters that are necessary for the request
    final Map<String, dynamic> requiredParameters = {
      "client_entity_name": entityName,
      "appointment_type": bookAppointmentParams.appointmenttype,
      "client_id": bookAppointmentParams.branchid,
      "branch_id": bookAppointmentParams.branchid,
      "service_id": bookAppointmentParams.serviceid,
      "user_id": bookAppointmentParams.userid,
      "service_charges": bookAppointmentParams.servicecharges,
      "reference_doctor": bookAppointmentParams.referencedoctor,
      "appointment_timestamp": bookAppointmentParams.appointmenttimestamp,
    };

// Optional parameters that may or may not change
    Map<String, dynamic> optionalParameters = {
      "patient_id": bookAppointmentParams.patientid,
      "patient_data": bookAppointmentParams.patientdata,

      // Add other optional parameters here
    };

// Filter out null or unchanged values from optionalParameters
    optionalParameters.removeWhere(
        (key, value) => value == null || requiredParameters[key] == value);

// Combine required and optional parameters to create the final request body
    final Map<String, dynamic> requestBody = {
      ...requiredParameters,
      ...optionalParameters
    };
    try {
      // 404
      WidgetHelper.startLoading('');

      final response = await dio.post(
        finalurl,
        data: requestBody,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        WidgetHelper.endLoading();
        profile = true;
        Fluttertoast.showToast(
            msg: 'Appointment booked!', gravity: ToastGravity.TOP);
        WidgetHelper.endLoading();

        return BookAppointmentModel.fromJson(response.data);
      } else {
        WidgetHelper.endLoading();
      }

      // await dio.get('https://api.pub.dev/not-exist');
// ignore: nullable_type_in_catch_clause
    } on Exception catch (e) {
      WidgetHelper.endLoading();

      Fluttertoast.showToast(msg: "Failed to book appointment!");

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
    }

    WidgetHelper.endLoading();

    throw ServerException();

    // final response = await dio.post(
    //   finalurl,
    //   data: requestBody,
    //   options: Options(
    //     headers: {'Authorization': 'Bearer $token'},
    //   ),
    // );
    // // queryParameters: {
    // //   'api_key': 'if needed',
    // // },
    // if (response.statusCode != 200) {
    //   WidgetHelper.endLoading();
    //   Fluttertoast.showToast(msg: 'Failed to book appointment!');
    // }
    // if (response.statusCode == 200) {
    //   profile = true;
    //   Fluttertoast.showToast(
    //       msg: 'Appointment booked!', gravity: ToastGravity.TOP);
    //   WidgetHelper.endLoading();

    //   return BookAppointmentModel.fromJson(response.data);
    // } else {
    //   WidgetHelper.endLoading();
    //   Fluttertoast.showToast(msg: 'Failed to book appointment!');

    //   throw ServerException();
    // }
  }
}
