import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/service/check_account/check_account_service.dart';
import 'package:ideas_desktop_getx/service/eft_pos/eft_pos_service.dart';
import 'package:ideas_desktop_getx/service/menu/menu_service.dart';
import 'package:ideas_desktop_getx/service/printer/printer_service.dart';
import 'package:ideas_desktop_getx/service/table/table_service.dart';
import 'package:ideas_desktop_getx/view/check-account/check-accounts/navigation/check_accounts_navigation_args.dart';
import 'package:ideas_desktop_getx/view/check-detail/check_detail_view.dart';
import 'package:ideas_desktop_getx/view/notes/notes_page.dart';
import '../../../locale_keys_enum.dart';
import '../../../model/check_account_model.dart';
import '../../../model/check_model.dart';
import '../../../model/menu_model.dart';
import '../../../model/home_model.dart';
import '../../../model/printer_model.dart';
import '../../../service/branch/branch_service.dart';
import '../../../service/check/check_service.dart';
import '../../../service/home/home_service.dart';
import '../../authentication/login/model/terminal_user.dart';
import '../../authentication/login/service/login_service.dart';
import '../../cancel-check-item/cancel_check_item_view.dart';
import '../../eft-pos-status/eft_pos_status_view.dart';
import '../../select-condiment/view/select_condiment_view.dart';
import '../../stopped-items/stopped_items_view.dart';
import '../component/change_waiter.dart';
import '../component/customer_count_dialog.dart';
import '../component/discount_dialog.dart';
import '../component/edit_item_actions_dialog.dart';
import '../component/extra_item_dialog.dart';
import '../component/new_check_dialog.dart';
import '../component/portion_quantity_dialog.dart';
import '../component/select_cashier_bank.dart';
import '../component/select_printer.dart';
import '../component/service_charge_dialog.dart';
import '../model/order_detail_model.dart';

class OrderDetailController extends BaseController {
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController selectedPriceCtrl = TextEditingController();
  TextEditingController checkNoteCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();
  TextEditingController tableNameCtrl = TextEditingController();
  final ScrollController controller = ScrollController();
  final ScrollController actionsScrollController = ScrollController();

  late EftPosService eftPosService = Get.find();
  late FocusNode myFocusNode = FocusNode();
  late FocusNode tableNameFocus = FocusNode();
  late MenuService menuService = Get.find();
  late PrinterService printerService = Get.find();
  late CheckService checkService = Get.find();
  late TableService tableService = Get.find();
  late HomeService homeService = Get.find();
  late LoginService authService = Get.find();
  late BranchService branchService = Get.find();
  late CheckAccountService checkAccountService = Get.find();

  RxBool print = RxBool(true);
  RxBool hideSearch = RxBool(true);
  RxDouble quantity = RxDouble(1);
  RxList<MenuItemCategory?> menuItemCategories = RxList<MenuItemCategory>([]);
  Rx<MenuItemCategory?> selectedCategory = Rx<MenuItemCategory?>(null);
  Rx<MenuItemSubCategory?> selectedSubCategory = Rx<MenuItemSubCategory?>(null);
  RxInt mainTabIndex = RxInt(1);
  RxInt checkActionsTabIndex = RxInt(0);
  Rx<CheckDetailsModel> basket = Rx<CheckDetailsModel>(
      CheckDetailsModel(checkId: -1, branchId: -1, basketItems: []));
  RxList<CheckMenuItemModel?> selectableMenuItems =
      RxList<CheckMenuItemModel?>([]);
  RxList<CheckMenuItemModel?> selectedMenuItems =
      RxList<CheckMenuItemModel?>([]);
  RxList<GroupedCheckItem> groupedBasketItems = RxList<GroupedCheckItem>([]);
  RxList<GroupedCheckItem> groupedCheckItems = RxList<GroupedCheckItem>([]);
  RxList<GroupedCheckItem> groupedSelectableItems =
      RxList<GroupedCheckItem>([]);
  RxList<GroupedCheckItem> groupedSelectedItems = RxList<GroupedCheckItem>([]);
  Rx<HomeGroupWithDetails?> selectedTableGroup =
      Rx<HomeGroupWithDetails?>(null);
  RxList<HomeGroupWithDetails?> tableGroups = RxList<HomeGroupWithDetails?>([]);
  Rx<CheckDetailsModel?> checkDetail = Rx<CheckDetailsModel?>(null);
  RxList<double> addition = RxList<double>([]);

  final int? tableId = Get.arguments.tableId;
  int? checkId = Get.arguments.checkId;
  final String? alias = Get.arguments.alias;
  final bool isIntegration = Get.arguments.isIntegration;
  final OrderDetailPageType type = Get.arguments.type;

