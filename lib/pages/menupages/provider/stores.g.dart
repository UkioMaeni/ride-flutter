// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StoreController on ControllerBase, Store {
  late final _$dateAtom = Atom(name: 'ControllerBase.date', context: context);

  @override
  DateTime get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$fromAtom = Atom(name: 'ControllerBase.from', context: context);

  @override
  DataCreate get from {
    _$fromAtom.reportRead();
    return super.from;
  }

  @override
  set from(DataCreate value) {
    _$fromAtom.reportWrite(value, super.from, () {
      super.from = value;
    });
  }

  late final _$toAtom = Atom(name: 'ControllerBase.to', context: context);

  @override
  DataCreate get to {
    _$toAtom.reportRead();
    return super.to;
  }

  @override
  set to(DataCreate value) {
    _$toAtom.reportWrite(value, super.to, () {
      super.to = value;
    });
  }

  late final _$priceAtom = Atom(name: 'ControllerBase.price', context: context);

  @override
  String get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(String value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  late final _$carAtom = Atom(name: 'ControllerBase.car', context: context);

  @override
  CarData get car {
    _$carAtom.reportRead();
    return super.car;
  }

  @override
  set car(CarData value) {
    _$carAtom.reportWrite(value, super.car, () {
      super.car = value;
    });
  }

  late final _$dopInfoAtom =
      Atom(name: 'ControllerBase.dopInfo', context: context);

  @override
  DopInfo get dopInfo {
    _$dopInfoAtom.reportRead();
    return super.dopInfo;
  }

  @override
  set dopInfo(DopInfo value) {
    _$dopInfoAtom.reportWrite(value, super.dopInfo, () {
      super.dopInfo = value;
    });
  }

  late final _$createAutoAtom =
      Atom(name: 'ControllerBase.createAuto', context: context);

  @override
  bool get createAuto {
    _$createAutoAtom.reportRead();
    return super.createAuto;
  }

  @override
  set createAuto(bool value) {
    _$createAutoAtom.reportWrite(value, super.createAuto, () {
      super.createAuto = value;
    });
  }

  late final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase', context: context);

  @override
  void setDate(DateTime date_) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setDate');
    try {
      return super.setDate(date_);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFrom(DataCreate from_) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setFrom');
    try {
      return super.setFrom(from_);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTo(DataCreate to_) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setTo');
    try {
      return super.setTo(to_);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrice(String price_) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setPrice');
    try {
      return super.setPrice(price_);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCar(CarData car_) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setCar');
    try {
      return super.setCar(car_);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDopInfo(DopInfo dopInfo_) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setDopInfo');
    try {
      return super.setDopInfo(dopInfo_);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCreatAuto(bool newValue) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setCreatAuto');
    try {
      return super.setCreatAuto(newValue);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
date: ${date},
from: ${from},
to: ${to},
price: ${price},
car: ${car},
dopInfo: ${dopInfo},
createAuto: ${createAuto}
    ''';
  }
}
