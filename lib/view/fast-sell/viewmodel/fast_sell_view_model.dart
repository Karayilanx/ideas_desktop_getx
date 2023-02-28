import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/base_controller.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import 'package:ideas_desktop_getx/view/notes/notes_page.dart';
import 'package:ideas_desktop_getx/view/order-detail/component/select_cashier_bank.dart';
import '../../../locale_keys_enum.dart';
import '../../../model/check_account_model.dart';
import '../../../model/check_model.dart';
import '../../../model/menu_model.dart';
import '../../../model/printer_model.dart';
import '../../../service/check/check_service.dart';
import '../../../service/check_account/check_account_service.dart';
import '../../../service/menu/menu_service.dart';
import '../../../service/printer/printer_service.dart';
import '../../_utility/service_helper.dart';
import '../../authentication/auth_store.dart';
import '../../cancel-check-item/cancel_check_item_view.dart';
import '../../check-account/check-accounts/navigation/check_accounts_navigation_args.dart';
import '../../order-detail/component/customer_count_dialog.dart';
import '../../order-detail/component/edit_item_actions_dialog.dart';
import '../../order-detail/component/portion_quantity_dialog.dart';
import '../../order-detail/component/select_printer.dart';
import '../../select-condiment/view/select_condiment_view.dart';

enum InputFocusTypeEnum { Barcode, Price, Quantity }

class FastSellController extends BaseController {
  MenuService menuService = Get.find();
  CheckService checkService = Get.find();
  PrinterService printerService = Get.find();
  CheckAccountService checkAccountService = Get.find();

  FocusNode myFocusNode = FocusNode();
  final ScrollController controller = ScrollController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController searchCtrl = TextEditingController();

  RxBool hideSearch = RxBool(true);
  RxDouble quantity = RxDouble(1);
  RxList<MenuItemCategory> menuItemCategories = RxList([]);
  Rx<MenuItemCategory?> selectedCategory = Rx<MenuItemCategory?>(null);
  Rx<MenuItemSubCategory?> selectedSubCategory = Rx<MenuItemSubCategory?>(null);
  RxBool showMenu = RxBool(true);
  RxList<GroupedCheckItem> groupedCheckItems = RxList([]);
  Rx<CheckDetailsModel> checkDetail = Rx<CheckDetailsModel>(CheckDetailsModel(
    checkId: -1,
    branchId: 1,
    basketItems: [],
    payments: CheckPaymentsModel(
        checkAmount: 0,
        discountAmount: 0,
        cashAmount: 0,
        creditCardAmount: 0,
        serviceChargeAmount: 0,
        paymentsWithoutDiscountsAmount: 0,
        remainingAmount: 0,
        totalPaymentAmount: 0,
        unpayableAmount: 0),
  ));

