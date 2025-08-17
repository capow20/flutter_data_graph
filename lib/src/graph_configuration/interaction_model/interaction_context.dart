import 'dart:js_interop';

import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// This class is not documented by dygraph, use at your own risk.
///
/// Altering the values of this context can have unintended effects, so proceed with caution.
///
/// This is a very simple mock-up of the context object passed to interaction handlers.
///
/// See [dygraph-interaction-model.js.html](https://dygraphs.com/jsdoc/symbols/src/src_dygraph-interaction-model.js.html) or [dygraph.js source](https://dygraphs.com/2.2.1/dist/dygraph.js) for examples
extension type InteractionContext._(JSObject object) implements JSObject {
  external factory InteractionContext({
    JSBoolean? isZooming,
    JSBoolean? isPanning,
    JSBoolean? is2DPan,
    JSNumber? dragStartX,
    JSNumber? dragStartY,
    JSNumber? dragEndX,
    JSNumber? dragEndY,
    JSNumber? dragDirection,
    JSNumber? prevEndX,
    JSNumber? prevEndY,
    JSNumber? prevDragDirection,
    JSBoolean? cancelNextDblclick,
    JSNumber? initialLeftMostDate,
    JSNumber? xUnitsPerPixel,
    JSNumber? dateRange,
    JSNumber? px,
    JSNumber? py,
    JSNumber? boundedDates,
    JSObject? boundedValues,
    JSBoolean? zoomMoved,
  });

  @JS('isZooming')
  external JSBoolean? _isZooming;
  bool? get isZooming => _isZooming?.toDart;
  set isZooming(bool? v) => _isZooming = v?.toJS;

  @JS('isPanning')
  external JSBoolean? _isPanning;
  bool? get isPanning => _isPanning?.toDart;
  set isPanning(bool? v) => _isPanning = v?.toJS;

  @JS('is2DPan')
  external JSBoolean? _is2DPan;
  bool? get is2DPan => _is2DPan?.toDart;
  set is2DPan(bool? v) => _is2DPan = v?.toJS;

  @JS('dragStartX')
  external JSNumber? _dragStartX;
  double? get dragStartX => _dragStartX?.toDartDouble;
  set dragStartX(double? v) => _dragStartX = v?.toJS;

  @JS('dragStartY')
  external JSNumber? _dragStartY;
  double? get dragStartY => _dragStartY?.toDartDouble;
  set dragStartY(double? v) => _dragStartY = v?.toJS;

  @JS('dragEndX')
  external JSNumber? _dragEndX;
  double? get dragEndX => _dragEndX?.toDartDouble;
  set dragEndX(double? v) => _dragEndX = v?.toJS;

  @JS('dragEndY')
  external JSNumber? _dragEndY;
  double? get dragEndY => _dragEndY?.toDartDouble;
  set dragEndY(double? v) => _dragEndY = v?.toJS;

  @JS('dragDirection')
  external JSNumber? _dragDirection;
  DragDirection? get dragDirection => DragDirection.fromJSNumber(_dragDirection);
  set dragDirection(DragDirection? v) => v?.toJS;

  @JS('prevEndX')
  external JSNumber? _prevEndX;
  double? get prevEndX => _prevEndX?.toDartDouble;
  set prevEndX(double? v) => _prevEndX = v?.toJS;

  @JS('prevEndY')
  external JSNumber? _prevEndY;
  double? get prevEndY => _prevEndY?.toDartDouble;
  set prevEndY(double? v) => _prevEndY = v?.toJS;

  @JS('prevDragDirection')
  external JSNumber? _prevDragDirection;
  DragDirection? get prevDragDirection => DragDirection.fromJSNumber(_prevDragDirection);
  set prevDragDirection(DragDirection? v) => v?.toJS;

  @JS('cancelNextDblclick')
  external JSBoolean? _cancelNextDblclick;
  bool? get cancelNextDblclick => _cancelNextDblclick?.toDart;
  set cancelNextDblclick(bool? v) => _cancelNextDblclick = v?.toJS;

  @JS('initialLeftMostDate')
  external JSNumber? _initialLeftMostDate;
  double? get initialLeftMostDate => _initialLeftMostDate?.toDartDouble;
  set initialLeftMostDate(double? v) => _initialLeftMostDate = v?.toJS;

  @JS('xUnitsPerPixel')
  external JSNumber? _xUnitsPerPixel;
  double? get xUnitsPerPixel => _xUnitsPerPixel?.toDartDouble;
  set xUnitsPerPixel(double? v) => _xUnitsPerPixel = v?.toJS;

  @JS('dateRange')
  external JSNumber? _dateRange;
  double? get dateRange => _dateRange?.toDartDouble;
  set dateRange(double? v) => _dateRange = v?.toJS;

  @JS('px')
  external JSNumber? _px;
  double? get px => _px?.toDartDouble;
  set px(double? v) => _px = v?.toJS;

  @JS('py')
  external JSNumber? _py;
  double? get py => _py?.toDartDouble;
  set py(double? v) => _py = v?.toJS;

  @JS('boundedDates')
  external JSNumber? _boundedDates;
  double? get boundedDates => _boundedDates?.toDartDouble;
  set boundedDates(double? v) => _boundedDates = v?.toJS;

  @JS('boundedValues')
  external JSObject? _boundedValues;
  List<double>? get boundedValues =>
      _boundedValues == null ? null : JSArray.from<JSNumber>(_boundedValues!).toDoubleList;
  set boundedValues(List<double>? v) => v?.map((e) => e.toJS).toList().toJS;

  @JS('zoomMoved')
  external JSBoolean? _zoomMoved;
  bool? get zoomMoved => _zoomMoved?.toDart;
  set zoomMoved(bool? v) => _zoomMoved = v?.toJS;
}

enum DragDirection {
  horizontal,
  vertical;

  static DragDirection? fromJSNumber(JSNumber? num) {
    try {
      if (num == null) return null;
      final int dart = num.toDartInt;
      return switch (dart) {
        1 => DragDirection.horizontal,
        2 => DragDirection.vertical,
        _ => null,
      };
    } on Exception catch (_) {}

    return null;
  }

  JSNumber get toJS {
    return switch (this) {
      DragDirection.horizontal => 1,
      DragDirection.vertical => 2,
    }.toJS;
  }
}
