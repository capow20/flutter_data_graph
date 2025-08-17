import 'dart:js_interop';
import 'dart:js_interop_unsafe';

typedef AxisRange = ({double min, double max});

extension JSAxisRange on AxisRange {
  JSObject get toJS {
    return JSObject()
      ..setProperty('min'.toJS, min.toJS)
      ..setProperty('max'.toJS, max.toJS);
  }
}
