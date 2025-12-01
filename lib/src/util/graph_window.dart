import 'dart:js_interop';

import 'package:flutter_data_graph/src/graph_configuration/circle_configuration/circle_configuration.dart';
import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';
import 'package:web/web.dart';

extension type DataGraphIFrameWindow(Window window) implements Window {
  external void initGraph(JSArray<JSArray<JSNumber?>> data, JSGraphConfiguration config);

  external void updateConfig(JSGraphConfiguration config);

  external void updateData(JSArray<JSArray<JSNumber?>> data);

  external void zoom(JSObject xRange, JSObject yRange);

  external void circlePoint(JSNumber x, JSNumber y, JSBoolean persist, JSCircleConfiguration config);

  external void clearCircledPoint(JSNumber x, JSNumber y);

  external void clearAllCircledPoints();

  external JSObject yAxisExtremes();
  external JSObject visibleYAxisRange();

  external JSObject xAxisExtremes();
  external JSObject visibleXAxisRange();

  external void dispose();
}
