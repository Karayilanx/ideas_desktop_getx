// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_account_transactions_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CheckAccountTransactionsViewModel on _CheckAccountViewModelBase, Store {
  late final _$checkAccountAtom =
      Atom(name: '_CheckAccountViewModelBase.checkAccount', context: context);

  @override
  GetCheckAccountTransactionsOutput? get checkAccount {
    _$checkAccountAtom.reportRead();
    return super.checkAccount;
  }

  @override
  set checkAccount(GetCheckAccountTransactionsOutput? value) {
    _$checkAccountAtom.reportWrite(value, super.checkAccount, () {
      super.checkAccount = value;
    });
  }

  late final _$sourceAtom =
      Atom(name: '_CheckAccountViewModelBase.source', context: context);

  @override
  CheckAccountTransactionsDataSource? get source {
    _$sourceAtom.reportRead();
    return super.source;
  }

  @override
  set source(CheckAccountTransactionsDataSource? value) {
    _$sourceAtom.reportWrite(value, super.source, () {
      super.source = value;
    });
  }

  late final _$getCheckAccountTransactionsAsyncAction = AsyncAction(
      '_CheckAccountViewModelBase.getCheckAccountTransactions',
      context: context);

  @override
  Future<dynamic> getCheckAccountTransactions() {
    return _$getCheckAccountTransactionsAsyncAction
        .run(() => super.getCheckAccountTransactions());
  }

  late final _$_CheckAccountViewModelBaseActionController =
      ActionController(name: '_CheckAccountViewModelBase', context: context);

  @override
  dynamic expandPanel(bool expand, int index) {
    final _$actionInfo = _$_CheckAccountViewModelBaseActionController
        .startAction(name: '_CheckAccountViewModelBase.expandPanel');
    try {
      return super.expandPanel(expand, index);
    } finally {
      _$_CheckAccountViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
checkAccount: ${checkAccount},
source: ${source}
    ''';
  }
}
