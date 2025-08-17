import 'dart:js_interop';
import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/params/data_point.dart';
import 'package:web/web.dart';

typedef GraphClickCallback = void Function(MouseEvent e, double x, List<DataPoint> points);

class GraphClickCallbackWrapper extends Equatable {
  const GraphClickCallbackWrapper(this._callback);

  final GraphClickCallback _callback;

  @JSExport()
  JSVoid call(MouseEvent e, JSNumber x, JSObject rawPoints) =>
      _callback(e, x.toDartDouble, JSArray.from<JSDataPoint>(rawPoints).toDart.map((e) => e.toDart).toList());

  @override
  List<Object> get props => [_callback];
}
