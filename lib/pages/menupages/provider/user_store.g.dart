// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStore, Store {
  late final _$userInfoAtom =
      Atom(name: '_UserStore.userInfo', context: context);

  @override
  UserData get userInfo {
    _$userInfoAtom.reportRead();
    return super.userInfo;
  }

  @override
  set userInfo(UserData value) {
    _$userInfoAtom.reportWrite(value, super.userInfo, () {
      super.userInfo = value;
    });
  }

  late final _$setUserInfoAsyncAction =
      AsyncAction('_UserStore.setUserInfo', context: context);

  @override
  Future<dynamic> setUserInfo() {
    return _$setUserInfoAsyncAction.run(() => super.setUserInfo());
  }

  @override
  String toString() {
    return '''
userInfo: ${userInfo}
    ''';
  }
}
