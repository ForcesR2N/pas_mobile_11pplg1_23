import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarHelper {
  static void showError(
    String message, {
    String title = 'Error',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: duration,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  static void showSuccess(
    String message, {
    String title = 'Success',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: duration,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  static void showWarning(
    String message, {
    String title = 'Warning',
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: duration,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      borderRadius: 10,
      icon: const Icon(Icons.warning, color: Colors.white),
    );
  }
}