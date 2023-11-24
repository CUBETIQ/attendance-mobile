import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/core/widgets/textfield/texfield.dart';
import 'package:attendance_app/feature/login/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFieldForm(label: 'Username'),
              SizedBox(height: 10.h),
              MyTextFieldForm(label: 'Password'),
              FilledButton(
                onPressed: () {
                  MyTextFieldFormController.findController('Username').isValid;
                  MyTextFieldFormController.findController('Password').isValid;
                  if (MyTextFieldFormController.findController('Username')
                          .isValid &&
                      MyTextFieldFormController.findController('Password')
                          .isValid) {
                    print("dawdaw");
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
