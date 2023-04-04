import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/model/menu_model.dart';
import 'package:ideas_desktop/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop/view/menu/create-condiment-group/create_condiment_group_view_model.dart';

class CreateCondimentGroupPage extends StatelessWidget {
  const CreateCondimentGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    CreateCondimentGroupController controller =
        Get.put(CreateCondimentGroupController());
    return SafeArea(
      child: Obx(() {
        return !controller.isLoading.value
            ? buildBody(controller)
            : const LoadingPage();
      }),
    );
  }

  Widget buildBody(CreateCondimentGroupController controller) {
    return Dialog(
      child: Container(
        width: 520,
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
                      "Yeni Ekseçim Grubu",
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
                    "Ekseçim Grup Adı (Türkçe): ",
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
                    "Ekseçim Grup Adı (İngilizce): ",
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
              children: [
                const SizedBox(
                  width: 180,
                  child: Text(
                    "Ekseçimler: ",
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
                          'Ekseçim Seçiniz',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: buildCondimentDropdownItems(controller),
                      onChanged: (value) {},
                      buttonHeight: 40,
                      buttonWidth: 230,
                      itemHeight: 30,
                      dropdownWidth: 300,
                      searchController: controller.searchCondimentCtrl,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          controller: controller.searchCondimentCtrl,
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
                      value: controller.selectedItems.isEmpty
                          ? null
                          : controller.selectedItems.last,
                      selectedItemBuilder: (context) {
                        var count = controller.getRowCount() +
                            controller.condiments.length;
                        return List.generate(count, (index) {
                          return Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              controller.getSelectedCondimentNames() +
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
                ElevatedButton(
                    onPressed: () => controller.openNewCondimentDialog(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50]),
                    child: const Text(
                      "Yeni Ekseçim",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const SizedBox(
                  width: 180,
                  child: Text(
                    "Ürünler: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: Obx(() {
                    return DropdownButton2(
                      isExpanded: true,
                      hint: const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Ürün Seçiniz',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: buildMenuItemDropdownItems(controller),
                      onChanged: (value) {},
                      buttonHeight: 40,
                      buttonWidth: 300,
                      itemHeight: 30,
                      searchInnerWidgetHeight: 40,
                      searchController: controller.searchMenuItemCtrl,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          controller: controller.searchMenuItemCtrl,
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
                      dropdownWidth: 300,
                      itemPadding: EdgeInsets.zero,
                      value: controller.selectedMenuItems.isEmpty
                          ? null
                          : controller.selectedMenuItems.last,
                      selectedItemBuilder: (context) {
                        var count = controller.getRowCount();
                        return List.generate(count, (index) {
                          return Container(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text(
                              controller.getSelectedMenuItemsNames() +
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
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 174,
                  child: Text(
                    "Zorunlu: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.blue,
                        value: controller.input.value.isRequired,
                        onChanged: (valuee) {
                          controller.changeIsRequired(valuee!);
                        },
                      ),
                      Text(controller.input.value.isRequired!
                          ? "Evet"
                          : "Hayır"),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 174,
                  child: Text(
                    "Çoklu Seçim: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.blue,
                        value: controller.input.value.isMultiple,
                        onChanged: (valuee) {
                          controller.changeIsMultiple(valuee!);
                        },
                      ),
                      Text(controller.input.value.isMultiple!
                          ? "Evet"
                          : "Hayır"),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            if (controller.input.value.isMultiple!) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 180,
                    child: Text(
                      "Minumum Seçim Sayısı: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 30,
                    child: TextFormField(
                      controller: controller.minCountController,
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
                      "Maximum Seçim Sayısı: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    height: 30,
                    child: TextFormField(
                      controller: controller.maxCountController,
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
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 174,
                  child: Text(
                    "Önkoşul: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.blue,
                        value: controller.hasPrerequisite.value,
                        onChanged: (valuee) {
                          controller.changeIsPrerequiste(valuee!);
                        },
                      ),
                      Text(controller.hasPrerequisite.value ? "Evet" : "Hayır"),
                    ],
                  ),
                )
              ],
            ),
            if (controller.hasPrerequisite.value) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  const SizedBox(
                    width: 180,
                    child: Text(
                      "Önkoşul Ekseçimler: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: Obx(() {
                      return DropdownButton2(
                        isExpanded: true,
                        searchInnerWidgetHeight: 40,
                        hint: const Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            '',
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
                        searchController: controller.searchPrerequisteCtrl,
                        searchInnerWidget: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            controller: controller.searchPrerequisteCtrl,
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
                        value: controller.selectedPrerequisteItems.isEmpty
                            ? null
                            : controller.selectedPrerequisteItems.last,
                        selectedItemBuilder: (context) {
                          return List.generate(controller.condiments.length,
                              (index) {
                            return Container(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                controller.getSelectedPrerequisteNames() +
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
            ],
            const Divider(),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () => controller.createCondimentGroup(),
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

  List<DropdownMenuItem<CondimentForEditOutput>> buildPrerequisteItems(
      CreateCondimentGroupController controller) {
    List<DropdownMenuItem<CondimentForEditOutput>> ret = [];
    ret.add(
      DropdownMenuItem(
        enabled: false,
        value: CondimentForEditOutput(nameTr: ""),
        child: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "Ekseçimler",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
    for (var con in controller.condiments) {
      ret.add(DropdownMenuItem(
        value: con,
        enabled: false,
        child: Obx(() {
          return InkWell(
            onTap: () {
              controller.isPrerequisteSelected(con)
                  ? controller.removePrerequiste(con)
                  : controller.addPrerequiste(con);
            },
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  controller.isPrerequisteSelected(con)
                      ? const Icon(Icons.check_box_outlined)
                      : const Icon(Icons.check_box_outline_blank),
                  const SizedBox(width: 16),
                  Text(
                    '${con.nameTr!} (${con.price!.toStringAsFixed(2)} TL)',
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

  List<DropdownMenuItem<GetCategoriesMenuItemOutput>>
      buildMenuItemDropdownItems(CreateCondimentGroupController controller) {
    List<DropdownMenuItem<GetCategoriesMenuItemOutput>> ret = [];
    for (var cat in controller.categories) {
      for (var subcat in cat.menuItemSubCategories!) {
        ret.add(
          DropdownMenuItem(
            enabled: false,
            value: GetCategoriesMenuItemOutput(nameTr: subcat.nameTr),
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                subcat.nameTr!,
                style:
                    const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        );
        for (var menuItem in subcat.menuItems!) {
          ret.add(DropdownMenuItem(
            value: menuItem,
            enabled: false,
            child: Obx(() {
              return InkWell(
                onTap: () {
                  controller.isMenuItemSelected(menuItem)
                      ? controller.removeMenuItem(menuItem)
                      : controller.addMenuItem(menuItem);
                },
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      controller.isMenuItemSelected(menuItem)
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 16),
                      Text(
                        '${menuItem.nameTr!} (${menuItem.price!.toStringAsFixed(2)} TL)',
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
      }
    }

    return ret;
  }

  List<DropdownMenuItem<dynamic>> buildCondimentDropdownItems(
      CreateCondimentGroupController controller) {
    List<DropdownMenuItem<dynamic>> ret = [];
    ret.add(
      DropdownMenuItem(
        enabled: false,
        value: CondimentForEditOutput(nameTr: "Ekseçimler"),
        child: const Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            "Ekseçimler",
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
    for (var con in controller.condiments) {
      ret.add(DropdownMenuItem(
        value: con,
        enabled: false,
        child: Obx(() {
          return InkWell(
            onTap: () {
              controller.isCondimentSelected(con.condimentId!)
                  ? controller.removeCondiment(con)
                  : controller.addCondiment(con);
            },
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  controller.isCondimentSelected(con.condimentId!)
                      ? const Icon(Icons.check_box_outlined)
                      : const Icon(Icons.check_box_outline_blank),
                  const SizedBox(width: 16),
                  Text(
                    '${con.nameTr!} (${con.price!.toStringAsFixed(2)} TL)',
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

    for (var cat in controller.categories) {
      for (var subcat in cat.menuItemSubCategories!) {
        ret.add(
          DropdownMenuItem(
            enabled: false,
            value: subcat,
            child: Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                subcat.nameTr!,
                style:
                    const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        );
        for (var menuItem in subcat.menuItems!) {
          ret.add(DropdownMenuItem(
            value: menuItem,
            enabled: false,
            child: Obx(() {
              return InkWell(
                onTap: () {
                  controller.isCondimentMenuItemSelected(menuItem.menuItemId!)
                      ? controller.removeCondiment(menuItem)
                      : controller.addCondiment(menuItem);
                },
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      controller
                              .isCondimentMenuItemSelected(menuItem.menuItemId!)
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 16),
                      Text(
                        '${menuItem.nameTr!} (${menuItem.price!.toStringAsFixed(2)} TL)',
                        overflow: TextOverflow.clip,
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
      }
    }

    return ret;
  }
}
