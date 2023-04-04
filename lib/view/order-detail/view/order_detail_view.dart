import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/order-detail/viewmodel/order_detail_view_model.dart';
import 'package:intl/intl.dart';
import '../../../locale_keys_enum.dart';
import '../../../model/check_model.dart';
import '../../../model/home_model.dart';
import '../../../model/menu_model.dart';
import '../../../model/table_model.dart';
import '../../_utility/keyboard/button_type_enum.dart';
import '../../_utility/keyboard/keyboard_custom_button.dart';
import '../../_utility/keyboard/numeric_keyboard.dart';
import '../../_utility/loading/loading_screen.dart';
import '../../_utility/loading/spinner.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';
import '../../home/component/table_widgets.dart';
import '../component/menu_item_category_button.dart';
import '../component/menu_item_widget.dart';
import '../component/order_list_tile.dart';
import '../component/payment_button.dart';
import '../component/payment_text.dart';
import '../component/tab_button.dart';
import '../component/tab_button_position_enum.dart';
import '../model/order_detail_model.dart';

class OrderDetailView extends StatelessWidget {
  const OrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailController controller = Get.find();
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: controller.checkDetail.value != null
              ? buildBody(controller)
              : const LoadingPage(),
        );
      }),
    );
  }

  Widget buildBody(OrderDetailController controller) {
    return Container(
      margin: const EdgeInsets.all(6),
      child: Row(
        children: [
          SizedBox(
            width: 350,
            child: buildLeftSideColumn(controller),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: buildRightSideColumn(controller),
          )
        ],
      ),
    );
  }

  Column buildLeftSideColumn(OrderDetailController controller) {
    return Column(
      children: [
        SizedBox(
          height: 45,
          child: buildOrderInfoRow(controller),
        ),
        SizedBox(
          height: 40,
          child: TextFormField(
            controller: controller.checkNoteCtrl,
            style: const TextStyle(
              fontSize: 14,
            ),
            onTap: () async {
              if (controller.localeManager
                  .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
                var res = await Get.dialog(
                  const ScreenKeyboard(),
                );
                if (res != null) {
                  controller.checkNoteCtrl.text = res;
                }
              }
            },
            onFieldSubmitted: (valueee) {
              if (controller.checkId != null && controller.checkId! > 0) {
                controller.updateCheckNote();
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: 'Hesap notlarınızı bu alana girebilirsiniz',
              filled: true,
              suffixIcon: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.checkId != null && controller.checkId! > 0
                        ? IconButton(
                            onPressed: () {
                              controller.updateCheckNote();
                            },
                            icon:
                                const Icon(Icons.check_circle_outline_rounded),
                            iconSize: 20,
                            color: const Color(0xffF1A159),
                          )
                        : Container(),
                  ],
                ),
              ),
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(() {
          return Expanded(
            child: buildLeftSideItemsList(controller),
          );
        }),
        const SizedBox(height: 10),
        SizedBox(
          height: 35,
          child: buildTotalPriceContainer(controller),
        ),
      ],
    );
  }

  Widget buildLeftSideItemsList(OrderDetailController controller) {
    if (controller.mainTabIndex.value == 0 ||
        controller.mainTabIndex.value == 3) {
      if (controller.checkActionsTabIndex.value == 0) {
        return buildCheckItemsListView(controller);
      } else if (controller.checkActionsTabIndex.value == 1) {
        return buildSelectableCheckItemsListView(controller);
      } else {
        if (controller.selectedMenuItems.isNotEmpty) {
          return buildTransferItemsList(controller);
        } else {
          return buildCheckItemsListView(controller);
        }
      }
    } else {
      return buildBasketItemsListView(controller);
    }
  }

  Widget buildSelectableCheckItemsListView(OrderDetailController controller) {
    return Obx(() {
      return Container(
        color: const Color(0xff2B393F),
        child: ListView.builder(
          itemBuilder: (context, index) {
            GroupedCheckItem groupedItem =
                controller.groupedSelectableItems[index];
            return GestureDetector(
              onTap: () => controller.selectableItemClick(groupedItem),
              child: groupedItem.itemCount != 0
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      color: index % 2 == 0
                          ? const Color(0xff2B393F)
                          : const Color(0xff253139),
                      child: OrderListTile(
                        groupedItem: groupedItem,
                      ),
                    )
                  : Container(),
            );
          },
          itemCount: controller.groupedSelectableItems.length,
        ),
      );
    });
  }

  Row buildOrderInfoRow(OrderDetailController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Text(
                getCheckString(controller),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ],
        ),
        FlutterSwitch(
          value: controller.print.value,
          onToggle: (p) {
            controller.print(p);
          },
          activeText: 'Yazdır',
          inactiveText: 'Yazdırma',
          activeTextColor: Colors.white,
          showOnOff: true,
          valueFontSize: 14,
          width: 80,
          activeTextFontWeight: FontWeight.w100,
          inactiveTextFontWeight: FontWeight.w100,
          height: 25,
        ),
      ],
    );
  }

  String getCheckString(OrderDetailController controller) {
    switch (controller.type) {
      case OrderDetailPageType.TABLE:
        if (controller.checkDetail.value != null &&
            controller.checkDetail.value!.alias != null &&
            controller.checkDetail.value!.alias != '') {
          return getAliasInformationString(controller);
        } else {
          return getTableInformationString(controller);
        }
      case OrderDetailPageType.DELIVERY:
        return 'PAKET SİPARİŞ';
      case OrderDetailPageType.ALIAS:
        return getAliasInformationString(controller);
      default:
        return 'Error';
    }
  }

  String getAliasInformationString(OrderDetailController controller) {
    if (controller.checkDetail.value == null) {
      return '';
    } else if (controller.checkDetail.value!.alias != null) {
      return '${controller.checkDetail.value!.alias} / ${controller.checkDetail.value!.checkId} \n${controller.checkDetail.value!.terminalUsername} (Açılış: ${DateFormat('HH:mm').format(controller.checkDetail.value!.createDate!)})';
    } else {
      return controller.alias!;
    }
  }

  String getTableInformationString(OrderDetailController controller) {
    if (controller.checkDetail.value == null) {
      return '';
    } else if (controller.checkDetail.value!.table!.status ==
        TableStatusTypeEnum.Empty.index) {
      return controller.checkDetail.value!.table!.name!;
    } else if (controller.checkDetail.value!.table != null) {
      return '${controller.checkDetail.value!.table!.name} / ${controller.checkDetail.value!.checkId} \n${controller.checkDetail.value!.table!.terminalUserName} (Açılış: ${DateFormat('HH:mm').format(controller.checkDetail.value!.createDate!)})';
    } else {
      return controller.checkDetail.value!.table!.name!;
    }
  }

  Widget buildCheckItemsListView(OrderDetailController controller) {
    return Container(
      color: const Color(0xff2B393F),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Obx(
            () {
              GroupedCheckItem groupedItem =
                  controller.groupedCheckItems[index];
              return GestureDetector(
                onTap: () => controller.checkItemClick(groupedItem),
                child: groupedItem.itemCount != 0
                    ? Container(
                        padding: const EdgeInsets.all(8.0),
                        color: index % 2 == 0
                            ? const Color(0xff2B393F)
                            : const Color(0xff253139),
                        child: OrderListTile(
                          groupedItem: groupedItem,
                        ),
                      )
                    : Container(),
              );
            },
          );
        },
        itemCount: controller.groupedCheckItems.length,
      ),
    );
  }

  Widget buildBasketItemsListView(OrderDetailController controller) {
    return Obx(() {
      return Container(
        color: const Color(0xff2B393F),
        child: ListView.builder(
          itemBuilder: (context, index) {
            GroupedCheckItem groupedItem = controller.groupedBasketItems[index];
            return GestureDetector(
              onTap: () => controller.basketItemClick(groupedItem),
              child: groupedItem.itemCount != 0
                  ? Container(
                      padding: const EdgeInsets.all(8.0),
                      color: index % 2 == 0
                          ? const Color(0xff2B393F)
                          : const Color(0xff253139),
                      child: OrderListTile(
                        groupedItem: groupedItem,
                      ),
                    )
                  : Container(),
            );
          },
          itemCount: controller.groupedBasketItems.length,
        ),
      );
    });
  }

  Container buildTotalPriceContainer(OrderDetailController controller) {
    return Container(
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
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            '${controller.getBottomLeftTotalPrice()} TL  ',
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Column buildRightSideColumn(OrderDetailController controller) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: buildRightTopButtonsRow(controller),
        ),
        Expanded(
          child: buildRightGreySide(controller),
        ),
      ],
    );
  }

  Widget buildRightTopButtonsRow(OrderDetailController controller) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildCheckDetailsButton(controller),
                getAddItemTabButton(controller),
                getExtraItemTabButton(controller),
                buildCheckActionsButton(controller)
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                (controller.mainTabIndex.value == 1 ||
                            controller.mainTabIndex.value == 4) &&
                        (controller.basket.value.basketItems!.isNotEmpty ||
                            (controller.basket.value.personCount != null &&
                                controller.basket.value.personCount! > 0))
                    ? ElevatedButton(
                        onPressed: () {
                          controller.sendOrder();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Gönder',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffF1A159),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed('home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Kapat',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }

  Widget getAddItemTabButton(OrderDetailController controller) {
    if (controller.isIntegration) {
      return Container();
    } else {
      return TabButton(
        callback: () {
          controller.changeMainTabIndex(1);
        },
        position: TabButtonPosition.MIDDLE,
        selected: controller.mainTabIndex.value == 1,
        text: 'İlave Ürün',
        selectedColor: const Color(0xffEDEAE6),
        unselectedColor: const Color(0xff253139),
        fontSize: 16,
        minWidht: 100,
        radius: 10,
        selectedTextColor: Colors.black,
        unselectedTextColor: Colors.white,
      );
    }
  }

  Widget getExtraItemTabButton(OrderDetailController controller) {
    if (controller.isIntegration) {
      return Container();
    } else {
      return TabButton(
        callback: () {
          controller.openExtraItemDialog();
        },
        position: TabButtonPosition.MIDDLE,
        selected: controller.mainTabIndex.value == 2,
        text: 'Ekstra Ürün',
        selectedColor: const Color(0xffEDEAE6),
        unselectedColor: const Color(0xff253139),
        fontSize: 16,
        minWidht: 100,
        radius: 10,
        selectedTextColor: Colors.black,
        unselectedTextColor: Colors.white,
      );
    }
  }

  Widget buildCheckDetailsButton(OrderDetailController controller) {
    bool showCheckDetailsButton = false;
    switch (controller.type) {
      case OrderDetailPageType.TABLE:
        if (controller.checkDetail.value!.table!.status !=
            TableStatusTypeEnum.Empty.index) {
          showCheckDetailsButton = true;
        }
        break;
      case OrderDetailPageType.DELIVERY:
        if (controller.checkId! > 0) {
          showCheckDetailsButton = true;
        }
        break;
      case OrderDetailPageType.ALIAS:
        if (controller.checkId! > 0) {
          showCheckDetailsButton = true;
        }
        break;
      default:
    }

    if (showCheckDetailsButton) {
      return TabButton(
        callback: () {
          controller.changeMainTabIndex(0);
        },
        position: TabButtonPosition.LEFT,
        selected: controller.mainTabIndex.value == 0,
        text: 'Hesap İşlemleri',
        selectedColor: const Color(0xffEDEAE6),
        unselectedColor: const Color(0xff253139),
        fontSize: 16,
        minWidht: 100,
        radius: 10,
        selectedTextColor: Colors.black,
        unselectedTextColor: Colors.white,
      );
    } else {
      return Container();
    }
  }

  Widget buildCheckActionsButton(OrderDetailController controller) {
    bool showCheckDetailsButton = false;
    switch (controller.type) {
      case OrderDetailPageType.TABLE:
        if (controller.checkDetail.value!.table!.status !=
            TableStatusTypeEnum.Empty.index) {
          showCheckDetailsButton = true;
        }
        break;
      case OrderDetailPageType.ALIAS:
        if (controller.checkId! > 0) {
          showCheckDetailsButton = true;
        }
        break;
      default:
    }

    if (showCheckDetailsButton) {
      return TabButton(
        callback: () {
          if (controller.authStore.user!.canSeeActions!) {
            controller.changeMainTabIndex(3);
          } else {
            controller.showSnackbarError(
                '${controller.authStore.user!.name!} adlı kullanıcının bu işlem için yetkisi yoktur.');
          }
        },
        position: TabButtonPosition.RIGHT,
        selected: controller.mainTabIndex.value == 3,
        text: 'İşlemler',
        selectedColor: const Color(0xffEDEAE6),
        unselectedColor: const Color(0xff253139),
        fontSize: 16,
        minWidht: 100,
        radius: 10,
        selectedTextColor: Colors.black,
        unselectedTextColor: Colors.white,
      );
    } else {
      return TabButton(
        callback: () {
          controller.changeMainTabIndex(4);
        },
        position: TabButtonPosition.RIGHT,
        selected: controller.mainTabIndex.value == 4,
        text: 'İşlemler',
        selectedColor: const Color(0xffEDEAE6),
        unselectedColor: const Color(0xff253139),
        fontSize: 16,
        minWidht: 100,
        radius: 10,
        selectedTextColor: Colors.black,
        unselectedTextColor: Colors.white,
      );
    }
  }

  Widget buildRightGreySide(OrderDetailController controller) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 4),
        decoration: BoxDecoration(
          color: const Color(0xffEDEAE6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: controller.mainTabIndex.value == 0
            ? buildCheckActionsColumn(controller)
            : controller.mainTabIndex.value == 1
                ? buildMenuColumn(controller)
                : controller.mainTabIndex.value == 4
                    ? buildCloseTableActionsColumn(controller)
                    : buildActionsColumn(controller),
      );
    });
  }

  Widget buildMenuColumn(OrderDetailController controller) {
    return Obx(() {
      return controller.selectedCategory.value != null
          ? Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: controller.hideSearch.value
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          MenuItemCategory cat = controller
                                              .menuItemCategories[index]!;
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
                                    SizedBox(
                                      width: 140,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: controller.basket.value
                                                              .personCount !=
                                                          null &&
                                                      controller.basket.value
                                                              .personCount! >
                                                          0
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .openCustomerCountDialog(
                                                                true);
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            controller
                                                                .basket
                                                                .value
                                                                .personCount
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        26),
                                                          ),
                                                          const Icon(
                                                            Icons
                                                                .person_add_alt_outlined,
                                                            size: 40,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .openCustomerCountDialog(
                                                                true);
                                                      },
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      icon: const Icon(Icons
                                                          .person_add_alt_outlined),
                                                      iconSize: 40,
                                                      color: Colors.black,
                                                    ),
                                            ),
                                          ),
                                          const VerticalDivider(),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  controller.changeShowSearch(),
                                              child: Icon(
                                                  controller.hideSearch.value
                                                      ? Icons.search
                                                      : Icons.search_off,
                                                  size: 36),
                                            ),
                                          ),
                                          const VerticalDivider(),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () => controller
                                                  .openQuantityDialog(),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Obx(() {
                                                    return Text(
                                                      controller.quantity
                                                          .toString(),
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
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
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
                                                controller.searchCtrl.text =
                                                    res;
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
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () =>
                                          controller.changeShowSearch(),
                                      child: Icon(
                                          controller.hideSearch.value
                                              ? Icons.search
                                              : Icons.search_off,
                                          size: 36),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Expanded(
                  flex: 8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      controller.hideSearch.value
                          ? SizedBox(
                              width: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  MenuItemSubCategory subCat = controller
                                      .selectedCategory
                                      .value!
                                      .menuItemSubCategories![index];
                                  return Obx(() {
                                    return SizedBox(
                                      height: 70,
                                      child: MenuItemCategoryButton(
                                        callback: () => controller
                                            .changeSubCategory(subCat),
                                        selected: controller
                                            .isSubCategorySelected(subCat),
                                        text: subCat.nameTr,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 4),
                                      ),
                                    );
                                  });
                                },
                                itemCount: controller.selectedCategory.value!
                                    .menuItemSubCategories!.length,
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: Obx(() {
                          return GridView.extent(
                              childAspectRatio: 1.5,
                              maxCrossAxisExtent: getMenuItemWidth(controller),
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              controller: controller.controller,
                              children: controller.hideSearch.value
                                  ? createMenuItems(controller)
                                  : createFilteredMenuItems(controller));
                        }),
                      ),
                    ],
                  ),
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

  List<Widget> createFilteredMenuItems(OrderDetailController controller) {
    List<Widget> ret = [];
    for (var cat in controller.menuItemCategories) {
      for (var subcat in cat!.menuItemSubCategories!) {
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

  List<Widget> createSubCategories(OrderDetailController controller) {
    List<Widget> ret = [];
    for (var cat in controller.menuItemCategories) {
      for (var subcat in cat!.menuItemSubCategories!) {
        ret.add(MenuItemCategoryButton(
          callback: () => controller.changeSubCategory(subcat),
          text: subcat.nameTr,
          selected: controller.isSubCategorySelected(subcat),
        ));
      }
    }
    return ret;
  }

  List<Widget> createMenuItems(OrderDetailController controller) {
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

  Widget buildCheckActionButtons(OrderDetailController controller) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TabButton(
              callback: () => controller.changeCheckActionsTabIndex(0),
              position: TabButtonPosition.LEFT,
              selected: controller.checkActionsTabIndex.value == 0,
              text: 'Hesap-Ödeme Al',
              selectedColor: const Color(0xffF1A159),
              unselectedColor: Colors.white,
              fontSize: 24,
              minWidht: 200,
              radius: 15,
              selectedTextColor: Colors.white,
              unselectedTextColor: const Color(0xffF1A159),
            ),
            controller.type != OrderDetailPageType.DELIVERY
                ? TabButton(
                    callback: () => controller.changeCheckActionsTabIndex(1),
                    position: TabButtonPosition.MIDDLE,
                    selected: controller.checkActionsTabIndex.value == 1,
                    text: 'Hesap Ayır',
                    selectedColor: const Color(0xffF1A159),
                    unselectedColor: Colors.white,
                    fontSize: 24,
                    minWidht: 180,
                    radius: 15,
                    selectedTextColor: Colors.white,
                    unselectedTextColor: const Color(0xffF1A159),
                  )
                : Container(),
            controller.type != OrderDetailPageType.DELIVERY
                ? TabButton(
                    callback: () => controller.authStore.user!.canTransferCheck!
                        ? controller.changeCheckActionsTabIndex(2)
                        : controller.showSnackbarError(
                            '${controller.authStore.user!.name!} adlı kullanıcının bu işlem için yetkisi yoktur.'),
                    position: TabButtonPosition.RIGHT,
                    selected: controller.checkActionsTabIndex.value == 2,
                    text: 'Hesap Aktar',
                    selectedColor: const Color(0xffF1A159),
                    unselectedColor: Colors.white,
                    fontSize: 24,
                    minWidht: 200,
                    radius: 15,
                    selectedTextColor: Colors.white,
                    unselectedTextColor: const Color(0xffF1A159),
                  )
                : Container(),
          ],
        ),
      );
    });
  }

  Column buildCheckActionsColumn(OrderDetailController controller) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: buildCheckActionButtons(controller),
        ),
        const Divider(
          color: Colors.black,
          thickness: 0.5,
        ),
        Obx(() {
          return Expanded(
            flex: 90,
            child: controller.checkActionsTabIndex.value == 0
                ? buildPaymentAndKeyboardRow(controller.type, controller)
                : controller.checkActionsTabIndex.value == 1
                    ? buildCheckTransferTab(controller)
                    : buildSelectTableTab(controller),
          );
        })
      ],
    );
  }

  Widget buildCloseTableActionsColumn(OrderDetailController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ActionsRow(
            ActionButton(
              text: 'Müşteri Seç',
              onPressed: () => controller.selectCustomer(),
            ),
            ActionButton(
              text: 'Masaya İsim Ver',
              onPressed: () {
                controller.giveNameToTable();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionsColumn(OrderDetailController controller) {
    return SingleChildScrollView(
      controller: controller.actionsScrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ActionsRow(
            ActionButton(
              text: 'Yazdırmayı Geri Al',
              onPressed: () => controller.cancelBillSent(),
            ),
            ActionButton(
                text: 'İskontoyu Geri Al',
                onPressed: () => controller.cancelDiscounts()),
          ),
          ActionsRow(
            ActionButton(
              text: 'Ödemeleri Sıfırla',
              onPressed: () => controller.cancelPayments(),
            ),
            ActionButton(
              text: 'Garson Değiştir',
              onPressed: () => controller.openChangeWaiterDialog(),
            ),
          ),
          ActionsRow(
            controller.checkDetail.value!.checkAccountId == null
                ? ActionButton(
                    text: 'Müşteri Seç',
                    onPressed: () => controller.selectCustomer(),
                  )
                : ActionButton(
                    text: 'Müşteri Seçimini Kaldır',
                    onPressed: () => controller.clearCheckCustomer(),
                  ),
            ActionButton(
              text: 'Ödenmez İşaretle',
              onPressed: () => controller.markUnpayable(),
            ),
          ),
          ActionsRow(
            ActionButton(
              text: 'Servis Bedeli Belirle',
              onPressed: () => controller.openServiceChargeDialog(),
            ),
            ActionButton(
              text: 'İskonto Tanımla',
              onPressed: () => controller.openDiscountDialog(),
            ),
          ),
          ActionsRow(
            ActionButton(
              text: 'Masaya İsim Ver',
              onPressed: () => controller.giveNameToTable(),
            ),
            ActionButton(
              text: 'Adisyon Yazdır',
              onPressed: () => controller.printSlip(),
            ),
          ),
          ActionsRow(
            ActionButton(
              text: 'Logları Gör',
              onPressed: () => controller.seeLogs(),
            ),
            ActionButton(
              text: 'Adisyonu İptal Et',
              onPressed: () => controller.cancelCheck(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectTableTab(OrderDetailController controller) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text(
                'Aktarmak istediğiniz hesaba tıklayınız.',
                style: TextStyle(fontSize: 16),
              ),
              Obx(
                () => DropdownButton(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      child: const Icon(
                        Icons.arrow_downward,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                    items: controller.tableGroups
                        .map<DropdownMenuItem>((HomeGroupWithDetails? value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value!.tableGroupId != -1 ? value.name! : value.name!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      );
                    }).toList(),
                    value: controller.selectedTableGroup.value,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    onChanged: (dynamic newGroup) {
                      controller.changeTableGroup(newGroup);
                    },
                    selectedItemBuilder: (context) {
                      return controller.tableGroups
                          .map((HomeGroupWithDetails? value) {
                        return Text(
                          value!.tableGroupId != -1 ? value.name! : value.name!,
                          style: const TextStyle(
                            color: Color(0xffF1A159),
                            fontSize: 18,
                          ),
                        );
                      }).toList();
                    }),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(
            () {
              return GridView.extent(
                maxCrossAxisExtent: getTableWidth(controller),
                childAspectRatio: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                shrinkWrap: true,
                children: controller.selectedTableGroup.value!.name != "Tümü"
                    ? createTables(
                        controller.selectedTableGroup.value!, controller)
                    : createFilteredTables(controller),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Widget> createTables(
      HomeGroupWithDetails group, OrderDetailController controller) {
    if (controller.selectedTableGroup.value != null) {
      if (controller.selectedTableGroup.value!.tables!.isNotEmpty) {
        return createTableWidgets(group, controller);
      } else {
        return [];
      }
    }
    return [];
  }

  double getTableWidth(OrderDetailController controller) {
    var widthStr =
        controller.localeManager.getStringValue(PreferencesKeys.TABLE_WIDTH);
    var res = double.tryParse(widthStr);
    if (res == null) {
      return 150;
    } else {
      return res;
    }
  }

  double getMenuItemWidth(OrderDetailController controller) {
    var widthStr = controller.localeManager
        .getStringValue(PreferencesKeys.MENU_ITEM_WIDTH);
    var res = double.tryParse(widthStr);
    if (res == null) {
      return 100;
    } else {
      return res;
    }
  }

  List<Widget> createFilteredTables(OrderDetailController controller) {
    List<Widget> ret = [];

    for (var group in controller.tableGroups) {
      if (group!.name == 'Açık Hesaplar' &&
          controller.selectedTableGroup.value != null &&
          controller.selectedTableGroup.value!.name != 'Açık Hesaplar') {
        continue;
      }
      for (var table in group.tables!) {
        if (table.name!
            .toUpperCase()
            .contains(controller.searchCtrl.text.toUpperCase())) {
          if (table.status == TableStatusTypeEnum.Empty.index) {
            ret.add(ClosedTableWidget(
              table: table,
              callback: () => controller.transferOrders(
                  controller.selectedMenuItems.isEmpty,
                  table.tableId,
                  table.checkId),
            ));
          } else if (table.status == TableStatusTypeEnum.HasOpenCheck.index) {
            ret.add(OpenTableWidget(
                table: table,
                callback: () async {
                  var res = await controller.openYesNoDialog(
                      'Aktarma yapmak istediğiniz masa şu anda dolu. Hesapları birleştirmek istediğinizden emin misiniz?');
                  if (res) {
                    controller.transferOrders(
                        controller.selectedMenuItems.isEmpty,
                        table.tableId,
                        table.checkId);
                  }
                }));
          } else {
            ret.add(CheckSendTableWidget(
              table: table,
              callback: () async {
                var res = await controller.openYesNoDialog(
                    'Aktarma yapmak istediğiniz masa şu anda dolu. Hesapları birleştirmek istediğinizden emin misiniz?');
                if (res) {
                  controller.transferOrders(
                      controller.selectedMenuItems.isEmpty,
                      table.tableId,
                      table.checkId);
                }
              },
            ));
          }
        }
      }
    }
    return ret;
  }

  List<Widget> createTableWidgets(
      HomeGroupWithDetails group, OrderDetailController controller) {
    if (group.name == 'Açık Hesaplar' &&
        controller.selectedTableGroup.value != null &&
        controller.selectedTableGroup.value!.name != 'Açık Hesaplar') return [];
    return List.generate(group.tables!.length, (index) {
      TableWithDetails table = group.tables![index];
      if (table.status == TableStatusTypeEnum.Empty.index) {
        return ClosedTableWidget(
          table: table,
          callback: () => controller.transferOrders(
              controller.selectedMenuItems.isEmpty,
              table.tableId,
              table.checkId),
        );
      } else if (table.status == TableStatusTypeEnum.HasOpenCheck.index) {
        return OpenTableWidget(
            table: table,
            callback: () async {
              var res = await controller.openYesNoDialog(
                  'Aktarma yapmak istediğiniz masa şu anda dolu. Hesapları birleştirmek istediğinizden emin misiniz?');
              if (res) {
                controller.transferOrders(controller.selectedMenuItems.isEmpty,
                    table.tableId, table.checkId);
              }
            });
      } else {
        return CheckSendTableWidget(
          table: table,
          callback: () async {
            var res = await controller.openYesNoDialog(
                'Aktarma yapmak istediğiniz masa şu anda dolu. Hesapları birleştirmek istediğinizden emin misiniz?');
            if (res) {
              controller.transferOrders(controller.selectedMenuItems.isEmpty,
                  table.tableId, table.checkId);
            }
          },
        );
      }
    });
  }

  Widget buildCheckTransferTab(OrderDetailController controller) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: buildCheckTransferText(),
        ),
        Expanded(
          flex: 90,
          child: buildTransferListAndActionsRow(controller),
        ),
      ],
    );
  }

  Row buildTransferListAndActionsRow(OrderDetailController controller) {
    return Row(
      children: [
        Expanded(
          flex: 60,
          child: buildTransferItemsColumn(controller),
        ),
        const Spacer(flex: 2),
        Expanded(
          flex: 60,
          child: buildTransferActionsColumn(controller),
        )
      ],
    );
  }

  Column buildTransferActionsColumn(OrderDetailController controller) {
    return Column(
      children: [
        PaymentButtonRow(
          flex: 10,
          buttonLeft: PaymentButton(
            callback: () {
              controller
                  .makeCheckPaymentWithMenuItems(CheckPaymentTypeEnum.Cash);
            },
            color: Colors.white,
            text: 'NAKİT',
          ),
          buttonRight: PaymentButton(
            callback: () => controller.navigateToCheckAccounts(false, true),
            color: Colors.white,
            text: 'CARİ',
          ),
        ),
        const Spacer(flex: 2),
        PaymentButtonRow(
          flex: 10,
          buttonLeft: PaymentButton(
            callback: () {
              controller.makeCheckPaymentWithMenuItems(
                  CheckPaymentTypeEnum.CreditCart);
            },
            color: Colors.white,
            text: 'KREDİ',
          ),
          buttonRight: PaymentButton(
            callback: () {
              controller
                  .makeCheckPaymentWithMenuItems(CheckPaymentTypeEnum.Gift);
            },
            color: Colors.white,
            text: 'İKRAM',
          ),
        ),
        const Divider(color: Colors.black),
        Expanded(
          flex: 10,
          child: SizedBox(
            width: double.infinity,
            child: PaymentButton(
              callback: () {
                controller.openNewCheckDialog();
              },
              color: Colors.white,
              text: 'YENİ HESAP AÇ',
            ),
          ),
        ),
        const Spacer(flex: 3),
        Expanded(
          flex: 10,
          child: SizedBox(
            width: double.infinity,
            child: PaymentButton(
              callback: () {
                controller.checkActionsTabIndex(2);
              },
              color: Colors.white,
              text: 'BAŞKA HESABA AKTAR',
            ),
          ),
        ),
        const Spacer(flex: 4),
        Expanded(
          flex: 40,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: buildPaymentTextColumn(controller),
          ),
        )
      ],
    );
  }

  Column buildTransferItemsColumn(OrderDetailController controller) {
    return Column(
      children: [
        Expanded(
          flex: 90,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black54)),
            child: buildTransferItemsList(controller),
          ),
        ),
        const Spacer(flex: 3),
        Expanded(
          flex: 15,
          child: buildTransferItemsTotalPrice(controller),
        )
      ],
    );
  }

  Container buildTransferItemsTotalPrice(OrderDetailController controller) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black54)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '   Toplam Tutar: ',
              style: TextStyle(fontSize: 20),
            ),
            Text(
                '${controller.getSelectedItemsTotalPrice().toStringAsFixed(2)} TL    ',
                style: const TextStyle(fontSize: 20))
          ],
        ));
  }

  Widget buildTransferItemsList(OrderDetailController controller) {
    return Container(
      color: controller.checkActionsTabIndex.value == 1
          ? Colors.white
          : const Color(0xff2B393F),
      child: ListView.builder(
        itemBuilder: (context, index) {
          GroupedCheckItem groupedItem = controller.groupedSelectedItems[index];
          return GestureDetector(
            onTap: () => controller.selectedItemClick(groupedItem),
            child: groupedItem.itemCount != 0
                ? Container(
                    padding: const EdgeInsets.all(8.0),
                    color: controller.checkActionsTabIndex.value == 1
                        ? (index % 2 == 0 ? Colors.white : Colors.black12)
                        : (index % 2 == 0
                            ? const Color(0xff2B393F)
                            : const Color(0xff253139)),
                    child: controller.checkActionsTabIndex.value == 1
                        ? OrderListTile(
                            groupedItem: groupedItem,
                            itemNameColor: Colors.black,
                            itemSubtitleColor: Colors.black54,
                            quantityTextBorderColor: Colors.grey,
                          )
                        : OrderListTile(
                            groupedItem: groupedItem,
                          ),
                  )
                : Container(),
          );
        },
        itemCount: controller.groupedSelectedItems.length,
      ),
    );
  }

  Padding buildCheckTransferText() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Soldaki listede, ayırmak istediğiniz ürünlere tıklayınız.',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Row buildPaymentAndKeyboardRow(
      OrderDetailPageType type, OrderDetailController controller) {
    return Row(
      children: [
        Expanded(
          flex: 40,
          child: buildKeyboardAndPrintColumn(controller),
        ),
        const Spacer(flex: 5),
        Expanded(
          flex: 40,
          child: buildPaymentButtonsColumn(type, controller),
        )
      ],
    );
  }

  Column buildKeyboardAndPrintColumn(OrderDetailController controller) {
    return Column(
      children: [
        buildPriceInput(controller),
        const SizedBox(height: 5),
        Expanded(flex: 88, child: buildKeyboard(controller)),
        const SizedBox(height: 10),
        Expanded(flex: 12, child: buildPrintButtonsRow())
      ],
    );
  }

  TextFormField buildPriceInput(OrderDetailController controller) {
    return TextFormField(
      controller: controller.priceCtrl,
      enabled: true,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\,?\d{0,4}'))
      ],
      autofocus: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          filled: true,
          fillColor: Colors.white),
    );
  }

  NumericKeyboard buildKeyboard(OrderDetailController controller) {
    return NumericKeyboard(
      buttonColor: Colors.white,
      pinFieldController: controller.priceCtrl,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      type: KeyboardType.DOUBLE,
      actionColumn: buildActionColumn(controller),
      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      clearCallback: () {
        controller.clearAddition();
      },
    );
  }

  Widget buildActionColumn(OrderDetailController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(flex: 3),
        Expanded(
          child: KeyboardCustomButton(
            buttonColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            child: const Text(
              '%',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (!controller.priceCtrl.text.contains('%')) {
                controller.priceCtrl.text = '%${controller.priceCtrl.text}';
              }
            },
          ),
        ),
      ],
    );
  }

  Row buildPrintButtonsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        // Expanded(
        //   child: buildPrintBillButton(),
        // ),
        // SizedBox(
        //   width: 10.h,
        // ),
        // Expanded(
        //   child: buildPrintCheckButton(),
        // ),
      ],
    );
  }

  ElevatedButton buildPrintBillButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      child: const Text(
        'Adisyon Yazdır',
        style: TextStyle(
          fontSize: 22,
          color: Color(0xffF1A159),
        ),
      ),
    );
  }

  ElevatedButton buildPrintCheckButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      child: const Text(
        'Adisyon Yazdır',
        style: TextStyle(
          fontSize: 22,
          color: Color(0xffF1A159),
        ),
      ),
    );
  }

  Column buildPaymentButtonsColumn(
      OrderDetailPageType type, OrderDetailController controller) {
    return Column(
      children: [
        PaymentButtonRow(
          buttonLeft: PaymentButton(
            callback: () =>
                controller.makeCheckPayment(CheckPaymentTypeEnum.Cash),
            text: 'NAKİT',
            color: const Color(0xffEC9191),
          ),
          buttonRight: PaymentButton(
            callback: () =>
                controller.makeCheckPayment(CheckPaymentTypeEnum.CreditCart),
            text: 'KREDİ',
            color: const Color(0xffF7C79B),
          ),
        ),
        const SizedBox(height: 8),
        PaymentButtonRow(
          buttonLeft: PaymentButton(
            callback: () => controller.navigateToCheckAccounts(true, false),
            text: controller.checkDetail.value!.checkAccountName != null
                ? '${'CARİ\n(${controller.checkDetail.value!.checkAccountName!}'})'
                : 'CARİ',
            color: const Color(0xffABCDDB),
          ),
          buttonRight: PaymentButton(
            callback: () => controller.closeUnpayableCheck(),
            text: 'ÖDENMEZ',
            color: const Color(0xffD6FECE),
          ),
        ),
        const SizedBox(height: 8),
        PaymentButtonRow(
          buttonLeft: PaymentButton(
            callback: () =>
                controller.makeCheckPayment(CheckPaymentTypeEnum.Discount),
            text: 'İSKONTO',
            color: const Color(0xffFDEEBC),
          ),
          buttonRight: PaymentButton(
            callback: () => controller.printCheck(),
            text: 'YAZDIR',
            color: const Color(0xffF3EDFF),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: buildPaymentTextContainer(controller),
        )
      ],
    );
  }

  Widget buildPaymentTextContainer(OrderDetailController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: buildPaymentTextColumn(controller),
    );
  }

  Widget buildPaymentTextColumn(OrderDetailController controller) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Spacer(),
              PaymentText(
                firstText: 'TOPLAM',
                secondText:
                    (controller.checkDetail.value!.payments!.checkAmount! -
                            controller.checkDetail.value!.payments!
                                .serviceChargeAmount!)
                        .toStringAsFixed(2),
              ),
              PaymentText(
                firstText: 'ÖDEMELER',
                secondText: controller.checkDetail.value!.payments!
                    .paymentsWithoutDiscountsAmount!
                    .toStringAsFixed(2),
              ),
              controller.checkDetail.value!.payments!.serviceChargeAmount! > 0
                  ? PaymentText(
                      firstText: 'SERVİS ÜCRETİ',
                      secondText: controller
                          .checkDetail.value!.payments!.serviceChargeAmount!
                          .toStringAsFixed(2),
                    )
                  : Container(),
              PaymentText(
                firstText: controller
                            .checkDetail.value!.constantDiscountPercentage !=
                        null
                    ? 'İSKONTO (%${controller.checkDetail.value!.constantDiscountPercentage})'
                    : 'İSKONTO',
                secondText: controller
                    .checkDetail.value!.payments!.discountAmount!
                    .toStringAsFixed(2),
              ),
              const Divider(),
              PaymentText(
                firstText: 'KALAN',
                secondText: controller
                    .checkDetail.value!.payments!.remainingAmount!
                    .toStringAsFixed(2),
              ),
              const Spacer()
            ],
          ),
        )
      ],
    );
  }
}