  @override
  void onInit() {
    super.onInit();
    checkDetail.value.terminalUserId = authStore.user!.terminalUserId;
    checkDetail.value.branchId = authStore.user!.branchId!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showMenu(true);
      getCategories();
      getFastSellCheck();
    });
  }

  Future getFastSellCheck() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkDetail(await checkService.getFastSellCheck(authStore.user!.branchId!));

    if (checkDetail.value == null) {
      // navigation.navigateToPageClear(path: NavigationConstants.ERROR_VIEW);
    }
    checkDetail.update((val) {
      val!.terminalUserId = authStore.user!.terminalUserId;
    });
    groupedCheckItems(getGroupedMenuItems(checkDetail.value.basketItems!));
    EasyLoading.dismiss();
    if (checkDetail.value.checkId! > 0) {
      showMenu(false);
    } else {
      showMenu(true);
    }
  }

  Future getCategories() async {
    menuItemCategories(
        await menuService.getCategories(authStore.user!.branchId));
    if (selectedCategory.value == null && menuItemCategories.isNotEmpty) {
      changeCategory(menuItemCategories[0]);
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

  double getCheckTotalPrice() {
    double totalPrice = 0;
    for (var item in groupedCheckItems) {
      totalPrice += item.totalPrice;
    }

    return totalPrice;
  }

  Future getCheckDetails() async {
    EasyLoading.show(
      status: 'Lütfen Bekleyiniz...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    checkDetail(await checkService.getCheckDetails(
        checkDetail.value.checkId, authStore.user!.branchId!));

    groupedCheckItems(getGroupedMenuItems(checkDetail.value.basketItems!));
    EasyLoading.dismiss();

    if (checkDetail.value.checkId! > 0) {
      showMenu(false);
    } else {
      showMenu(true);
    }
  }

  Future sendOrder(CheckPaymentTypeEnum type, bool makePayment) async {
    if (checkDetail.value.basketItems!.isNotEmpty) {
      if (checkDetail.value.checkId != null && checkDetail.value.checkId! < 0) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        var checkId = await checkService.sendOrder(checkDetail.value);
        EasyLoading.dismiss();
        if (checkId != null) {
          checkDetail.value.checkId = checkId.value;
        } else {
          makePayment = false;
        }
      }

      if (makePayment) {
        await getCheckDetails();
        await makeCheckPayment(type);
      }
    }
  }

  void closePage() {
    Get.back();
  }

  Future makeCheckPayment(CheckPaymentTypeEnum type) async {
    bool makePayment = true;
    CheckPaymentModel input = CheckPaymentModel(
      checkId: checkDetail.value.checkId,
      isMenuItemBased: false,
      paymentTypeId: type.index,
      terminalUserId: authStore.user!.terminalUserId,
      branchId: authStore.user!.branchId!,
    );
    double? inputPrice = priceCtrl.text.getDouble;
    inputPrice ??= checkDetail.value.payments!.remainingAmount;
    input.amount = inputPrice;

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
        }
      } else if (cashiers.length == 1) {
        input.checkAccountId = cashiers.first.checkAccountId;
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
      if (res != null) {
        if (res.checkStatusTypeId == CheckStatusTypeEnum.Closed.index) {
          EasyLoading.dismiss();
          Get.back(closeOverlays: true);
        } else {
          priceCtrl.text = '';
          await getCheckDetails();
        }
      } else {
        EasyLoading.dismiss();
      }
    }
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
          SelectCondimentPage());

      if (list != null && list.isNotEmpty) {
        for (var listItem in list) {
          listItem.sellUnit = item.sellUnit;
          listItem.sellUnitQuantity = sellUnitQnt;
          if (item.isCategoryStoppedDefault!) listItem.isStopped = true;
          checkDetail.update((val) {
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
          });
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
          checkDetail.update((val) {
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
          checkDetail.update((val) {
            val!.basketItems!.add(checkItem);
          });
        }
      }
    }
    quantity(1);
    groupedCheckItems(getGroupedMenuItems(checkDetail.value.basketItems!));
  }

  Future checkItemClick(GroupedCheckItem item) async {
    var res = await Get.dialog(
      EditItemActionsDialog(
        item: item,
        isCheckItem: true,
        deleteAction: () async {
          var res = await checkMenuItemCancelDialog(
            item,
          );
          if (res == 0) {
            showSnackbarError(
                'İptal edebilmek için ödemeleri sıfırlamanız gerekmektedir');
          }
          await getCheckDetails();
          if (checkDetail.value.payments!.remainingAmount! == 0) {
            Get.back();
          }
        },
        noteAction: null,
      ),
    );
    if (res != null) {
      checkDetail.refresh();
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
      updateQuantityAction: () async {
        var res = await showUpdateQuantityDialog(
            item,
            (itemCount) =>
                updateBasketItemQuantity(item, itemCount.getDouble!.getInt));
        if (res != null) Get.back(result: res);
      },
    ));
    if (res != null) {
      checkDetail.refresh();
    }
  }

  void removeCheckItem(GroupedCheckItem item) {
    for (var i = 0; i < checkDetail.value.basketItems!.length; i++) {
      var basketItem = checkDetail.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        checkDetail.value.basketItems!.removeAt(i);
        i--;
      }
    }

    checkDetail.refresh();
    groupedCheckItems(getGroupedMenuItems(checkDetail.value.basketItems!));
    Get.back(result: checkDetail.value.basketItems);
  }

  dynamic showNoteDialog(GroupedCheckItem item) async {
    TextEditingController noteController =
        TextEditingController(text: item.originalItem!.note ?? '');
    var result = await Get.dialog(
      NotesPages(),
      arguments: [
        item,
        noteController,
        (note) {
          updateNote(item, note);
        },
      ],
    );

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
              var closePage = await Get.dialog(
                CancelCheckItemPage(),
                arguments: [
                  int.parse(quantity),
                  item,
                  checkDetail.value.checkId!,
                ],
              );
              if (closePage) Get.back();
            }
          },
        ),
      );

      return result;
    } else {
      var closePage = await Get.dialog(
        CancelCheckItemPage(),
        arguments: [
          1,
          item,
          checkDetail.value.checkId!,
        ],
      );
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
    for (var i = 0; i < checkDetail.value.basketItems!.length; i++) {
      var basketItem = checkDetail.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        checkDetail.value.basketItems!.removeAt(i);
        i--;
      }
    }

    for (var i = 0; i < itemCount; i++) {
      checkDetail.update((val) {
        val!.basketItems!.add(CheckMenuItemModel(
          totalPrice: item.originalItem!.totalPrice,
          actionType: item.originalItem!.actionType,
          condiments: item.originalItem!.condiments,
          isStopped: item.originalItem!.isStopped,
          menuItemId: item.originalItem!.menuItemId,
          name: item.originalItem!.name,
          note: item.originalItem!.note,
          sellUnit: item.originalItem!.sellUnit,
          sellUnitQuantity: item.originalItem!.sellUnitQuantity,
        ));
      });
    }

    checkDetail.refresh();
    groupedCheckItems(getGroupedMenuItems(checkDetail.value.basketItems!));
    Get.back(result: checkDetail.value.basketItems);
  }

  void updateNote(GroupedCheckItem item, String note) {
    for (var i = 0; i < checkDetail.value.basketItems!.length; i++) {
      var basketItem = checkDetail.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        basketItem.note = note;
      }
    }

    checkDetail.refresh();
    groupedCheckItems(getGroupedMenuItems(checkDetail.value.basketItems!));
    Get.back(result: checkDetail.value.basketItems);
  }

  Future openQuantityDialog() async {
    var res = await Get.dialog(PortionQuantityDialog());
    if (res != null) {
      quantity(res.toString().getDouble!);
    }
  }

  void removeBasketItem(GroupedCheckItem item) {
    for (var i = 0; i < checkDetail.value.basketItems!.length; i++) {
      var basketItem = checkDetail.value.basketItems![i]!;
      if (basketItem.isSame(item.originalItem!)) {
        checkDetail.value.basketItems!.removeAt(i);
        i--;
      }
    }

    checkDetail.refresh();
    groupedCheckItems(getGroupedMenuItems(checkDetail.value.basketItems!));
    Get.back(result: checkDetail.value.basketItems);
  }

  Future openCustomerCountDialog(bool dismissable) async {
    var customerCount = await Get.dialog(
        barrierDismissible: dismissable,
        CustomerCountDialog(canClose: dismissable));
    if (customerCount != null) {
      if (customerCount == false) {
        Get.back();
        return;
      }
      checkDetail.update((val) {
        val!.personCount = int.parse(customerCount);
      });
    }
  }

  Future printCheck() async {
    if (checkDetail.value.basketItems!.isNotEmpty) {
      if (checkDetail.value.checkId == null || checkDetail.value.checkId! < 0) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await sendOrder(CheckPaymentTypeEnum.Other, false);
        EasyLoading.dismiss();
      }
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
        await printerService.printCheck(
            checkDetail.value.checkId,
            authStore.user!.terminalUserId,
            printerName,
            authStore.user!.branchId!);
        EasyLoading.dismiss();
      }
      if (printers.length > 1) {
        var printer = await Get.dialog(SelectPrinter(printers));
        if (printer != null) {
          EasyLoading.show(
            status: 'Lütfen Bekleyiniz...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.black,
          );
          await printerService.printCheck(
              checkDetail.value.checkId,
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
            checkDetail.value.checkId,
            authStore.user!.terminalUserId,
            printers
                .where((element) => element.isCashPrinter!)
                .first
                .printerName!,
            authStore.user!.branchId!);
        EasyLoading.dismiss();
      }
    }
  }

  Future cancelBillSent() async {
    bool confirm = await openYesNoDialog(
        'Yazdırma işlemini geri almak ve adisyonu tekrardan aktif hale almak istediğnizden emin misiniz?');

    if ((checkDetail.value.checkId != null && checkDetail.value.checkId! > 0)) {
      if (confirm) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await checkService.cancelBillSent(checkDetail.value.checkId!,
            authStore.user!.terminalUserId, authStore.user!.branchId!);
        EasyLoading.dismiss();
        await getCheckDetails();
      }
    } else {
      showSnackbarError(
          'Şu anda hesap gönderilmemiş ve yazdırılmamış durumda!');
    }
  }

  Future cancelPrintCheck() async {}

  Future navigateToCheckAccounts() async {
    if (checkDetail.value.basketItems!.isNotEmpty) {
      if (checkDetail.value.checkId == null || checkDetail.value.checkId! < 0) {
        EasyLoading.show(
          status: 'Lütfen Bekleyiniz...',
          dismissOnTap: false,
          maskType: EasyLoadingMaskType.black,
        );
        await sendOrder(CheckPaymentTypeEnum.Other, false);
        EasyLoading.dismiss();
        await getCheckDetails();
      }
      if (checkDetail.value.checkAccountId == null) {
        Get.toNamed('check-accounts',
            arguments: CheckAccountsArguments(
                checkId: checkDetail.value.checkId,
                type: CheckAccountsPageType.Check,
                transferAll: true,
                menuItems: null));
      } else {
        bool confirm = await openYesNoDialog('Adisyonu ' +
            checkDetail.value.checkAccountName! +
            ' adlı cari hesaba aktarmak istediğinizden emin misiniz?');

        if (confirm) {
          TransferCheckToCheckAccountInput inp =
              TransferCheckToCheckAccountInput(
            checkAccountId: checkDetail.value.checkAccountId,
            checkId: checkDetail.value.checkId,
            menuItems: checkDetail.value.basketItems,
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
            Get.offAllNamed('/home');
          }
        }
      }
    }
  }

  void changeShowSearch() {
    hideSearch(!hideSearch.value);
    if (!hideSearch.value) {
      myFocusNode.requestFocus();
    }
    searchCtrl.text = '';
  }

  void filterMenuItems() {
    menuItemCategories.refresh();
  }

  void changeShowMenu() {
    if (!(checkDetail.value.checkId! > 0)) {
      showMenu(!showMenu.value);
      priceCtrl.text = '';
    }
  }

  double getBasketTotalPrice() {
    double totalPrice = 0;
    for (var item in groupedCheckItems) {
      totalPrice += item.totalPrice;
    }
    return totalPrice;
  }
}
