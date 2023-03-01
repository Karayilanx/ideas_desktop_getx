import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/view/fast-sell/viewmodel/fast_sell_view_model.dart';
import '../../../locale_keys_enum.dart';
import '../../../model/check_model.dart';
import '../../../model/menu_model.dart';
import '../../../theme/theme.dart';
import '../../_utility/keyboard/button_type_enum.dart';
import '../../_utility/keyboard/numeric_keyboard.dart';
import '../../_utility/loading/spinner.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';
import '../../order-detail/component/menu_item_category_button.dart';
import '../../order-detail/component/menu_item_widget.dart';
import '../../order-detail/component/order_list_tile.dart';

class FastSellPage extends StatelessWidget {
  const FastSellPage({super.key});

  @override
  Widget build(BuildContext context) {
    FastSellController controller = Get.find();
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: SafeArea(
      child: buildBody(controller),
    ));
  }

  Widget buildBody(FastSellController controller) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: buildLeftSideColumn(controller),
        ),
        Expanded(
          flex: 70,
          child: buildRightSideColumn(controller),
        )
      ],
    );
  }

  Widget buildLeftSideColumn(FastSellController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 4, 4, 10),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  runAlignment: WrapAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Hızlı Satış',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ],
                ),
                if (controller.showMenu.value)
                  Expanded(
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            controller.hideSearch.value
                                ? Container()
                                : Expanded(
                                    child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),
                                        controller: controller.searchCtrl,
                                        focusNode: controller.myFocusNode,
                                        onTap: () async {
                                          if (controller.localeManager
                                              .getBoolValue(PreferencesKeys
                                                  .SCREEN_KEYBOARD)) {
                                            var res = await Get.dialog(
                                              const ScreenKeyboard(),
                                            );
                                            if (res != null) {
                                              controller.searchCtrl.text = res;
                                              createFilteredMenuItems(
                                                  controller);
                                              controller.filterMenuItems();
                                            }
                                          }
                                        },
                                        onChanged: (v) => {
                                              createFilteredMenuItems(
                                                  controller),
                                              controller.filterMenuItems(),
                                            }),
                                  ),
                            GestureDetector(
                              onTap: () => controller.changeShowSearch(),
                              child: Icon(
                                controller.hideSearch.value
                                    ? Icons.search
                                    : Icons.search_off,
                                size: 34,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )),
                  ),
              ],
            ),
          ),
          Obx(() {
            return Expanded(
              flex: 60,
              child: buildCheckItemsListView(controller),
            );
          }),
          const SizedBox(height: 10),
          buildTotalPriceContainer(controller),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: FastSellPaymentButton(
                      text: 'Nakit',
                      callback: () {
                        if (controller
                            .checkDetail.value.basketItems!.isNotEmpty) {
                          controller.sendOrder(CheckPaymentTypeEnum.Cash, true);
                        }
                      }),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: FastSellPaymentButton(
                      text: 'Kredi',
                      callback: () {
                        if (controller
                            .checkDetail.value.basketItems!.isNotEmpty) {
                          controller.sendOrder(
                              CheckPaymentTypeEnum.CreditCart, true);
                        }
                      }),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: FastSellPaymentButton(
                    text: 'Parçalı',
                    callback: () => controller.changeShowMenu(),
                    selected: !controller.showMenu.value,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckItemsListView(FastSellController controller) {
    return Container(
      color: const Color(0xff2B393F),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Obx(
            () {
              GroupedCheckItem groupedItem =
                  controller.groupedCheckItems[index];
              return GestureDetector(
                onTap: () => controller.checkDetail.value.checkId != null &&
                        controller.checkDetail.value.checkId! > 0
                    ? controller.checkItemClick(groupedItem)
                    : controller.basketItemClick(groupedItem),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: index % 2 == 0 ? const Color(0xff2B393F) : const Color(0xff253139),
                  child: OrderListTile(
                    groupedItem: groupedItem,
                  ),
                ),
              );
            },
          );
        },
        itemCount: controller.groupedCheckItems.length,
      ),
    );
  }

  Widget buildRightSideColumn(FastSellController controller) {
    return Column(
      children: [
        Expanded(
          child: buildRightGreySide(controller),
        ),
      ],
    );
  }

  Widget buildRightGreySide(FastSellController controller) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        decoration: BoxDecoration(
          color: const Color(0xffEDEAE6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: controller.showMenu.value
            ? buildMenuColumn(controller)
            : buildPaymentColumn(controller),
      );
    });
  }

  Widget buildPaymentColumn(FastSellController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                        controller: controller.priceCtrl,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              margin: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  FixedPriceButton(
                                    text: '20 TL',
                                    callback: () =>
                                        controller.priceCtrl.text = '20',
                                  ),
                                  FixedPriceButton(
                                    text: '50 TL',
                                    callback: () =>
                                        controller.priceCtrl.text = '50',
                                  ),
                                  FixedPriceButton(
                                    text: '100 TL',
                                    callback: () =>
                                        controller.priceCtrl.text = '100',
                                  ),
                                  FixedPriceButton(
                                    text: '200 TL',
                                    callback: () =>
                                        controller.priceCtrl.text = '200',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildKeyboard(controller),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PartialPaymentButton(
                        text: 'Nakit',
                        callback: () => controller.sendOrder(
                            CheckPaymentTypeEnum.Cash, true),
                      ),
                      PartialPaymentButton(
                        text: 'Kredi',
                        callback: () => controller.sendOrder(
                            CheckPaymentTypeEnum.CreditCart, true),
                      ),
                      PartialPaymentButton(
                        text: 'Cari',
                        color: Colors.blueGrey,
                        callback: () => controller.navigateToCheckAccounts(),
                      ),
                      PartialPaymentButton(
                        text: 'İskonto',
                        color: Colors.red,
                        callback: () => controller.sendOrder(
                            CheckPaymentTypeEnum.Discount, true),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 240,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      PaymentTextContainer(
                        text1: 'Toplam:',
                        text2: controller.checkDetail.value.checkId != null &&
                                controller.checkDetail.value.checkId! > 0
                            ? controller.checkDetail.value.payments!
                                .checkAmount!.getPriceString
                            : controller
                                .getBasketTotalPrice()
                                .toStringAsFixed(2),
                      ),
                      PaymentTextContainer(
                        text1: 'Nakit:',
                        text2: controller.checkDetail.value.payments!
                            .cashAmount!.getPriceString,
                      ),
                      PaymentTextContainer(
                        text1: 'Kredi:',
                        text2: controller.checkDetail.value.payments!
                            .creditCardAmount!.getPriceString,
                      ),
                      PaymentTextContainer(
                        text1: 'İskonto',
                        text2: controller.checkDetail.value.payments!
                            .discountAmount!.getPriceString,
                      ),
                      PaymentTextContainer(
                        text1: 'Kalan:',
                        text2: controller.checkDetail.value.payments!
                            .remainingAmount!.getPriceString,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => controller.printCheck(),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ideasTheme.scaffoldBackgroundColor,
                          ),
                          child: const Center(
                              child: Text(
                            'Hesap Yazdır',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => controller.cancelBillSent(),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ideasTheme.scaffoldBackgroundColor,
                          ),
                          child: const Center(
                              child: Text(
                            'Yazdırmayı Geri Al',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildTotalPriceContainer(FastSellController controller) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xff2B393F),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.only(right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '   Toplam ',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Obx(() => Text(
                '${controller.checkDetail.value.checkId != null && controller.checkDetail.value.checkId! > 0 ? controller.checkDetail.value.payments!.checkAmount!.getPriceString : controller.getBasketTotalPrice().toStringAsFixed(2)} TL  ',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  NumericKeyboard buildKeyboard(FastSellController controller) {
    return NumericKeyboard(
      buttonColor: Colors.white,
      pinFieldController: controller.priceCtrl,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      type: KeyboardType.DOUBLE,
      actionColumn: null,
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      clearCallback: () {},
    );
  }

  Obx buildMenuColumn(FastSellController controller) {
    return Obx(() {
      return controller.selectedCategory.value != null
          ? Column(
              children: [
                controller.hideSearch.value
                    ? SizedBox(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 16,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          MenuItemCategory cat = controller
                                              .menuItemCategories[index];
                                          return Obx(() {
                                            return MenuItemCategoryButton(
                                              callback: () => controller
                                                  .changeCategory(cat),
                                              selected: controller
                                                  .isCategorySelected(cat),
                                              text: cat.nameTr,
                                            );
                                          });
                                        },
                                        itemCount: controller
                                            .menuItemCategories.length,
                                      ),
                                    ),
                                    const Spacer(flex: 2),
                                    Expanded(
                                      flex: 16,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          MenuItemSubCategory subCat =
                                              controller.selectedCategory.value!
                                                      .menuItemSubCategories![
                                                  index];
                                          return Obx(() {
                                            return MenuItemCategoryButton(
                                              callback: () => controller
                                                  .changeSubCategory(subCat),
                                              selected: controller
                                                  .isSubCategorySelected(
                                                      subCat),
                                              text: subCat.nameTr,
                                            );
                                          });
                                        },
                                        itemCount: controller
                                            .selectedCategory
                                            .value!
                                            .menuItemSubCategories!
                                            .length,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    // IconButton(
                                    //   onPressed: () {
                                    //     value.openCustomerCountDialog();
                                    //   },
                                    //   icon: Icon(Icons.person_add_alt_outlined),
                                    //   iconSize: 30,
                                    //   color: Color(0xffF1A159),
                                    // ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => controller
                                            .openCustomerCountDialog(true),
                                        child: controller.checkDetail.value
                                                        .personCount !=
                                                    null &&
                                                controller.checkDetail.value
                                                        .personCount! >
                                                    0
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    controller.checkDetail.value
                                                        .personCount
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 26,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              )
                                            : const Icon(
                                                Icons.person_add_alt_outlined,
                                                size: 40,
                                                color: Color(0xffF1A159),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            controller.openQuantityDialog(),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Obx(() {
                                              return Text(
                                                controller.quantity.toString(),
                                                style: const TextStyle(
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                const Divider(),
                Expanded(
                  flex: 8,
                  child: Obx(() {
                    return GridView.extent(
                        childAspectRatio: 1.5,
                        maxCrossAxisExtent: 100,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        controller: controller.controller,
                        children: controller.hideSearch.value
                            ? createMenuItems(controller)
                            : createFilteredMenuItems(controller));
                  }),
                ),
                const SizedBox(height: 4),
              ],
            )
          : const Center(
              child: Spinner(
                'Ürünler getiriliyor...',
                color: Colors.black,
              ),
            );
    });
  }

  List<Widget> createMenuItems(FastSellController controller) {
    if (controller.selectedSubCategory.value != null) {
      if (controller.selectedSubCategory.value!.menuItems!.isNotEmpty) {
        return List.generate(
            controller.selectedSubCategory.value!.menuItems!.length, (index) {
          MenuItem menuItem =
              controller.selectedSubCategory.value!.menuItems![index];
          return MenuItemWidget(
            callback: () => controller.menuItemClick(menuItem),
            menuItem: menuItem,
          );
        });
      } else {
        return [];
      }
    }
    return [];
  }

  List<Widget> createFilteredMenuItems(FastSellController controller) {
    List<Widget> ret = [];
    for (var cat in controller.menuItemCategories) {
      for (var subcat in cat.menuItemSubCategories!) {
        for (var item in subcat.menuItems!) {
          if (item.nameTr!
              .toUpperCase()
              .contains(controller.searchCtrl.text.toUpperCase())) {
            ret.add(MenuItemWidget(
              callback: () => controller.menuItemClick(item),
              menuItem: item,
            ));
          }
        }
      }
    }
    return ret;
  }
}

class PaymentTextContainer extends StatelessWidget {
  final String text1;
  final String text2;
  const PaymentTextContainer({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: TextStyle(
                color: ideasTheme.scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          Text(
            text2,
            style: TextStyle(
                color: ideasTheme.scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 22),
          )
        ],
      ),
    );
  }
}

class PartialPaymentButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback callback;
  const PartialPaymentButton(
      {super.key, required this.text, this.color = Colors.orange, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => callback(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color,
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

class FixedPriceButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const FixedPriceButton({super.key, required this.text, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => callback(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ideasTheme.scaffoldBackgroundColor,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class FastSellPaymentButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final bool selected;
  const FastSellPaymentButton({super.key, 
    required this.callback,
    required this.text,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
            color: selected ? Colors.orange : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
              width: 1.3,
            )),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
