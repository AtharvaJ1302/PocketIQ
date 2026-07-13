import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final instance =
  NavigationService._();

  final navigatorKey =
  GlobalKey<NavigatorState>();
}