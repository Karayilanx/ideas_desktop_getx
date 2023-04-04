import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/extension/string_extension.dart';

import '../../../../locale_keys_enum.dart';
import '../../../../model/check_account_model.dart';
import '../../../../theme/theme.dart';
import '../../../_utility/keyboard/button_type_enum.dart';
import '../../../_utility/keyboard/keyboard_custom_button.dart';
import '../../../_utility/keyboard/numeric_keyboard.dart';
import '../../../_utility/loading/loading_screen.dart';
import '../../../_utility/screen_keyboard/screen_keyboard_view.dart';
import '../component/check_account_list_tile.dart';
import '../navigation/check_accounts_navigation_args.dart';
import '../viewmodel/check_accounts_view_model.dart';

class CheckAccountsPage extends StatelessWidget {
  const CheckAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CheckAccountsController controller = Get.find();
    return Scaffold(
      body: SafeArea(
        child: controller.checkId != null ||
                controller.type == CheckAccountsPageType.CheckAccount
            ? buildBody(controller)
            : const LoadingPage(),
      ),
    );
  }

  Widget buildBody(CheckAccountsController controller) {
    return Row(
      children: [
        Expanded(
          flex: 75,
          child: buildLeftSideColumn(controller),
        ),
        controller.type == CheckAccountsPageType.CheckAccount
            ? Expanded(
                flex: 25,
                child: buildRightSideColumn(controller),
              )
            : Container()
      ],
    );
  }

  Column buildLeftSideColumn(CheckAccountsController controller) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: buildTopRow(controller),
        ),
        Expanded(
          child: buildCheckAccountsGrid(controller),
        ),
      ],
    );
  }

  Row buildTopRow(CheckAccountsController controller) {
    if (controller.type == CheckAccountsPageType.CheckAccount) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSearchInput(controller),
          const SizedBox(width: 10),
          buildTypeDropdown(controller),
          const SizedBox(width: 10),
          buildNewCheckAccountButton(controller),
          const SizedBox(width: 10),
          buildCloseButton(controller),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSearchInput(controller),
          buildSaveButton(controller),
          TopRowButton(
            callback: () => controller.showCheckAccountDetailsDialog(-1),
            text: 'Yeni Hesap',
          ),
          TopRowButton(
            callback: () => controller.closePage(),
            text: 'Kapat',
          ),
          const SizedBox(width: 10),
        ],
      );
    }
  }

  Widget buildSaveButton(CheckAccountsController controller) {
    switch (controller.type) {
      case CheckAccountsPageType.Check:
        return TopRowButton(
          callback: () => controller.transferCheckToCheckAccount(),
          text: 'Kaydet',
        );
      case CheckAccountsPageType.CheckCustomer:
        return TopRowButton(
          callback: () => controller.changeCheckCustomer(),
          text: 'Müşteri Seç',
        );
      case CheckAccountsPageType.Unpayable:
        return TopRowButton(
          callback: () => controller.closeUnpayableCheck(),
          text: 'Ödenmeze At',
        );
      default:
        return Container();
    }
  }

  Expanded buildSearchInput(CheckAccountsController controller) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: controller.searchCtrl,
          onTap: () async {
            if (controller.localeManager
                .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
              var res = await Get.dialog(
                const ScreenKeyboard(),
              );
              if (res != null) {
                controller.searchCtrl.text = res;
                controller.filterCheckAccounts(controller.searchCtrl.text);
              }
            }
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.black),
            ),
            filled: true,
            hintText: 'Aradığınız hesap adını buraya girebilirsiniz',
            suffixIcon: Icon(
              Icons.search,
              size: 40,
              color: ideasTheme.scaffoldBackgroundColor,
            ),
          ),
          onChanged: (val) => controller.filterCheckAccounts(val),
        ),
      ),
    );
  }

  Container buildTypeDropdown(CheckAccountsController controller) {
    return Container(
      width: 150,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: DropdownSearch<CheckAccountType>(
          mode: Mode.MENU,
          items: controller.types,
          showSearchBox: false,
          itemAsString: (item) => item!.name,
          maxHeight: 200,
          onChanged: (val) {
            controller.changeSelectedType(val!.value);
          },
          selectedItem: controller.types[1]),
    );
  }

  Widget buildNewCheckAccountButton(CheckAccountsController controller) {
    return GestureDetector(
      onTap: () => controller.showCheckAccountDetailsDialog(-1),
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'Yeni Hesap',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget buildCloseButton(CheckAccountsController controller) {
    return GestureDetector(
      onTap: () => controller.closePage(),
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'Kapat',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Container buildCheckAccountsGrid(CheckAccountsController controller) {
    return Container(
      color: const Color(0xFFEEEAE7),
      child: Obx(() => GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            crossAxisCount: 4,
            childAspectRatio: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: createTables(controller),
          )),
    );
  }

  Widget buildRightSideColumn(CheckAccountsController controller) {
    return Obx(
      () {
        return controller.checkAccountSummary.value != null &&
                controller.selectedCheckAccount.value != null
            ? Column(
                children: [
                  Container(
                    height: 70,
                  ),
                  buildActionsRow(controller),
                  buildActionsRow2(controller),
                  buildInformationWidget(controller),
                  const SizedBox(height: 4),
                  buildPaymentButtonRow(controller),
                  buildOtherActionsRow(controller),
                  buildPriceInput(controller),
                  buildKeyboard(controller)
                ],
              )
            : const Text(
                'Detay görmek için cari hesap seçiniz.',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              );
      },
    );
  }

  Row buildActionsRow(CheckAccountsController controller) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => controller.removeCheckAccount(),
          text: 'Hesabı Kaldır',
        ),
        CheckAccountActionWidget(
          callback: () => controller.transferCheckAccountToCheckAccount(),
          text: 'Hesabı Aktar',
        ),
      ],
    );
  }

  Row buildActionsRow2(CheckAccountsController controller) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => controller.navigateToCheckAccountTransactions(
              controller.selectedCheckAccount.value!.checkAccountId),
          text: 'Hesap Ekstre',
        ),
        CheckAccountActionWidget(
          callback: () => controller.markCheckAccountUnpayable(),
          text: 'Ödenmeze At',
        ),
      ],
    );
  }

  Container buildInformationWidget(CheckAccountsController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEAE7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          PaymentTextRow(
            text1: 'Borçlar',
            text2: controller
                .checkAccountSummary.value!.totalDebtAmount!.getPriceString,
          ),
          PaymentTextRow(
            text1: 'Ödemeler',
            text2: controller
                .checkAccountSummary.value!.totalPaymentAmount!.getPriceString,
          ),
          PaymentTextRow(
            text1: 'İskontolar',
            text2: controller
                .checkAccountSummary.value!.discountAmount!.getPriceString,
          ),
          PaymentTextRow(
            text1: 'Bakiye',
            text2:
                controller.checkAccountSummary.value!.balance!.getPriceString,
          )
        ],
      ),
    );
  }

  Row buildPaymentButtonRow(CheckAccountsController controller) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => controller.insertCheckAccountTransaction(2),
          text: 'Nakit',
          height: 70,
        ),
        CheckAccountActionWidget(
          callback: () => controller.insertCheckAccountTransaction(3),
          text: 'Kredi',
          height: 70,
        ),
      ],
    );
  }

  Row buildOtherActionsRow(CheckAccountsController controller) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => controller.showCheckAccountDetailsDialog(
              controller.selectedCheckAccount.value!.checkAccountId!),
          text: 'Diğer Seçenekler',
          height: 50,
        ),
      ],
    );
  }

  Container buildPriceInput(CheckAccountsController controller) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: controller.priceCtrl,
        style: const TextStyle(fontSize: 18),
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Expanded buildKeyboard(CheckAccountsController controller) {
    return Expanded(
      child: NumericKeyboard(
        buttonColor: Colors.white,
        pinFieldController: controller.priceCtrl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        type: KeyboardType.DOUBLE,
        actionColumn: buildActionColumn(controller),
      ),
    );
  }

  Widget buildActionColumn(CheckAccountsController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 75,
          child: KeyboardCustomButton(
            buttonColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const AutoSizeText(
              'İSKONTO',
              style: TextStyle(color: Colors.black, fontSize: 26),
              maxLines: 1,
              minFontSize: 0,
            ),
            onPressed: () => controller.insertCheckAccountTransaction(0),
          ),
        ),
        Expanded(
          flex: 25,
          child: KeyboardCustomButton(
            buttonColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              '%',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            onPressed: () => controller.getPercentage(),
          ),
        )
      ],
    );
  }

  List<Widget> createTables(CheckAccountsController controller) {
    if (controller.filteredCheckAccounts.isNotEmpty) {
      return List.generate(controller.filteredCheckAccounts.length, (index) {
        CheckAccountListItem checkAcc = controller.filteredCheckAccounts[index];
        return CheckAccountListTile(
          checkAcc: checkAcc,
          isSelected: controller.isAccountSelected(checkAcc),
          callback: () => controller.selectCheckAccount(checkAcc),
        );
      });
    } else {
      return [];
    }
  }
}

class TopRowButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const TopRowButton({super.key, required this.callback, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 50,
        width: 180,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FDFE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class PaymentTextRow extends StatelessWidget {
  final String text1;
  final String text2;
  final TextStyle style =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  const PaymentTextRow({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: style,
          ),
          Text(
            text2,
            style: style,
          ),
        ],
      ),
    );
  }
}

class CheckAccountActionWidget extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final double height;
  const CheckAccountActionWidget(
      {super.key,
      required this.callback,
      required this.text,
      this.height = 50});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => callback(),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEAE7),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.fromLTRB(4, 0, 4, 4),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
