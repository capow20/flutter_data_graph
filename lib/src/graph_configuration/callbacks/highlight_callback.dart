import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/params/data_point.dart';
import 'package:web/web.dart';

typedef HighlightCallback = void Function(MouseEvent e, double x, List<DataPoint> points, double row, String? series);

class HighlightCallbackWrapper extends Equatable {
  const HighlightCallbackWrapper(this._callback);

  final HighlightCallback _callback;

  @JSExport()
  JSVoid call(MouseEvent e, JSNumber x, JSObject points, JSNumber row, JSString? series) {
    final p = JSArray.from<JSDataPoint>(points).toDart.map((e) => e.toDart).toList();

    _callback(e, x.toDartDouble, p, row.toDartDouble, series?.toDart);
  }

  @override
  List<Object> get props => [_callback];
}
