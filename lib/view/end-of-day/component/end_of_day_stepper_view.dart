import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/end-of-day/component/end_of_day_stepper_view_model.dart';
import 'package:intl/intl.dart';
import '../../../theme/theme.dart';
import '../../_utility/loading/loading_screen.dart';
import '../../_utility/service_helper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EndOfDayStepperPage extends StatelessWidget with ServiceHelper {
  @override
  Widget build(BuildContext context) {
    EndOfDayStepperController controller = Get.put(EndOfDayStepperController());
    return Obx(() => controller.firstCheck.value != null &&
            controller.checkCount.value != null
        ? buildBody(context, controller)
        : LoadingPage());
  }

  SimpleDialog buildBody(
      BuildContext context, EndOfDayStepperController controller) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(0),
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
      title: Text(
        'Tarih Seçimi',
        style: TextStyle(color: Colors.white),
      ),
      content: buildDateStep(controller),
    );
    Step reportStep = Step(
      isActive: controller.stepIndex.value == 1,
      title: Text(
        'Rapor Seçimi',
        style: TextStyle(color: Colors.white),
      ),
      content: buildReportStep(controller),
    );
    Step informationStep = Step(
      isActive: controller.stepIndex.value == 2,
      title: Text(
        'Gün Sonu',
        style: TextStyle(color: Colors.white),
      ),
      content: buildInformationStep(controller),
    );
    Step serverStep = Step(
      isActive: controller.stepIndex.value == 3,
      title: Text(
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
            Text(
              'Yazdırılacak Raporları Seçiniz',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
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
                  Spacer(),
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
          Text(
            'Gün Sonu Bilgileri',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
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
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getDateString(controller.firstCheck.value!.createDate!),
                    style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    controller.dateCtrl.selectedDate != null
                        ? DateFormat('dd-MMMM-yyyy')
                            .format(controller.dateCtrl.selectedDate!)
                        : 'Gün sonu tarihi seçiniz.',
                    style: TextStyle(fontSize: 18, fontFamily: 'Arial'),
                  )
                ],
              ),
            ],
          ),
          Text(
            openChecksString(controller),
            style: TextStyle(
                fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
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
      res += '\nAçık Masa: ' + controller.checkCount.value!.table.toString();
    }
    if (controller.checkCount.value!.alias != 0) {
      res +=
          '\nAçık İsme Hesap: ' + controller.checkCount.value!.alias.toString();
    }
    if (controller.checkCount.value!.fastSell != 0) {
      res += '\nAçık Hızlı Satış: ' +
          controller.checkCount.value!.fastSell.toString();
    }
    if (controller.checkCount.value!.delivery != 0) {
      res += '\nAçık Paket Servis: ' +
          controller.checkCount.value!.delivery.toString();
    }
    if (controller.checkCount.value!.getir != 0) {
      res += '\nAçık Getir: ' + controller.checkCount.value!.getir.toString();
    }
    if (controller.checkCount.value!.yemeksepeti != 0) {
      res += '\nAçık Yemeksepeti: ' +
          controller.checkCount.value!.yemeksepeti.toString();
    }

    return res;
  }

  Widget buildServerStep(EndOfDayStepperController controller) {
    return SizedBox(
      height: 330,
      child: Column(
        children: [
          controller.serverConnectionSuccess.value == false
              ? Text(
                  "Gün sonu başarıyla alındı.\n\nGün sonu bilgilerini merkez bilgisayara atmak için önce 'Bağlantıyı Kontrol Et' tuşuna basınız.\n\nArdından veriler otomatik olarak atılacaktır.",
                  style: TextStyle(fontSize: 20, fontFamily: 'Arial'),
                )
              : Text("Veriler sunucuya aktarılıyor...",
                  style: TextStyle(fontSize: 20, fontFamily: 'Arial')),
        ],
      ),
    );
  }

  Widget buildCalender(EndOfDayStepperController controller) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SfDateRangePicker(
          backgroundColor: Colors.white,
          showNavigationArrow: true,
          initialSelectedDate: controller.firstCheck.value!.createDate,
          controller: controller.dateCtrl,
          initialDisplayDate: controller.firstCheck.value!.createDate,
          monthCellStyle: DateRangePickerMonthCellStyle(
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
            textStyle: TextStyle(
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
  const StepperButton({required this.text, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        margin: EdgeInsets.only(left: 10),
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
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
