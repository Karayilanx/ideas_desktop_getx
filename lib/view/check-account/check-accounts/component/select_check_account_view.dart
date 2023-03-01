import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/check-account/check-accounts/component/select_check_account_view_model.dart';
import '../../../../locale_keys_enum.dart';
import '../../../../model/check_account_model.dart';
import '../../../../theme/theme.dart';
import '../../../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'check_account_list_tile.dart';
import '../viewmodel/check_accounts_view_model.dart';

class SelectCheckAccountPage extends StatelessWidget {
  const SelectCheckAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    SelectCheckAccountController controller =
        Get.put(SelectCheckAccountController());
    return SimpleDialog(
      title: const Text('Aktarılacak hesap seçimi'),
      children: [
        SizedBox(
          height: context.height,
          width: context.width,
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: buildTopRow(controller),
              ),
              Expanded(
                child: buildCheckAccountsGrid(controller),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container buildCheckAccountsGrid(SelectCheckAccountController controller) {
    return Container(
      color: const Color(0xFFEEEAE7),
      child: Obx(() {
        return GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          crossAxisCount: 4,
          childAspectRatio: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: createTables(controller),
        );
      }),
    );
  }

  List<Widget> createTables(SelectCheckAccountController controller) {
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

Row buildTopRow(SelectCheckAccountController controller) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      buildSearchInput(controller),
      const SizedBox(width: 10),
      buildTypeDropdown(controller),
      const SizedBox(width: 10),
      buildSaveButton(controller),
      const SizedBox(width: 10),
      buildCloseButton(controller),
      const SizedBox(width: 10),
    ],
  );
}

Widget buildCloseButton(SelectCheckAccountController controller) {
  return GestureDetector(
    onTap: () => controller.closePage(),
    child: Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.red[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          'Kapat',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget buildSaveButton(SelectCheckAccountController controller) {
  return GestureDetector(
    onTap: () {
      controller.save();
    },
    child: Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        color: ideasTheme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          'Hesabı Aktar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    ),
  );
}

Expanded buildSearchInput(SelectCheckAccountController controller) {
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

Container buildTypeDropdown(SelectCheckAccountController value) {
  return Container(
    width: 150,
    height: 50,
    decoration: const BoxDecoration(
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
