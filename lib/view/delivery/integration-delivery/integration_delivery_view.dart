import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/delivery/integration-delivery/integration_delivery_view_model.dart';
import '../../../image/image_constatns.dart';
import '../../../locale_keys_enum.dart';
import '../../_utility/loading/loading_screen.dart';
import '../table/integration_delivery_order_table.dart';

class IntegrationDeliveryPage extends StatelessWidget {
  const IntegrationDeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    IntegrationDeliveryController controller = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          return SafeArea(
            child: !controller.isLoading.value
                ? buildBody(controller)
                : const LoadingPage(),
          );
        },
      ),
    );
  }

  Widget buildBody(IntegrationDeliveryController controller) {
    return Column(
      children: [
        Container(
          height: 60,
          color: const Color(0xff253139),
          child: Obx(() {
            return buildTopButtons(controller);
          }),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey[300]!)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 65,
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      color: const Color(0xFFF8F9FB)),
                  child: buildMiddleRow(controller),
                ),
                Obx(
                  () => Expanded(
                    child: IntegrationDeliveryOrderTable(
                      source: controller.source.value!,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Row buildTopButtons(IntegrationDeliveryController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        controller.localeManager.getBoolValue(PreferencesKeys.USE_YEMEKSEPETI)
            ? IntegrationDeliveryTopButton(
                callback: () => controller.changeSelectedIntegration(0),
                image: Image.asset(ImageConstants.instance.yemeksepetiLogo),
                color: const Color(0xFFFC0151),
                isActive: controller.selectedIntegration.value == 0,
              )
            : Container(),
        controller.localeManager.getBoolValue(PreferencesKeys.USE_GETIR)
            ? IntegrationDeliveryTopButton(
                callback: () => controller.changeSelectedIntegration(1),
                image: Image.asset(ImageConstants.instance.getirLogo),
                color: const Color(0xFF5D3EBD),
                isActive: controller.selectedIntegration.value == 1,
              )
            : controller.localeManager.getBoolValue(PreferencesKeys.USE_FUUDY)
                ? IntegrationDeliveryTopButton(
                    callback: () => controller.changeSelectedIntegration(3),
                    image: Image.asset(
                      ImageConstants.instance.fuudy,
                    ),
                    color: const Color(0xFFefca88),
                    isActive: controller.selectedIntegration.value == 3,
                  )
                : Container(),
        IntegrationDeliveryTopButton(
          callback: () => controller.changeSelectedIntegration(2),
          image: Image.asset(ImageConstants.instance.paket),
          color: const Color.fromARGB(255, 109, 60, 255),
          isActive: controller.selectedIntegration.value == 2,
        ),
        Expanded(child: Container()),
        if (controller.selectedIntegration.value == 2)
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 150,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed('delivery-customer-page', arguments: false);
                },
                child: const Text('Müşteriler')),
          ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: 150,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Get.offNamed('/home');
              },
              child: const Text(
                'Kapat',
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Row buildMiddleRow(IntegrationDeliveryController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            buildOrderText(controller),
            if (controller.selectedIntegration.value == 2)
              GestureDetector(
                onTap: () => controller.navigateToRestaurantDeliveryOrder(),
                child: Container(
                  height: 40,
                  width: 120,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  child: const Text(
                    "Yeni Sipariş",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        Wrap(
          children: [
            // Observer(
            //   builder: (_) {
            //     return buildCourierSwitch(value);
            //   },
            // ),
            const SizedBox(width: 20),
            Obx(
              () {
                return buildRestaurantSwitch(controller);
              },
            ),
            const SizedBox(width: 20),
            buildDeliveryStatusDropdown(controller),
          ],
        ),
      ],
    );
  }

  Widget buildOrderText(IntegrationDeliveryController controller) {
    return Text(
      'Aktif Siparişler(${controller.source.value!.rows.length})',
      style: const TextStyle(fontSize: 20),
    );
  }

  Widget buildCourierSwitch(IntegrationDeliveryController controller) {
    return controller.selectedIntegration.value == 0
        ? Container()
        : Column(
            children: [
              const Text(
                'Kurye',
                style: TextStyle(fontSize: 18),
              ),
              FlutterSwitch(
                value: controller.getirCourierStatus.value,
                onToggle: (val) {
                  // value.changeCourierStatus(val);
                },
                disabled: true,
                activeColor: Colors.green[800]!,
                activeText: 'Müsait',
                inactiveColor: Colors.red,
                inactiveText: 'Kapalı',
                width: 80,
                height: 26,
                activeTextColor: Colors.white,
                showOnOff: true,
                valueFontSize: 14,
                activeTextFontWeight: FontWeight.normal,
                inactiveTextFontWeight: FontWeight.normal,
              ),
            ],
          );
  }

  Column buildRestaurantSwitch(IntegrationDeliveryController controller) {
    return controller.selectedIntegration.value == 0
        ? Column(
            children: [
              const Text(
                'Restoran Durumu',
                style: TextStyle(fontSize: 18),
              ),
              FlutterSwitch(
                value: controller.yemeksepetiRestaurantStatus.value,
                onToggle: (val) async {
                  await controller.updateRestaurantState(val);
                },
                activeColor: Colors.green[800]!,
                activeText: 'Açık',
                inactiveColor: Colors.red,
                inactiveText: 'Kapalı',
                width: 80,
                height: 26,
                activeTextColor: Colors.white,
                showOnOff: true,
                valueFontSize: 14,
                activeTextFontWeight: FontWeight.normal,
                inactiveTextFontWeight: FontWeight.normal,
              ),
            ],
          )
        : Column(
            // children: [
            //   // Text(
            //   //   'Restorant',
            //   //   style: TextStyle(fontSize: 18),
            //   // ),
            //   // FlutterSwitch(
            //   //   value: value.getirRestaurantStatus,
            //   //   onToggle: (val) {
            //   //     value.changeRestaurantStatus(val);
            //   //   },
            //   //   disabled: true,
            //   //   activeColor: Colors.green[800]!,
            //   //   activeText: 'Açık',
            //   //   inactiveColor: Colors.red,
            //   //   inactiveText: 'Kapalı',
            //   //   width: 80,
            //   //   height: 26,
            //   //   activeTextColor: Colors.white,
            //   //   showOnOff: true,
            //   //   valueFontSize: 14,
            //   //   activeTextFontWeight: FontWeight.normal,
            //   //   inactiveTextFontWeight: FontWeight.normal,
            //   // ),
            // ],
            );
  }

  Widget buildDeliveryStatusDropdown(IntegrationDeliveryController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconSize: 30,
            items: getDeliveryStatusDropdownItems(),
            value: controller.selectedDeliveryStatusType.value,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
            onChanged: (dynamic newGroup) {
              controller.changeDeliveryStatus(newGroup);
            },
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem> getDeliveryStatusDropdownItems() {
    List<DropdownMenuItem> ret = [];
    ret.add(
      const DropdownMenuItem(
        value: 0,
        child: Text(
          'Gelen Siparişler',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
    ret.add(
      const DropdownMenuItem(
        value: 1,
        child: Text(
          'Tamamlanan Siparişler',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
    ret.add(
      const DropdownMenuItem(
        value: 2,
        child: Text(
          'İptal Edilen Siparişler',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
    ret.add(
      const DropdownMenuItem(
        value: 3,
        child: Text(
          'İleri Zamanlı Siparişler',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
    );
    return ret;
  }
}

class IntegrationDeliveryTopButton extends StatelessWidget {
  final VoidCallback callback;
  final Image image;
  final Color color;
  final bool isActive;
  const IntegrationDeliveryTopButton({
    super.key,
    required this.callback,
    required this.image,
    required this.color,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 200),
      child: GestureDetector(
        onTap: () => callback(),
        child: Container(
          foregroundDecoration: BoxDecoration(
            color:
                isActive ? color.withOpacity(0) : Colors.grey.withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
          margin: const EdgeInsets.fromLTRB(8, 10, 4, 10),
          padding: const EdgeInsets.all(8),
          child: image,
        ),
      ),
    );
  }
}
