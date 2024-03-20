class AppSize {
  static final AppSize _instance = AppSize._internal();

  factory AppSize() {
    return _instance;
  }

  AppSize._internal();

  // Padding Vertical
  double get paddingVerticalSmall => 8.0;
  double get paddingVerticalMedium => 16.0;
  double get paddingVerticalLarge => 24.0;

  // Padding Horizontal
  double get paddingHorizontalSmall => 8.0;
  double get paddingHorizontalMedium => 16.0;
  double get paddingHorizontalLarge => 20;

  // Padding for title
  double get paddingTitleSmall => 30.0;
  double get paddingTitleMedium => 40.0;
  double get paddingTitleLarge => 50.0;
  double get paddingTitleXLarge => 60.0;

  // Padding for body
  double get paddingS1 => 4.0;
  double get paddingS2 => 5.0;
  double get paddingS3 => 6.0;
  double get paddingS4 => 8.0;
  double get paddingS5 => 10.0;
  double get paddingS6 => 12.0;
  double get paddingS7 => 14.0;
  double get paddingS8 => 15.0;
  double get paddingS9 => 16.0;
  double get paddingS10 => 18.0;
  double get paddingS11 => 20.0;
  double get paddingS12 => 22.0;
  double get paddingS13 => 24.0;
  double get paddingS14 => 25.0;
  double get paddingS15 => 26.0;
  double get paddingS16 => 28.0;
  double get paddingS17 => 30.0;

  // Margin
  double get marginSmall => 8.0;
  double get marginMedium => 16.0;
  double get marginLarge => 24.0;

  // Width
  double get widthSmall => 100.0;
  double get widthMedium => 200.0;
  double get widthLarge => 300.0;

  // Height
  double get heightSmall => 50.0;
  double get heightMedium => 100.0;
  double get heightLarge => 150.0;

  // Font Size
  double get fontSizeSmall => 12.0;
  double get fontSizeMedium => 16.0;
  double get fontSizeLarge => 20.0;

  // Icon Size
  double get iconSizeSmall => 12.0;
  double get iconSizeMedium => 16.0;
  double get iconSizeLarge => 20.0;

  // Border Radius
  double get borderRadiusSmall => 10.0;
  double get borderRadiusMedium => 16.0;
  double get borderRadiusLarge => 24.0;
  double get borderRadiusXLarge => 32.0;
}
