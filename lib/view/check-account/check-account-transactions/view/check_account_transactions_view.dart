import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop_getx/extension/string_extension.dart';
import '../../../../theme/theme.dart';
import '../../../_utility/loading/loading_screen.dart';
import '../table/check_account_transactions_table.dart';
import '../viewmodel/check_account_transactions_view_model.dart';

class CheckAccountTransactionsPage extends StatelessWidget {
  const CheckAccountTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CheckAccountTransactionsController controller = Get.find();
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: controller.source.value != null ? buildBody(controller) : const LoadingPage(),
        );
      }),
    );
  }

  Widget buildBody(CheckAccountTransactionsController controller) {
    return Column(
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E5E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          controller.checkAccount.value!.name!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20, color: ideasTheme.scaffoldBackgroundColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          controller.checkAccount.value!.balance!.getPriceString,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFFF29106)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E5E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Kapat',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20, color: ideasTheme.scaffoldBackgroundColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
        Obx(() {
          return Expanded(
            child: CheckAccountTransactionsTable(
              source: controller.source.value!,
            ),
          );
        })
      ],
    );
  }
}
