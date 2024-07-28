import 'package:flutter/material.dart';
import 'package:news_app/utils/constants/app_constant.dart';

class SettingCard extends StatelessWidget {
  IconData icon;
  String text;
  SettingCard({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.indigo[900],
              ),
              SizedBox(
                width: 15,
              ),
              Text(text,
                  style: AppConstant.descriptionMedium.copyWith(fontSize: 14)),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.indigo[300],
            size: 15,
          ),
        ],
      ),
    );
  }
}
