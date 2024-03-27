import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timesync/constants/font.dart';
import 'package:timesync/constants/icon.dart';
import 'package:timesync/core/widgets/icon/svg_icon.dart';
import 'package:timesync/core/widgets/no_data/no_data.dart';
import 'package:timesync/core/widgets/pull_refresh/refresh_indicator.dart';
import 'package:timesync/feature/report/controller/index.dart';
import 'package:timesync/feature/report/widget/attendance_text_title.dart';
import 'package:timesync/feature/report/widget/leave_text_title.dart';
import 'package:timesync/feature/report/widget/marker_dot.dart';
import 'package:timesync/feature/report/widget/report_attendance_card.dart';
import 'package:timesync/feature/report/widget/report_break_card.dart';
import 'package:timesync/feature/report/widget/report_leave_card.dart';
import 'package:timesync/utils/size_util.dart';

class StaffReportViewMobile extends StatelessWidget {
  const StaffReportViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ReportController.to;
    final size = MediaQuery.of(context).size;
    return MyRefreshIndicator(
      onRefresh: controller.initFunction,
      child: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.scale(8, size.width)),
                child: Obx(
                  () => TableCalendar(
                    daysOfWeekHeight: SizeUtils.scale(48, size.width),
                    rowHeight: SizeUtils.scale(48, size.width),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (BuildContext context, date, events) {
                        if (events.isEmpty) return const SizedBox.shrink();
                        return AnimatedOpacity(
                          duration: const Duration(
                              milliseconds:
                                  250), // Adjust the duration as per your preference
                          opacity: date.day ==
                                  controller.calendarFocusedDay.value.day
                              ? 0
                              : 1,
                          child: MarkerDot(
                            events: events,
                          ),
                        );
                      },
                    ),
                    locale: Get.locale.toString(),
                    headerStyle: HeaderStyle(
                      titleTextStyle: AppFonts.TitleSmall.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      formatButtonVisible: false,
                      titleCentered: true,
                      leftChevronIcon: SvgIcon(
                          icon: IconAssets.arrowLeft,
                          color: Theme.of(context).colorScheme.onBackground),
                      rightChevronIcon: SvgIcon(
                          icon: IconAssets.arrowRight,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: AppFonts.LabelMedium.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      weekendStyle: AppFonts.LabelMedium.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    availableGestures: AvailableGestures.all,
                    firstDay: DateTime.utc(2010, 10, 1),
                    lastDay: DateTime.utc(2050, 12, 14),
                    focusedDay: controller.calendarFocusedDay.value,
                    currentDay: controller.calendarFocusedDay.value,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: CalendarStyle(
                      // Normal Day
                      defaultTextStyle: AppFonts.LabelMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      // Today
                      selectedTextStyle: AppFonts.LabelMedium.copyWith(
                          color: controller.calendarFocusedDay.value.day ==
                                  DateTime.now().day
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onBackground),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: controller.calendarFocusedDay.value.day ==
                                  DateTime.now().day
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          width: SizeUtils.scale(1.5, size.width),
                        ),
                        color: DateTime(
                                    controller.calendarFocusedDay.value.year,
                                    controller.calendarFocusedDay.value.month,
                                    controller.calendarFocusedDay.value.day) !=
                                DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day)
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.background,
                      ),
                      // Selected Day
                      todayTextStyle: AppFonts.LabelMedium.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: SizeUtils.scale(1.5, size.width),
                        ),
                        color: DateTime(
                                    controller.calendarFocusedDay.value.year,
                                    controller.calendarFocusedDay.value.month,
                                    controller.calendarFocusedDay.value.day) !=
                                DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day)
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.background,
                      ),
                      // Saturday
                      weekendTextStyle: AppFonts.LabelMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      // Sunday
                      holidayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      holidayTextStyle: AppFonts.LabelMedium.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                      markerDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      outsideDaysVisible: false,
                      markerMargin: EdgeInsets.only(
                        top: SizeUtils.scale(6, size.width),
                      ),
                    ),
                    holidayPredicate: (day) {
                      return day.weekday > 6;
                    },
                    selectedDayPredicate: (day) =>
                        isSameDay(day, controller.selectedDate.value),
                    onDaySelected: controller.onDaySelected,
                    onPageChanged: controller.onPageChanged,
                    eventLoader: controller.eventLoader,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeUtils.scale(14, size.width),
                    horizontal: SizeUtils.scale(20, size.width)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              ? const MyNoData()
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.attendanceList.value.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: SizeUtils.scale(12, size.width),
                                  ),
                                  itemBuilder: (context, index) {
                                    final startBreak = controller.attendanceList
                                        .value[index].breakTime?.start;
                                    final checkOut = controller.attendanceList
                                        .value[index].checkOutDateTime;
                                    return Column(
                                      children: [
                                        checkOut != null
                                            ? ReportAttendanceCard(
                                                attendance: controller
                                                    .attendanceList
                                                    .value[index],
                                              )
                                            : const SizedBox.shrink(),
                                        SizedBox(
                                          height: startBreak != null
                                              ? SizeUtils.scale(12, size.width)
                                              : 0,
                                        ),
                                        startBreak != null
                                            ? ReportBreakCard(
                                                attendance: controller
                                                    .attendanceList
                                                    .value[index],
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    );
                                  },
                                ),
                    ),
                    LeaveTextTitle(leaves: controller.leaves),
                    Obx(
                      () => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.leaves.value.length,
                        separatorBuilder: (context, index) => SizedBox(
                          height: SizeUtils.scale(12, size.width),
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
            ],
          ),
        ),
      ),
    );
  }
}
