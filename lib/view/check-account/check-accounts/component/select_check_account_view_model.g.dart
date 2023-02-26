// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_check_account_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectCheckAccountViewModel on _SelectCheckAccountViewModelBase, Store {
  late final _$selectedTypeAtom = Atom(
      name: '_SelectCheckAccountViewModelBase.selectedType', context: context);

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

  late final _$checkAccountsAtom = Atom(
      name: '_SelectCheckAccountViewModelBase.checkAccounts', context: context);

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
      name: '_SelectCheckAccountViewModelBase.filteredCheckAccounts',
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
      name: '_SelectCheckAccountViewModelBase.selectedCheckAccount',
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

  late final _$getCheckAccountsAsyncAction = AsyncAction(
      '_SelectCheckAccountViewModelBase.getCheckAccounts',
      context: context);

  @override
  Future<dynamic> getCheckAccounts() {
    return _$getCheckAccountsAsyncAction.run(() => super.getCheckAccounts());
  }

  late final _$_SelectCheckAccountViewModelBaseActionController =
      ActionController(
          name: '_SelectCheckAccountViewModelBase', context: context);

  @override
  dynamic changeSelectedType(int val) {
    final _$actionInfo =
        _$_SelectCheckAccountViewModelBaseActionController.startAction(
            name: '_SelectCheckAccountViewModelBase.changeSelectedType');
    try {
      return super.changeSelectedType(val);
    } finally {
      _$_SelectCheckAccountViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void filterCheckAccounts(String text) {
    final _$actionInfo =
        _$_SelectCheckAccountViewModelBaseActionController.startAction(
            name: '_SelectCheckAccountViewModelBase.filterCheckAccounts');
    try {
      return super.filterCheckAccounts(text);
    } finally {
      _$_SelectCheckAccountViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void selectCheckAccount(CheckAccountListItem item) {
    final _$actionInfo =
        _$_SelectCheckAccountViewModelBaseActionController.startAction(
            name: '_SelectCheckAccountViewModelBase.selectCheckAccount');
    try {
      return super.selectCheckAccount(item);
    } finally {
      _$_SelectCheckAccountViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedType: ${selectedType},
checkAccounts: ${checkAccounts},
filteredCheckAccounts: ${filteredCheckAccounts},
selectedCheckAccount: ${selectedCheckAccount}
    ''';
  }
}
