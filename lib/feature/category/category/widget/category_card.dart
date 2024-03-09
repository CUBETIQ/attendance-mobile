import 'package:flutter/material.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/core/model/category_model.dart';
import 'package:timesync/core/widgets/text/text.dart';
import 'package:timesync/extensions/string.dart';
import 'package:timesync/utils/color_utils.dart';
import 'package:timesync/utils/size_util.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
  });

  final CategoryModel category;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: SizeUtils.scaleMobile(75, size.width),
          maxHeight: SizeUtils.scaleMobile(120, size.width),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: SizeUtils.scaleMobile(75, size.width),
              height: SizeUtils.scaleMobile(75, size.width),
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: category.color != null &&
                        category.color?.isNotEmpty == true
                    ? Color(category.color!.toInt()).withOpacity(0.15)
                    : Theme.of(context).colorScheme.primary.withOpacity(0.15),
              ),
              child: Icon(
                category.icon != null && category.icon?.isNotEmpty == true
                    ? IconData(
                        category.icon!.toInt(),
                        fontFamily: 'MaterialIcons',
                      )
                    : Icons.task,
                color:
                    category.color != null && category.color?.isNotEmpty == true
                        ? ColorUtil.darken(Color(category.color!.toInt()), 20)
                        : ColorUtil.darken(
                            Theme.of(context).colorScheme.primary, 20),
                size: SizeUtils.scaleMobile(
                  38,
                  size.width,
                ),
              ),
            ),
            SizedBox(height: SizeUtils.scaleMobile(5, size.width)),
            MyText(
              text: category.name ?? "N/A",
              maxLines: 2,
              style: AppFonts().bodyMediumRegular,
            ),
          ],
        ),
      ),
    );
  }
}
