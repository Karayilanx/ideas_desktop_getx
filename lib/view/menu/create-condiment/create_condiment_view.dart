import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop/view/menu/create-condiment/create_condiment_view_model.dart';

class CreateCondimentPage extends StatelessWidget {
  const CreateCondimentPage({super.key});

  @override
  Widget build(BuildContext context) {
    CreateCondimentController controller = Get.put(CreateCondimentController());
    return SafeArea(
      child: Obx(() {
        return !controller.isLoading.value
            ? buildBody(controller)
            : const LoadingPage();
      }),
    );
  }

  Widget buildBody(CreateCondimentController controller) {
    return Dialog(
      child: Container(
        width: 480,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Yeni Ekseçim",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 28,
                    ))
              ],
            ),
            const Divider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 180,
                  child: Text(
                    "Ekseçim Adı (Türkçe): ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 30,
                  child: TextFormField(
                    controller: controller.nameTrController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 180,
                  child: Text(
                    "Ekseçim Adı (İngilizce): ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 30,
                  child: TextFormField(
                    controller: controller.nameEnController,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 180,
                  child: Text(
                    "Satış Fiyatı(Kdv Dahil): ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 30,
                  child: TextFormField(
                    controller: controller.priceCtrl,
                    style: const TextStyle(fontSize: 16),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      hintText: "Fiyat",
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const SizedBox(
                  width: 180,
                  child: Text(
                    "Ekseçim Grupları: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: Obx(() {
                    return DropdownButton2(
                      searchInnerWidgetHeight: 40,
                      isExpanded: true,
                      hint: const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Ekseçim grubu seçimi',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: buildPrerequisteItems(controller),
                      onChanged: (value) {},
                      buttonHeight: 40,
                      buttonWidth: 300,
                      itemHeight: 30,
                      dropdownWidth: 300,
                      searchController: controller.searchCondimentGroupCtrl,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          controller: controller.searchCondimentGroupCtrl,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Arama...',
                            hintStyle: const TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.value!.nameTr
                            .toString()
                            .toLowerCase()
                            .contains(searchValue.toLowerCase()));
                      },
                      itemPadding: EdgeInsets.zero,
                      value: controller.selectedCondimentGroups.isEmpty
                          ? null
                          : controller.selectedCondimentGroups.last,
                      selectedItemBuilder: (context) {
                        return List.generate(controller.condimentGroups.length,
                            (index) {
                          return Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              controller.getSelectedCondimentGrouppNames() +
                                  " tane seçildi",
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                            ),
                          );
                        });
                      },
                    );
                  }),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () => controller.createCondiment(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text(
                    "Kaydet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<CondimentGroupForEditOutput>> buildPrerequisteItems(
      CreateCondimentController controller) {
    List<DropdownMenuItem<CondimentGroupForEditOutput>> ret = [];
    ret.add(
      DropdownMenuItem(
        enabled: false,
        value: CondimentGroupForEditOutput(nameTr: ""),
        child: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "Ekseçim Grupları",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
    for (var congr in controller.condimentGroups) {
      ret.add(DropdownMenuItem(
        value: congr,
        enabled: false,
        child: Obx(() {
          return InkWell(
            onTap: () {
              controller.isCondimentGroupSelected(congr)
                  ? controller.removeCondimentGroup(congr)
                  : controller.addCondimentGroup(congr);
            },
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  controller.isCondimentGroupSelected(congr)
                      ? const Icon(Icons.check_box_outlined)
                      : const Icon(Icons.check_box_outline_blank),
                  const SizedBox(width: 16),
                  Text(
                    congr.nameTr!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ));
    }

    return ret;
  }
}
