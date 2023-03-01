import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/home/viewmodel/home_view_model.dart';
import '../../../image/image_constatns.dart';
import '../../../locale_keys_enum.dart';
import '../../../model/home_model.dart';
import '../../../model/table_model.dart';
import '../../../theme/theme.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';
import '../component/table_widgets.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF0F0F0),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 65,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: ideasTheme.scaffoldBackgroundColor,
                  ),
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [Image.asset(ImageConstants.instance.ideaslogo)],
                  )),
            ),
            ExpansionTile(
              title: const Text(
                'Sabit Tanımlar',
                style: TextStyle(fontSize: 16),
              ),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: const Text(
                    'Menü İşlemleri',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    homeController.navigateToMenuPage();
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: const Text(
                    'Fiyat Değişikliği',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    homeController.navigateToPriceChangePage();
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: const Text(
                    'Kullanıcı İşlemleri',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    homeController.navigateToTerminalUsersPage();
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: const Text(
                    'Ekseçim Grupları',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    homeController.navigateToCondimentGroupsPage();
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: const Text(
                    'Ekseçimler',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    homeController.navigateToCondimentsPage();
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: const Text(
                    'Pos Entegrasyonu',
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    homeController.navigateToPosIntegrationPage();
                  },
                ),
              ],
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Cari Hesaplar',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                homeController.navigateToCheckAccounts();
              },
            ),
            const Divider(),
            Obx(() {
              return ListTile(
                title: const Text(
                  'Talepler',
                  style: TextStyle(fontSize: 16),
                ),
                trailing: homeController.showBadgeRequest.value
                    ? const Icon(
                        Icons.notification_important_sharp,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.arrow_forward_ios,
                        size: 0,
                      ),
                onTap: () {
                  homeController.navigateToRequests();
                },
              );
            }),
            const Divider(),
            ListTile(
              title: const Text(
                'Kapanmış Hesaplar',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                homeController.navigateToClosedChecks();
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Gün sonu işlemleri',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                homeController.navigateToEndOfDay();
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Ağ Bilgileri',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                homeController.navigateToNetworkInfoPage();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            color: context.theme.primaryColor,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildMenuIcon(_scaffoldKey, homeController),
                      const VerticalDivider(
                        color: Colors.white,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                      HomeTopButton(
                        callback: () => homeController.openNewCheckDialog(),
                        text: 'İsme Hesap',
                      ),
                      Obx(() {
                        return HomeTopButton(
                          callback: () =>
                              homeController.navigateToDeliveryOrder(),
                          text: 'Paket Servis',
                          showBadge: homeController.showBadgeGetir.value ||
                              homeController.showBadgeYemeksepeti.value,
                        );
                      }),
                      Obx(() {
                        return HomeTopButton(
                          callback: () => homeController.navigateToFastSell(),
                          text: 'Peşin Satış',
                          showBadge:
                              homeController.hasFastSellCheck.value == true,
                        );
                      }),
                      HomeTopButton(
                        callback: () => homeController.lockScreen(),
                        text: 'Kilitle',
                      ),
                    ],
                  ),
                  Obx(() {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: () {
                            homeController.changeShowSearch();
                          },
                          child: Obx(() {
                            return Container(
                              margin: const EdgeInsets.only(right: 0),
                              child: Icon(
                                homeController.hideSearch.value
                                    ? Icons.search
                                    : Icons.search_off,
                                size: 40,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ),
                        homeController.hideSearch.value
                            ? buildTableGroupsDropdown(homeController)
                            : Center(
                                child: SizedBox(
                                  width: 200,
                                  child: TextFormField(
                                      onTap: () async {
                                        if (homeController.localeManager
                                            .getBoolValue(PreferencesKeys
                                                .SCREEN_KEYBOARD)) {
                                          var res = await showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const ScreenKeyboard(),
                                          );
                                          if (res != null) {
                                            homeController.searchCtrl.text =
                                                res;
                                            createFilteredTables(
                                                homeController);
                                            homeController.tableGroups
                                                .refresh();
                                          }
                                        }
                                      },
                                      focusNode: homeController.myFocusNode,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        fillColor: Colors.white,
                                        filled: true,
                                      ),
                                      controller: homeController.searchCtrl,
                                      onChanged: (v) => {
                                            createFilteredTables(
                                                homeController),
                                            homeController.tableGroups.refresh()
                                          }),
                                ),
                              ),
                        GestureDetector(
                          onTap: () {
                            homeController.getTableGroups();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Icon(
                              Icons.refresh,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          Obx(
            () {
              return (!homeController.serverSignalRConnected.value)
                  ? Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide()),
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          const Text(
                            "Server ile bağlantı kurulamadı !",
                            style: TextStyle(color: Colors.red, fontSize: 22),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => homeController.reconnectServer(),
                            child: Container(
                              height: 30,
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              color: context.theme.primaryColor,
                              child: const Text(
                                "Yeniden Bağlan",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container();
            },
          ),
          Expanded(
            child: Obx(() {
              if (homeController.selectedTableGroup.value != null) {
                if (homeController.tableGroupDivider.value) {
                  if (homeController.selectedTableGroup.value!.name == "Tümü" &&
                      homeController.hideSearch.value) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return GridView.extent(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          maxCrossAxisExtent: getTableWidth(homeController),
                          childAspectRatio: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          shrinkWrap: true,
                          children: createTableWidgets(
                              homeController.tableGroups[index + 1],
                              homeController),
                        );
                      },
                      itemCount: homeController.tableGroups != null &&
                              homeController.tableGroups.isNotEmpty
                          ? homeController.tableGroups.length - 1
                          : 0,
                    );
                  } else {
                    return GridView.extent(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        maxCrossAxisExtent: getTableWidth(homeController),
                        childAspectRatio: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: homeController.hideSearch.value
                            ? createTables(
                                homeController.selectedTableGroup.value!,
                                homeController)
                            : createFilteredTables(homeController));
                  }
                } else {
                  return GridView.extent(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      maxCrossAxisExtent: getTableWidth(homeController),
                      childAspectRatio: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      children: homeController.hideSearch.value &&
                              homeController.selectedTableGroup.value!.name !=
                                  "Tümü"
                          ? createTables(
                              homeController.selectedTableGroup.value!,
                              homeController)
                          : createFilteredTables(homeController));
                }
              }
              return Container();
            }),
          ),
        ],
      ),
    ));
  }

  double getTableWidth(HomeController homeController) {
    var tableWidthStr = homeController.localeManager
        .getStringValue(PreferencesKeys.TABLE_WIDTH);
    var res = double.tryParse(tableWidthStr);
    if (res == null) {
      return 150;
    } else {
      return res;
    }
  }

  List<Widget> createTables(
      HomeGroupWithDetails group, HomeController homeController) {
    if (homeController.selectedTableGroup.value != null) {
      if (homeController.selectedTableGroup.value!.tables!.isNotEmpty) {
        return createTableWidgets(group, homeController);
      } else {
        return [];
      }
    }
    return [];
  }

  List<Widget> createTableWidgets(
      HomeGroupWithDetails group, HomeController homeController) {
    if (group.name == 'Açık Hesaplar' &&
        homeController.selectedTableGroup.value != null &&
        homeController.selectedTableGroup.value!.name != 'Açık Hesaplar') {
      return [];
    }
    return List.generate(
      group.tables!.length,
      (index) {
        TableWithDetails table = group.tables![index];
        if (table.status == TableStatusTypeEnum.Empty.index) {
          return ClosedTableWidget(
            table: table,
            callback: () => homeController.navigateToTableDetail(
                table.tableId, table.checkId),
          );
        } else if (table.status == TableStatusTypeEnum.HasOpenCheck.index) {
          return OpenTableWidget(
            table: table,
            callback: () => homeController.navigateToTableDetail(
                table.tableId, table.checkId),
          );
        } else {
          return CheckSendTableWidget(
            table: table,
            callback: () => homeController.navigateToTableDetail(
                table.tableId, table.checkId),
          );
        }
      },
    );
  }

  List<Widget> createFilteredTables(HomeController homeController) {
    List<Widget> ret = [];

    for (var group in homeController.tableGroups) {
      if (group.name == 'Açık Hesaplar' &&
          homeController.selectedTableGroup.value != null &&
          homeController.selectedTableGroup.value!.name != 'Açık Hesaplar') {
        continue;
      }
      for (var table in group.tables!) {
        if (table.name!
            .toUpperCase()
            .contains(homeController.searchCtrl.text.toUpperCase())) {
          if (table.status == TableStatusTypeEnum.Empty.index) {
            ret.add(ClosedTableWidget(
              table: table,
              callback: () => homeController.navigateToTableDetail(
                  table.tableId, table.checkId),
            ));
          } else if (table.status == TableStatusTypeEnum.HasOpenCheck.index) {
            ret.add(OpenTableWidget(
              table: table,
              callback: () => homeController.navigateToTableDetail(
                  table.tableId, table.checkId),
            ));
          } else {
            ret.add(CheckSendTableWidget(
              table: table,
              callback: () => homeController.navigateToTableDetail(
                  table.tableId, table.checkId),
            ));
          }
        }
      }
    }
    return ret;
  }

  Widget buildTableGroupsDropdown(HomeController homeController) {
    return Obx(
      () => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              icon: null,
              iconSize: 0,
              items: homeController.tableGroups
                  .map<DropdownMenuItem>((HomeGroupWithDetails value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.tableGroupId != -1 ? value.name! : value.name!,
                  ),
                );
              }).toList(),
              value: homeController.selectedTableGroup.value,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
              onChanged: (dynamic newGroup) {
                homeController.changeTableGroup(newGroup);
              },
              selectedItemBuilder: (context) {
                return homeController.tableGroups
                    .map((HomeGroupWithDetails value) {
                  return Center(
                    child: Text(
                      value.tableGroupId != -1 ? value.name! : value.name!,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList();
              }),
        ),
      ),
    );
  }

  Widget buildMenuIcon(
      GlobalKey<ScaffoldState> key, HomeController homeController) {
    return Obx(() {
      return GestureDetector(
        onTap: () => key.currentState!.openDrawer(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Badge(
            showBadge: homeController.showBadgeRequest.value,
            badgeStyle: const BadgeStyle(padding: EdgeInsets.all(6)),
            position: BadgePosition.topEnd(top: 0),
            child: const Icon(
              Icons.menu,
              size: 50,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}

class HomeTopButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;
  final bool showBadge;
  const HomeTopButton({
    super.key,
    required this.callback,
    required this.text,
    this.showBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 150),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          ),
          onPressed: () => callback(),
          child: Badge(
            badgeContent: const Text('!'),
            showBadge: showBadge,
            position: BadgePosition.topEnd(),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
