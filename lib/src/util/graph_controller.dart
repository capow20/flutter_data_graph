import 'dart:js_interop';
import 'dart:math';
import 'dart:ui';
import 'dart:ui_web';

import 'package:flutter/widgets.dart';
import 'package:flutter_data_graph/src/graph_configuration/circle_configuration/circle_configuration.dart';
import 'package:flutter_data_graph/src/graph_configuration/graph_configuration.dart';
import 'package:flutter_data_graph/src/util/graph_window.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';
import 'package:uuid/uuid.dart';
import 'package:web/web.dart';

/// Controller used to interact with the graph and its data.
///
/// Use [double.nan] to insert breaks in a series's line.
class GraphController {
  GraphController({
    required List<List<num?>> data,
    required GraphConfiguration config,
  }) {
    final origin = window.location.origin;

    final HTMLIFrameElement iframe = HTMLIFrameElement()
      ..id = _graphId
      ..src = '$origin/assets/packages/flutter_data_graph/lib/src/js/index.html'
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%'
      ..style.margin = '0px'
      ..style.padding = '0px'
      ..style.backgroundColor = '#FFFFFF';

    // When iframe loads, grab reference to content window and initialize the graph
    iframe.addEventListener(
      'load',
      ((JSAny event) {
        _contentWindow = DataGraphIFrameWindow(iframe.contentWindow!);
        _initGraph(data: data, config: config);
      }).toJS,
    );

    PlatformViewRegistry().registerViewFactory('platform-view-$_graphId', (int id) => iframe);
  }

  bool ready = false;

  final String _graphId = const Uuid().v4();

  late final DataGraphIFrameWindow _contentWindow;

  late GraphConfiguration _config;
  GraphConfiguration get config => _config;

  Widget get graph => HtmlElementView(viewType: 'platform-view-$_graphId');

  /// Retrieves the full y-axis range of the graph.
  ///
  /// If both [GraphConfiguration.minY] and [GraphConfiguration.maxY] were specified, they will be returned here.
  ///
  /// If not, the provided value along with the automatically calculated value from `Dygraph.yAxisExtremes()[0]` will be returned instead.
  List<double> get yAxisExtremes => JSArray.from<JSNumber>(_contentWindow.yAxisExtremes()).toDoubleList;

  /// Retrieves the visible y-axis range of the graph.
  ///
  /// `Dygraph.yAxisRange()`
  List<double> get visibleYAxisRange => JSArray.from<JSNumber>(_contentWindow.visibleYAxisRange()).toDoubleList;

  /// Retrieves the full y-axis range of the graph.
  ///
  /// `Dygraph.xAxisExtremes()`
  List<double> get xAxisExtremes => JSArray.from<JSNumber>(_contentWindow.xAxisExtremes()).toDoubleList;

  /// Retrieves the visible x-axis range of the graph.
  ///
  /// `Dygraph.xAxisRange()`
  List<double> get visibleXAxisRange => JSArray.from<JSNumber>(_contentWindow.visibleXAxisRange()).toDoubleList;

  /// Initializes the graph with the provided data and configuration.
  ///
  /// [data] must be a 2D array, with each data point represented in the format: [x, y1, y2, y3, ...]
  ///
  /// Values provided for x-axis must not be null.
  void _initGraph({
    required List<List<num?>> data,
    required GraphConfiguration config,
  }) {
    _config = config;
    _contentWindow.initGraph(data.toJS, _config.toJS);
  }

  /// Updates the configuration for the graph without altering the dataset.
  ///
  /// Used to update configuration after graph has been initialized.
  void updateConfig({required GraphConfiguration config}) {
    _config = config;
    _contentWindow.updateConfig(_config.toJS);
  }

  /// Updates the data set shown in the graph without altering configuration.
  ///
  /// Used to update data after graph has been initialized.
  ///
  /// Values provided for x-axis must not be null.
  void updateData({required List<List<num?>> data}) {
    _contentWindow.updateData(data.toJS);
  }

  /// Focuses the graph on the specified axis ranges.
  ///
  /// If [GraphConfiguration.reverseScale] is true, be sure that min > max for [yRange].
  ///
  /// Automatically clamps the values of [xRange] and [yRange] between [xAxisExtremes] and [yAxisExtremes]
  /// respectively to ensure a range within bounds is selected.
  void zoom(AxisRange xRange, AxisRange yRange) {
    final [bX, tX] = xAxisExtremes;
    final [bY, tY] = yAxisExtremes;
    final minX = min(bX, tX);
    final maxX = max(bX, tX);
    final minY = min(bY, tY);
    final maxY = max(bY, tY);
    final clampedX = (min: clampDouble(xRange.min, minX, maxX), max: clampDouble(xRange.max, minX, maxX));
    final clampedY = (min: clampDouble(yRange.min, minY, maxY), max: clampDouble(yRange.max, minY, maxY));

    _contentWindow.zoom(clampedX.toJS, clampedY.toJS);
  }

  /// Draws a circle centered on the provided [x] and [y] coordinates.
  ///
  /// Set [persist] to false if you want the circle to automatically disappear when the user zooms or pans
  ///
  /// If you wish to zoom in on the circle being drawn, either zoom first then circle the point, or ensure persist is true.
  void circlePoint({
    required double x,
    required double y,
    bool persist = true,
    CircleConfiguration config = const CircleConfiguration(),
  }) => _contentWindow.circlePoint(x.toJS, y.toJS, persist.toJS, config.toJS);

  /// Clears the drawn circle centered on the provided [x] and [y] coordinates.
  ///
  /// Only clears circles drawn with persist set to true.
  void clearCircledPoint({required double x, required double y}) => _contentWindow.clearCircledPoint(x.toJS, y.toJS);

  /// Clears all circles drawn with persist set to true.
  void clearAllCircledPoints() => _contentWindow.clearAllCircledPoints();

  void dispose() {
    _contentWindow.dispose();
    document.getElementById(_graphId)?.remove();
  }
}
