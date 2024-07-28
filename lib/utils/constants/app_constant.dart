import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstant {
  static const Color blueColor = Color(0xFF0C54BE);
  static const Color darkBlueColor = Color(0xFF303F60);
  static const Color whiteColor = Color(0xFFF5F9FD);
  static const Color greyColor = Color(0xFFCED3DC);
  // Color.fromARGB(255, 233, 238, 248); // Color.fromRGBO(244, 248, 255, 1);
  // Color.fromARGB(255, 233, 238, 248); //Color(0xFFCED3DC);
  // static const black

  static TextStyle headlineWhite = GoogleFonts.poppins(
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: whiteColor, fontSize: 15));

  static TextStyle headlineBlack = GoogleFonts.poppins(
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: darkBlueColor, fontSize: 15));

  static TextStyle descriptionRegular = GoogleFonts.poppins(
      textStyle: const TextStyle(
          fontWeight: FontWeight.normal, color: darkBlueColor, fontSize: 12));

  static TextStyle descriptionMedium = GoogleFonts.poppins(
      textStyle: const TextStyle(
          fontWeight: FontWeight.w500, color: darkBlueColor, fontSize: 12));

  static TextStyle descriptionBold = GoogleFonts.poppins(
      textStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: darkBlueColor, fontSize: 12));

  // static TextStyle noramalMedium = GoogleFonts.poppins(
  //     textStyle: const TextStyle(
  //         fontWeight: FontWeight.w500, color: darkBlueColor, fontSize: 12));

  static String timeAgo(DateTime dateTime) {
    final Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final int weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  static String imageLoadedFailed = 'assets/image-loading-failed.png';
  static String imageFailed = 'assets/image-failed.png';
}
