import 'package:attendance_app/core/widgets/layout_builder/responsive_layout.dart';
import 'package:attendance_app/feature/profile/edit_profile/controller/index.dart';
import 'package:attendance_app/feature/profile/edit_profile/view/mobile/index.dart';
import 'package:attendance_app/feature/profile/edit_profile/view/tablet/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
      tablet: EditProfileViewTablet(),
      mobile: EditProfileViewMobile(),
    );
  }
}
