import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/base/view/base_widget.dart';
import '../../../../core/constants/enums/locale_keys_enum.dart';
import '../../../../core/theme/theme.dart';
import '../../../../model/check_account_model.dart';
import '../../../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'check_account_list_tile.dart';
import 'select_check_account_view_model.dart';
import '../viewmodel/check_accounts_view_model.dart';

class SelectCheckAccountPage extends StatelessWidget {
  final int checkAccountId;
  final int? endOfDayId;
  final bool transferAll;
  const SelectCheckAccountPage(
      {required this.checkAccountId,
      required this.transferAll,
      this.endOfDayId});

  @override
  Widget build(BuildContext context) {
    return BaseView<SelectCheckAccountViewModel>(
      viewModel: SelectCheckAccountViewModel(
          checkAccountId: checkAccountId,
          transferAll: transferAll,
          endOfDayId: endOfDayId),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (context, value) => SimpleDialog(
        title: const Text('Aktarılacak hesap seçimi'),
        children: [
          SizedBox(
            height: MediaQuery.of(value.buildContext!).size.height,
            width: MediaQuery.of(value.buildContext!).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: buildTopRow(value),
                ),
                Expanded(
                  child: buildCheckAccountsGrid(value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildCheckAccountsGrid(SelectCheckAccountViewModel value) {
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

  List<Widget> createTables(SelectCheckAccountViewModel value) {
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

Row buildTopRow(SelectCheckAccountViewModel value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      buildSearchInput(value),
      SizedBox(width: 10),
      buildTypeDropdown(value),
      SizedBox(width: 10),
      buildSaveButton(value),
      SizedBox(width: 10),
      buildCloseButton(value),
      SizedBox(width: 10),
    ],
  );
}

Widget buildCloseButton(SelectCheckAccountViewModel value) {
  return GestureDetector(
    onTap: () => value.closePage(),
    child: Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Kapat',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buildSaveButton(SelectCheckAccountViewModel value) {
  return GestureDetector(
    onTap: () {
      value.save();
    },
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: ideasTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          'Hesabı Aktar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ),
  );
}

Expanded buildSearchInput(SelectCheckAccountViewModel value) {
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

Container buildTypeDropdown(SelectCheckAccountViewModel value) {
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
        maxHeight: 300,
        onChanged: (val) {
          value.changeSelectedType(val!.value);
        },
        selectedItem: value.types[0]),
  );
}
