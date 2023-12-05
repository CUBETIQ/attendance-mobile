import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/config/font.dart';
import 'package:attendance_app/constants/svg.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/home/controller/index.dart';
import 'package:attendance_app/feature/navigation/controller/index.dart';
import 'package:attendance_app/utils/time_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeStaffMobileView extends StatelessWidget {
  const HomeStaffMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.to;
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: AppSize.paddingHorizontalLarge,
          right: AppSize.paddingHorizontalLarge,
          top: AppSize.paddingTitleSmall,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text:
                            "Hey ${NavigationController.to.user.value.username}",
                        style: BodyXlargeMedium,
                      ),
                      const SizedBox(height: AppSize.spacingS1),
                      MyText(
                        text: TimeFormatter().formatDate(
                          controller.date,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(
                          NavigationController.to.user.value.image!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.spacingS10),
            Row(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.antiAlias,
                  width: size.width * 0.43,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.spacingS7,
                      vertical: AppSize.spacingS7,
                    ),
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.25),
                    width: double.infinity,
                    height: size.height * 0.13,
                    child: SvgPicture.asset(
                      checkIn,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.antiAlias,
                  width: size.width * 0.43,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.027),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.spacingS7,
                      vertical: AppSize.spacingS7,
                    ),
                    width: double.infinity,
                    height: size.height * 0.13,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.25),
                    child: SvgPicture.asset(
                      checkOut,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
