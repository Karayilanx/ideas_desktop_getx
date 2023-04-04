import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/check-account/check-account-detail/viewmodel/check_account_detail_view_model.dart';

import '../../../delivery/customer/customer-detail/view/customer_detail_view.dart';

class CheckAccountDetailPage extends StatelessWidget {
  const CheckAccountDetailPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CheckAccountDetailController checkAccountDetailController =
        Get.put(CheckAccountDetailController());
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        Container(
            color: context.theme.primaryColor,
            padding: const EdgeInsets.all(10),
            child: Text(
              checkAccountDetailController.checkAccountId > 0
                  ? 'Düzenle'
                  : 'Yeni Cari Hesap',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildTableGroupsDropdown(checkAccountDetailController),
              CustomerDetailInput(
                ctrl: checkAccountDetailController.nameCtrl,
                hintText: 'Cari Hesap Adı*',
                enabled: true,
              ),
              const SizedBox(height: 20),
              PhoneInput(
                controller: checkAccountDetailController.phoneCtrl,
                maskFormatter: checkAccountDetailController.maskFormatter,
                enabled: true,
              ),
              const SizedBox(height: 20),
              CustomerDetailInput(
                ctrl: checkAccountDetailController.addressCtrl,
                hintText: 'Adres',
                enabled: true,
              ),
              const SizedBox(height: 20),
              CustomerDetailInput(
                ctrl: checkAccountDetailController.taxOfficeCtrl,
                hintText: 'Vergi Dairesi',
                enabled: true,
              ),
              const SizedBox(height: 20),
              CustomerDetailInput(
                ctrl: checkAccountDetailController.taxNoCtrl,
                hintText: 'Vergi No',
                enabled: true,
                type: TextInputType.number,
              ),
              const SizedBox(height: 20),
              CustomerDetailInput(
                ctrl: checkAccountDetailController.discountCtrl,
                hintText: 'İskonto Oranı',
                enabled: true,
                type: TextInputType.number,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    checkAccountDetailController.createCheckAccount();
                  },
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.symmetric(
                        vertical: 8,
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffF1A159)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ))),
                  child: const Text(
                    'Kaydet',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      )),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.symmetric(
                        vertical: 8,
                      ))),
                  child: const Text(
                    'Vazgeç',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

Widget buildTableGroupsDropdown(CheckAccountDetailController controller) {
  return Obx(
    () => Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          'Hesap Tipi: ',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            child: DropdownButton(
              icon: const Icon(
                Icons.arrow_downward,
                size: 36,
                color: Colors.black,
              ),
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    'Müşteri',
                  ),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(
                    'Tedarikçi',
                  ),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text(
                    'Banka/POS',
                  ),
                ),
                DropdownMenuItem(
                  value: 6,
                  child: Text(
                    'Kasa',
                  ),
                ),
                DropdownMenuItem(
                  value: 8,
                  child: Text(
                    'Ödenmez',
                  ),
                ),
                DropdownMenuItem(
                  value: 10,
                  child: Text(
                    'Zayi',
                  ),
                ),
                DropdownMenuItem(
                  value: 9,
                  child: Text(
                    'Personel',
                  ),
                ),
              ],
              value: controller.checkAccountTypeId.value,
              style: const TextStyle(color: Colors.black, fontSize: 22),
              onChanged: (dynamic newGroup) {
                controller.changeCheckAccountType(newGroup);
              },
            ),
          ),
        ),
      ],
    ),
  );
}
