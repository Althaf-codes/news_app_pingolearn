import 'package:flutter/material.dart';
import 'package:news_app/utils/constants/app_constant.dart';

void showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        backgroundColor: AppConstant.blueColor,
        shape: const StadiumBorder(),
        content: Text(
          msg,
          style: const TextStyle(color: AppConstant.whiteColor),
        )));
}

void showErrorSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        shape: const StadiumBorder(),
        content: Text(
          msg,
          style: const TextStyle(color: AppConstant.whiteColor),
        )));
}
