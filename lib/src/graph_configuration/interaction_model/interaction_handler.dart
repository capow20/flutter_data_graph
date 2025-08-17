import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/src/graph_configuration/dygraph/dygraph.dart';
import 'package:flutter_data_graph/src/graph_configuration/interaction_model/interaction_context.dart';
import 'package:web/web.dart';

typedef InteractionHandler = void Function(MouseEvent e, Dygraph g, InteractionContext ctx);

class InteractionHandlerWrapper extends Equatable {
  const InteractionHandlerWrapper(this._handler);

  final InteractionHandler _handler;

  @JSExport()
  JSVoid call(MouseEvent e, Dygraph g, InteractionContext jsContext) => _handler(e, g, jsContext);

  @override
  List<Object> get props => [_handler];
}
