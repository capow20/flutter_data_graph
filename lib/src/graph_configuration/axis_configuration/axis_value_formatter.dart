import 'dart:js_interop';

import 'package:equatable/equatable.dart';

typedef AxisValueFormatter = String Function(num, String);

class AxisValueFormatterWrapper extends Equatable {
  const AxisValueFormatterWrapper(this._formatter);

  final AxisValueFormatter _formatter;

  @JSExport()
  JSString call(JSNumber val, JSString series) => _formatter(val.toDartDouble, series.toDart).toJS;

  @override
  List<Object> get props => [_formatter];
}
