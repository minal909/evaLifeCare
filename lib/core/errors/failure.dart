import 'package:flutter/material.dart';

abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}

class NoInternetConnection extends Failure {
  final Widget noInternet;
  NoInternetConnection(
      {required super.errorMessage, required Widget noInternet})
      : noInternet = noInternet;
}
