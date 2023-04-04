import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/end-of-day/select-report/select_report_view_model.dart';

class SelectReportPage extends StatelessWidget {
  const SelectReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    SelectReportController controller = Get.put(SelectReportController());
    return SimpleDialog(
      children: [
        SizedBox(
          height: 330,
          width: 400,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: buildBody(controller),
          ),
        ),
      ],
    );
  }

  Widget buildBody(SelectReportController controller) {
    return Column(
      children: [
        const Text(
          'Yazdırılacak Raporları Seçiniz',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Obx(() {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      var report = controller.reportsLeft[index];
                      return CheckboxListTile(
                        value: report.isSelected,
                        onChanged: (_) => controller.selectReport(report),
                        title: Text(report.reportName),
                        activeColor: Colors.blue,
                      );
                    },
                    itemCount: controller.reportsLeft.length,
                  );
                }),
              ),
              Expanded(
                flex: 3,
                child: Obx(() {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      var report = controller.reportsRight[index];
                      return CheckboxListTile(
                        value: report.isSelected,
                        onChanged: (_) => controller.selectReport(report),
                        title: Text(report.reportName),
                      );
                    },
                    itemCount: controller.reportsRight.length,
                  );
                }),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed:
                  controller.loading.value ? null : () => controller.print(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.white),
              child: const Text("Yazdır"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              child: const Text("Vazgeç"),
            ),
            const SizedBox(width: 10),
          ],
        )
      ],
    );
  }
}
