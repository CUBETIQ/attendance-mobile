import 'package:timesync360/core/widgets/no_data/no_data.dart';
import 'package:timesync360/feature/report/controller/index.dart';
import 'package:timesync360/feature/report/widget/attendance_text_title.dart';
import 'package:timesync360/feature/report/widget/leave_text_title.dart';
import 'package:timesync360/feature/report/widget/marker_dot.dart';
import 'package:timesync360/feature/report/widget/report_attendance_card.dart';
import 'package:timesync360/feature/report/widget/report_leave_card.dart';
import 'package:timesync360/utils/size_util.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => TableCalendar(
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (BuildContext context, date, events) {
                    if (events.isEmpty) return const SizedBox.shrink();
                    return MarkerDot(
                      events: events,
                    );
                  },
                ),
                locale: 'en_US',
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                firstDay: DateTime.utc(2010, 10, 1),
                lastDay: DateTime.utc(2050, 12, 14),
                focusedDay: controller.calendarFocusedDay.value,
                currentDay: controller.calendarFocusedDay.value,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  markerMargin: EdgeInsets.only(
                    top: SizeUtils.scale(6, size.width),
                  ),
                  holidayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  holidayTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                  markerDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
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
                holidayPredicate: (day) {
                  return day.weekday > 6;
                },
                selectedDayPredicate: (day) =>
                    isSameDay(day, controller.selectedDate.value),
                onDaySelected: controller.onDaySelected,
                onPageChanged: controller.onPageChanged,
                eventLoader: (day) {
                  return controller.events.value[day] ?? [];
                },
              ),
            ),
            AttendanceTextTitle(
              attendanceList: controller.attendanceList,
              leaves: controller.leaves,
            ),
            Obx(
              () => controller.attendanceList.value.isEmpty &&
                      controller.leaves.value.isNotEmpty
                  ? const SizedBox.shrink()
                  : controller.attendanceList.value.isEmpty &&
                          controller.leaves.value.isEmpty
                      ? MyNoData(paddingTop: SizeUtils.scale(30, size.width))
                      : ListView.separated(
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
                            return ReportAttendanceCard(
                              attendance:
                                  controller.attendanceList.value[index],
                            );
                          },
                        ),
            ),
            LeaveTextTitle(leaves: controller.leaves),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.scale(20, size.width),
                  vertical: SizeUtils.scale(10, size.width),
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.leaves.value.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: SizeUtils.scale(10, size.width),
                ),
                itemBuilder: (context, index) {
                  return ReportLeaveCard(
                    leave: controller.leaves.value[index],
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
