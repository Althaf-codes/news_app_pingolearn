import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_model.dart';
import 'package:news_app/service/config/remote_config.dart';
import 'package:news_app/service/news/news_service.dart';
import 'package:news_app/utils/constants/network_constant.dart';
import 'package:news_app/utils/exceptions/app_exception.dart';
import 'package:news_app/utils/exceptions/error_handler.dart';

class NewsServiceImpl extends NewsService {
  final RemoteConfigService _remoteConfigService = RemoteConfigService();

  @override
  Future<List<dynamic>> fecthHeadlines() async {
    try {
      String country = _remoteConfigService.country;
      print("the country is ${country}");

      http.Response res = await http.get(
        Uri.parse('${NetworkConstant.baseUrl}?country=${country}'),
        headers: <String, String>{'x-api-key': "Your-Api-Key"},
      );
      var response = returnResponse(res) as List;
      print("THE Response CALLED is  RES ${response}");

      if (kDebugMode) {
        print(response);
      }

      return response;
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
  }

  @override
  Future<List> fetchCategoryNews({required String category}) async {
    try {
      String country = _remoteConfigService.country;
      print("the country is ${country}");

      http.Response res = await http.get(
        Uri.parse(
            '${NetworkConstant.baseUrl}?country=${country}&category=${category}'),
        headers: <String, String>{'x-api-key': "Your-Api-Key"},
      );
      var response = returnResponse(res) as List;
      print("THE Response CALLED is  RES ${response}");

      if (kDebugMode) {
        print(response);
      }

      return response;
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
  }

  Future<List<NewsModel>> fetchByQuery({required String query}) async {
    try {
      String country = _remoteConfigService.country;
      print("the country is ${country}");

      http.Response res = await http.get(
        Uri.parse('${NetworkConstant.baseUrl}?q=${query}'),
        headers: <String, String>{'x-api-key': "Your-Api-Key"},
      );
      var response = returnResponse(res) as List;
      print("THE Response CALLED is  RES ${response}");

      if (kDebugMode) {
        print(response);
      }

      List<NewsModel> newsModel = response
          .map((ele) => NewsModel.fromMap(ele as Map<String, dynamic>))
          .toList();

      return newsModel;
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw FetchDataException('Network Request time out');
    }
  }
}
