import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop_getx/view/pos-integration/pos_integration_view_model.dart';
import 'package:ideas_desktop_getx/view/pos-integration/poss_table.dart';

class PosIntegrationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PosIntegrationController controller = Get.find();
    return SafeArea(
      child: Obx(() {
        return Scaffold(
          body: controller.possDataSource.value != null
              ? buildBody(controller)
              : LoadingPage(),
        );
      }),
    );
  }

  Widget buildBody(PosIntegrationController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // GestureDetector(
            //   onTap: () => value.savePriceChange(),
            //   child: Container(
            //     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //     width: 120,
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(4),
            //     ),
            //     padding: EdgeInsets.symmetric(vertical: 12),
            //     child: Text(
            //       'Kaydet',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(fontSize: 24),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () => controller.saveChanges(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Kaydet',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.addNewRow(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Yeni Kayıt',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Kapat',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: buildCancelReportTable(controller),
          ),
        ),
      ],
    );
  }

  Widget buildCancelReportTable(PosIntegrationController controller) {
    return Obx(() {
      return PossTable(
        source: controller.possDataSource.value!,
      );
    });
  }
}
