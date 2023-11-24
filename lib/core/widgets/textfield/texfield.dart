import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/theme/font/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyTextFieldForm extends StatelessWidget {
  final String label;

  const MyTextFieldForm({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final isBiggerScreen = MediaQuery.of(context).size.width > 640;
    final controller = MyTextFieldFormController.findController(label);
    return GetBuilder<MyTextFieldFormController>(
      init: controller,
      builder: (_) => Form(
        key: controller.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: controller.textFieldController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: isBiggerScreen ? 12.h : 15.h,
              bottom: isBiggerScreen ? 12.h : 15.h,
            ),
            isDense: true,
            errorMaxLines: 2,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.r),
              borderSide: BorderSide(
                width: 1,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            errorStyle: isBiggerScreen ? BodyXXSmallMedium : BodyMediumMedium,
          ),
          style: isBiggerScreen ? BodyXSmallMedium : BodyMediumMedium,
          onChanged: (value) {
            controller.formKey.currentState?.validate();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
      ),
    );
  }
}
