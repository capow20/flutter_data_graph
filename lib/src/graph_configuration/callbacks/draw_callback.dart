import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/dygraph/dygraph.dart';

typedef DrawCallback = void Function(Dygraph g, bool initial);

class DrawCallbackWrapper extends Equatable {
  const DrawCallbackWrapper(this._callback);

  final DrawCallback _callback;

  @JSExport()
  JSVoid call(Dygraph g, JSBoolean initial) => _callback(g, initial.toDart);

  @override
  List<Object?> get props => [_callback];
}
