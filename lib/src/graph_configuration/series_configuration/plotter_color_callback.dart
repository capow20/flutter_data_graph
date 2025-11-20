import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

typedef PlotterColorCallback = Color Function(double x, double y);

class PlotterColorCallbackWrapper extends Equatable {
  const PlotterColorCallbackWrapper(this._callback);

  final PlotterColorCallback _callback;

  @JSExport()
  JSString call(JSNumber x, JSNumber y) => _callback(x.toDartDouble, y.toDartDouble).toCSS.toJS;

  @override
  List<Object> get props => [_callback];
}
