import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/delivery/couirer/couirer_view_model.dart';

class CouirerPage extends StatelessWidget {
  const CouirerPage({super.key});

  @override
  Widget build(BuildContext context) {
    CouirerController controller = Get.find();
    return Dialog(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Kurye Seçimi",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            height: 60,
            color: const Color(0xff2B393F),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        filled: true,
                        hintText: 'Kurye Adı',
                      ),
                      controller: controller.nameCtrl,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () => controller.addCourier(),
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        backgroundColor: const Color(0xffF1A159),
                        padding: const EdgeInsets.symmetric(vertical: 8)),
                    child: const Text("Kaydet"),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () => controller.deleteCourier(),
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 8)),
                    child: const Text("Sil"),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 8)),
                    child: const Text("Vazgeç"),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return GridView.count(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                crossAxisCount: 4,
                childAspectRatio: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: createCouirers(controller),
              );
            }),
          ),
        ],
      ),
    );
  }

  List<Widget> createCouirers(CouirerController controller) {
    List<Widget> ret = [];

    if (controller.couriers.isNotEmpty) {
      ret.addAll(List.generate(
        controller.couriers.length,
        (index) {
          return ElevatedButton(
            onPressed: () =>
                controller.selectCourier(controller.couriers[index].courierId!),
            style: ElevatedButton.styleFrom(
              backgroundColor: controller.couriers[index].courierId! ==
                      controller.selectedCourierId.value
                  ? Colors.blue
                  : Colors.green,
            ),
            child: Text(controller.couriers[index].courierName!),
          );
        },
      ));
    }

    return ret;
  }
}
