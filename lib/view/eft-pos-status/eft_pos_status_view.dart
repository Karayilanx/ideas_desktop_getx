// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/eft-pos-status/eft_pos_status_view_model.dart';

class EftPosStatusPage extends StatelessWidget {
  const EftPosStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final EftPosStatusController controller = Get.put(EftPosStatusController());
    return Dialog(
      child: Obx(
        () => Container(
          height: !controller.total
              ? 120 + controller.departments.length * 40
              : 240,
          padding: const EdgeInsets.all(8),
          width: controller.total ? 600 : 860,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Pos Cihazı Bağlantı Durumu",
                            style: TextStyle(fontSize: 20),
                          ),
                          const Divider(),
                          EftPosTextStatusWidget(
                              "Bağlantı başarısız",
                              "Pos Cihazına Bağlanılıyor",
                              "Bağlantı başarılı",
                              controller.connectionStatus.value),
                          const SizedBox(height: 8),
                          EftPosTextStatusWidget(
                              "Belge başlatma başarısız",
                              "Belge Başlatılıyor",
                              "Belge başlatıldı",
                              controller.startReceiptStatus.value),
                          const SizedBox(height: 8),
                          EftPosTextStatusWidget(
                              "Satış başarısız",
                              "Satış yapılıyor",
                              "Satış başarılı",
                              controller.saleStatus.value),
                          const SizedBox(height: 8),
                          EftPosTextStatusWidget(
                              "Belge kapatma başarısız",
                              "Belge kapatılıyor",
                              "Belge kapandı",
                              controller.closeStatus.value),
                        ],
                      ),
                    ),
                    if (!controller.total) const VerticalDivider(indent: 30),
                    if (!controller.total)
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              "Departmanlar",
                              style: TextStyle(fontSize: 20),
                            ),
                            const Divider(),
                            ...buildDepartments(controller),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!controller.total)
                    ElevatedButton(
                      onPressed: () => controller.paymentStart.value
                          ? null
                          : controller.checkAmount(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Fiş Başlat",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (controller.startReceiptStatus.value == Status.ERROR ||
                      controller.saleStatus.value == Status.ERROR ||
                      controller.closeStatus.value == Status.ERROR)
                    ElevatedButton(
                      onPressed: () => controller.voidReceipt(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Fiş İptal",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  const SizedBox(width: 8),
                  if (!controller.total)
                    ElevatedButton(
                      onPressed: () => controller.paymentStart.value
                          ? null
                          : Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 250, 94, 4),
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Vazgeç",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  buildDepartments(EftPosStatusController controller) {
    List<Widget> ret = [];
    for (var i = 0; i < controller.departments.length; i++) {
      var element = controller.departments[i];
      ret.add(
        Row(
          children: [
            Expanded(
              child: Text("${element.deptName!} (%${element.kdv})"),
            ),
            SizedBox(
              width: 90,
              height: 30,
              child: TextFormField(
                controller: controller.controllers[i],
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () =>
                    controller.getRemainingAmount(controller.controllers[i]),
                style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 12, 69, 192)),
                child: const Text("Tüm Tutar"),
              ),
            ),
          ],
        ),
      );
      ret.add(const SizedBox(height: 4));
    }
    return ret;
  }
}

class EftPosTextStatusWidget extends StatelessWidget {
  final String errorText;
  final String loadingText;
  final String successText;
  final Status status;
  const EftPosTextStatusWidget(
    this.errorText,
    this.loadingText,
    this.successText,
    this.status, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(status == Status.OK
            ? successText
            : status == Status.LOADING
                ? loadingText
                : errorText),
        const SizedBox(width: 30),
        if (status == Status.LOADING)
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 2,
            ),
          ),
        if (status == Status.OK) const Icon(Icons.check, color: Colors.green),
        if (status == Status.ERROR) const Icon(Icons.error, color: Colors.red),
        const Spacer(),
      ],
    );
  }
}

enum Status { OK, ERROR, LOADING }
