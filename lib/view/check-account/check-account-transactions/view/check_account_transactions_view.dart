import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../core/base/view/base_widget.dart';
import '../../../../core/theme/theme.dart';
import '../../../_utility/loading/loading_screen.dart';
import '../table/check_account_transactions_table.dart';
import '../viewmodel/check_account_transactions_view_model.dart';
import '../../../../core/extension/string_extension.dart';

class CheckAccountTransactionsPage extends StatelessWidget {
  final int? checkAccountId;

  const CheckAccountTransactionsPage({required this.checkAccountId});
  @override
  Widget build(BuildContext context) {
    return BaseView<CheckAccountTransactionsViewModel>(
      viewModel: CheckAccountTransactionsViewModel(checkAccountId),
      onModelReady: (model) {
        model.setContext(context);
        model.setModel(model);
        model.init();
      },
      onPageBuilder: (context, value) => Scaffold(
        body: Observer(builder: (_) {
          return SafeArea(
            child:
                value.source != null ? buildBody(value) : const LoadingPage(),
          );
        }),
      ),
    );
  }

  Widget buildBody(CheckAccountTransactionsViewModel value) {
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE1E5E6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          value.checkAccount!.name!,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: ideasTheme.scaffoldBackgroundColor),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          value.checkAccount!.balance!.getPriceString,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(0xFFF29106)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // const SizedBox(width: 10),
              // Container(
              //   width: 180,
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFE1E5E6),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Text(
              //       'Ekstre Yazdır',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           color: ideasTheme.scaffoldBackgroundColor),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 10),
              // Container(
              //   width: 180,
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFE1E5E6),
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Align(
              //     alignment: Alignment.center,
              //     child: Text(
              //       'Detaylı Ekstre Yazdır',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           color: ideasTheme.scaffoldBackgroundColor),
              //     ),
              //   ),
              // ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Navigator.pop(value.buildContext!),
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
        const Divider(color: Colors.grey),
        Observer(builder: (_) {
          return Expanded(
            child: CheckAccountTransactionsTable(
              source: value.source!,
            ),
          );
        })
      ],
    );
  }

  // Widget buildBody(
  //     CheckAccountTransactionsViewModel value, BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 10),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Container(
  //               width: 0.25.sw,
  //               padding: EdgeInsets.fromLTRB(6, 15, 6, 15),
  //               margin: EdgeInsets.only(right: 8),
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(20),
  //                   border: Border.all(color: Colors.black, width: 2),
  //                   color: Colors.white),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(
  //                     'Ünvanı\n${value.checkAccount!.name}',
  //                     style:
  //                         TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
  //                   ),
  //                   Text(
  //                     'Bakiye\n${value.checkAccount!.balance}',
  //                     style:
  //                         TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Spacer(flex: 6),
  //             TopBarButton(
  //               icon: Icons.print,
  //               name: 'YAZDIR',
  //               onPress: () {
  //                 // value.showCheckAccountDetailsDialog(-1);
  //               },
  //             ),
  //             TopBarButton(
  //               icon: Icons.close,
  //               name: 'ÇIKIŞ',
  //               onPress: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         ),
  //         Divider(color: Colors.white),
  //         Container(
  //           height: 0.10.sh,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 'HESAP DÖKÜMÜ',
  //                 style: TextStyle(color: Colors.white),
  //               )
  //             ],
  //           ),
  //         ),
  //         Observer(builder: (_) {
  //           return Expanded(
  //             child: ListView(
  //               children: [
  //                 ExpansionPanelList(
  //                   expansionCallback: (int index, bool isExpanded) {
  //                     value.expandPanel(isExpanded, index);
  //                   },
  //                   children: value.checkAccount!.checkAccountTransactions!
  //                       .asMap()
  //                       .entries
  //                       .map((item) {
  //                     return buildExpansionPanel(value, item);
  //                   }).toList(),
  //                 )
  //               ],
  //             ),
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }

  // ExpansionPanel buildExpansionPanel(CheckAccountTransactionsViewModel value,
  //     MapEntry<int, CheckAccountTransactionListItem> item) {
  //   if (item.value.checkDetail == null) {
  //     return ExpansionPanel(
  //       headerBuilder: (context, isExpanded) =>
  //           getPaymentExpandedTitle(item.value, value),
  //       isExpanded: false,
  //       body: Text('BADİ'),
  //     );
  //   } else {
  //     return getCheckExpansionPanel(value, item);
  //   }
  // }

  // ExpansionPanel getCheckExpansionPanel(CheckAccountTransactionsViewModel value,
  //     MapEntry<int, CheckAccountTransactionListItem> item) {
  //   return ExpansionPanel(
  //     body: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Divider(
  //           color: Colors.orange,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Expanded(
  //               flex: 80,
  //               child: ListView.separated(
  //                 shrinkWrap: true,
  //                 physics: NeverScrollableScrollPhysics(),
  //                 itemBuilder: (context, index) {
  //                   // var groupedCheck = value.groupedChecks[item.key][index];
  //                   var check = item.value.checkDetail!;
  //                   var groupedCheckMenuItems =
  //                       value.getGroupedMenuItems(check.basketItems!);
  //                   var groupedCheck = groupedCheckMenuItems[index];
  //                   return Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(groupedCheck.getName),
  //                             Text('    ' +
  //                                 value.getCondimentText(
  //                                     groupedCheck.originalItem!)),
  //                             Text(
  //                                 getItemNoteString(groupedCheck.originalItem!))
  //                           ],
  //                         ),
  //                         Row(
  //                           children: [
  //                             Text(groupedCheck.itemCount!.toStringAsFixed(0) +
  //                                 ' ADET'),
  //                             SizedBox(
  //                               width: 20,
  //                             ),
  //                             Text(groupedCheck.totalPrice.toStringAsFixed(2)),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 },
  //                 itemCount: value
  //                     .getGroupedMenuItems(item.value.checkDetail!.basketItems!)
  //                     .length,
  //                 separatorBuilder: (context, index) {
  //                   return Divider(
  //                     color: Colors.grey,
  //                     height: 1,
  //                   );
  //                 },
  //               ),
  //             ),
  //             Spacer(flex: 2),
  //             Expanded(
  //               flex: 30,
  //               child: Container(
  //                 margin: EdgeInsets.fromLTRB(0, 0, 12, 12),
  //                 decoration: new BoxDecoration(
  //                   color: Colors.white,
  //                   border: Border.all(color: Colors.black),
  //                   borderRadius: BorderRadius.circular(15),
  //                 ),
  //                 child: Padding(
  //                   padding: EdgeInsets.all(8.0),
  //                   child: buildPaymentTextColumn(item.value.checkDetail!),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ],
  //     ),
  //     isExpanded: item.value.expaned,
  //     headerBuilder: (context, isExpanded) {
  //       return getCheckExpandedTitle(item.value, value);
  //     },
  //   );
  // }

  // Widget buildPaymentTextColumn(CheckDetailsModel checkDetail) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       PaymentText(
  //         firstText: 'TOPLAM',
  //         fontSize: 18,
  //         secondText: checkDetail.payments!.checkAmount!.toStringAsFixed(2),
  //       ),
  //       PaymentText(
  //         firstText: 'NAKİT',
  //         fontSize: 18,
  //         secondText: checkDetail.payments!.cashAmount!.toStringAsFixed(2),
  //       ),
  //       PaymentText(
  //         firstText: 'KREDİ',
  //         fontSize: 18,
  //         secondText:
  //             checkDetail.payments!.creditCardAmount!.toStringAsFixed(2),
  //       ),
  //       PaymentText(
  //         firstText: 'İSKONTO',
  //         fontSize: 18,
  //         secondText: checkDetail.payments!.discountAmount!.toStringAsFixed(2),
  //       ),
  //       Divider(),
  //       PaymentText(
  //         firstText: 'KALAN',
  //         fontSize: 18,
  //         secondText: checkDetail.payments!.remainingAmount!.toStringAsFixed(2),
  //       ),
  //     ],
  //   );
  // }

  // Row getPaymentExpandedTitle(CheckAccountTransactionListItem item,
  //     CheckAccountTransactionsViewModel value) {
  //   return Row(
  //     children: [
  //       Expanded(
  //           child: Text(
  //         'İşlem Türü: ' + getTransactionTypeString(item),
  //         textAlign: TextAlign.center,
  //       )),
  //       Expanded(
  //           child: Text(
  //         'Tarih: ' + value.getDateString(item.createDate!),
  //         textAlign: TextAlign.center,
  //       )),
  //       Expanded(
  //           child: Text(
  //         'Tutar: ' + item.amount!.toStringAsFixed(2),
  //         textAlign: TextAlign.center,
  //       )),
  //     ],
  //   );
  // }

  // Row getCheckExpandedTitle(CheckAccountTransactionListItem item,
  //     CheckAccountTransactionsViewModel value) {
  //   return Row(
  //     children: [
  //       Expanded(
  //           child: Text(
  //         'Fiş No: ' + item.checkId.toString(),
  //         textAlign: TextAlign.center,
  //       )),
  //       Expanded(
  //           child: Text(
  //         'Tarih: ' + value.getDateString(item.createDate!),
  //         textAlign: TextAlign.center,
  //       )),
  //       Expanded(
  //           child: Text(
  //         'Tutar: ' + item.amount!.toStringAsFixed(2),
  //         textAlign: TextAlign.center,
  //       )),
  //     ],
  //   );
  // }

  // String getItemNoteString(CheckMenuItemModel item) {
  //   if (item.note != null && item.note!.isNotEmpty) {
  //     return '    ' + item.note!;
  //   } else
  //     return '';
  // }

}
