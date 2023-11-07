// ignore_for_file: must_be_immutable

import 'package:cubetiq_attendance_app/components/text/text.dart';
import 'package:cubetiq_attendance_app/config/theme/color/color_app.dart';
import 'package:cubetiq_attendance_app/config/theme/font/default_font.dart';
import 'package:flutter/material.dart';

class PasswordValidator extends StatelessWidget {
  final Function(bool)? isValidate;
  final String? password;
  final bool? checkValidate;

  PasswordValidator(
      {super.key, this.isValidate, required this.password, this.checkValidate})
      : assert(password != null);

  var isClose = false;

  @override
  Widget build(BuildContext context) {
    void validatePassword(String? password) {
      bool isPasswordEightCharacters = password != null && password.length >= 8;
      bool isPasswordOneUpperCase =
          password != null && RegExp(r'[A-Z]').hasMatch(password);
      bool isPasswordOneLowerCase =
          password != null && RegExp(r'[a-z]').hasMatch(password);
      bool isPasswordOneDigit =
          password != null && RegExp(r'[0-9]').hasMatch(password);
      bool isPasswordOneSpecialCharacter = password != null &&
          RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);

      bool isAllValid = isPasswordEightCharacters &&
          isPasswordOneUpperCase &&
          isPasswordOneLowerCase &&
          isPasswordOneDigit &&
          isPasswordOneSpecialCharacter;

      if (isValidate != null) {
        isValidate!(isAllValid);
        if (isAllValid == true) {
          isClose = true;
        }
      }
    }

    validatePassword(password);

    return isClose == true
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(left: 24, top: 10),
            child: Column(
              children: [
                ValidationRuleItem(
                  label: 'Password must be at least 8 characters long',
                  isValid: password != null && password!.length >= 8,
                  checkValidate: checkValidate,
                ),
                ValidationRuleItem(
                  label: 'Password must contain at least 1 uppercase letter',
                  isValid:
                      password != null && RegExp(r'[A-Z]').hasMatch(password!),
                  checkValidate: checkValidate,
                ),
                ValidationRuleItem(
                  label: 'Password must contain at least 1 lowercase letter',
                  isValid:
                      password != null && RegExp(r'[a-z]').hasMatch(password!),
                  checkValidate: checkValidate,
                ),
                ValidationRuleItem(
                  label: 'Password must contain at least 1 digit',
                  isValid:
                      password != null && RegExp(r'[0-9]').hasMatch(password!),
                  checkValidate: checkValidate,
                ),
                ValidationRuleItem(
                  label: 'Password must contain at least 1 special character',
                  isValid: password != null &&
                      RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password!),
                  checkValidate: checkValidate,
                ),
              ],
            ),
          );
  }
}

class ValidationRuleItem extends StatelessWidget {
  final String label;
  final bool isValid;
  final bool? checkValidate;

  const ValidationRuleItem({
    super.key,
    required this.label,
    required this.isValid,
    this.checkValidate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: isValid
                  ? MyAppColor.instance.alert.Success
                  : Colors.transparent,
              border: isValid
                  ? Border.all(color: Colors.transparent)
                  : Border.all(
                      width: 1,
                      color: checkValidate == true
                          ? MyAppColor.instance.alert.Error
                          : Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: isValid
                  ? Icon(
                      Icons.check,
                      color: MyAppColor.instance.light.L5,
                      size: 10,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          const SizedBox(width: 10.0),
          Flexible(
            child: MyText(
              text: label,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: BodySmallRegular.copyWith(
                fontSize: 12,
                color: isValid
                    ? MyAppColor.instance.alert.Success
                    : checkValidate == true
                        ? MyAppColor.instance.alert.Error
                        : Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
