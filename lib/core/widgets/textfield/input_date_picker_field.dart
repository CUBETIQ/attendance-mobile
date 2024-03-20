import 'package:flutter/material.dart';
import 'package:timesync/core/widgets/textfield/texfield_validate.dart';

enum DateFormatType {
  type1, // 12/02/22
  type2, // 12/02/2022
  type3, // 12-02-22
  type4, // 12-02-2022
}

class InputDatePickerField extends StatefulWidget {
  const InputDatePickerField({
    super.key,
    required this.onComplete,
    this.type = DateFormatType.type2,
    this.addCalendar = true,
    this.decoration,
    this.controller,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.label,
    this.focusNode,
  });

  final InputDecoration? decoration;
  final DateFormatType? type;
  final Function(DateTime?) onComplete;
  final bool addCalendar;
  final DateTime? initialDate;
  final DateTime? lastDate;
  final DateTime? firstDate;
  final FocusNode? focusNode;
  final String? label;
  final TextEditingController? controller;

  @override
  State<InputDatePickerField> createState() => _InputDatePickerFieldState();
}

class _InputDatePickerFieldState extends State<InputDatePickerField> {
  late final TextEditingController _dobFormater;

  @override
  void initState() {
    _dobFormater = widget.controller ?? TextEditingController();
    super.initState();
  }

  InputDecoration? decoration() {
    if (!widget.addCalendar) return widget.decoration;

    if (widget.decoration == null) {
      return InputDecoration(
        suffixIcon: IconButton(
          onPressed: pickDate,
          icon: const Icon(Icons.calendar_month),
        ),
      );
    }

    return widget.decoration!.copyWith(
      suffixIcon: IconButton(
        onPressed: pickDate,
        icon: const Icon(Icons.calendar_month),
      ),
    );
  }

  void formatInput(String value) {
    /// formater for the text input field
    DateTime? completeDate;
    switch (widget.type) {
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
    setState(() {
      // update the datetime
      widget.onComplete(completeDate);
    });
  }

  Future<void> pickDate() async {
    /// pick the date directly from the screen
    final picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate ?? DateTime(1800),
      lastDate: widget.lastDate ?? DateTime(3000),
    );
    if (picked != null) {
      String inputText;
      switch (widget.type) {
        case DateFormatType.type1:
          inputText =
              '${padDayMonth(picked.day)}/${padDayMonth(picked.month)}/${picked.year % 100}';
          break;
        case DateFormatType.type2:
          inputText =
              '${padDayMonth(picked.day)}/${padDayMonth(picked.month)}/${picked.year}';
          break;
        case DateFormatType.type3:
          inputText =
              '${padDayMonth(picked.day)}-${padDayMonth(picked.month)}-${picked.year % 100}';
          break;
        case DateFormatType.type4:
          inputText =
              '${padDayMonth(picked.day)}-${padDayMonth(picked.month)}-${picked.year}';
          break;
        default:
          inputText = '';
      }
      setState(() {
        _dobFormater.text = inputText;
      });
      widget.onComplete(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyTextFieldForm(
      hasLabel: true,
      label: widget.label ?? 'Date',
      textController: _dobFormater,
      onTap: () {
        _dobFormater.selection = TextSelection.fromPosition(
          TextPosition(offset: _dobFormater.text.length),
        );
      },
      focusNode: widget.focusNode,
      keyboardType: TextInputType.datetime,
      onChanged: formatInput,
      haveSuffixIcon: true,
      suffixIcon: IconButton(
        onPressed: pickDate,
        icon: const Icon(Icons.calendar_month),
      ),
    );
  }

  String padDayMonth(int value) => value.toString().padLeft(2, '0');
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
