import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timesync/core/widgets/snackbar/snackbar.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';

/// [DateFormatType] enum specifies the formating option for the date format
/// field.
///
/// example:
///
/// The date -> 2nd November 2022 is displayed in the different types as:
///
/// [type1] => 02/11/22
/// [type2] => 02/11/2022
/// [type3] => 02-11-22
/// [type4] => 02-11-2022

enum DateFormatType {
  type1, // 12/02/22
  type2, // 12/02/2022
  type3, // 12-02-22
  type4, // 12-02-2022
}

class InputDatePickerField extends StatelessWidget {
  InputDatePickerField({
    super.key,
    this.label,
    required this.onComplete,
    this.type = DateFormatType.type2,
    this.addCalendar = true,
    this.decoration,
    this.firstDate,
    this.calendarColor,
    this.hintText,
  }) : _dobFormater = TextEditingController();

  final String? label;
  final InputDecoration? decoration;
  final DateFormatType? type;
  final Function(DateTime?) onComplete;
  final bool addCalendar;
  final TextEditingController _dobFormater;
  final DateTime? firstDate;
  final String? hintText;
  final Color? calendarColor;
  final initialDate = Rxn<DateTime>();

  @override
  Widget build(BuildContext context) {
    void formatInput(String value) {
      DateTime? completeDate;
      switch (type) {
        case DateFormatType.type1:
          completeDate = Formater.type1(value, _dobFormater);
          break;
        case DateFormatType.type2:
          completeDate = Formater.type2(value, _dobFormater);
          break;
        case DateFormatType.type3:
          completeDate = Formater.type3(value, _dobFormater);
          break;
        case DateFormatType.type4:
          completeDate = Formater.type4(value, _dobFormater);
          break;
        default:
      }
      initialDate.value = completeDate;
      onComplete(completeDate);
    }

    Future<void> pickDate({DateTime? initDate}) async {
      bool isValidYear(int year) {
        return year >= 1900 && year <= 2100;
      }

      if (initDate != null) {
        final selectedYear = initDate.year;
        if (!isValidYear(selectedYear)) {
          // Show an error message for an invalid initial date
          showErrorSnackBar('Invalid Date', ' ');
          return; // Exit the function early
        }
      }

      if (firstDate != null && initDate != null) {
        if (initDate.isBefore(firstDate!)) {
          initDate = firstDate;
          // showErrorSnackBar('Inavlid Date', 'Please select a valid date');
          // return;
        }
      }

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: firstDate ?? initDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != DateTime.now()) {
        String inputText;

        initialDate.value = picked;
        switch (type) {
          case DateFormatType.type1:
            inputText =
                '${picked.day}/${picked.month.isLowerThan(10) ? '0${picked.month}' : picked.month}/${picked.year % 100}';
            break;
          case DateFormatType.type2:
            inputText =
                '${picked.day}/${picked.month.isLowerThan(10) ? '0${picked.month}' : picked.month}/${picked.year}';
            break;
          case DateFormatType.type3:
            inputText =
                '${picked.day}-${picked.month.isLowerThan(10) ? '0${picked.month}' : picked.month}-${picked.year % 100}';
            break;
          case DateFormatType.type4:
            inputText =
                '${picked.day}-${picked.month.isLowerThan(10) ? '0${picked.month}' : picked.month}-${picked.year}';
            break;
          default:
            inputText = '';
        }
        onComplete(picked);
        _dobFormater.text = inputText;
      }
    }

    return MyTextFieldForm(
      label: 'Date',
      textController: _dobFormater,
      onTap: () {
        _dobFormater.selection = TextSelection.fromPosition(
          TextPosition(offset: _dobFormater.text.length),
        );
      },
      hasLabel: true,
      hintText: hintText,
      haveSuffixIcon: true,
      suffixIcon: addCalendar
          ? IconButton(
              onPressed: () {
                pickDate(initDate: initialDate.value);
              },
              icon: Icon(
                Icons.calendar_today,
                color:
                    calendarColor ?? Theme.of(context).colorScheme.onBackground,
              ))
          : null,
      keyboardType: TextInputType.datetime,
      onChanged: formatInput,
    );
  }
}

class Formater {
  static int _parseInt(String input) {
    return int.parse(input);
  }

  static DateTime _parseDateTimeShort(String input) {
    int day = int.parse(input.substring(0, 2));
    int month = int.parse(input.substring(3, 5));
    int year = int.parse(input.substring(6, 8));
    return DateTime(year + 2000, month, day);
  }

  static DateTime _parseDateTimeLong(String input) {
    int day = int.parse(input.substring(0, 2));
    int month = int.parse(input.substring(3, 5));
    int year = int.parse(input.substring(6, 10));
    return DateTime(year, month, day);
  }

  static void _typeTemplate(String input, TextEditingController controller,
      String seperator, int lastIndex) {
    switch (input.length) {
      case 1:
        if (_parseInt(input) > 3) {
          controller.text = '0$input$seperator';
        }
        break;
      case 2:
        if (_parseInt(input) > 31) {
          controller.text = input[0];
        }
        break;
      case 3:
        if (input[2] != seperator) {
          controller.text = int.parse(input[2]) <= 1
              ? '${input.substring(0, 2)}$seperator${input[2]}'
              : '${input.substring(0, 2)}${seperator}0${input[2]}$seperator';
        }
        break;
      case 4:
        break;
      case 5:
        if (_parseInt(input.substring(3, 5)) > 12) {
          controller.text = input.substring(0, 4);
          break;
        }
        break;
      case 6:
        if (input[5] != seperator) {
          controller.text = '${input.substring(0, 5)}$seperator${input[5]}';
        }
        break;
      default:
        if (input.length == lastIndex) {
          controller.text = input.substring(0, lastIndex - 1);
        }
    }
    // move to the end of textfield
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );
  }

  static DateTime? type1(String input, TextEditingController controller) {
    int maxLength = 9;
    _typeTemplate(input, controller, '/', maxLength);
    if (input.length >= maxLength - 1) {
      return _parseDateTimeShort(input);
    }
    return null;
  }

  static DateTime? type2(String input, TextEditingController controller) {
    int maxLength = 11;
    _typeTemplate(input, controller, '/', maxLength);
    if (input.length >= maxLength - 1) {
      return _parseDateTimeLong(input);
    }
    return null;
  }

  static DateTime? type3(String input, TextEditingController controller) {
    int maxLength = 9;
    _typeTemplate(input, controller, '-', maxLength);
    if (input.length >= maxLength - 1) {
      return _parseDateTimeShort(input);
    }
    return null;
  }

  static DateTime? type4(String input, TextEditingController controller) {
    int maxLength = 11;
    _typeTemplate(input, controller, '-', maxLength);
    if (input.length >= maxLength - 1) {
      return _parseDateTimeLong(input);
    }
    return null;
  }
}
