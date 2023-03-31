import 'dart:developer';
import 'package:flutter/foundation.dart';

class ConstUtils {}

logs(String message) {
  if (kDebugMode) {
    log(message);
  }
}
