import 'package:flutter/material.dart';

class Constants {
  static List<String> profileInfo = [
    "Profil Bilgileri",
    "Siparişler",
    "İade ve İptal İşlemleri",
    "Favoriler",
    "Kuponlar ve İndirimler",
    "Ödeme Bilgileri"
  ];
  static EdgeInsets normalPadding() {
    return const EdgeInsets.all(16);
  }

  static EdgeInsets littlePadding() {
    return const EdgeInsets.all(8);
  }

  static TextStyle getNormalTextStyle(double value) {
    return TextStyle(fontSize: getFontSize(value));
  }

  static TextStyle productMoneyTextStyle() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }

  static Color circularProgressColor = Colors.blue;

  static Color bottomSelectedItemColor = Colors.white;

  static String basketPagePlaceHolderImageAdress = "assets/placeholder.png";

  static String getFirstLetter(String word) {
    String result = "";
    var iterations = word.split(" ");
    for (int i = 0; i < iterations.length; i++) {
      result += iterations[i][0];
    }
    return result;
  }

  static String userId = "rHxujj8j9oGCysm4VJbk";

  static double getFontSize(double value) {
    return value;
  }

  static String getSpliceWord(String word) {
    List<String> words = word.split(" ");
    if (words.length >= 2) {
      return "${words[0]} ${words[1]}\n\t${words.sublist(2).join(" ")}";
    } else {
      return word;
    }
  }




}
