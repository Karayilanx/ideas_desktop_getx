// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/select-condiment/viewmodel/select_condiment_view_model.dart';

import '../../../locale_keys_enum.dart';
import '../../../model/check_model.dart';
import '../../../model/menu_model.dart';
import '../component/condiment_button.dart';

class SelectCondimentPage extends StatelessWidget {
  const SelectCondimentPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final SelectCondimentController controller =
        Get.put(SelectCondimentController());
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.width * 90 / 100,
            minWidth: context.width * 90 / 100,
            maxHeight: context.height * 90 / 100,
            minHeight: context.height * 10 / 100,
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: context.theme.primaryColor,
                child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Seçimler',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 16),
                                child: Text(
                                  controller.sellUnitQuantity.value % 1 == 0
                                      ? controller.menuItem.nameTr!
                                      : '${controller.sellUnitQuantity.value} ${controller.menuItem.nameTr!}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                'Adet: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.decreaseAddCount();
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                  child: Text(
                                    ' - ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 50),
                                  ),
                                ),
                              ),
                              Text(
                                controller.addCount.value.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24),
                              ),
                              GestureDetector(
                                onTap: () => controller.increaseAddCount(),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                  child: Text(
                                    ' + ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 40),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xffEDEAE6),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(4),
                    separatorBuilder: (context, index) {
                      CondimentGroup group =
                          controller.menuItem.condimentGroups![index];
                      if (controller.isPreRequisteSelected(group)) {
                        return const Divider(thickness: 2);
                      } else {
                        return Container();
                      }
                    },
                    itemBuilder: (context, index) {
                      CondimentGroup group =
                          controller.menuItem.condimentGroups![index];
                      if (controller.isPreRequisteSelected(group)) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text(
                                  group.nameTr! +
                                      (group.isRequired! ? ' *' : ''),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 16,
                                  )),
                            ),
                            GridView.extent(
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 2.1,
                              maxCrossAxisExtent: getCondimentWidth(),
                              shrinkWrap: true,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              children: createCondimentButtons(group),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                    itemCount: controller.menuItem.condimentGroups!.length,
                  ),
                ),
              ),
              Container(
                color: context.theme.primaryColor,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffF1A159),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
                          child: Obx(() => Text(
                                controller.getTotalPrice().toStringAsFixed(2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                controller.handleOk();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 0),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Gönder',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffF1A159),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.handleClose();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Vazgeç',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  double getCondimentWidth() {
    final SelectCondimentController controller = Get.find();
    var widthStr = controller.localeManager
        .getStringValue(PreferencesKeys.MENU_ITEM_WIDTH);
    var res = double.tryParse(widthStr);
    if (res == null) {
      return 135;
    } else {
      return res;
    }
  }

  List<Widget> createCondimentButtons(CondimentGroup group) {
    final SelectCondimentController controller = Get.find();
    if (group.condiments!.isNotEmpty) {
      return List.generate(group.condiments!.length, (index) {
        CondimentModel condiment = group.condiments![index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Obx(() => CondimentButton(
                callback: () => controller.selectCondiment(condiment, group),
                condiment: condiment,
                isSelected: controller.isCondimentSelected(condiment, group),
              )),
        );
      });
    } else {
      return [];
    }
  }
}
