import 'package:flex_color_scheme/flex_color_scheme.dart';

class ThemeUtil {
  static FlexScheme getFlexScheme(String? theme) {
    if (theme == null) {
      return FlexScheme.indigoM3;
    }

    final Map<String, FlexScheme> themeMap = {
      "purpleM3": FlexScheme.purpleM3,
      "redM3": FlexScheme.redM3,
      "pinkM3": FlexScheme.pinkM3,
      "orangeM3": FlexScheme.orangeM3,
      "greenM3": FlexScheme.greenM3,
      "materialHc": FlexScheme.materialHc,
      "sakura": FlexScheme.sakura,
      "gold": FlexScheme.gold,
      "limeM3": FlexScheme.limeM3,
      "cyanM3": FlexScheme.limeM3,
      "blue": FlexScheme.blue,
      "hippieBlue": FlexScheme.hippieBlue,
      "aquaBlue": FlexScheme.aquaBlue,
      "mandyRed": FlexScheme.mandyRed,
      "purpleBrown": FlexScheme.purpleBrown,
      "deepOrangeM3": FlexScheme.deepOrangeM3,
      "brandBlue": FlexScheme.brandBlue,
      "money": FlexScheme.money,
      "greyLaw": FlexScheme.greyLaw,
      "wasabi": FlexScheme.wasabi,
      "mango": FlexScheme.mango,
      "amber": FlexScheme.amber,
    };

    return themeMap[theme] ?? FlexScheme.indigoM3;
  }
}
