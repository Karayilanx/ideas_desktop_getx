import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/end-of-day/component/end_of_day_stepper_view_model.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../theme/theme.dart';
import '../../_utility/loading/loading_screen.dart';
import '../../_utility/service_helper.dart';

class EndOfDayStepperPage extends StatelessWidget with ServiceHelper {
  EndOfDayStepperPage({super.key});

  @override
  Widget build(BuildContext context) {
    EndOfDayStepperController controller = Get.put(EndOfDayStepperController());
    return Obx(() => controller.firstCheck.value != null &&
            controller.checkCount.value != null
        ? buildBody(context, controller)
        : const LoadingPage());
  }

  SimpleDialog buildBody(
      BuildContext context, EndOfDayStepperController controller) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(0),
      children: [
        SizedBox(
          height: 500,
          width: 700,
          child: Theme(
            data: ThemeData(
              canvasColor: ideasTheme.scaffoldBackgroundColor,
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: Colors.orange,
                    onSurface: Colors.grey,
                  ),
            ),
            child: Obx(() {
              return Stepper(
                controlsBuilder: (context, details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(() {
                        return StepperButton(
                          text: controller.stepIndex.value == 2
                              ? 'Gün Sonu Al'
                              : controller.stepIndex.value == 3 &&
                                      controller
                                              .serverConnectionSuccess.value ==
                                          false
                                  ? 'Bağlantıyı Kontrol Et'
                                  : 'Devam Et',
                          callback: () {
                            controller.stepIndex.value == 2
                                ? controller.endDay()
                                : controller.stepIndex.value == 3 &&
                                        controller.serverConnectionSuccess
                                                .value ==
                                            false
                                    ? controller.tryServerConnection()
                                    : controller.stepForward();
                          },
                        );
                      }),
                      StepperButton(
                        text: controller.stepIndex.value == 0
                            ? 'Vazgeç'
                            : controller.stepIndex.value == 3
                                ? 'Kapat'
                                : 'Geri Dön',
                        callback: () {
                          controller.stepIndex.value == 0
                              ? Get.back()
                              : controller.stepIndex.value == 3
                                  ? Get.back(result: true)
                                  : controller.stepBack();
                        },
                      ),
                    ],
                  );
                },
                steps: buildStep(controller),
                currentStep: controller.stepIndex.value,
                type: StepperType.horizontal,
              );
            }),
          ),
        )
      ],
    );
  }

  List<Step> buildStep(EndOfDayStepperController controller) {
    List<Step> ret = [];
    Step dateStep = Step(
      isActive: controller.stepIndex.value == 0,
      title: const Text(
        'Tarih Seçimi',
        style: TextStyle(color: Colors.white),
      ),
      content: buildDateStep(controller),
    );
    Step reportStep = Step(
      isActive: controller.stepIndex.value == 1,
      title: const Text(
        'Rapor Seçimi',
        style: TextStyle(color: Colors.white),
      ),
      content: buildReportStep(controller),
    );
    Step informationStep = Step(
      isActive: controller.stepIndex.value == 2,
      title: const Text(
        'Gün Sonu',
        style: TextStyle(color: Colors.white),
      ),
      content: buildInformationStep(controller),
    );
    Step serverStep = Step(
      isActive: controller.stepIndex.value == 3,
      title: const Text(
        'Sunucu Bİlgileri',
        style: TextStyle(color: Colors.white),
      ),
      content: buildServerStep(controller),
    );
    ret.add(dateStep);
    ret.add(reportStep);
    ret.add(informationStep);
    ret.add(serverStep);
    return ret;
  }

  Widget buildDateStep(EndOfDayStepperController controller) {
    return SizedBox(
      height: 330,
      child: Column(
        children: [
          buildCalender(controller),
        ],
      ),
    );
  }

  Widget buildReportStep(EndOfDayStepperController controller) {
    return SizedBox(
        height: 330,
        child: Column(
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
                  const Spacer(),
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
                  const Spacer(),
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildInformationStep(EndOfDayStepperController controller) {
    return SizedBox(
      height: 330,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gün Sonu Bilgileri',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Gün Sonu Açılış Tarihi:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial'),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Seçilen Gün Sonu Tarihi:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial'),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getDateString(controller.firstCheck.value!.createDate!),
                    style: const TextStyle(fontSize: 18, fontFamily: 'Arial'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.dateCtrl.selectedDate != null
                        ? DateFormat('dd-MMMM-yyyy')
                            .format(controller.dateCtrl.selectedDate!)
                        : 'Gün sonu tarihi seçiniz.',
                    style: const TextStyle(fontSize: 18, fontFamily: 'Arial'),
                  )
                ],
              ),
            ],
          ),
          Text(
            openChecksString(controller),
            style: const TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            "Gün sonunu tamamlamak için 'Gün Sonu Al' butonuna tıklayınız ve bekleyiniz.\n İşlem bitene kadar bilgisayarınızı kapatmayınız.",
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  String openChecksString(EndOfDayStepperController controller) {
    String res = '';
    if (controller.checkCount.value!.table != 0) {
      res += '\nAçık Masa: ${controller.checkCount.value!.table}';
    }
    if (controller.checkCount.value!.alias != 0) {
      res += '\nAçık İsme Hesap: ${controller.checkCount.value!.alias}';
    }
    if (controller.checkCount.value!.fastSell != 0) {
      res += '\nAçık Hızlı Satış: ${controller.checkCount.value!.fastSell}';
    }
    if (controller.checkCount.value!.delivery != 0) {
      res += '\nAçık Paket Servis: ${controller.checkCount.value!.delivery}';
    }
    if (controller.checkCount.value!.getir != 0) {
      res += '\nAçık Getir: ${controller.checkCount.value!.getir}';
    }
    if (controller.checkCount.value!.yemeksepeti != 0) {
      res += '\nAçık Yemeksepeti: ${controller.checkCount.value!.yemeksepeti}';
    }

    return res;
  }

  Widget buildServerStep(EndOfDayStepperController controller) {
    return SizedBox(
      height: 330,
      child: Column(
        children: [
          controller.serverConnectionSuccess.value == false
              ? const Text(
                  "Gün sonu başarıyla alındı.\n\nGün sonu bilgilerini merkez bilgisayara atmak için önce 'Bağlantıyı Kontrol Et' tuşuna basınız.\n\nArdından veriler otomatik olarak atılacaktır.",
                  style: TextStyle(fontSize: 20, fontFamily: 'Arial'),
                )
              : const Text("Veriler sunucuya aktarılıyor...",
                  style: TextStyle(fontSize: 20, fontFamily: 'Arial')),
        ],
      ),
    );
  }

  Widget buildCalender(EndOfDayStepperController controller) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SfDateRangePicker(
          backgroundColor: Colors.white,
          showNavigationArrow: true,
          initialSelectedDate: controller.firstCheck.value!.createDate,
          controller: controller.dateCtrl,
          initialDisplayDate: controller.firstCheck.value!.createDate,
          monthCellStyle: const DateRangePickerMonthCellStyle(
            specialDatesTextStyle:
                TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            textStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            todayTextStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          selectionColor: Colors.orange,
          maxDate: DateTime.now(),
          monthViewSettings: DateRangePickerMonthViewSettings(
              specialDates: controller.specialDates),
          headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: ideasTheme.scaffoldBackgroundColor,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }
}

class StepperButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const StepperButton({super.key, required this.text, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ideasTheme.scaffoldBackgroundColor,
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
