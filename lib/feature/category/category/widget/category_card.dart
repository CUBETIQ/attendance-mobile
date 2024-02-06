import 'package:flutter/material.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/model/category_model.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/extensions/string.dart';
import 'package:timesync360/utils/size_util.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        maxWidth: SizeUtils.scale(75, size.width),
        maxHeight: SizeUtils.scale(120, size.width),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: SizeUtils.scale(75, size.width),
            height: SizeUtils.scale(75, size.width),
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  category.color != null && category.color?.isNotEmpty == true
                      ? Color(category.color!.toInt())
                      : Theme.of(context).colorScheme.primary,
            ),
            child: Icon(
              category.icon != null && category.icon?.isNotEmpty == true
                  ? IconData(
                      category.icon!.toInt(),
                      fontFamily: 'MaterialIcons',
                    )
                  : Icons.task,
              color: Colors.white,
              size: SizeUtils.scale(
                38,
                size.width,
              ),
            ),
          ),
          SizedBox(height: SizeUtils.scale(5, size.width)),
          MyText(
            text: category.name ?? "N/A",
            maxLines: 2,
            style: BodyMediumRegular,
          ),
        ],
      ),
    );
  }
}
