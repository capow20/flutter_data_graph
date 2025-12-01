import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';

extension JSExtension on List<List<num?>> {
  JSArray<JSArray<JSNumber?>> get toJS {
    return map((e) => e.map((f) => f?.toJS).toList().toJS).toList().toJS;
  }
}

extension DartExtension on JSArray<JSNumber> {
  List<double> get toDoubleList {
    return toDart.map((e) => e.toDartDouble).toList();
  }
}

extension CSSExtension on Color {
  String get toCSS {
    return '#${toARGB32().toRadixString(16).substring(2)}';
  }
}

typedef AxisRange = ({double min, double max});

extension JSAxisRange on AxisRange {
  JSObject get toJS {
    return JSObject()
      ..setProperty('min'.toJS, min.toJS)
      ..setProperty('max'.toJS, max.toJS);
  }
}