  @override
  void onInit() {
    super.onInit();
    basket.value.terminalUserId = authStore.user!.terminalUserId;
    basket.value.branchId = authStore.user!.branchId;
    hideSearch(!localeManager.getBoolValue(PreferencesKeys.AUTO_SEARCH));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initCheckDetails();
      getCategories();
      getTableGroups();
      myFocusNode.requestFocus();
    });
  }

  initCheckDetails() async {
    if (tableId != null && tableId! > 0) {
      var res = await tableService.getActiveCheckIdByTableId(tableId);
      if (res != null && res.value! > 0) {
        checkId = res.value;
      }
    }
    if (checkId! > 0) {
      await getCheckDetails();
      // for (var item in checkDetail!.basketItems!) {
      //   print(item!.checkMenuItemId.toString() + "\n");
      // }
    }

    switch (type) {
      case OrderDetailPageType.TABLE:
        if (checkId == null || checkId == -1) {
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          var table = await tableService.getTableDetails(tableId);
          checkDetail(CheckDetailsModel(table: table));
          EasyLoading.dismiss();
          if (table == null) {
            // navigation.navigateToPageClear(
            //     path: NavigationConstants.ERROR_VIEW);
          }
          basket.value.tableId = tableId;
          if (!checkDetail.value!.table!.disablePersonCount! &&
              authStore.settings!.isPersonCountRequired!) {
            await openCustomerCountDialog(false);
          }
        }
        break;
      case OrderDetailPageType.ALIAS:
        if (checkId! <= 0) {
          basket.update((val) {
            val!.alias = alias!;
          });
          checkDetail(CheckDetailsModel());
          if (authStore.settings!.isPersonCountRequired!) {
            await openCustomerCountDialog(false);
          }
        } else {
          basket.value.alias = checkDetail.value!.alias;
        }
        break;
      case OrderDetailPageType.DELIVERY:
        if (checkId! <= 0) {
          checkDetail(CheckDetailsModel());
        } else {
          basket.value.checkId = checkId;
        }
        if (isIntegration) mainTabIndex(0);
        break;
      default:
    }
  }

  Future getCheckDetails() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkDetail(
        await checkService.getCheckDetails(checkId, authStore.user!.branchId!));

    if (checkDetail.value == null) {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    }
    basket.value.checkId = checkId;
    groupedCheckItems(getGroupedMenuItems(checkDetail.value!.basketItems!));
    resetSelectableMenuItems();
    checkNoteCtrl.text = checkDetail.value!.checkNote != null
        ? checkDetail.value!.checkNote!
        : '';
    if (checkDetail.value!.checkStatusTypeId ==
        CheckStatusTypeEnum.BillSent.index) {
      mainTabIndex(0);
    }
    EasyLoading.dismiss();
  }

  void resetSelectedMenuItems() {
    selectedMenuItems([]);
    groupedSelectedItems([]);
  }

  void resetSelectableMenuItems() {
    selectableMenuItems([]);
    var temp = checkDetail.value!.basketItems!
        .where((x) => x!.actionType == CheckMenuItemActionType.ORDER.getValue)
        .toList();
    for (var item in temp) {
      selectableMenuItems.add(CheckMenuItemModel(
          totalPrice: item!.totalPrice,
          condiments: item.condiments,
          isStopped: item.isStopped,
          menuItemId: item.menuItemId,
          name: item.name,
          note: item.note,
          actionType: item.actionType,
          sellUnit: item.sellUnit,
          sellUnitQuantity: item.sellUnitQuantity));
    }
    groupedSelectableItems(getGroupedMenuItems(selectableMenuItems));
  }

  void changeTableGroup(HomeGroupWithDetails? group) {
    selectedTableGroup(group);
  }

  Future getTableGroups() async {
    tableGroups(
        await homeService.getHomeGroupsWithDetails(authStore.user!.branchId!));

    if (tableGroups != null) {
      if (tableGroups.isNotEmpty) {
        if (selectedTableGroup.value != null) {
          selectedTableGroup(tableGroups
              .where((element) =>
                  element!.tableGroupId ==
                  selectedTableGroup.value!.tableGroupId)
              .first);
        } else {
          selectedTableGroup(tableGroups[0]);
        }
      }
    }
  }

  Future getCategories() async {
    menuItemCategories(
        await menuService.getCategories(authStore.user!.branchId));
    if (selectedCategory.value == null && menuItemCategories.isNotEmpty) {
      changeCategory(menuItemCategories[0]!);
    }
  }

  void changeCategory(MenuItemCategory category) {
    selectedCategory(category);
    if (selectedCategory.value!.menuItemSubCategories!.isNotEmpty) {
      changeSubCategory(selectedCategory.value!.menuItemSubCategories![0]);
    }
  }

  void changeSubCategory(MenuItemSubCategory subCategory) {
    selectedSubCategory(subCategory);
  }

  bool isCategorySelected(MenuItemCategory category) {
    return category.menuItemCategoryId ==
        selectedCategory.value!.menuItemCategoryId;
  }

  bool isSubCategorySelected(MenuItemSubCategory category) {
    return category.menuItemSubCategoryId ==
        selectedSubCategory.value!.menuItemSubCategoryId;
  }

  Future menuItemClick(MenuItem item) async {
    // MenuItem with condiments
    if (item.condimentGroups!.isNotEmpty) {
      int itemCount = 1;
      double sellUnitQnt = 1;

      double qnt = quantity.toString().getDouble!;
      if (qnt % 1 == 0) {
        itemCount = qnt.getInt;
      } else {
        sellUnitQnt = qnt;
      }

      List<CheckMenuItemModel>? list = await Get.dialog(
        useSafeArea: true,
        arguments: [
          item,
          itemCount,
          sellUnitQnt,
        ],
        SelectCondimentPage(),
      );

      if (list != null && list.isNotEmpty) {
        for (var listItem in list) {
          listItem.sellUnit = item.sellUnit;
          listItem.sellUnitQuantity = sellUnitQnt;
          if (item.isCategoryStoppedDefault!) listItem.isStopped = true;

          basket.update(
            (val) {
              val!.basketItems!.add(CheckMenuItemModel(
                totalPrice: listItem.totalPrice,
                actionType: listItem.actionType,
                condiments: listItem.condiments,
                isStopped: listItem.isStopped,
                menuItemId: listItem.menuItemId,
                name: listItem.name,
                note: listItem.note,
                sellUnit: listItem.sellUnit,
                sellUnitQuantity: listItem.sellUnitQuantity,
              ));
            },
          );
        }
      }
    }
    // MenuItem with gram
    else {
      if (item.sellUnit!.defaultSellUnitId != 1) {
        await showUpdateGramDialog(item, (quantity) {
          CheckMenuItemModel checkItem = CheckMenuItemModel(
              condiments: [],
              menuItemId: item.menuItemId,
              name: item.nameTr,
              totalPrice: item.price,
              sellUnit: item.sellUnit,
              actionType: CheckMenuItemActionType.ORDER.getValue,
              sellUnitQuantity: (quantity.getDouble));
          checkItem.totalPrice =
              checkItem.totalPrice * checkItem.sellUnitQuantity!;
          if (item.isCategoryStoppedDefault!) checkItem.isStopped = true;
          basket.update((val) {
            val!.basketItems!.add(checkItem);
          });

          if (quantity.getDouble! > 0) {
            Get.back();
          }
        });
      }
      // Basic MenuItem
      else {
        int itemCount = 1;
        double sellUnitQnt = 1;

        double qnt = quantity.toString().getDouble!;
        if (qnt % 1 == 0) {
          itemCount = qnt.getInt;
        } else {
          sellUnitQnt = qnt;
        }

        for (var v = 0; v < itemCount; v++) {
          CheckMenuItemModel checkItem = CheckMenuItemModel(
            condiments: [],
            menuItemId: item.menuItemId,
            name: item.nameTr,
            totalPrice: item.price,
            sellUnit: item.sellUnit,
            sellUnitQuantity: sellUnitQnt,
            actionType: CheckMenuItemActionType.ORDER.getValue,
          );
          checkItem.totalPrice =
              checkItem.totalPrice * checkItem.sellUnitQuantity!;
          if (item.isCategoryStoppedDefault!) checkItem.isStopped = true;
          basket.update((val) {
            val!.basketItems!.add(checkItem);
          });
        }
      }
    }
    quantity(1);
    groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
  }

  void changeMainTabIndex(int index) {
    if ((index == 1 || index == 2) &&
        checkDetail.value!.checkStatusTypeId == 1) {
      showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
      return;
    }

    mainTabIndex(index);
  }

  void changeCheckActionsTabIndex(int index) {
    // 1 IS SEPERATION TAB
    if (index != 1) {
      resetSelectedMenuItems();
      resetSelectableMenuItems();
    }
    checkActionsTabIndex(index);
  }

  Future checkItemClick(GroupedCheckItem item) async {
    if (checkActionsTabIndex.value != 2) {
      if (item.originalItem!.actionType !=
          CheckMenuItemActionType.ORDER.getValue) {
        showSnackbarError(
            'Ödemesi yapılmış ürünlerde güncelleme yapamazsınız.');
      } else if (checkDetail.value!.checkStatusTypeId! == 1) {
        showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
      } else {
        var res = await Get.dialog(
          EditItemActionsDialog(
            item: item,
            isCheckItem: true,
            giftAction: () async {
              if (item.itemCount! > 1) {
                var res = await Get.dialog(
                  QuantityDialog(
                    item: item,
                    updateAction: (quantity) {
                      if (quantity.getDouble! > 0) {
                        resetSelectedMenuItems();
                        resetSelectableMenuItems();
                        for (var i = 0; i < quantity.getDouble!; i++) {
                          selectedMenuItems.add(item.originalItem);
                        }
                        makeCheckPaymentWithMenuItems(
                            CheckPaymentTypeEnum.Gift);
                        Get.back(result: true);
                      }
                    },
                  ),
                );
                if (res != null) Get.back();
              } else {
                var res = await openYesNoDialog(
                    'Ürünü ikram etmek istediğinizden emin misiniz?');
                if (res) {
                  resetSelectedMenuItems();
                  resetSelectableMenuItems();
                  selectedMenuItems.add(item.originalItem);
                  makeCheckPaymentWithMenuItems(CheckPaymentTypeEnum.Gift);
                  Get.back();
                }
              }
            },
            stopSendAction: () async {
              var res = await Get.dialog(StoppedItemsPage(), arguments: [
                checkId!,
                groupedCheckItems
                    .where((element) => element.originalItem!.isStopped == true)
                    .toList()
                    .map((e) => GroupedCheckItem(
                        totalPrice: e.totalPrice,
                        name: e.name,
                        originalItem: e.originalItem,
                        sellUnitQuantity: e.sellUnitQuantity,
                        itemCount: e.itemCount))
                    .toList()
              ]);
              if (res != null) {
                Get.back();
                closePage(checkId);
              }
            },
            deleteAction: () async {
              var res = await checkMenuItemCancelDialog(
                item,
              );
              if (res == 0) {
                showSnackbarError(
                    'İptal edebilmek için ödemeleri sıfırlamanız gerekmektedir');
              }
              await getCheckDetails();
              Get.back();
              if (checkDetail.value!.checkStatusTypeId == 2) closePage(checkId);
            },
            noteAction: null,
            addAction: () async {
              var res = await Get.dialog(
                QuantityDialog(
                  item: item,
                  updateAction: (quantity) async {
                    if (int.tryParse(quantity) != null) {
                      EasyLoading.show(
                        status: 'Lütfen Bekleyiniz...',
                        dismissOnTap: false,
                        maskType: EasyLoadingMaskType.black,
                      );
                      for (var i = 0; i < int.parse(quantity); i++) {
                        basket.update((val) {
                          val!.basketItems!.add(item.originalItem);
                        });
                      }
                      await sendOrder();
                      await getCheckDetails();
                      EasyLoading.dismiss();
                    }
                  },
                ),
              );
              if (res != null) {
                Get.back();
                closePage(checkId);
              }
            },
            changePriceAction: () async {
              var res = await Get.dialog(
                QuantityDialog(
                  item: item,
                  updateAction: (price) async {
                    if (price.toString().getDouble != null) {
                      EasyLoading.show(
                        status: 'Lütfen Bekleyiniz...',
                        dismissOnTap: false,
                        maskType: EasyLoadingMaskType.black,
                      );
                      ChangePriceModel input = ChangePriceModel(
                        branchId: authStore.user!.branchId,
                        checkId: checkDetail.value!.checkId,
                        totalPrice: price.toString().getDouble,
                        checkMenuItemIds: item.checkMenuItemIds,
                        terminalUserId: authStore.user!.terminalUserId,
                      );
                      var res =
                          await checkService.changeCheckMenuItemPrice(input);
                      EasyLoading.dismiss();
                      if (res != null) {
                        Get.back(result: true);
                      }
                    }
                  },
                ),
              );
              if (res != null) {
                Get.back();
                getCheckDetails();
              }
            },
          ),
        );
        if (res != null) {
          // basket.basketItems = basket.basketItems;
          basket.refresh();
        }
      }
    }
  }

  Future basketItemClick(GroupedCheckItem item) async {
    var res = await Get.dialog(EditItemActionsDialog(
      item: item,
      isCheckItem: false,
      deleteAction: () => removeBasketItem(item),
      noteAction: () async {
        var res = await showNoteDialog(item);
        if (res != null) {
          Get.back(result: res);
        }
      },
      stopSendAction: () => stopItem(item),
      updateQuantityAction: () async {
        var res = await showUpdateQuantityDialog(
            item,
            (itemCount) =>
                updateBasketItemQuantity(item, itemCount.getDouble!.getInt));
        if (res != null) Get.back(result: res);
      },
    ));
    if (res != null) {
      basket.refresh();
    }
  }

  Future selectableItemClick(GroupedCheckItem item) async {
    selectedMenuItems.add(CheckMenuItemModel(
      totalPrice: item.originalItem!.totalPrice,
      condiments: item.originalItem!.condiments,
      isStopped: item.originalItem!.isStopped,
      menuItemId: item.originalItem!.menuItemId,
      name: item.originalItem!.name,
      note: item.originalItem!.note,
      sellUnit: item.originalItem!.sellUnit,
      sellUnitQuantity: item.originalItem!.sellUnitQuantity,
      actionType: item.originalItem!.actionType,
    ));
    CheckDetailsModel temp = CheckDetailsModel(basketItems: selectedMenuItems);
    groupedSelectedItems(getGroupedMenuItems(temp.basketItems!));

    for (var i = 0; i < selectableMenuItems.length; i++) {
      var selectableItem = selectableMenuItems[i]!;
      if (selectableItem.isSame(item.originalItem!)) {
        selectableMenuItems.removeAt(i);
        break;
      }
    }

    CheckDetailsModel temp2 =
        CheckDetailsModel(basketItems: selectableMenuItems);
    groupedSelectableItems(getGroupedMenuItems(temp2.basketItems!));
  }

  Future selectedItemClick(GroupedCheckItem item) async {
    selectableMenuItems.add(item.originalItem);
    CheckDetailsModel temp =
        CheckDetailsModel(basketItems: selectableMenuItems);
    groupedSelectableItems(getGroupedMenuItems(temp.basketItems!));

    for (var i = 0; i < selectedMenuItems.length; i++) {
      var selectedItem = selectedMenuItems[i]!;
      if (selectedItem.isSame(item.originalItem!)) {
        selectedMenuItems.removeAt(i);
        break;
      }
    }

    CheckDetailsModel temp2 = CheckDetailsModel(basketItems: selectedMenuItems);
    groupedSelectedItems(getGroupedMenuItems(temp2.basketItems!));
  }

  dynamic showNoteDialog(GroupedCheckItem item) async {
    TextEditingController noteController =
        TextEditingController(text: item.originalItem!.note ?? '');
    var result = await Get.dialog(NotesPages(), arguments: [
      item,
      noteController,
      (note) {
        updateNote(item, note);
      },
    ]);

    return result;
  }

  dynamic showUpdateQuantityDialog(
      GroupedCheckItem item, Function(String quantity) callback) async {
    var result = await Get.dialog(
      QuantityDialog(
        item: item,
        updateAction: (quantity) {
          callback(quantity);
        },
      ),
    );

    return result;
  }

  dynamic checkMenuItemCancelDialog(GroupedCheckItem item) async {
    if (item.itemCount != 1) {
      var result = await Get.dialog(
        QuantityDialog(
          item: item,
          updateAction: (quantity) async {
            if (quantity != '' && quantity != '0') {
              var closePage =
                  await Get.dialog(CancelCheckItemPage(), arguments: [
                int.parse(quantity),
                item,
                checkId!,
              ]);
              if (closePage) Get.back();
            }
          },
        ),
      );

      return result;
    } else {
      var closePage = await Get.dialog(CancelCheckItemPage(), arguments: [
        int.parse("1"),
        item,
        checkId!,
      ]);
      if (closePage) Get.back();
    }
  }

  dynamic showUpdateGramDialog(
      MenuItem item, Function(String quantity) callback) async {
    var result = await Get.dialog(GramDialog(
      item: item,
      updateAction: (quantity) {
        callback(quantity);
      },
    ));

    return result;
  }

  void updateBasketItemQuantity(GroupedCheckItem item, int itemCount) {
    for (var i = 0; i < basket.value.basketItems!.length; i++) {
      var basketItem = basket.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        basket.value.basketItems!.removeAt(i);
        i--;
      }
    }

    for (var i = 0; i < itemCount; i++) {
      basket.value.basketItems!.add(CheckMenuItemModel(
        totalPrice: item.originalItem!.totalPrice,
        actionType: item.originalItem!.actionType,
        condiments: item.originalItem!.condiments,
        isStopped: item.originalItem!.isStopped,
        menuItemId: item.originalItem!.menuItemId,
        name: item.originalItem!.name,
        note: item.originalItem!.note,
        sellUnit: item.originalItem!.sellUnit,
        sellUnitQuantity: item.originalItem!.sellUnitQuantity,
        printerId: item.originalItem!.printerId,
      ));
    }

    basket.refresh();
    groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
    Get.back(result: basket.value.basketItems);
  }

  void updateNote(GroupedCheckItem item, String note) {
    for (var i = 0; i < basket.value.basketItems!.length; i++) {
      var basketItem = basket.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        basketItem.note = note;
      }
    }

    basket.refresh();
    groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
    Get.back(result: basket.value.basketItems);
  }

  void removeBasketItem(GroupedCheckItem item) {
    for (var i = 0; i < basket.value.basketItems!.length; i++) {
      var basketItem = basket.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        basket.value.basketItems!.removeAt(i);
        i--;
      }
    }

    basket.refresh();
    groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
    Get.back(result: basket.value.basketItems);
  }

  Future sendOrder() async {
    if (type == OrderDetailPageType.TABLE ||
        type == OrderDetailPageType.ALIAS) {
      basket.value.checkNote = checkNoteCtrl.text;
      basket.value.printOrders = print.value;
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var checkId = await checkService.sendOrder(basket.value);
      EasyLoading.dismiss();
      if (checkId != null) Get.back(result: checkId.value);
    } else if (type == OrderDetailPageType.DELIVERY) {
      if (checkId! > 0) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var checkId = await checkService.sendOrder(basket.value);
        EasyLoading.dismiss();
        if (checkId != null) Get.back(result: checkId.value);
      }
    }
  }

  Future updateCheckNote() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    await checkService.updateCheckNote(UpdateCheckNoteInput(
      checkId: checkId!,
      checkNote: checkNoteCtrl.text,
      terminalUserId: basket.value.terminalUserId!,
      branchId: authStore.user!.branchId!,
    ));
    EasyLoading.dismiss();
    await getCheckDetails();
  }

  void closePage(int? checkId) {
    // Navigator.pop(buildContext!, checkId);
    if (authStore.settings!.autoLock!) {
      Get.offAllNamed('/');
    } else {
      Get.offAllNamed('/home');
    }
  }

  double getBasketTotalPrice() {
    double totalPrice = 0;
    for (var item in groupedBasketItems) {
      totalPrice += item.totalPrice;
    }
    return totalPrice;
  }

  String getBottomLeftTotalPrice() {
    if (mainTabIndex.value == 0 || mainTabIndex.value == 3) {
      return checkDetail.value!.payments!.checkAmount!.toStringAsFixed(2);
    } else {
      return getBasketTotalPrice().toStringAsFixed(2);
    }
  }

  double getSelectedItemsTotalPrice() {
    double totalPrice = 0;
    for (var item in groupedSelectedItems) {
      totalPrice += item.totalPrice;
    }

    return totalPrice;
  }

  Future makeCheckPayment(CheckPaymentTypeEnum type) async {
    if (type == CheckPaymentTypeEnum.Discount && priceCtrl.text.contains('%')) {
      var percantage = priceCtrl.text.substring(1).getDouble;
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.addConstantDiscount(checkId,
          basket.value.terminalUserId, percantage, authStore.user!.branchId!);
      EasyLoading.dismiss();
      await getCheckDetails();
      basket.refresh();
      groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
      priceCtrl.text = '';
    } else {
      bool makePayment = true;
      CheckPaymentModel input = CheckPaymentModel(
        checkId: checkId,
        isMenuItemBased: false,
        paymentTypeId: type.index,
        terminalUserId: authStore.user!.terminalUserId,
        branchId: authStore.user!.branchId!,
      );
      double? inputPrice = priceCtrl.text.getDouble;
      inputPrice ??= checkDetail.value!.payments!.remainingAmount;
      input.amount = inputPrice;

      CheckAccountListItem? selectedAcc;

      // CASHIERS
      if (type == CheckPaymentTypeEnum.Cash) {
        List<int> cashierInputId = [6];
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        List<CheckAccountListItem>? cashiers =
            await checkAccountService.getCheckAccounts(
          GetCheckAccountsInput(
              branchId: authStore.user!.branchId,
              checkAccountTypeIds: cashierInputId),
        );
        EasyLoading.dismiss();
        if (cashiers!.length > 1) {
          var cashierId = await Get.dialog(SelectCashierBank(cashiers));
          if (cashierId == null) {
            makePayment = false;
          } else {
            input.checkAccountId = cashierId;
            selectedAcc = cashiers
                .where((element) => element.checkAccountId == cashierId)
                .first;
          }
        } else if (cashiers.length == 1) {
          input.checkAccountId = cashiers.first.checkAccountId;
          selectedAcc = cashiers.first;
        }
      }

      // BANKS
      if (type == CheckPaymentTypeEnum.CreditCart) {
        List<int> bankId = [5, 7];
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        List<CheckAccountListItem>? banks =
            await checkAccountService.getCheckAccounts(
          GetCheckAccountsInput(
              branchId: authStore.user!.branchId, checkAccountTypeIds: bankId),
        );
        EasyLoading.dismiss();
        if (banks!.length > 1) {
          var bankId = await Get.dialog(SelectCashierBank(banks));
          if (bankId == null) {
            makePayment = false;
          } else {
            input.checkAccountId = bankId;
            selectedAcc = banks
                .where((element) => element.checkAccountId == bankId)
                .first;
          }
        } else if (banks.length == 1) {
          input.checkAccountId = banks.first.checkAccountId;
          selectedAcc = banks.first;
        }
      }

      if (makePayment) {
        input.printerName =
            localeManager.getStringValue(PreferencesKeys.CASH_PRINTER_NAME);
        if (input.checkAccountId != null &&
            selectedAcc != null &&
            selectedAcc.eftPosId != null &&
            selectedAcc.eftPosId! > 0) {
          var yesNo = await openFisDialog(type);
          if (yesNo) {
            bool total = false;
            double remaining = 0;
            await getCheckDetails();
            if (input.amount == checkDetail.value!.payments!.remainingAmount &&
                checkDetail.value!.payments!.totalPaymentAmount == 0) {
              total = true;
            } else {
              remaining = input.amount!;
            }
            var status = await Get.dialog(
                barrierDismissible: false,
                EftPosStatusPage(),
                arguments: [
                  selectedAcc.eftPosId!,
                  input.checkId!,
                  type,
                  total,
                  remaining,
                ]);
            if (status != true) {
              return;
            }
          }
        }
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var res = await checkService.makeCheckPayment(input);
        if (res != null) {
          priceCtrl.text = '';
          // CHECK IS CLOSED
          if (res.checkStatusTypeId == CheckStatusTypeEnum.Closed.index) {
            // SLIP PRINTER PRINTER
            List<PrinterOutput>? printers =
                await printerService.getPrinters(authStore.user!.branchId);
            printers =
                printers!.where((element) => element.isSlipPrinter!).toList();
            if (printers.isNotEmpty) {
              EasyLoading.dismiss();
              var isPrintSlip = await openYesNoDialog(
                  'Hesabı RESMİ FATURA yazıcısından yazdırmak istiyor musunuz?');
              if (isPrintSlip) {
                await printSlip();
              }
            }

            EasyLoading.dismiss();
            if (authStore.settings!.autoLock!) {
              Get.offNamed('/');
            } else {
              Get.offNamed('/home');
            }
          } else {
            await getCheckDetails();
          }
        } else {
          EasyLoading.dismiss();
        }
      }
    }
  }

  Future makeCheckPaymentWithMenuItems(CheckPaymentTypeEnum type) async {
    CheckPaymentModel input = CheckPaymentModel(
      checkId: checkId,
      isMenuItemBased: true,
      paymentTypeId: type.index,
      checkMenuItems: selectedMenuItems,
      terminalUserId: authStore.user!.terminalUserId,
      branchId: authStore.user!.branchId!,
    );
    input.amount = getSelectedItemsTotalPrice();
    bool makePayment = true;

    // BANKS
    if (type == CheckPaymentTypeEnum.CreditCart) {
      List<int> bankId = [5, 7];
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<CheckAccountListItem>? banks =
          await checkAccountService.getCheckAccounts(
        GetCheckAccountsInput(
            branchId: authStore.user!.branchId, checkAccountTypeIds: bankId),
      );
      EasyLoading.dismiss();
      if (banks!.length > 1) {
        var bankId = await Get.dialog(SelectCashierBank(banks));
        if (bankId == null) {
          makePayment = false;
        } else {
          input.checkAccountId = bankId;
        }
      } else if (banks.length == 1) {
        input.checkAccountId = banks.first.checkAccountId;
      }
    }

    if (makePayment) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      input.printerName =
          localeManager.getStringValue(PreferencesKeys.CASH_PRINTER_NAME);
      var res = await checkService.makeCheckPayment(input);
      EasyLoading.dismiss();
      if (res != null) {
        priceCtrl.text = '';
        if (res.checkStatusTypeId == CheckStatusTypeEnum.Closed.index) {
          Get.back(closeOverlays: true);
        } else {
          await getCheckDetails();
          resetSelectedMenuItems();
          resetSelectableMenuItems();
        }
      }
    }
  }

  Future transferOrders(
      bool transferAll, int? targetTableId, int? targetCheckId) async {
    TransferOrdersInput input = TransferOrdersInput(
      alias: "",
      checkId: checkId,
      targetTableId: targetTableId,
      terminalUserId: basket.value.terminalUserId,
      targetCheckId: targetCheckId,
      transferAll: transferAll,
      branchId: authStore.user!.branchId!,
    );
    if (transferAll) {
      input.checkMenuItems = checkDetail.value!.basketItems;
    } else {
      input.checkMenuItems = selectedMenuItems;
    }
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    var res = await checkService.transferOrders(input);
    EasyLoading.dismiss();
    if (res != null) {
      closePage(checkId);
    }
  }

  Future openNewCheckDialog() async {
    var checkAlias = await Get.dialog(InputDialog(
      hintText: 'Hesap adı giriniz.',
      titleText: 'Yeni Hesap Adı',
      inputType: TextInputType.text,
    ));

    if (checkAlias != null) {
      TransferOrdersInput input = TransferOrdersInput(
        alias: checkAlias,
        checkId: checkId,
        terminalUserId: basket.value.terminalUserId,
        transferAll: selectedMenuItems.isEmpty,
        branchId: authStore.user!.branchId!,
      );
      input.checkMenuItems = selectedMenuItems;
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      var res = await checkService.transferOrders(input);
      EasyLoading.dismiss();
      if (res != null) {
        closePage(checkId);
      }
    }
  }

  Future navigateToCheckAccounts(bool transferAll, bool isSeperated) async {
    if (authStore.user!.canSendCheckToCheckAccount!) {
      if (checkDetail.value!.checkAccountId == null || isSeperated) {
        Get.toNamed('check-accounts',
            arguments: CheckAccountsArguments(
                checkId: checkId,
                type: CheckAccountsPageType.Check,
                transferAll: transferAll,
                menuItems: transferAll ? null : selectedMenuItems));
      } else {
        bool confirm = await openYesNoDialog(
            'Adisyonu ${checkDetail.value!.checkAccountName!} adlı cari hesaba aktarmak istediğinizden emin misiniz?');

        if (confirm) {
          TransferCheckToCheckAccountInput inp =
              TransferCheckToCheckAccountInput(
            checkAccountId: checkDetail.value!.checkAccountId,
            checkId: checkId,
            menuItems: checkDetail.value!.basketItems,
            transferAll: true,
            branchId: authStore.user!.branchId!,
            terminalUserId: authStore.user!.terminalUserId!,
          );
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          var res = await checkAccountService.transferCheckToCheckAccount(inp);
          EasyLoading.dismiss();
          if (res != null) {
            closePage(checkId);
          }
        }
      }
    } else {
      showSnackbarError(
          '${authStore.user!.name!} adlı kullanıcının bu işlem için yetkisi yoktur.');
    }
  }

  Future openExtraItemDialog() async {
    if (checkDetail.value!.checkStatusTypeId == 1) {
      showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
    } else {
      mainTabIndex(1);
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<PrinterOutput>? printers = [];
      var res = await printerService.getPrinters(authStore.user!.branchId);
      EasyLoading.dismiss();
      if (res != null) printers = res;
      var resultArray = await Get.dialog(ExtraItemDialog(printers));

      // Extra MenuItem
      for (var v = 0; v < resultArray[2].toString().getDouble!.getInt; v++) {
        CheckMenuItemModel checkItem = CheckMenuItemModel(
          condiments: [],
          menuItemId: -1,
          actionType: 0,
          name: resultArray[0],
          totalPrice: resultArray[1].toString().getDouble!,
          sellUnit: DefaultSellUnitModel(
            defaultSellUnitId: 1,
            isFloating: false,
            name: 'Adet',
          ),
          sellUnitQuantity: 1,
          printerId: resultArray[3] == -1 ? null : resultArray[3],
        );
        basket.value.basketItems!.add(checkItem);
      }

      groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
      basket.refresh();
    }
  }

  void stopItem(GroupedCheckItem item) {
    for (var i = 0; i < basket.value.basketItems!.length; i++) {
      var basketItem = basket.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        if (basket.value.basketItems![i]!.isStopped == null ||
            basket.value.basketItems![i]!.isStopped == false) {
          basket.value.basketItems![i]!.isStopped = true;
        } else {
          basket.value.basketItems![i]!.isStopped = false;
        }
      }
    }
    basket.refresh();
    groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
    Get.back(result: basket.value.basketItems);
  }

  Future cancelDiscounts() async {
    bool confirm = await openYesNoDialog(
        'Adisyona yapılmış olan iskontoları sıfırlamak istediğinizden emin misiniz?');

    if (confirm) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.cancelDiscounts(
          checkId, basket.value.terminalUserId, authStore.user!.branchId!);
      EasyLoading.dismiss();
      await getCheckDetails();
      basket.refresh();
      groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
      changeMainTabIndex(0);
    }
  }

  Future cancelPayments() async {
    bool confirm = await openYesNoDialog(
        'Adisyona yapılmış olan ödemeleri sıfırlamak istediğinizden emin misiniz?');

    if (confirm) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.cancelPayments(
          checkId, basket.value.terminalUserId, authStore.user!.branchId!);
      EasyLoading.dismiss();
      await getCheckDetails();
      basket.refresh();
      groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
      changeMainTabIndex(0);
    }
  }

  Future openDiscountDialog() async {
    if (checkDetail.value!.checkStatusTypeId == 1) {
      showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
    } else {
      var discount = await Get.dialog(const DiscountDialog());
      if (discount != null) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await checkService.addConstantDiscount(
            checkId,
            basket.value.terminalUserId,
            discount.toString().getDouble,
            authStore.user!.branchId!);
        EasyLoading.dismiss();
        await getCheckDetails();
        basket.refresh();
        groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
        changeMainTabIndex(0);
      }
    }
  }

  Future openServiceChargeDialog() async {
    if (checkDetail.value!.checkStatusTypeId == 1) {
      showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
    } else {
      var charge = await Get.dialog(const ServiceChargeDialog());
      if (charge != null) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await checkService.addServiceCharge(
            checkId,
            basket.value.terminalUserId,
            charge.toString().getDouble,
            authStore.user!.branchId!);
        EasyLoading.dismiss();
        await getCheckDetails();
        basket.refresh();
        groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
        changeMainTabIndex(0);
      }
    }
  }

  Future markUnpayable() async {
    bool confirm = await openYesNoDialog(
        'Adisyonu ödenmez olarak işaretlemek istediğinizden emin misiniz?');

    if (confirm) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.markUnpayable(checkId, authStore.user!.branchId!);
      EasyLoading.dismiss();
      await getCheckDetails();
      basket.refresh();
      groupedBasketItems(getGroupedMenuItems(basket.value.basketItems!));
      changeMainTabIndex(0);
    }
  }

  Future closeUnpayableCheck() async {
    if (authStore.user!.canMarkUnpayable!) {
      bool confirm = await openYesNoDialog(
          'Adisyonu ödenmez olarak kapatmak istediğinizden emin misiniz?');

      if (confirm) {
        /////// if (checkDetail!.checkAccountId == null)
        Get.toNamed('check-accounts',
            arguments: CheckAccountsArguments(
                checkId: checkId,
                type: CheckAccountsPageType.Unpayable,
                transferAll: true,
                menuItems: null));
      }
    } else {
      showSnackbarError(
          '${authStore.user!.name!} adlı kullanıcının bu işlem için yetkisi yoktur.');
    }
  }

  void selectCustomer() async {
    if (checkDetail.value!.checkStatusTypeId == 1) {
      showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
    } else {
      Get.toNamed('check-accounts',
          arguments: CheckAccountsArguments(
              checkId: checkId,
              type: CheckAccountsPageType.CheckCustomer,
              transferAll: false,
              menuItems: null));
    }
  }

  void clearCheckCustomer() async {
    if (checkDetail.value!.checkStatusTypeId == 1) {
      showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
    } else {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.clearCheckCustomer(checkId, authStore.user!.branchId!);
      EasyLoading.dismiss();
      await getCheckDetails();
    }
  }

  Future openChangeWaiterDialog() async {
    if (checkDetail.value!.checkStatusTypeId == 1) {
      showSnackbarError('Değişiklik yapmak için yazdırmayı geri alın.');
    } else {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<TerminalUser>? users =
          await authService.getTerminalUsers(authStore.user!.branchId!);
      EasyLoading.dismiss();
      var terminalUserId = await Get.dialog(ChangeWaiter(users!));
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.changeWaiter(
          checkId, terminalUserId, authStore.user!.branchId!);
      EasyLoading.dismiss();
      await getCheckDetails();
    }
  }

  Future printCheck() async {
    bool print = true;
    if (checkDetail.value!.spendingLimit != null &&
        checkDetail.value!.payments!.checkAmount! <
            checkDetail.value!.spendingLimit!) {
      print = await openYesNoDialog(
          "Hesap harcama limitine ulaşmamıştır. Yine de yazdırmak istiyor musunuz?");
    }

    if (print) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<PrinterOutput>? printers =
          await printerService.getPrinters(authStore.user!.branchId);
      EasyLoading.dismiss();
      printers = printers!.where((element) => element.isCashPrinter!).toList();
      var printerName =
          localeManager.getStringValue(PreferencesKeys.CASH_PRINTER_NAME);

      if (printerName.isNotEmpty) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await printerService.printCheck(checkId, authStore.user!.terminalUserId,
            printerName, authStore.user!.branchId!);
        EasyLoading.dismiss();
        closePage(checkId);
      } else if (printers.length > 1) {
        var printer = await Get.dialog(SelectPrinter(printers));
        if (printer != null) {
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await printerService.printCheck(
              checkId,
              authStore.user!.terminalUserId,
              printer.printerName!,
              authStore.user!.branchId!);
          EasyLoading.dismiss();
          await getCheckDetails();
        }
      } else {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await printerService.printCheck(
            checkId,
            authStore.user!.terminalUserId,
            printers
                .where((element) => element.isCashPrinter!)
                .first
                .printerName!,
            authStore.user!.branchId!);
        EasyLoading.dismiss();
        closePage(checkId);
      }
    }
  }

  Future printSlip() async {
    bool print = true;
    if (checkDetail.value!.spendingLimit != null &&
        checkDetail.value!.payments!.checkAmount! <
            checkDetail.value!.spendingLimit!) {
      print = await openYesNoDialog(
          "Hesap harcama limitine ulaşmamıştır. Yine de yazdırmak istiyor musunuz?");
    }

    if (print) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      List<PrinterOutput>? printers =
          await printerService.getPrinters(authStore.user!.branchId);
      EasyLoading.dismiss();
      printers = printers!.where((element) => element.isSlipPrinter!).toList();
      if (printers.length > 1) {
        PrinterOutput? printer = await Get.dialog(SelectPrinter(printers));
        if (printer != null) {
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await printerService.printSlipCheck(
            checkId,
            authStore.user!.terminalUserId,
            printer.printerName!,
            authStore.user!.branchId!,
            printer.isGeneric!,
          );
          EasyLoading.dismiss();
          await getCheckDetails();
        }
      } else if (printers.length == 1) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await printerService.printSlipCheck(
          checkId,
          authStore.user!.terminalUserId,
          printers
              .where((element) => element.isSlipPrinter!)
              .first
              .printerName!,
          authStore.user!.branchId!,
          printers.where((element) => element.isSlipPrinter!).first.isGeneric!,
        );
        EasyLoading.dismiss();
        closePage(checkId);
      } else {
        showSnackbarError('Yazıcı bulunamadı!');
      }
    }
  }

  Future cancelBillSent() async {
    bool confirm = await openYesNoDialog(
        'Yazdırma işlemini geri almak ve adisyonu tekrardan aktif hale almak istediğnizden emin misiniz?');

    if (confirm) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.cancelBillSent(
          checkId, authStore.user!.terminalUserId, authStore.user!.branchId!);
      EasyLoading.dismiss();
      await getCheckDetails();
    }
  }

  Future openCustomerCountDialog(bool canClose) async {
    var customerCount = await Get.dialog(
        barrierDismissible: canClose, CustomerCountDialog(canClose: canClose));
    if (customerCount != null) {
      if (customerCount == false) {
        Get.back();
        return;
      }
      basket.update((val) {
        val!.personCount = int.parse(customerCount);
      });
    }
  }

  void clearAddition() {
    addition([]);
  }

  Future openQuantityDialog() async {
    var res = await Get.dialog(const PortionQuantityDialog());
    if (res != null) {
      quantity(res.toString().getDouble!);
    }
  }

  void changeShowSearch() {
    hideSearch(!hideSearch.value);
    if (!hideSearch.value) {
      myFocusNode.requestFocus();
    }
    searchCtrl.text = '';
  }

  void seeLogs() {
    if (checkId != null) {
      Get.dialog(CheckDetailPage(), arguments: [checkId, null]);
    } else {
      showSnackbarError('Adisyon bulunamadı!');
    }
  }

  Future cancelCheck() async {
    bool confirm = await openYesNoDialog(
        'Adisyonu komple iptal etmek istediğinizden emin misiniz?');

    if (confirm) {
      EasyLoading.show(
        status: 'Lütfen Bekleyiniz...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await checkService.cancelCheck(
          checkId, basket.value.terminalUserId, authStore.user!.branchId!);
      EasyLoading.dismiss();
      closePage(checkId);
    }
  }

  void filterMenuItems() {
    menuItemCategories.refresh();
  }

  Future giveNameToTable() async {
    await Get.dialog(SimpleDialog(
      title: const Text("Masaya İsim Ver"),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      children: [
        TextField(
          focusNode: tableNameFocus,
          autofocus: true,
          controller: tableNameCtrl,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: "Masa İsmi"),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    if (checkId != null && checkId! > 0) {
                      EasyLoading.show(
                        status: 'Lütfen Bekleyiniz...',
                        dismissOnTap: false,
                        maskType: EasyLoadingMaskType.black,
                      );
                      var giveTableRes = await checkService.giveTableToName(
                          authStore.user!.branchId!,
                          checkId!,
                          tableNameCtrl.text);
                      EasyLoading.dismiss();
                      // getCheckDetails();
                      if (giveTableRes != null) {
                        Get.back();
                      }
                    } else {
                      if (tableNameCtrl.text.trim().isNotEmpty) {
                        checkDetail.value!.table!.name = tableNameCtrl.text;
                        basket.value.alias = tableNameCtrl.text;
                        basket.refresh();
                        checkDetail.refresh();
                        Get.back();
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xff253139),
                    child: const Center(
                      child: Text(
                        "KAYDET",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        "VAZGEÇ",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
