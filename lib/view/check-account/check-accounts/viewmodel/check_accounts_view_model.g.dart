// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_accounts_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckAccountsViewModel on _CheckAccountsViewModelBase, Store {
  late final _$selectedTypeAtom =
      Atom(name: '_CheckAccountsViewModelBase.selectedType', context: context);

  @override
  int get selectedType {
    _$selectedTypeAtom.reportRead();
    return super.selectedType;
  }

  @override
  set selectedType(int value) {
    _$selectedTypeAtom.reportWrite(value, super.selectedType, () {
      super.selectedType = value;
    });
  }

  late final _$checkAccountsAtom =
      Atom(name: '_CheckAccountsViewModelBase.checkAccounts', context: context);

  @override
  List<CheckAccountListItem>? get checkAccounts {
    _$checkAccountsAtom.reportRead();
    return super.checkAccounts;
  }

  @override
  set checkAccounts(List<CheckAccountListItem>? value) {
    _$checkAccountsAtom.reportWrite(value, super.checkAccounts, () {
      super.checkAccounts = value;
    });
  }

  late final _$filteredCheckAccountsAtom = Atom(
      name: '_CheckAccountsViewModelBase.filteredCheckAccounts',
      context: context);

  @override
  List<CheckAccountListItem>? get filteredCheckAccounts {
    _$filteredCheckAccountsAtom.reportRead();
    return super.filteredCheckAccounts;
  }

  @override
  set filteredCheckAccounts(List<CheckAccountListItem>? value) {
    _$filteredCheckAccountsAtom.reportWrite(value, super.filteredCheckAccounts,
        () {
      super.filteredCheckAccounts = value;
    });
  }

  late final _$selectedCheckAccountAtom = Atom(
      name: '_CheckAccountsViewModelBase.selectedCheckAccount',
      context: context);

  @override
  CheckAccountListItem? get selectedCheckAccount {
    _$selectedCheckAccountAtom.reportRead();
    return super.selectedCheckAccount;
  }

  @override
  set selectedCheckAccount(CheckAccountListItem? value) {
    _$selectedCheckAccountAtom.reportWrite(value, super.selectedCheckAccount,
        () {
      super.selectedCheckAccount = value;
    });
  }

  late final _$checkAccountSummaryAtom = Atom(
      name: '_CheckAccountsViewModelBase.checkAccountSummary',
      context: context);

  @override
  CheckAccountSummaryModel? get checkAccountSummary {
    _$checkAccountSummaryAtom.reportRead();
    return super.checkAccountSummary;
  }

  @override
  set checkAccountSummary(CheckAccountSummaryModel? value) {
    _$checkAccountSummaryAtom.reportWrite(value, super.checkAccountSummary, () {
      super.checkAccountSummary = value;
    });
  }

  late final _$getCheckAccountsAsyncAction = AsyncAction(
      '_CheckAccountsViewModelBase.getCheckAccounts',
      context: context);

  @override
  Future<dynamic> getCheckAccounts() {
    return _$getCheckAccountsAsyncAction.run(() => super.getCheckAccounts());
  }

  late final _$getCheckAccountSummaryAsyncAction = AsyncAction(
      '_CheckAccountsViewModelBase.getCheckAccountSummary',
      context: context);

  @override
  Future getCheckAccountSummary() {
    return _$getCheckAccountSummaryAsyncAction
        .run(() => super.getCheckAccountSummary());
  }

  late final _$insertCheckAccountTransactionAsyncAction = AsyncAction(
      '_CheckAccountsViewModelBase.insertCheckAccountTransaction',
      context: context);

  @override
  Future<dynamic> insertCheckAccountTransaction(
      int checkAccountTransactionTypeId) {
    return _$insertCheckAccountTransactionAsyncAction.run(() =>
        super.insertCheckAccountTransaction(checkAccountTransactionTypeId));
  }

  late final _$removeCheckAccountAsyncAction = AsyncAction(
      '_CheckAccountsViewModelBase.removeCheckAccount',
      context: context);

  @override
  Future<dynamic> removeCheckAccount() {
    return _$removeCheckAccountAsyncAction
        .run(() => super.removeCheckAccount());
  }

  late final _$_CheckAccountsViewModelBaseActionController =
      ActionController(name: '_CheckAccountsViewModelBase', context: context);

  @override
  dynamic changeSelectedType(int val) {
    final _$actionInfo = _$_CheckAccountsViewModelBaseActionController
        .startAction(name: '_CheckAccountsViewModelBase.changeSelectedType');
    try {
      return super.changeSelectedType(val);
    } finally {
      _$_CheckAccountsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterCheckAccounts(String text) {
    final _$actionInfo = _$_CheckAccountsViewModelBaseActionController
        .startAction(name: '_CheckAccountsViewModelBase.filterCheckAccounts');
    try {
      return super.filterCheckAccounts(text);
    } finally {
      _$_CheckAccountsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectCheckAccount(CheckAccountListItem item) {
    final _$actionInfo = _$_CheckAccountsViewModelBaseActionController
        .startAction(name: '_CheckAccountsViewModelBase.selectCheckAccount');
    try {
      return super.selectCheckAccount(item);
    } finally {
      _$_CheckAccountsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCheckAccountBalance(int? checkAccountId, double? newBalance) {
    final _$actionInfo =
        _$_CheckAccountsViewModelBaseActionController.startAction(
            name: '_CheckAccountsViewModelBase.updateCheckAccountBalance');
    try {
      return super.updateCheckAccountBalance(checkAccountId, newBalance);
    } finally {
      _$_CheckAccountsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getPercentage() {
    final _$actionInfo = _$_CheckAccountsViewModelBaseActionController
        .startAction(name: '_CheckAccountsViewModelBase.getPercentage');
    try {
      return super.getPercentage();
    } finally {
      _$_CheckAccountsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedType: ${selectedType},
checkAccounts: ${checkAccounts},
filteredCheckAccounts: ${filteredCheckAccounts},
selectedCheckAccount: ${selectedCheckAccount},
checkAccountSummary: ${checkAccountSummary}
    ''';
  }
}
