import 'package:attendance_app/core/widgets/button/back_button.dart';
import 'package:attendance_app/core/widgets/image/cache_image_organization.dart';
import 'package:attendance_app/core/widgets/text/app_bar_title.dart';
import 'package:attendance_app/core/widgets/text/text.dart';
import 'package:attendance_app/feature/organization/controller/index.dart';
import 'package:attendance_app/utils/size_util.dart';
import 'package:flutter/material.dart';

class OrganizationViewMobile extends StatelessWidget {
  const OrganizationViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrganizationController.to;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const MyAppBarTitle(title: "Organization"),
        centerTitle: true,
        leading: const MyBackButton(),
        automaticallyImplyLeading: false,
        elevation: 2,
      ),
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //  SizedBox(height: SizeUtils.scale(, width)),
              Center(
                child: MyCacheImageOrganization(
                  imageUrl: null,
                  width: SizeUtils.scale(85, size.width),
                  height: SizeUtils.scale(85, size.width),
                ),
              ),
              MyText(text: controller.organization.value.name ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}
