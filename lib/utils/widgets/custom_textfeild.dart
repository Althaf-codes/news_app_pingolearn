import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/utils/constants/app_constant.dart';

Widget customTextFeild(
    {required String title,
    required String hintText,
    required IconData icondata,
    required TextInputType textInputType,
    required TextEditingController textEditingController,
    required String? Function(String?)? validate,
    bool isPassword = false,
    bool isObscure = false,
    Function()? obscureOntap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
    child: Container(
      // height: 40,
      // width: ,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: Offset(1, 10),
            color: Colors.grey.withOpacity(0.2))
      ]),
      child: TextFormField(
        style: AppConstant.descriptionMedium
          ..copyWith(color: AppConstant.blueColor, fontSize: 12),
        cursorColor: AppConstant.blueColor,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            isDense: true,
            labelText: title, //'Username'
            labelStyle: AppConstant.descriptionMedium,
            hintText: hintText, // 'Enter your name',
            hintStyle: AppConstant.descriptionMedium,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.red, style: BorderStyle.solid, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: AppConstant.blueColor,
                  style: BorderStyle.solid,
                  width: 1),
            ),
            focusColor: AppConstant.whiteColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                  color: Colors.transparent,
                  style: BorderStyle.solid,
                  width: 5),
            ),
            prefixIcon: IconButton(
              icon: Icon(
                icondata,
                color: AppConstant.darkBlueColor,
                size: 16,
              ),
              onPressed: () {},
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility : Icons.visibility_off,
                      color: AppConstant.darkBlueColor,
                      size: 16,
                    ),
                    onPressed: obscureOntap,
                  )
                : const SizedBox.shrink(),
            fillColor: AppConstant.whiteColor,
            filled: true),
        obscureText: isObscure,
        controller: textEditingController,
        validator: validate,
        keyboardType: textInputType,
      ),
    ),
  );
}
