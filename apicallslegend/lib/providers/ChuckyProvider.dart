import 'package:apicallslegend/models/chuck_categories.dart';
import 'package:apicallslegend/utils/commons.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class ChuckyProvider extends ChangeNotifier {
  ChuckCategories chuckCategories;

  Future<ChuckCategories> fetchChuckyCategories() async {
    try {
      final response =
          await http.get((Commons.baseURL + "jokes/categories"), headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      });
      if (response.statusCode == 200) {
        var responseJson = Commons.returnResponse(response);
        chuckCategories = ChuckCategories.fromJson(responseJson);
        return ChuckCategories.fromJson(responseJson);
      } else {
        return null;
      }
    } on SocketException {
      return null;
    }
  }
}
