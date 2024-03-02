import 'package:dio/dio.dart';
import 'package:eva_life_care/features/Routes/routeNames.dart';
import 'package:eva_life_care/main.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages

abstract class LogInRemoteDataSource {
  Future getLogIn({required LogInParams logInParams});
}

class LogInRemoteDataSourceImpl implements LogInRemoteDataSource {
  final Dio dio;
  late final mySession;

  LogInRemoteDataSourceImpl({required this.dio});

  @override
  Future getLogIn({required LogInParams logInParams}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    mySession = await Amplify.Auth.fetchAuthSession(
      // ignore: deprecated_member_use
      options: const CognitoSessionOptions(getAWSCredentials: true),
    ) as CognitoAuthSession;

    SignInResult response = await Amplify.Auth.signIn(
        username: logInParams.email, password: logInParams.password);
    bool loginresult = response.isSignedIn;
    await prefs.setBool("loginresult", loginresult);
    final cognitoPlugin = Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
    CognitoAuthSession result = await cognitoPlugin.fetchAuthSession();

    final identityId = result.userPoolTokensResult.value.userId;
    AuthUser authuser = await Amplify.Auth.getCurrentUser();

    String authToken = result.userPoolTokensResult.value.idToken.raw.toString();
    await prefs.setString('authToken', authToken);

    if (response.nextStep.signInStep.name == "confirmSignInWithNewPassword") {
      navigatorKey.currentState!.pushNamed(firstlogin);
      // await dio.get(
      //   'https://pokeapi.co/api/v2/pokemon/',
      //   queryParameters: {
      //     'api_key': 'if needed',
      //   },
      // );
    } else {
      if (response.isSignedIn) {
        return response.isSignedIn;
      } else {
        throw ServerException();
      }
    }
    throw ServerException();
  }
}
