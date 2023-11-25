import 'package:attendance_app/config/app_size.dart';
import 'package:attendance_app/core/widgets/console/console.dart';
import 'package:attendance_app/core/widgets/textfield/controller/textfield_controller.dart';
import 'package:attendance_app/core/widgets/textfield/texfield_validate.dart';
import 'package:attendance_app/feature/login/controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextFieldForm(
              label: 'Username',
              textController: controller.usernameController,
            ),
            const SizedBox(height: AppSize.spacingMedium),
            MyTextFieldForm(
              label: 'Password',
              textController: controller.passwordController,
            ),
            const SizedBox(height: AppSize.spacingMedium),
            ElevatedButton(
              onPressed: () {
                MyTextFieldFormController.findController('Username').isValid;
                MyTextFieldFormController.findController('Password').isValid;
                Console.log(controller.usernameController.text,
                    controller.passwordController.text);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
