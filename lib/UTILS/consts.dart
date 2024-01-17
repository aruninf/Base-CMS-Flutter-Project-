import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

/// Created by Arun Android

const String authTokenKey = "auth_key";
const String isLogin = "is_login";

void showSnackBar(String message, Color? color) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 3,
      backgroundColor: color ?? Colors.deepOrange,
      textColor: Colors.white,
      fontSize: 16.0);
}

String formatDateTimeToMMM(String dateString) {
  if (dateString.isEmpty) return '01 Jan 2023';
  DateTime dateParsed = DateTime.parse(dateString);
  return DateFormat('dd MMM yyyy').format(dateParsed);
}

int calculateAge(String birthDate) {
  DateTime today = DateTime.now();
  DateTime birthDateParsed = DateTime.parse(birthDate);

  // Calculate the difference between today and the birth date
  int yearsDifference = today.year - birthDateParsed.year;

  // Check if the birth date has occurred this year or not
  if (today.month < birthDateParsed.month ||
      (today.month == birthDateParsed.month &&
          today.day < birthDateParsed.day)) {
    yearsDifference--;
  }

  return yearsDifference;
}
