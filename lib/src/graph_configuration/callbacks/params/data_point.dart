import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter_data_graph/flutter_data_graph.dart';

/// Represents a data point on the graph
///
/// Passed as parameter to certain callback methods
class DataPoint extends Equatable {
  const DataPoint({
    required this.series,
    required this.x,
    required this.y,
  });

  /// The series this data point is associated with
  final String series;

  /// The x value of the data point
  final double x;

  /// The y value of the data point
  ///
  /// In callbacks such as [GraphConfiguration.clickCallback], this value will be [double.nan] if the original data point is null
  final double y;

  JSDataPoint get toJS => JSDataPoint(name: series, xval: x, yval: y);

  @override
  List<Object> get props => [series, x, y];
}

extension type JSDataPoint._(JSObject _) implements JSObject {
  external factory JSDataPoint({
    required String name,
    required double xval,
    required double yval,
  });

  external String get name;
  external double get xval;
  external double get yval;

  DataPoint get toDart => DataPoint(series: name, x: xval, y: yval);
}
