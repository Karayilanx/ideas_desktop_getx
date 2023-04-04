import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideas_desktop/view/stopped-items/stopped_items_view_model.dart';

import '../../model/check_model.dart';

class StoppedItemsPage extends StatelessWidget {
  const StoppedItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    StoppedItemsController controller = Get.put(StoppedItemsController());
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color(0xffEDEAE6),
      children: [
        SizedBox(
          width: context.width * 30 / 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: context.theme.primaryColor,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Ürünler',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    GroupedCheckItem item = controller.originalItems[index];
                    return Obx(() {
                      return ListTile(
                        title: Text(
                          item.name!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        leading: Checkbox(
                          value: controller.isItemSelected(item),
                          onChanged: (_) {
                            if (controller.isItemSelected(item)) {
                              controller.removeItem(item);
                            } else {
                              controller.selectItem(item);
                            }
                          },
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                onPressed: () =>
                                    controller.removeQuantity(item),
                                icon: const Icon(Icons.remove)),
                            Text(
                              controller.getQuantity(item),
                              style: const TextStyle(fontSize: 20),
                            ),
                            IconButton(
                                onPressed: () => controller.addQuantity(item),
                                icon: const Icon(Icons.add))
                          ],
                        ),
                        selected: controller.isItemSelected(item),
                        onTap: () {
                          if (controller.isItemSelected(item)) {
                            controller.removeItem(item);
                          } else {
                            controller.selectItem(item);
                          }
                        },
                      );
                    });
                  },
                  itemCount: controller.originalItems.length,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.printItems(),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                              vertical: 8,
                            )),
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
                          'Marşla',
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            )),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
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
          ),
        )
      ],
    );
  }
}
