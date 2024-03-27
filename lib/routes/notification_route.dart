import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timesync/feature/home/admin_leave_request/controller/index.dart';
import 'package:timesync/feature/leave/leave/controller/index.dart';
import 'package:timesync/types/notification_type.dart';
import 'package:timesync/core/model/notification_model.dart';
import 'package:timesync/core/model/task_model.dart';
import 'package:timesync/feature/home/home/controller/index.dart';
import 'package:timesync/feature/navigation/controller/index.dart';
import 'package:timesync/feature/task/task/controller/index.dart';
import 'package:timesync/routes/app_pages.dart';
import 'package:timesync/types/role.dart';
import 'package:timesync/utils/logger.dart';
import 'package:timesync/utils/string_util.dart';

import '../core/database/isar/controller/local_storage_controller.dart';

class NotifyRoutePage {
  static final NotifyRoutePage instance = NotifyRoutePage._();

  factory NotifyRoutePage() => instance;
  final localDB = LocalStorageController.getInstance();

  NotifyRoutePage._();

  static void pushToOtherPagesFromBackground(RemoteMessage message) async {
    Logs.e('pushToOtherPagesFromBackground: ${message.data}');
    final payload = message.data['payload'];
    final decodedPayload = json.decode(payload.toString());
    handlePayload(decodedPayload);
  }

  static void pushToOtherPagesFromForeground(
      NotificationResponse message) async {
    Logs.e('pushToOtherPagesFromForeground: ${message.payload}');
    if (message.payload == null || message.payload?.isEmpty == true) return;
    final raw = message.payload!.replaceAll('"', "");
    final payload = StringUtil.convertToJsonStringQuotes(raw: raw);
    final decodedPayload = json.decode(payload.toString());
    handlePayload(decodedPayload['payload']);
  }

  static void handlePayload(dynamic json) {
    final data = PayloadModel.fromJson(json);
    final type = data.type;
    final subType = data.data?.subtype;
    Logs.e('handlePayload: ${data.type}');
    if (type == NotificationType.checkIn || type == NotificationType.checkOut) {
      if (subType == NotificationSubType.checkInLate ||
          subType == NotificationSubType.checkOutLate) {
        _handleCheckInOut();
      }
    } else if (type == NotificationType.task) {
      _handleTask(data);
    } else if (type == NotificationType.leavePermission) {
      _handleLeavePermission(data);
    }
  }

  static void _handleCheckInOut() {
    if (Get.isRegistered<NavigationController>()) {
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 0) {
        NavigationController.to.selectedIndex.value = 0;
      }
      if (NavigationController.to.getUserRole.value == Role.admin) {
        HomeController.to.tabController?.animateTo(1);
      }
    }
  }

  static Future<void> _handleTask(PayloadModel data) async {
    String? id = data.data?.prop?["id"];
    TaskModel? task;
    if (id == null) return;

    if (Get.isRegistered<NavigationController>()) {
      Get.offNamed(Routes.NAVIGATION);

      if (NavigationController.to.selectedIndex.value != 2) {
        NavigationController.to.selectedIndex.value = 2;
      }
      await Future.delayed(const Duration(milliseconds: 250));
      if (Get.isRegistered<TaskController>()) {
        final worker = ever(TaskController.to.tasks, (value) {
          if (value.isNotEmpty) {
            task = value.firstWhereOrNull((element) => element.id == id);
            if (task != null) {
              TaskController.to.onTapTask(task!);
            }
          }
        });
        Future.delayed(const Duration(seconds: 30), () {
          worker.dispose();
        });
      }
    }
  }

  static Future<void> _handleLeavePermission(PayloadModel data) async {
    final subType = data.data?.subtype;
    String? id = data.data?.prop?["id"];
    if (id == null) return;

    if (Get.isRegistered<NavigationController>()) {
      Get.offNamed(Routes.NAVIGATION);

      if (subType == NotificationSubType.leaveRequest) {
        if (NavigationController.to.getUserRole.value == Role.admin) {
          if (NavigationController.to.selectedIndex.value != 0) {
            NavigationController.to.selectedIndex.value = 0;
          }
          if (Get.isRegistered<HomeController>()) {
            HomeController.to.tabController?.animateTo(0);
            Get.toNamed(
              Routes.ADMIN_LEAVE_REQUEST,
              arguments: HomeController.to.staffs.value,
            );
            await Future.delayed(const Duration(milliseconds: 250));
            if (Get.isRegistered<AdminLeaveRequestController>()) {
              final worker =
                  ever(AdminLeaveRequestController.to.leaveList, (value) {
                if (value.isNotEmpty) {
                  Logs.e('List ${value.map((e) => e.id).toList()}');
                  Logs.e('Here $id');
                  final index = value.indexWhere((element) => element.id == id);

                  if (index == -1) return;
                  AdminLeaveRequestController.to.onTapView(index);
                }
              });

              Future.delayed(const Duration(seconds: 30), () {
                worker.dispose();
              });
            }
          }
        }
      } else if (subType == NotificationSubType.leaveApproval) {
        if (NavigationController.to.selectedIndex.value != 3) {
          NavigationController.to.selectedIndex.value = 3;
        }
        await Future.delayed(const Duration(milliseconds: 250));
        if (Get.isRegistered<LeaveController>()) {
          final worker = ever(LeaveController.to.leaves, (value) {
            if (value.isNotEmpty) {
              final index = value.indexWhere((element) => element.id == id);
              if (index == -1) return;
              LeaveController.to.onTapView(index);
            }
          });
          Future.delayed(const Duration(seconds: 30), () {
            worker.dispose();
          });
        }
      }
    }
  }
}
