import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

typedef ZoomCallback = void Function(double minX, double maxX, List<List<double>> yRanges);

class ZoomCallbackWrapper extends Equatable {
  const ZoomCallbackWrapper(this._callback);

  final ZoomCallback _callback;

  @JSExport()
  JSVoid call(JSNumber minX, JSNumber maxX, JSObject js) {
    final yRanges = JSArray.from<JSObject>(js).toDart.map((e) => JSArray.from<JSNumber>(e).toDoubleList).toList();
    _callback(minX.toDartDouble, maxX.toDartDouble, yRanges);
  }

  @override
  List<Object> get props => [_callback];
}
