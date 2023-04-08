import 'package:flutter/material.dart';

InputDecoration commonInputDecoration([label]) {
  return InputDecoration(
    counterText: '',
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 0),
      borderRadius: BorderRadius.zero,
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 0),
      borderRadius: BorderRadius.zero,
    ),
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    filled: true,
    labelText: label ?? '',
    labelStyle: TextStyle(
      color: Colors.grey[400]
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.white
    )
  );
}
