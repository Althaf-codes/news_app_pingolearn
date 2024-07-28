import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/exceptions/app_exception.dart';

dynamic returnResponse(http.Response response) {
  if (kDebugMode) {
    print(response.statusCode);
  }

  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      // print("THE RESPONSE in ERROR_HANDLER : ${responseJson}");
      return responseJson['articles'];

    case 400:
      throw BadRequestException(response.body.toString());

    case 401:
      throw UnauthorisedException(response.body.toString());

    case 404:
      throw UnauthorisedException(response.body.toString());
    default:
      throw FetchDataException('Error occured while communicating with server');
  }
}
