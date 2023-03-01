// ignore_for_file: constant_identifier_names

import '../../../../model/check_model.dart';

class CheckAccountsArguments {
  final int? checkId;
  final CheckAccountsPageType type;
  final bool? transferAll;
  final List<CheckMenuItemModel?>? menuItems;
  CheckAccountsArguments({
    required this.checkId,
    required this.type,
    required this.transferAll,
    this.menuItems,
  });
}

enum CheckAccountsPageType { Check, CheckAccount, CheckCustomer, Unpayable }
