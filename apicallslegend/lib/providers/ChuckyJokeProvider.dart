import 'package:apicallslegend/models/chuck_response.dart';
import 'package:apicallslegend/utils/commons.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class ChuckyJokeProvider extends ChangeNotifier {
  ChuckResponse chuckResponse;

  Future<ChuckResponse> fetchChuckyJoke(String category) async {
    try {
      final response = await http.get(
          (Commons.baseURL + "jokes/random?category=" + category),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          });
      if (response.statusCode == 200) {
        var responseJson = Commons.returnResponse(response);
        chuckResponse = ChuckResponse.fromJson(responseJson);
        return ChuckResponse.fromJson(responseJson);
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}
