import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/_utility/loading/loading_screen.dart';
import 'package:ideas_desktop_getx/view/menu/create-menu-item/create_menu_item_view_model.dart';

class CreateMenuItemPage extends StatelessWidget {
  const CreateMenuItemPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CreateMenuItemController controller = Get.put(CreateMenuItemController());
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(() => buildBody(controller))),
    );
  }

  Widget buildBody(CreateMenuItemController controller) {
    return !controller.showLoading.value
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Color(0xff223540),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () => controller.createMenuItem(),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Kaydet',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => controller.closePage(),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            'Kapat',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildGeneralInfoTab(controller),
                      buildCondimentTab(controller),
                    ],
                  ),
                ),
              ],
            ),
          )
        : LoadingPage();
  }

  Widget buildCondimentTab(CreateMenuItemController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text("Ek Seçimler",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue[800])),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildSelectCondimentButton(controller),
                Divider(),
                ...getSelectedCondimentGroups(controller),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> getSelectedCondimentGroups(CreateMenuItemController controller) {
    List<Widget> ret = [];
    for (var id in controller.menuItemModel.value.condimentGroupIds!) {
      var condimentGroup = controller.condimentGroups
          .where((element) => element.condimentGroupId == id)
          .first;

      ret.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              condimentGroup.nameTr!,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => controller.removeCondimentGroupSelection(id),
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      );
    }

    return ret;
  }

  Widget buildSelectCondimentButton(CreateMenuItemController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "Ek Seçimler: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () => controller.openSelectCondimentPage(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                "Ekseçim Seç",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            )),
      ],
    );
  }

  Widget buildGeneralInfoTab(CreateMenuItemController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Text("Genel Bilgiler",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue[800])),
        ),
        Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCategoryDropdown(controller),
              SizedBox(width: 460, child: Divider()),
              buildMenuItemNameInput(controller),
              SizedBox(width: 460, child: Divider()),
              buildPortionCheckbox(controller),
              if (!controller.menuItemModel.value.hasPortion!)
                SizedBox(width: 460, child: Divider()),
              if (!controller.menuItemModel.value.hasPortion!)
                buildPriceInput(controller),
              if (controller.menuItemModel.value.hasPortion!)
                ...buildPortions(controller),
              SizedBox(width: 460, child: Divider()),
              buildKdvInput(controller),
              SizedBox(width: 460, child: Divider()),
              buildBarcodeInput(controller),
              SizedBox(width: 460, child: Divider()),
              buildPrinterDropdown(controller),
              SizedBox(width: 460, child: Divider()),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildPortions(CreateMenuItemController controller) {
    List<Widget> ret = [];

    for (var i = 0; i < controller.menuItemModel.value.portions!.length; i++) {
      var portion = controller.menuItemModel.value.portions![i];
      var a = TextEditingController(text: portion.price.toString());
      var b = TextEditingController(text: portion.portionName);
      ret.add(
        Row(
          children: [
            Checkbox(
              value: portion.isPriceToShow,
              activeColor: Colors.blue,
              onChanged: (valuee) {
                if (valuee!) controller.changeIsPriceToShow(i);
              },
            ),
            SizedBox(
              width: 200,
              height: 30,
              child: TextFormField(
                style: TextStyle(fontSize: 16),
                controller: b,
                onChanged: (name) {
                  portion.portionName = name;
                },
                decoration: InputDecoration(
                  hintText: "Porsiyon Adı",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(width: 4),
            SizedBox(
              width: 100,
              height: 30,
              child: TextFormField(
                style: TextStyle(fontSize: 16),
                controller: a,
                onChanged: (price) {
                  var pr = double.tryParse(price);
                  if (pr != null) {
                    portion.price = pr;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Fiyat",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              onPressed: () => controller.removePortion(i),
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      );
    }

    ret.add(TextButton.icon(
        onPressed: () => controller.addPortion(),
        style: TextButton.styleFrom(padding: EdgeInsets.all(4)),
        icon: Icon(Icons.add, color: Color.fromARGB(255, 6, 89, 156)),
        label: Text(
          "Yeni Porsiyon",
          style: TextStyle(
              color: Color.fromARGB(255, 6, 89, 156),
              fontWeight: FontWeight.bold),
        )));

    return ret;
  }

  Row buildPrinterDropdown(CreateMenuItemController controller) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "Yazıcı: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        DropdownButtonHideUnderline(
          child: Obx(() {
            return DropdownButton2(
              isExpanded: true,
              hint: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'Yazıcı Seçiniz',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              items: controller.printers.map((item) {
                return DropdownMenuItem(
                  value: item.printerId,
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: Obx(() {
                    return InkWell(
                      onTap: () {
                        controller.isPrinterSelected(item.printerId!)
                            ? controller.removePrinter(item.printerId!)
                            : controller.addPrinter(item.printerId!);
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            controller.isPrinterSelected(item.printerId!)
                                ? const Icon(Icons.check_box_outlined)
                                : const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Text(
                              item.printerName!,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }).toList(),
              value: controller.menuItemModel.value.printerIds!.isEmpty
                  ? null
                  : controller.menuItemModel.value.printerIds!.last,
              onChanged: (value) {},
              buttonHeight: 40,
              buttonWidth: 300,
              itemHeight: 40,
              itemPadding: EdgeInsets.zero,
              selectedItemBuilder: (context) {
                return controller.printers.map(
                  (item) {
                    return Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        controller.getSelectedPrinterNames(),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                      ),
                    );
                  },
                ).toList();
              },
            );
          }),
        ),
      ],
    );
  }

  Widget buildBarcodeInput(CreateMenuItemController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "Barkod: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
          child: TextFormField(
            controller: controller.barcodeCtrl,
            style: TextStyle(fontSize: 16),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "Barkod",
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildKdvInput(CreateMenuItemController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "KDV: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
          child: TextFormField(
            controller: controller.kdvCtrl,
            style: TextStyle(fontSize: 16),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "KDV",
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPortionCheckbox(CreateMenuItemController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 145,
          child: Text(
            "Porsiyon var mı?: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          width: 130,
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.blue,
                value: controller.menuItemModel.value.hasPortion,
                onChanged: (valuee) {
                  controller.changeHasPortion(valuee!);
                },
              ),
              Text(controller.menuItemModel.value.hasPortion!
                  ? "Evet"
                  : "Hayır"),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPriceInput(CreateMenuItemController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "Satış Fiyatı(Kdv Dahil): ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
          child: TextFormField(
            controller: controller.priceCtrl,
            style: TextStyle(fontSize: 16),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "Fiyat",
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMenuItemNameInput(CreateMenuItemController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "Ürün Adı: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(
          width: 300,
          height: 30,
          child: TextFormField(
            controller: controller.nameCtrl,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: "Ürün Adı",
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCategoryDropdown(CreateMenuItemController controller) {
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: Text(
            "Kategori Seçimi: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Text(
              'Kategori Seçiniz',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            items: getCategoryDropdownItems(controller),
            value: controller.menuItemModel.value.subCategoryId,
            onChanged: (valuee) {
              controller.changeSelectedCategory(valuee as int);
            },
            buttonHeight: 40,
            buttonWidth: 300,
            itemHeight: 40,
            searchInnerWidgetHeight: 40,
            dropdownMaxHeight: 400,
            searchController: controller.textEditingController,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: controller.textEditingController,
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
                controller.textEditingController.clear();
              }
            },
          ),
        ),
        IconButton(
          onPressed: () => controller.openAddCategoryDialog(),
          icon: Icon(Icons.add, color: Colors.blue),
        )
      ],
    );
  }

  List<DropdownMenuItem<int>> getCategoryDropdownItems(
      CreateMenuItemController controller) {
    List<DropdownMenuItem<int>> ret = [];

    for (var cat in controller.categories) {
      for (var subcat in cat.menuItemSubCategories!) {
        ret.add(
          DropdownMenuItem(
            value: subcat.menuItemSubCategoryId,
            child: Text(
              cat.nameTr! + ' - ' + subcat.nameTr!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
    }

    return ret;
  }

  Widget buildCondimentsTab() {
    return Text("condiment");
  }
}
