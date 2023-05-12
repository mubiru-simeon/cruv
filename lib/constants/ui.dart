import 'package:flutter/material.dart';

const primaryColor = Colors.blue;
const borderDouble = 8.0;
const standardElevation = 10.0;
const standardPadding = 10.0;
BorderRadius standardBorderRadius = BorderRadius.circular(borderDouble);

Color selectedSeatColor = Colors.green;
Color unavailableColor = Colors.black;
Color availableColor = Color.fromARGB(255, 171, 209, 240);

InputDecoration standardInputDecoration = InputDecoration(
  hintText: "Type here",
  contentPadding: const EdgeInsets.only(
    top: 10,
    bottom: 10,
    left: 10,
    right: 10,
  ),
  border: OutlineInputBorder(
    borderRadius: standardBorderRadius,
  ),
);
