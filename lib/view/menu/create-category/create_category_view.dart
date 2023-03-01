import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop_getx/view/menu/create-category/create_category_view_model.dart';

class CreateCategoryPage extends StatelessWidget {
  const CreateCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CreateCategoryController controller = Get.put(CreateCategoryController());
    return SafeArea(
      child: Obx(() {
        return !controller.showLoading.value
            ? buildBody(controller)
            : const LoadingPage();
      }),
    );
  }

  Widget buildBody(CreateCategoryController controller) {
    return Dialog(
      child: Container(
        width: 500,
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
                      "Kategori Ekle/Düzenle",
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Ana Kategoriler",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const SizedBox(
                        width: 170,
                        child: Text(
                          "Kategori: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: Obx(
                          () => DropdownButton2(
                            isExpanded: true,
                            hint: const Text(
                              'Kategori Seçiniz',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            items: controller.categories.map((cat) {
                              return DropdownMenuItem<int>(
                                value: cat.menuItemCategoryId,
                                child: Text(
                                  cat.menuItemCategoryId == -1
                                      ? "Yeni Kategori"
                                      : cat.nameTr!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                            value: controller.selectedCategoryId.value,
                            onChanged: (cat) {
                              controller.changeSelectedCategory(cat as int);
                            },
                            buttonHeight: 40,
                            buttonWidth: 300,
                            itemHeight: 40,
                            dropdownMaxHeight: 400,
                            searchController: controller.searchCatController,
                            searchInnerWidgetHeight: 40,
                            searchInnerWidget: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                controller: controller.searchCatController,
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
                              return (item.child
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase()));
                            },
                            //This to clear the search value when you close the menu
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                controller.searchCatController.clear();
                              }
                            },
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
                        width: 170,
                        child: Text(
                          "Kategori Adı (Türkçe): ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 30,
                        child: TextFormField(
                          controller: controller.catNameTrController,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: "Türkçe Kategori Adı",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
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
                        width: 170,
                        child: Text(
                          "Kategori Adı (İngilizce): ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 30,
                        child: TextFormField(
                          controller: controller.catNameEnController,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: "İngilizce Kategori Adı",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const SizedBox(width: 384),
                      ElevatedButton(
                        onPressed: () => controller.updateMenuItemCategory(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
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
            const SizedBox(height: 12),
            if (controller.selectedCategoryId.value != -1)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Alt Kategoriler",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const SizedBox(
                          width: 170,
                          child: Text(
                            "Alt Kategori: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: Obx(
                            () => DropdownButton2(
                              isExpanded: true,
                              hint: const Text(
                                'Alt Kategori Seçiniz',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              searchInnerWidgetHeight: 40,
                              items: controller.categories
                                  .where((x) =>
                                      x.menuItemCategoryId ==
                                      controller.selectedCategoryId.value)
                                  .first
                                  .menuItemSubCategories!
                                  .map((subCat) {
                                return DropdownMenuItem<int>(
                                  value: subCat.menuItemSubCategoryId,
                                  child: Text(
                                    subCat.menuItemSubCategoryId == -1
                                        ? "Yeni Alt Kategori"
                                        : subCat.nameTr!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: controller.selectedSubCategoryId.value,
                              onChanged: (cat) {
                                controller
                                    .changeSelectedSubCategory(cat as int);
                              },
                              buttonHeight: 40,
                              buttonWidth: 300,
                              itemHeight: 40,
                              dropdownMaxHeight: 400,
                              searchController:
                                  controller.searchSubCatController,
                              searchInnerWidget: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  controller: controller.searchSubCatController,
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
                                return (item.child
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchValue.toLowerCase()));
                              },
                              //This to clear the search value when you close the menu
                              onMenuStateChange: (isOpen) {
                                if (!isOpen) {
                                  controller.searchSubCatController.clear();
                                }
                              },
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
                          width: 170,
                          child: Text(
                            "Alt Kategori Adı (Türkçe): ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          height: 30,
                          child: TextFormField(
                            controller: controller.subCatNameTrController,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: "Türkçe Alt Kategori Adı",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
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
                          width: 170,
                          child: Text(
                            "Alt Kategori Adı (İngilizce): ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          height: 30,
                          child: TextFormField(
                            controller: controller.subCatNameEnController,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              hintText: "İngilizce Alt Kategori Adı",
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const SizedBox(width: 384),
                        ElevatedButton(
                          onPressed: () =>
                              controller.updateMenuItemSubCategory(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
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
            if (controller.selectedCategoryId.value == -1)
              const Text(
                "Alt kategorileri görmek için ana kategori seçiniz",
                style: TextStyle(fontStyle: FontStyle.italic),
              )
          ],
        ),
      ),
    );
  }
}
