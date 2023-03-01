import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/view/delivery/customer/customer-detail/viewmodel/customer_detail_view_model.dart';
import '../../../../../locale_keys_enum.dart';
import '../../../../../locale_manager.dart';
import '../../../../_utility/screen_keyboard/screen_keyboard_view.dart';
import '../model/customer_detail_page_enum.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomerDetailPage extends StatelessWidget {
  const CustomerDetailPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CustomerDetailController customerDetailController =
        Get.put(CustomerDetailController());
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: [
        SizedBox(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: context.theme.primaryColor,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    customerDetailController.type ==
                            CustomerDetailPageTypeEnum.NEW
                        ? 'Yeni Müşteri'
                        : 'Yeni Adres',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomerDetailInput(
                      ctrl: customerDetailController.nameCtrl,
                      hintText: 'Müşteri Adı',
                      enabled: customerDetailController.type !=
                          CustomerDetailPageTypeEnum.ADDRESS,
                      focusNode: customerDetailController.customerNameFocusNode,
                    ),
                    const SizedBox(height: 20),
                    CustomerDetailInput(
                      ctrl: customerDetailController.lastnameCtrl,
                      hintText: 'Müşteri Soyadı',
                      enabled: customerDetailController.type !=
                          CustomerDetailPageTypeEnum.ADDRESS,
                    ),
                    const SizedBox(height: 20),
                    // PhoneInput(
                    //   controller: value.phoneNumberCtrl,
                    //   // maskFormatter: value.maskFormatter,
                    //   enabled: type != CustomerDetailPageTypeEnum.ADDRESS,
                    // ),
                    CustomerDetailInput(
                      ctrl: customerDetailController.phoneNumberCtrl,
                      hintText: 'Telefon numarası',
                      isRequired: true,
                      enabled: customerDetailController.type !=
                          CustomerDetailPageTypeEnum.ADDRESS,
                    ),
                    const SizedBox(height: 20),
                    CustomerDetailInput(
                      ctrl: customerDetailController.addressTitleCtrl,
                      hintText: 'Adres Başlığı',
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    CustomerDetailInput(
                      ctrl: customerDetailController.addressCtrl,
                      hintText: 'Adres',
                      enabled: true,
                      isAddress: true,
                    ),
                    const SizedBox(height: 20),
                    CustomerDetailInput(
                      ctrl: customerDetailController.addressDefinitionCtrl,
                      hintText: 'Adres Tarifi',
                      isRequired: false,
                      enabled: true,
                      isAddress: true,
                    )
                  ],
                ),
              ),
              Container(
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          customerDetailController.createDeliveryCustomer();
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 8)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xffF1A159)),
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
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 8)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
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
          ),
        ),
      ],
    );
  }
}

class PhoneInput extends StatelessWidget {
  final MaskTextInputFormatter maskFormatter;
  final TextEditingController controller;
  final bool? enabled;
  const PhoneInput(
      {Key? key,
      required this.maskFormatter,
      required this.controller,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: '(555)-555-55-55',
        isDense: true,
      ),
      enabled: enabled,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.number,
      style: const TextStyle(),
    );
  }
}

class CustomerDetailInput extends StatelessWidget {
  final TextEditingController? ctrl;
  final String? hintText;
  final bool? isRequired;
  final bool? enabled;
  final FocusNode? focusNode;
  final TextInputType type;
  final bool isAddress;
  const CustomerDetailInput({
    super.key,
    this.ctrl,
    this.hintText,
    this.isRequired,
    this.enabled,
    this.type = TextInputType.text,
    this.focusNode,
    this.isAddress = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      focusNode: focusNode,
      onTap: () async {
        if (LocaleManager.instance
            .getBoolValue(PreferencesKeys.SCREEN_KEYBOARD)) {
          var res = await showDialog(
            context: context,
            builder: (context) => const ScreenKeyboard(),
          );
          if (res != null) {
            ctrl!.text = res;
          }
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        hintText: hintText,
        isDense: true,
      ),
      enabled: enabled,
      minLines: isAddress ? 3 : 1,
      maxLines: isAddress ? 3 : 1,
      style: const TextStyle(),
      validator: (value) {
        if (value!.isEmpty && isRequired == null) {
          return "required";
        }
        return null;
      },
    );
  }
}
