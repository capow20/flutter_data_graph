import 'dart:js_interop';

import 'package:equatable/equatable.dart';

typedef TagClickHandler = void Function(double x);

class TagClickHandlerWrapper extends Equatable {
  const TagClickHandlerWrapper(this._handler);

  final TagClickHandler _handler;

  @JSExport()
  JSVoid call(JSNumber x) => _handler(x.toDartDouble);

  @override
  List<Object> get props => [_handler];
}
