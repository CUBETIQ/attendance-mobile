import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync360/constants/font.dart';
import 'package:timesync360/core/widgets/text/text.dart';
import 'package:timesync360/routes/app_pages.dart';

showSessionExpiredDialog() {
  Get.dialog(
    barrierDismissible: false,
    Dialog(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) => false,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                text: "Session Expired",
                style: AppStyles().bodyLarge,
              ),
              const SizedBox(height: 5),
              MyText(
                text: "Your session has expired. Please login again.",
                style: AppStyles().bodyMediumRegular,
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.offAllNamed(Routes.LOGIN),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(Get.context!).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: MyText(
                      text: "Confirm",
                      style: AppStyles().bodyMediumRegular.copyWith(
                            color: Theme.of(Get.context!).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