class ActionsRow extends StatelessWidget {
  final ActionButton button1;
  final ActionButton button2;
  const ActionsRow(this.button1, this.button2, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      child: Row(
        children: [button1, const SizedBox(width: 8), button2],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ActionButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 90,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2B393F)),
          onPressed: () => onPressed(),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}


// Widget buildActionColumn() {
//   return Column(
//     children: [
//       Expanded(
//         flex: 100,
//         child: KeyboardCustomButton(
//           buttonColor: Colors.red,
//           shape: RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(18.0),
//           ),
//           child: Text(
//             '+',
//             style: TextStyle(fontSize: 80.sp, color: Colors.white),
//           ),
//           onPressed: () {},
//         ),
//       ),
//       Expanded(
//         flex: 50,
//         child: KeyboardCustomButton(
//           buttonColor: Color(0xffF1A159),
//           shape: RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(18.0),
//           ),
//           child: Text(
//             '-',
//             style: TextStyle(fontSize: 80.sp, color: Colors.white),
//           ),
//           onPressed: () {},
//         ),
//       ),
//       Expanded(
//         flex: 50,
//         child: KeyboardCustomButton(
//           buttonColor: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: new BorderRadius.circular(18.0),
//           ),
//           child: Text(
//             '%',
//             style: TextStyle(fontSize: 60.sp, color: Color(0xffF1A159)),
//           ),
//           onPressed: () {},
//         ),
//       )
//     ],
//   );
// }
