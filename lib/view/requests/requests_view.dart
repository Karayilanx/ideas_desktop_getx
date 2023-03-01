import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/theme.dart';
import '../_utility/loading/loading_screen.dart';
import 'requests_view_model.dart';
import 'table/cancel_requests_table.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    RequestsController controller = Get.find();
    return Obx(
      () => controller.source.value != null
          ? buildBody(controller)
          : const LoadingPage(),
    );
  }

  Widget buildBody(RequestsController controller) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Text(
                      'Talepler',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 130,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE1E5E6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Kapat',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: ideasTheme.scaffoldBackgroundColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return Container(
                color: Colors.white,
                child: CancelRequestsTable(
                  source: controller.source.value!,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
