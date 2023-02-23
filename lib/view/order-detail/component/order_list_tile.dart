import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';
import '../../../model/check_model.dart';

class OrderListTile extends StatelessWidget {
  final GroupedCheckItem groupedItem;
  final Color quantityTextColor;
  final Color quantityTextBorderColor;
  final Color itemNameColor;
  final Color itemSubtitleColor;
  final Color priceColor;
  const OrderListTile({
    super.key,
    required this.groupedItem,
    this.quantityTextColor = const Color(0xffF1A159),
    this.quantityTextBorderColor = Colors.white,
    this.itemNameColor = Colors.white,
    this.itemSubtitleColor = Colors.white54,
    this.priceColor = const Color(0xffF1A159),
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildQuantity(),
        const SizedBox(width: 5),
        buildCenterTile(),
        buildItemPrice()
      ],
    );
  }

  Container buildQuantity() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: quantityTextBorderColor, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(9.0)),
      ),
      child: Text(
        groupedItem.itemCount.toString(),
        style: TextStyle(fontSize: 20, color: quantityTextColor),
      ),
    );
  }

  Expanded buildCenterTile() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            groupedItem.getName +
                (groupedItem.originalItem!.actionType ==
                        CheckMenuItemActionType.GIFT.getValue
                    ? '(İKRAM)'
                    : groupedItem.originalItem!.actionType ==
                            CheckMenuItemActionType.PAID.getValue
                        ? ' (ÖDENDİ)'
                        : ''),
            style: TextStyle(
              fontSize: 16,
              color: itemNameColor,
            ),
          ),
          groupedItem.originalItem!.condiments!.isNotEmpty ||
                  groupedItem.originalItem!.note != null &&
                      groupedItem.originalItem!.note != ''
              ? StyledText(
                  text: groupedItem.getCondimentNamesAndNote(),
                  tags: {
                    'b': StyledTextTag(
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  },
                  style: TextStyle(
                    fontSize: 14,
                    color: itemSubtitleColor,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Container buildItemPrice() {
    return Container(
      margin: const EdgeInsets.only(right: 0),
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          groupedItem.originalItem!.isStopped == true
              ? const Icon(
                  Icons.access_time,
                  size: 20,
                  color: Colors.white,
                )
              : Container(),
          const SizedBox(width: 4),
          Text(
            "${groupedItem.totalPrice.toStringAsFixed(2)} TL",
            style: TextStyle(
              color: priceColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// createUrunAdi(Order sip) {
//   List<Widget> ret = new List<Widget>();
//   ret.add(Text(
//     sip.urunadi,
//     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
//   ));
//   ret.add(Text(
//     sip.eksecimlerString,
//     style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600]),
//   ));
//   if (sip.notlar != '') {
//     ret.add(Text(sip.notlar,
//         style:
//             TextStyle(fontStyle: FontStyle.italic, color: Colors.grey[600])));
//   }
//   return ret;
// }
