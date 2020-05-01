import 'dart:convert';

import 'package:apicallslegend/networking/AppException.dart';
import 'package:apicallslegend/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Commons {
  static const baseURL = "https://api.chucknorris.io/";

  static const tileBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeBackgroundColor = const Color(0xFFF1F1F1);
  static const chuckyJokeWaveBackgroundColor = const Color(0xFFA8184B);
  static const gradientBackgroundColorEnd = const Color(0xFF601A36);
  static const gradientBackgroundColorWhite = const Color(0xFFFFFFFF);
  static const mainAppFontColor = const Color(0xFF4D0F29);
  static const appBarBackGroundColor = const Color(0xFF4D0F28);
  static const categoriesBackGroundColor = const Color(0xFFA8184B);
  static const gradientBackgroundColorStart = const Color(0xFF4D0F29);

  static Widget chuckyLoader() {
    return Center(child: SpinKitFoldingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Color(0xFFFFFFFF) : Color(0xFF311433),
          ),
        );
      },
    ));
  }

  static Widget chuckyLoading(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.all(18), child: Text(message)),
        chuckyLoader(),
      ],
    );
  }

  static Future logout(BuildContext context) async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
