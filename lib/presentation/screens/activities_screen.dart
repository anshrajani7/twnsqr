import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twnsqr/controllers/activity_controller.dart';
import 'package:twnsqr/presentation/layouts/mobile_layout.dart';
import 'package:twnsqr/presentation/layouts/tablet_layout.dart';
import 'package:twnsqr/presentation/layouts/desktop_layout.dart';
import 'package:twnsqr/utils/responsive_layout.dart';

class ResponsiveActivitiesScreen extends StatelessWidget {
  ResponsiveActivitiesScreen({Key? key}) : super(key: key);

  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: ResponsiveLayout(
        mobile: MobileLayout(controller: controller),
        tablet: TabletLayout(controller: controller),
        desktop: DesktopLayout(controller: controller),
      ),
    );
  }
}