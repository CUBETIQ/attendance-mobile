import 'package:attendance_app/core/widgets/card/my_card.dart';
import 'package:attendance_app/feature/report/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class StaffReportViewMobile extends StatelessWidget {
  const StaffReportViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ReportController.to;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Obx(
              () => TableCalendar(
                locale: 'en_US',
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: controller.calendarFocusedDay.value,
                currentDay: controller.calendarFocusedDay.value,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DateTime(
                                controller.calendarFocusedDay.value.year,
                                controller.calendarFocusedDay.value.month,
                                controller.calendarFocusedDay.value.day) !=
                            DateTime(DateTime.now().year, DateTime.now().month,
                                DateTime.now().day)
                        ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                        : Theme.of(context).colorScheme.primary,
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                selectedDayPredicate: (day) =>
                    isSameDay(day, controller.selectedDate.value),
                onDaySelected: controller.onDaySelected,
              ),
            ),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(20, size.width),
                  vertical: SizeUtils.scale(10, size.width),
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.attendanceList.value.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeUtils.scale(10, size.width),
                ),
                itemBuilder: (context, index) {
                  return MyCard(
                    width: size.width,
                    height: SizeUtils.scale(100, size.width),
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
