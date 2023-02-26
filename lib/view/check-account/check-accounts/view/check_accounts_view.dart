import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/base/view/base_widget.dart';
import '../../../../core/constants/enums/locale_keys_enum.dart';
import '../../../../core/theme/theme.dart';
import '../../../../model/check_account_model.dart';
import '../../../../model/check_model.dart';
import '../../../_utility/keyboard/button_type_enum.dart';
import '../../../_utility/keyboard/keyboard_custom_button.dart';
import '../../../_utility/keyboard/numeric_keyboard.dart';
import '../../../_utility/loading/loading_screen.dart';
import '../../../_utility/screen_keyboard/screen_keyboard_view.dart';
import '../component/check_account_list_tile.dart';
import '../navigation/check_accounts_navigation_args.dart';
import '../viewmodel/check_accounts_view_model.dart';
import '../../../../core/extension/string_extension.dart';

class CheckAccountsPage extends StatelessWidget {
  final int? checkId;
  final CheckAccountsPageType type;
  final List<CheckMenuItemModel?>? menuItems;
  final bool? transferAll;
  const CheckAccountsPage({
    required this.checkId,
    required this.type,
    required this.transferAll,
    this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<CheckAccountsViewModel>(
      viewModel: CheckAccountsViewModel(checkId, transferAll, menuItems, type),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, value) => Scaffold(
        // resizeToAvoidBottomPadding: false,
        body: Observer(builder: (_) {
          return SafeArea(
            child: value.checkId != null ||
                    value.type == CheckAccountsPageType.CheckAccount
                ? buildBody(value)
                : LoadingPage(),
          );
        }),
      ),
    );
  }

  Widget buildBody(CheckAccountsViewModel value) {
    return Row(
      children: [
        Expanded(
          flex: 75,
          child: buildLeftSideColumn(value),
        ),
        type == CheckAccountsPageType.CheckAccount
            ? Expanded(
                flex: 25,
                child: buildRightSideColumn(value),
              )
            : Container()
      ],
    );
  }

  Column buildLeftSideColumn(CheckAccountsViewModel value) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: buildTopRow(value),
        ),
        Expanded(
          child: buildCheckAccountsGrid(value),
        ),
      ],
    );
  }

  Row buildTopRow(CheckAccountsViewModel value) {
    if (type == CheckAccountsPageType.CheckAccount) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSearchInput(value),
          SizedBox(width: 10),
          buildTypeDropdown(value),
          SizedBox(width: 10),
          buildNewCheckAccountButton(value),
          SizedBox(width: 10),
          buildCloseButton(value),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSearchInput(value),
          buildSaveButton(value),
          TopRowButton(
            callback: () => value.showCheckAccountDetailsDialog(-1),
            text: 'Yeni Hesap',
          ),
          TopRowButton(
            callback: () => value.closePage(),
            text: 'Kapat',
          ),
          SizedBox(width: 10),
        ],
      );
    }
  }

  Widget buildSaveButton(CheckAccountsViewModel value) {
    switch (type) {
      case CheckAccountsPageType.Check:
        return TopRowButton(
          callback: () => value.transferCheckToCheckAccount(),
          text: 'Kaydet',
        );
      case CheckAccountsPageType.CheckCustomer:
        return TopRowButton(
          callback: () => value.changeCheckCustomer(),
          text: 'Müşteri Seç',
        );
      case CheckAccountsPageType.Unpayable:
        return TopRowButton(
          callback: () => value.closeUnpayableCheck(),
          text: 'Ödenmeze At',
        );
      default:
        return Container();
    }
  }

  Expanded buildSearchInput(CheckAccountsViewModel value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: value.searchCtrl,
          onTap: () async {
            if (value.localeManager
                .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
              var res = await showDialog(
                context: value.buildContext!,
                builder: (context) => ScreenKeyboard(),
              );
              if (res != null) {
                value.searchCtrl.text = res;
                value.filterCheckAccounts(value.searchCtrl.text);
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
          onChanged: (val) => value.filterCheckAccounts(val),
        ),
      ),
    );
  }

  Container buildTypeDropdown(CheckAccountsViewModel value) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: DropdownSearch<CheckAccountType>(
          mode: Mode.MENU,
          items: value.types,
          showSearchBox: false,
          itemAsString: (item) => item!.name,
          maxHeight: 200,
          onChanged: (val) {
            value.changeSelectedType(val!.value);
          },
          selectedItem: value.types[1]),
    );
  }

  Widget buildNewCheckAccountButton(CheckAccountsViewModel value) {
    return GestureDetector(
      onTap: () => value.showCheckAccountDetailsDialog(-1),
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Yeni Hesap',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget buildCloseButton(CheckAccountsViewModel value) {
    return GestureDetector(
      onTap: () => value.closePage(),
      child: Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Kapat',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Container buildCheckAccountsGrid(CheckAccountsViewModel value) {
    return Container(
      color: Color(0xFFEEEAE7),
      child: Observer(builder: (_) {
        return GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          crossAxisCount: 4,
          childAspectRatio: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: createTables(value),
        );
      }),
    );
  }

  Widget buildRightSideColumn(CheckAccountsViewModel value) {
    return Observer(
      builder: (_) {
        return value.checkAccountSummary != null &&
                value.selectedCheckAccount != null
            ? Column(
                children: [
                  Container(
                    height: 70,
                  ),
                  buildActionsRow(value),
                  buildActionsRow2(value),
                  buildInformationWidget(value),
                  SizedBox(height: 4),
                  buildPaymentButtonRow(value),
                  buildOtherActionsRow(value),
                  buildPriceInput(value),
                  buildKeyboard(value)
                ],
              )
            : Text(
                'Detay görmek için cari hesap seçiniz.',
                style: TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              );
      },
    );
  }

  Row buildActionsRow(CheckAccountsViewModel value) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => value.removeCheckAccount(),
          text: 'Hesabı Kaldır',
        ),
        CheckAccountActionWidget(
          callback: () => value.transferCheckAccountToCheckAccount(),
          text: 'Hesabı Aktar',
        ),
      ],
    );
  }

  Row buildActionsRow2(CheckAccountsViewModel value) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => value.navigateToCheckAccountTransactions(
              value.selectedCheckAccount!.checkAccountId),
          text: 'Hesap Ekstre',
        ),
        CheckAccountActionWidget(
          callback: () => value.markCheckAccountUnpayable(),
          text: 'Ödenmeze At',
        ),
      ],
    );
  }

  Container buildInformationWidget(CheckAccountsViewModel value) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFEEEAE7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          PaymentTextRow(
            text1: 'Borçlar',
            text2: value.checkAccountSummary!.totalDebtAmount!.getPriceString,
          ),
          PaymentTextRow(
            text1: 'Ödemeler',
            text2:
                value.checkAccountSummary!.totalPaymentAmount!.getPriceString,
          ),
          PaymentTextRow(
            text1: 'İskontolar',
            text2: value.checkAccountSummary!.discountAmount!.getPriceString,
          ),
          PaymentTextRow(
            text1: 'Bakiye',
            text2: value.checkAccountSummary!.balance!.getPriceString,
          )
        ],
      ),
    );
  }

  Row buildPaymentButtonRow(CheckAccountsViewModel value) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => value.insertCheckAccountTransaction(2),
          text: 'Nakit',
          height: 70,
        ),
        CheckAccountActionWidget(
          callback: () => value.insertCheckAccountTransaction(3),
          text: 'Kredi',
          height: 70,
        ),
      ],
    );
  }

  Row buildOtherActionsRow(CheckAccountsViewModel value) {
    return Row(
      children: [
        CheckAccountActionWidget(
          callback: () => value.showCheckAccountDetailsDialog(
              value.selectedCheckAccount!.checkAccountId!),
          text: 'Diğer Seçenekler',
          height: 50,
        ),
      ],
    );
  }

  Container buildPriceInput(CheckAccountsViewModel value) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: TextFormField(
        textAlign: TextAlign.center,
        controller: value.priceCtrl,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Expanded buildKeyboard(CheckAccountsViewModel value) {
    return Expanded(
      child: NumericKeyboard(
        buttonColor: Colors.white,
        pinFieldController: value.priceCtrl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        type: KeyboardType.DOUBLE,
        actionColumn: buildActionColumn(value),
      ),
    );
  }

  Widget buildActionColumn(CheckAccountsViewModel value) {
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
            child: AutoSizeText(
              'İSKONTO',
              style: TextStyle(color: Colors.black, fontSize: 26),
              maxLines: 1,
              minFontSize: 0,
            ),
            onPressed: () => value.insertCheckAccountTransaction(0),
          ),
        ),
        Expanded(
          flex: 25,
          child: KeyboardCustomButton(
            buttonColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              '%',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            onPressed: () => value.getPercentage(),
          ),
        )
      ],
    );
  }

