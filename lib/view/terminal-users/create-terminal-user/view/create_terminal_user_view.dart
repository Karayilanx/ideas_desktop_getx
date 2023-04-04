import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/create_terminal_user_view_model.dart';

class CreateTerminalUserPage extends StatelessWidget {
  const CreateTerminalUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    CreateTerminalUserController controller =
        Get.put(CreateTerminalUserController());
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        SizedBox(
          width: 600,
          child: Column(
            children: [
              Container(
                color: const Color(0xff223540),
                child: Row(
                  children: const [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Yeni Kullanıcı',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.nameCtrl,
                      decoration:
                          const InputDecoration(hintText: 'Kullanıcı Adı'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Obx(() {
                      return CheckboxListTile(
                        value: controller.model.value.isAdmin,
                        title: const Text('Admin Yetkisi'),
                        onChanged: (val) => controller.changeIsAdmin(val!),
                      );
                    }),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.pinCtrl,
                        decoration:
                            const InputDecoration(hintText: '4 Haneli Şifre'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        controller: controller.maxDiscountPercentageCtrl,
                        decoration:
                            const InputDecoration(hintText: 'Max. İskonto(%)'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canGift,
                          title: const Text('İkram Yetkisi'),
                          onChanged: (val) => controller.changeCanGift(val!),
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canMarkUnpayable,
                          title: const Text('Ödenmez Yetkisi'),
                          onChanged: (val) =>
                              controller.changeCanMarkUnpayable(val!),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canDiscount,
                          title: const Text('İskonto Yetkisi'),
                          onChanged: (val) =>
                              controller.changeCanDiscount(val!),
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canTransferCheck,
                          title: const Text('Aktarma Yetkisi'),
                          onChanged: (val) =>
                              controller.changeCanTransferCheck(val!),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canRestoreCheck,
                          title: const Text('Geri Yükleme Yetkisi'),
                          onChanged: (val) =>
                              controller.changeCanRestoreCheck(val!),
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value:
                              controller.model.value.canSendCheckToCheckAccount,
                          title: const Text('Cari Yetkisi'),
                          onChanged: (val) =>
                              controller.changeCanSendCheckToCheckAccount(val!),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canMakeCheckPayment,
                          title: const Text('Ödeme Alma Yetkisi'),
                          onChanged: (val) =>
                              controller.changeCanMakeCheckPayment(val!),
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canCancel,
                          title: const Text('İptal Yetkisi'),
                          onChanged: (val) => controller.changeCanCancel(val!),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canEndDay,
                          title: const Text('Gün Sonu Yetkisi'),
                          onChanged: (val) => controller.changeCanEndDay(val!),
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Obx(() {
                        return CheckboxListTile(
                          value: controller.model.value.canSeeActions,
                          title: const Text('İşlemler Tuşu Yetkisi'),
                          onChanged: (val) =>
                              controller.changeCanSeeActions(val!),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.createTerminalUser(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Kaydet',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Vazgeç',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
