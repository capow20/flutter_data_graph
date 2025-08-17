import 'dart:js_interop';

import 'package:equatable/equatable.dart';

typedef AxisLabelFormatter = String Function(double value);

class AxisLabelFormatterWrapper extends Equatable {
  const AxisLabelFormatterWrapper(this._formatter);

  final AxisLabelFormatter _formatter;

  @JSExport()
  JSString call(JSNumber val) => _formatter(val.toDartDouble).toJS;

  @override
  List<Object> get props => [_formatter];
}
