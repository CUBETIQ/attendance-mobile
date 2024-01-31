import 'package:timesync360/config/app_size.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconPicker extends StatefulWidget {
  final void Function(String?)? onChangeResult;
  const IconPicker({super.key, this.onChangeResult});

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  final sortedKeys = iconsMap.keys.toList()..sort();
  IconData selectedIcon = Icons.task;
  int? selectedIndex;
  String? icon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppSize.borderRadiusLarge *
                    (MediaQuery.of(context).size.width / 375.0),
              ),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                    ),
                    padding: EdgeInsets.all(AppSize.paddingS5 *
                        (MediaQuery.of(context).size.width / 375.0)),
                    itemCount: sortedKeys.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedIcon = iconsMap[sortedKeys[index]]!;
                            icon = selectedIcon.codePoint.toString();
                            widget.onChangeResult?.call(icon);
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                5 * (MediaQuery.of(context).size.width / 375.0),
                              ),
                              child: Icon(
                                size: 24 *
                                    (MediaQuery.of(context).size.width / 375.0),
                                iconsMap[sortedKeys[index]]!,
                                color: selectedIndex == index
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            MyText(
                              text: sortedKeys[index],
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: Get.back,
                        child: MyText(
                          text: 'Cancel',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: Get.back,
                        child: MyText(
                          text: 'Select',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

final iconsMap = {
  'Appliances': Icons.kitchen,
  'Art and Creativity': Icons.palette,
  'Beauty': Icons.face_retouching_natural,
  'Business': Icons.business_center,
  'Car Purchase': Icons.directions_car_rounded,
  'Dollar': Icons.attach_money_rounded,
  'Debt Repayment': Icons.monetization_on,
  'Education': Icons.school_rounded,
  'Electronics': Icons.devices_rounded,
  'Emergency': Icons.local_hospital_rounded,
  'Entertainment': Icons.local_movies_rounded,
  'Family and Children': Icons.child_friendly_rounded,
  'Fashion': Icons.accessibility_new_rounded,
  'Food': Icons.local_dining_rounded,
  'Gifts': Icons.card_giftcard_rounded,
  'Healthcare': Icons.healing_rounded,
  'Renovation': Icons.build,
  'House': Icons.home_work_rounded,
  'Hobbies': Icons.sports_soccer,
  'Insurance': Icons.assignment_rounded,
  'Internet': Icons.wifi,
  'Investments': Icons.show_chart,
  'Leisure Activities': Icons.local_bar,
  'Loan Payment': Icons.money_off,
  'Medical': Icons.medical_services,
  'Outdoor Activities': Icons.terrain,
  'Pet Care': Icons.pets,
  'Retirement': Icons.account_balance,
  'Savings Goals': Icons.flag,
  'Sports': Icons.fitness_center,
  'Taxes': Icons.account_balance,
  'Delivery': Icons.delivery_dining,
  'Traveling': Icons.flight,
  'Vacation': Icons.beach_access,
  'Wedding': Icons.favorite,
  'Others': Icons.question_mark_rounded,
};
