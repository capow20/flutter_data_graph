import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/params/area.dart';
import 'package:flutter_data_graph/src/graph_configuration/dygraph/dygraph.dart';
import 'package:web/web.dart';

typedef UnderlayCallback = void Function(CanvasRenderingContext2D ctx, Area area, Dygraph g);

class UnderlayCallbackWrapper extends Equatable {
  const UnderlayCallbackWrapper(this._callback);

  final UnderlayCallback _callback;

  @JSExport()
  JSVoid call(CanvasRenderingContext2D ctx, JSArea area, Dygraph g) => _callback(ctx, area.toDart, g);

  @override
  List<Object> get props => [_callback];
}
