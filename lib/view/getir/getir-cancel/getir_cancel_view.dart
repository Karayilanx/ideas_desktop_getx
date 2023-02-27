import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../locale_keys_enum.dart';
import '../../../theme/theme.dart';
import '../../_utility/loading/loading_screen.dart';
import '../../_utility/screen_keyboard/screen_keyboard_view.dart';
import 'getir_cancel_view_model.dart';

class GetirCancelPage extends StatelessWidget {
  const GetirCancelPage();

  @override
  Widget build(BuildContext context) {
    GetirCancelController controller = Get.find();
    return buildBody(controller);
  }

  SimpleDialog buildBody(GetirCancelController controller) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Color(0xffEDEAE6),
      children: [
        Obx(() => SizedBox(
              height: 300,
              child: controller.cancelOptions == null
                  ? LoadingPage()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Sipariş İptal',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                          child: Row(
                            children: [
                              Text(
                                'İptal Sebebi: ',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: DropdownButton(
                                    icon: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.black,
                                    ),
                                    items: getCancelButtons(controller),
                                    value: controller.selectedReasonId.value,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                    onChanged: (dynamic newGroup) {
                                      controller.changeSelectedReason(newGroup);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: TextFormField(
                            controller: controller.ctrl,
                            onTap: () async {
                              if (controller.localeManager.getBoolValue(
                                  PreferencesKeys.SCREEN_KEYBOARD)) {
                                var res = await Get.dialog(
                                  ScreenKeyboard(),
                                );
                                if (res != null) {
                                  controller.ctrl.text = res;
                                }
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'Açıklama',
                              isDense: true,
                            ),
                            style: TextStyle(),
                          ),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Spacer(),
                            Expanded(
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                                child: ElevatedButton(
                                  onPressed: () => controller.save(),
                                  child: Text(
                                    'KAYDET',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ideasTheme.scaffoldBackgroundColor),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 60,
                                margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                                child: ElevatedButton(
                                  onPressed: () => Get.back(),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: Text(
                                    'Vazgeç',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
            ))
      ],
    );
  }
}

Widget buildTableGroupsDropdown(GetirCancelController controller) {
  return Obx(
    () => Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Hesap Tipi: ',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 16),
            child: DropdownButton(
              icon: Icon(
                Icons.arrow_downward,
                color: Colors.black,
              ),
              items: getCancelButtons(controller),
              value: controller.selectedReasonId.value,
              style: TextStyle(color: Colors.black, fontSize: 22),
              onChanged: (dynamic newGroup) {
                controller.changeSelectedReason(newGroup);
              },
            ),
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller.ctrl,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              hintText: 'Açıklama',
              isDense: true,
            ),
            style: TextStyle(),
          ),
        ),
        ElevatedButton(
            onPressed: () => controller.save(), child: Text('KAYDET'))
      ],
    ),
  );
}

List<DropdownMenuItem> getCancelButtons(GetirCancelController controller) {
  List<DropdownMenuItem> items = [];
  for (var item in controller.cancelOptions) {
    items.add(DropdownMenuItem(
      value: item.id,
      child: Text(
        item.message!,
      ),
    ));
  }
  return items;
}
