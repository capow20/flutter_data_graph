import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:web/web.dart';

typedef UnhighlightCallback = void Function(MouseEvent e);

class UnhighlightCallbackWrapper extends Equatable {
  const UnhighlightCallbackWrapper(this._callback);

  final UnhighlightCallback _callback;

  @JSExport()
  JSVoid call(MouseEvent event) => _callback(event);
  @override
  List<Object> get props => [_callback];
}
