import 'dart:js_interop';
import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/params/data_point.dart';
import 'package:web/web.dart';

typedef PointClickCallback = void Function(MouseEvent e, DataPoint point);

class PointClickCallbackWrapper extends Equatable {
  const PointClickCallbackWrapper(this._callback);

  final PointClickCallback _callback;

  @JSExport()
  JSVoid call(MouseEvent e, JSDataPoint point) => _callback(e, point.toDart);

  @override
  List<Object> get props => [_callback];
}
