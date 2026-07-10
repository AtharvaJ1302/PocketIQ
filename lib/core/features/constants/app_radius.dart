import 'package:flutter/widgets.dart';

class AppRadius {
  AppRadius._();

  // Radius Values
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 28;
  static const double full = 999;

  // Radius
  static const Radius radiusXs = Radius.circular(xs);
  static const Radius radiusSm = Radius.circular(sm);
  static const Radius radiusMd = Radius.circular(md);
  static const Radius radiusLg = Radius.circular(lg);
  static const Radius radiusXl = Radius.circular(xl);
  static const Radius radiusFull = Radius.circular(full);

  // BorderRadius
  static const BorderRadius borderRadiusXs =
  BorderRadius.all(radiusXs);

  static const BorderRadius borderRadiusSm =
  BorderRadius.all(radiusSm);

  static const BorderRadius borderRadiusMd =
  BorderRadius.all(radiusMd);

  static const BorderRadius borderRadiusLg =
  BorderRadius.all(radiusLg);

  static const BorderRadius borderRadiusXl =
  BorderRadius.all(radiusXl);

  static const BorderRadius borderRadiusFull =
  BorderRadius.all(radiusFull);
}