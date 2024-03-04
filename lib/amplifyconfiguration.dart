import 'package:flutter_dotenv/flutter_dotenv.dart';

var region = dotenv.env['region'] ?? "";
var cognitoIdentityPoolId = dotenv.env['cognitoIdentityPoolId'] ?? "";
var cognitoUserPoolId = dotenv.env['cognitoUserPoolId'] ?? "";
var appClientId = dotenv.env['appClientId'] ?? "";

var amplifyconfig = ''' {
  "UserAgent": "aws-amplify-cli/2.0",
  "Version": "1.0",
   "auth": {
      "plugins": {
          "awsCognitoAuthPlugin": {
              "IdentityManager": {
                  "Default": {}
              },
              "CredentialsProvider": {
                  "CognitoIdentity": {
                      "Default": {
                          "PoolId": "$cognitoIdentityPoolId",
                          "Region": "$region"
                      }
                  }
              },
              "CognitoUserPool": {
                  "Default": {
                      "PoolId": "$cognitoUserPoolId",
                      "AppClientId": "$appClientId",
                      "Region": "$region"
                  }
              },
              "Auth": {
                  "Default": {
                      "authenticationFlowType": "USER_SRP_AUTH"
                  }
              }
          }
      }
  }
}''';
