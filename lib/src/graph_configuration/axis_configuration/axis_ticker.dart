import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/axis_configuration/axis_tick.dart';
import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';

/// Builds the list of [AxisTick]s to be displayed on an axis.
///
/// [a] and [b] represent the lower and upper bounds of the axis, respectively.
///
/// [a] is not always smaller than [b], such as when an explicit [GraphConfiguration.minY] or [GraphConfiguration.maxY] are used.
typedef AxisTicker = List<AxisTick> Function(num a, num b, num pixels);

class AxisTickerWrapper extends Equatable {
  const AxisTickerWrapper(this._ticker);

  final List<AxisTick> Function(num, num, num) _ticker;

  @JSExport()
  JSArray<JSAxisTick> call(JSNumber a, JSNumber b, JSNumber pixels) =>
      _ticker(a.toDartDouble, b.toDartDouble, pixels.toDartDouble).map((e) => e.toJS).toList().toJS;

  @override
  List<Object> get props => [_ticker];
}