// Widget buildPaymentTextColumn(CheckAccountsViewModel value) {
//   return SingleChildScrollView(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         PaymentText(
//           firstText: 'BORÇLAR',
//           fontSize: 19,
//           secondText:
//               value.checkAccountSummary!.totalDebtAmount!.toStringAsFixed(2),
//         ),
//         PaymentText(
//           firstText: 'ÖDEMELER',
//           fontSize: 19,
//           secondText:
//               value.checkAccountSummary!.totalPaymentAmount!.toStringAsFixed(2),
//         ),
//         PaymentText(
//           firstText: 'CARİ İSKONTO',
//           fontSize: 19,
//           secondText:
//               value.checkAccountSummary!.discountAmount!.toStringAsFixed(2),
//         ),
//         Divider(),
//         PaymentText(
//           firstText: 'BAKİYE',
//           fontSize: 19,
//           secondText: value.checkAccountSummary!.balance!.toStringAsFixed(2),
//         ),
//       ],
//     ),
//   );
// }

  List<Widget> createTables(CheckAccountsViewModel value) {
    if (value.filteredCheckAccounts != null) {
      if (value.filteredCheckAccounts!.isNotEmpty) {
        return List.generate(value.filteredCheckAccounts!.length, (index) {
          CheckAccountListItem checkAcc = value.filteredCheckAccounts![index];
          return CheckAccountListTile(
            checkAcc: checkAcc,
            isSelected: value.isAccountSelected(checkAcc),
            callback: () => value.selectCheckAccount(checkAcc),
          );
        });
      } else {
        return [];
      }
    }
    return [];
  }
}

class TopRowButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  const TopRowButton({required this.callback, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        margin: EdgeInsets.only(left: 10),
        height: 50,
        width: 180,
        decoration: BoxDecoration(
          color: Color(0xFFF9FDFE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class PaymentTextRow extends StatelessWidget {
  final String text1;
  final String text2;
  final TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  PaymentTextRow({required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
      {required this.callback, required this.text, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => callback(),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: Color(0xFFEEEAE7),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.fromLTRB(4, 0, 4, 4),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
