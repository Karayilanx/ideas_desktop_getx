import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../locale_keys_enum.dart';
import '../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'setting_controller.dart';

class SettingsPage extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());

  SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title:
          const Text('Ayarlar', style: TextStyle(fontWeight: FontWeight.bold)),
      children: [
        const Divider(),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: getTabButtons(),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(() => Column(
                children: buildBody(),
              )),
        ),
        const SizedBox(height: 10),
        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => settingsController.save(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff223540)),
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  'Vazgeç',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> buildBody() {
    if (settingsController.pageTab.value == SettingsPageTabEnum.Connection) {
      return getConnectionWidgets();
    } else if (settingsController.pageTab.value == SettingsPageTabEnum.Visual) {
      return getVisualWidgets();
    } else if (settingsController.pageTab.value ==
        SettingsPageTabEnum.Integration) {
      return getIntegrationWidgets();
    } else if (settingsController.pageTab.value == SettingsPageTabEnum.Other) {
      return getOtherWidgets();
    }

    return [];
  }

  List<Widget> getIntegrationWidgets() {
    return [
      Obx(
        () {
          return CheckboxListTile(
            value: settingsController.useYemeksepeti.value,
            onChanged: (val) => settingsController.changeYemeksepeti(val!),
            title: const Text('Yemeksepeti Entegrasyonu'),
          );
        },
      ),
      Obx(
        () {
          return CheckboxListTile(
            value: settingsController.useGetir.value,
            onChanged: (val) => settingsController.changeGetir(val!),
            title: const Text('Getir Entegrasyonu'),
          );
        },
      ),
      Obx(
        () {
          return CheckboxListTile(
            value: settingsController.useFuudy.value,
            onChanged: (val) => settingsController.changeFuudy(val!),
            title: const Text('Fuudy Entegrasyonu'),
          );
        },
      ),
    ];
  }

  List<Widget> getVisualWidgets() {
    return [
      Obx(
        () {
          return CheckboxListTile(
            value: settingsController.showScreenKeyboard.value,
            onChanged: (val) =>
                settingsController.changeshowScreenKeyboard(val!),
            title: const Text('Ekran Klavyesini Göster'),
          );
        },
      ),
      Obx(
        () {
          return CheckboxListTile(
            value: settingsController.autoSearch.value,
            onChanged: (val) => settingsController.changeSearch(val!),
            title: const Text('Arama Açık Gelsin'),
          );
        },
      ),
      Obx(
        () {
          return CheckboxListTile(
            value: settingsController.tableGroupDivider.value,
            onChanged: (val) =>
                settingsController.changeTableGroupDivider(val!),
            title: const Text('Masa Gruplarını Ayır'),
          );
        },
      ),
      Obx(
        () {
          return CheckboxListTile(
            value: settingsController.autoLock2.value,
            onChanged: (val) => settingsController.changeAutoLock2(val!),
            title: const Text('Oto Kilit(2dk)'),
          );
        },
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 17),
        child: TextField(
          decoration: const InputDecoration(hintText: 'Masa Genişliği(px)'),
          controller: settingsController.tableWidthCtrl,
          onTap: () async {
            if (settingsController.localeManager
                .getBoolValue(PreferencesKeys.TABLE_WIDTH)) {
              var res = await Get.dialog(
                const ScreenKeyboard(),
              );
              if (res != null) {
                settingsController.tableWidthCtrl.text = res;
              }
            }
          },
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 17),
        child: TextField(
          decoration: const InputDecoration(hintText: 'Ürün Genişliği(px)'),
          controller: settingsController.menuItemWidthCtrl,
          onTap: () async {
            if (settingsController.localeManager
                .getBoolValue(PreferencesKeys.MENU_ITEM_WIDTH)) {
              var res = await Get.dialog(
                const ScreenKeyboard(),
              );
              if (res != null) {
                settingsController.menuItemWidthCtrl.text = res;
              }
            }
          },
        ),
      ),
    ];
  }

  List<Widget> getConnectionWidgets() {
    return [
      TextFormField(
        decoration: const InputDecoration(hintText: 'IP Adresi'),
        controller: settingsController.ipCtrl,
        onTap: () async {
          if (settingsController.localeManager
              .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
            var res = await Get.dialog(
              const ScreenKeyboard(),
            );
            if (res != null) {
              settingsController.ipCtrl.text = res;
            }
          }
        },
      ),
      TextFormField(
        decoration: const InputDecoration(hintText: 'Server IP Adresi'),
        controller: settingsController.serverIpCtrl,
        onTap: () async {
          if (settingsController.localeManager
              .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
            var res = await Get.dialog(
              const ScreenKeyboard(),
            );
            if (res != null) {
              settingsController.serverIpCtrl.text = res;
            }
          }
        },
      ),
      TextFormField(
        decoration: const InputDecoration(hintText: 'Şube Kullanıcı Adı'),
        controller: settingsController.usernametrl,
        onTap: () async {
          if (settingsController.localeManager
              .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
            var res = await Get.dialog(
              const ScreenKeyboard(),
            );
            if (res != null) {
              settingsController.usernametrl.text = res;
            }
          }
        },
      ),
    ];
  }

  List<Widget> getOtherWidgets() {
    return [
      TextFormField(
        decoration: const InputDecoration(hintText: 'Kasa Yazıcısı Adı'),
        controller: settingsController.cashPrinterNameCtrl,
        onTap: () async {
          if (settingsController.localeManager
              .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
            var res = await Get.dialog(
              const ScreenKeyboard(),
            );
            if (res != null) {
              settingsController.ipCtrl.text = res;
            }
          }
        },
      )
    ];
  }

  List<Widget> getTabButtons() {
    return [
      const SizedBox(width: 4),
      Expanded(child: Obx(() {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    getTabButtonColor(SettingsPageTabEnum.Connection)),
            onPressed: () =>
                settingsController.changeTab(SettingsPageTabEnum.Connection),
            child: Text(
              'Bağlantı Ayarları',
              style: TextStyle(
                  color: getTabButtonTextColor(SettingsPageTabEnum.Connection)),
            ));
      })),
      const SizedBox(width: 4),
      Expanded(child: Obx(() {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: getTabButtonColor(SettingsPageTabEnum.Visual)),
            onPressed: () =>
                settingsController.changeTab(SettingsPageTabEnum.Visual),
            child: Text('Görsel Ayarlar',
                style: TextStyle(
                    color: getTabButtonTextColor(SettingsPageTabEnum.Visual))));
      })),
      const SizedBox(width: 4),
      Expanded(child: Obx(() {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor:
                    getTabButtonColor(SettingsPageTabEnum.Integration)),
            onPressed: () =>
                settingsController.changeTab(SettingsPageTabEnum.Integration),
            child: Text('Entegrasyon',
                style: TextStyle(
                    color: getTabButtonTextColor(
                        SettingsPageTabEnum.Integration))));
      })),
      const SizedBox(width: 4),
      Expanded(child: Obx(() {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: getTabButtonColor(SettingsPageTabEnum.Other)),
            onPressed: () =>
                settingsController.changeTab(SettingsPageTabEnum.Other),
            child: Text('Diğer Ayarlar',
                style: TextStyle(
                    color: getTabButtonTextColor(
                        SettingsPageTabEnum.Integration))));
      })),
      const SizedBox(width: 4),
    ];
  }

  Color getTabButtonColor(SettingsPageTabEnum type) {
    if (type == settingsController.pageTab.value) {
      return const Color(0xff223540);
    } else {
      return Colors.grey;
    }
  }

  Color getTabButtonTextColor(SettingsPageTabEnum type) {
    if (type == settingsController.pageTab.value) {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }
}
