import 'dart:js_interop';

import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';
import 'package:flutter_data_graph/src/util/graph_controller.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

extension type Dygraph._(JSObject _) implements JSObject {
  //! ========== DOM Coords => Data Coords ========== //
  @JS('toDataCoords')
  external JSObject _toDataCoords(JSNumber x, JSNumber y, JSNumber axis);

  /// Converts from canvas/div coordinates to data coordinates along the specified axis.
  ///
  /// If [axis] is left null, the primary y-axis will be used.
  ///
  /// Use toDomXCoord instead of toDomCoords(x, null) and use toDomYCoord instead of toDomCoords(null, y, axis).
  List<double> toDataCoords(double x, double y, {int axis = 0}) {
    final JSObject jsCoords = _toDataCoords(x.toJS, y.toJS, axis.toJS);

    return JSArray.from<JSNumber>(jsCoords).toDoubleList;
  }

  @JS('toDataXCoord')
  external JSNumber _toDataXCoord(JSNumber x);

  /// Converts a canvas/div x coordinate to a data x coordinate.
  double toDataXCoord(double x) => _toDataXCoord(x.toJS).toDartDouble;

  @JS('toDataYCoord')
  external JSNumber _toDataYCoord(JSNumber y, JSNumber? axis);

  /// Converts a canvas/div y coordinate to a data y coordinate along the specified axis.
  ///
  /// If axis is left null, the primary y-axis will be used.
  double toDataYCoord(double y, {int axis = 0}) => _toDataYCoord(y.toJS, axis.toJS).toDartDouble;

  //! ========== Data Coords => DOM Coords ========== //
  @JS('toDomCoords')
  external JSObject _toDomCoords(JSNumber x, JSNumber y, JSNumber axis);

  /// Converts from data coordinates to canvas/div coordinates.
  ///
  /// If [axis] is left null, the primary y-axis will be used.
  ///
  /// Use toDomXCoord instead of toDomCoords(x, null) and use toDomYCoord instead of toDomCoords(null, y, axis)
  List<double> toDomCoords(double x, double y, {int axis = 0}) =>
      JSArray.from<JSNumber>(_toDomCoords(x.toJS, y.toJS, axis.toJS)).toDoubleList;

  @JS('toDomXCoord')
  external JSNumber _toDomXCoord(JSNumber x);

  /// Converts a data x coordinate to a canvas/div x coordinate.
  double toDomXCoord(double x) => _toDomXCoord(x.toJS).toDartDouble;

  @JS('toDomYCoord')
  external JSNumber _toDomYCoord(JSNumber y, JSNumber axis);

  /// Converts a data y coordinate to a canvas/div y coordinate along the specified axis.
  ///
  /// If axis is left null, the primary y-axis will be used.
  double toDomYCoord(double y, {int axis = 0}) => _toDomYCoord(y.toJS, axis.toJS).toDartDouble;

  //! ========== Axis Ranges ========== //
  @JS('xAxisExtremes')
  external JSObject _xAxisExtremes();

  /// Returns the lower and upper x-axis bounds for the data set.
  List<double> xAxisExtremes() => JSArray.from<JSNumber>(_xAxisExtremes()).toDoubleList;

  @JS('xAxisRange')
  external JSObject _xAxisRange();

  /// Returns the currently visible x-axis range.
  List<double> xAxisRange() => JSArray.from<JSNumber>(_xAxisRange()).toDoubleList;

  @JS('yAxisExtremes')
  external JSObject _yAxisExtremes();

  /// Gets the lower and upper y-axis bounds for each axis.
  ///
  /// This value will be different than what is returned by [GraphController.yAxisExtremes] if you set [GraphConfiguration.minY] or [GraphConfiguration.maxY]
  ///
  /// Returns a list of `[low, high]`, one for each y-axis.
  List<List<double>> yAxisExtremes() =>
      JSArray.from<JSObject>(_yAxisExtremes()).toDart.map((e) => JSArray.from<JSNumber>(e).toDoubleList).toList();

  @JS('yAxisRange')
  external JSObject _yAxisRange(JSNumber axis);

  /// Returns the currently visible y-axis range for the specified axis.
  ///
  /// If axis is left null, the primary y-axis will be used.
  List<double> yAxisRange({int axis = 0}) => JSArray.from<JSNumber>(_yAxisRange(axis.toJS)).toDoubleList;

  //! ========== MISC ========== //
  @JS('clearZoomRect_')
  external JSVoid clearZoomRect();
}
