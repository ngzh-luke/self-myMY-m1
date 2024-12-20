import 'package:flutter/material.dart';

class UiConsts {
  /// SizedBox(height: 10, width: 10);
  static const spaceBetweenSections = SizedBox(
    height: 10,
    width: 10,
  );

  /// SizedBox(height: 20, width: 20);
  static const spaceBetweenSectionsLarge = SizedBox(
    height: 20,
    width: 20,
  );

  /// SizedBox(height: 3, width: 3);
  static const spaceBetweenElementsInTheSection = SizedBox(height: 3, width: 3);

  /// SizedBox(height: 5, width: 5,)
  static const spaceBetweenElementsInTheSectionMedium = SizedBox(
    height: 5,
    width: 5,
  );

  /// SizedBox(height: 7, width: 7)
  static const spaceBetweenElementsInTheSectionLarge =
      SizedBox(height: 7, width: 7);

  /// double 50
  static const double largeMaterialBtnHeight = 50;

  ///  Padding(padding:  EdgeInsets.symmetric(horizontal: 25), child: Divider(thickness: 0.5,))
  static const horizontalDividerBetweenVerticalSections = Padding(
    padding: EdgeInsets.symmetric(horizontal: 25),
    child: Divider(
      thickness: 1.25,
    ),
  );

  /// double 16
  static const double smallIconSize = 16;

  /// double 24
  static const double standardIconSize = 24;

  /// double 35
  static const double largeIconSize = 35;

  /// EdgeInsets.all(16)
  static const paddingEdgeInsetsAllLarge = EdgeInsets.all(16);

  /// EdgeInsets.all(8)
  static const paddingEdgeInsetsAll = EdgeInsets.all(8);
}
