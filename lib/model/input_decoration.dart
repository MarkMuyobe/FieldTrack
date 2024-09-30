import 'package:flutter/material.dart';

InputDecoration inputDecoration(String labelText, [Icon? icon]) {
  const borderColor = Color(0xFF4ECB71);
  return InputDecoration(
    labelText: labelText,
    prefixIcon: icon,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      borderSide: BorderSide(color: borderColor),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      borderSide: BorderSide(color: borderColor),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      borderSide: BorderSide(color: borderColor),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(24.0)),
      borderSide: BorderSide(color: borderColor),
    ),
  );
}