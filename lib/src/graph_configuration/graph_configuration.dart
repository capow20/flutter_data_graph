import 'dart:js_interop';
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/graph_configuration/axis_configuration/axis_configuration.dart';
import 'package:flutter_data_graph/src/graph_configuration/axis_configuration/axis_value_formatter.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/draw_callback.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/graph_click_callback.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/highlight_callback.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/point_click_callback.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/underlay_callback.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/unhighlight_callback.dart';
import 'package:flutter_data_graph/src/graph_configuration/callbacks/zoom_callback.dart';
import 'package:flutter_data_graph/src/graph_configuration/extra_line_configuration/extra_line_configuration.dart';
import 'package:flutter_data_graph/src/graph_configuration/interaction_model/interaction_handler.dart';
import 'package:flutter_data_graph/src/graph_configuration/legend_configuration/legend_configuration.dart';
import 'package:flutter_data_graph/src/graph_configuration/series_configuration/series_configuration.dart';
import 'package:flutter_data_graph/src/graph_configuration/tag_configuration/tag_configuration.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Configuration for many aspects of the graph.
///
/// Used to update everything except data for the graph.
class GraphConfiguration extends Equatable {
  const GraphConfiguration({
    //! ===== X-AXIS ===== //
    required this.xLabel,
    this.xRangePad,
    this.xAxisConfig,
    //! ===== Y-AXIS ===== //
    this.minY,
    this.maxY,
    this.reverseScale = false,
    this.yRangePad,
    this.yAxisConfig,
    required this.series,
    //! ===== GENERIC ===== //
    this.valueFormatter,
    this.rightGap = 5,
    this.showZeroValueLabels = false,
    this.connectSeparatedPoints = false,
    this.backgroundColor = Colors.white,
    this.highlightSeriesOpts,
    this.highlightSeriesBackgroundColor = Colors.white,
    this.highlightSeriesBackgroundAlpha = 0.5,
    //! ===== LEGEND ===== //
    this.legendConfig,
    //! ===== EXTRA LINES ===== //
    this.extraLines = const [],
    //! ===== TAGS ===== //
    this.tags = const [],
    //! ===== CALLBACKS ===== //
    this.clickCallback,
    this.pointClickCallback,
    this.highlightCallback,
    this.unhighlightCallback,
    this.drawCallback,
    this.zoomCallback,
    this.underlayCallback,
    //!===== INTERACTION MODEL ===== //
    this.mouseupHandler,
  });

  //! ===== X-AXIS ===== //
  /// The label for the x-axis.
  final String xLabel;

  /// The amount of padding in pixels to apply to both sides of the x-axis.
  ///
  /// Useful for keeping data points on the edge of the graph visible.
  final double? xRangePad;

  /// Configuration for the graph's x-axis.
  final AxisConfiguration? xAxisConfig;

  //! ===== Y-AXIS ===== //
  /// The minimum value to be displayed on the y-axis.
  ///
  /// If specified, will always be used as the start value of the y-axis.
  final double? minY;

  /// The maximum value to be displayed on the y-axis.
  ///
  /// If specified, will always be used as the end value of the y-axis.
  ///
  /// If specified alongside [AxisConfiguration.withIncrement], slightly increase this value
  /// or add a small [yRangePad] to ensure the final tick mark is drawn.
  final double? maxY;

  /// Whether the y-axis should decrease in value as it goes up the screen.
  ///
  /// If both [minY] and [maxY] are specified, this value has no effect.
  ///
  /// This value should only be set to true when either [minY], [maxY], or both are left unspecified.
  final bool reverseScale;

  /// The amount of padding in pixels to apply to both sides of the y-axis.
  ///
  /// 10% of the y-axis height is added automatically if both [minY] and [maxY] are unspecified and this value is null.
  ///
  /// Pass zero explicitly if you would like to have no padding at all.
  final double? yRangePad;

  /// Configuration for the graph's y-axis.
  final AxisConfiguration? yAxisConfig;

  /// Per-series configuration. See [SeriesConfiguration]
  final List<SeriesConfiguration> series;

  //! ===== GENERIC ===== //
  /// Callback to format values displayed on mouseover.
  /// Can be overwritten on a per-axis basis with [xAxisConfig] and [yAxisConfig].
  final AxisValueFormatter? valueFormatter;

  /// Number of pixels of empty space to the right of graph.
  final double rightGap;

  /// Whether zero values should be displayed in the label.
  final bool showZeroValueLabels;

  /// Whether or not gaps (missing data points in a series) should be connected.
  ///
  /// Use [double.nan] to explicitly connect a gap with this set to false.
  final bool connectSeparatedPoints;

  /// The background color of the graph.
  final Color backgroundColor;

  /// Applied to the series closest to the mouse pointer for interactive highlighting
  ///
  /// Consider using [SeriesConfiguration.highlight] to construct this value.
  final SeriesConfiguration? highlightSeriesOpts;

  /// The color to apply over the background (everything except highlighted series) when [highlightSeriesOpts] is provided.
  final Color highlightSeriesBackgroundColor;

  /// The alpha value for the background
  ///
  ///  1=fully visible background (disable fading), 0=hiddden background (show highlighted series only)
  final double highlightSeriesBackgroundAlpha;

  //! ===== LEGEND ===== //
  /// Configuration for the graph's legend.
  final LegendConfiguration? legendConfig;

  //! ===== EXTRA LINES ===== //
  /// Additional lines outside of dataset to be drawn at constant y-values;
  final List<ExtraLineConfiguration> extraLines;

  //! ===== TAGS ===== //
  /// Simple tags drawn on the canvas to provide additional context to certain points on the graph.
  final List<TagConfiguration> tags;

  //! ===== CALLBACKS ===== //

  /// Called when the graph is clicked.
  ///
  /// Clicking a tag will not call this function.
  final GraphClickCallback? clickCallback;

  /// Called when a specific point on the graph is clicked.
  final PointClickCallback? pointClickCallback;

  /// Called each time a new point is highlighted.
  ///
  /// If [highlightSeriesOpts] is left null, series will be null.
  final HighlightCallback? highlightCallback;

  /// Called each time the user stops highlighting any point by mousing out of the graph.
  final UnhighlightCallback? unhighlightCallback;

  /// Called each time the graph is drawn.
  ///
  /// Initial draw, after each zoom, and repeatedly while panning.
  final DrawCallback? drawCallback;

  /// Called after each zoom.
  ///
  /// An array of `[min, max]` will be present for each y-axis
  final ZoomCallback? zoomCallback;

  /// Called before each time the graph is drawn.
  ///
  /// Allows you to draw on the graph's canvas before the graph itself is drawn.
  ///
  /// [tags] and [extraLines] are drawn just before this callback.
  final UnderlayCallback? underlayCallback;

  //! ===== INTERACTION MODEL ===== //
  //! All interaction handlers are risky and can have unintended consequences. It is HIGHLY recommended to use one of the other callbacks if possible.

  /// Called upon each mouseup event within the graph.
  final InteractionHandler? mouseupHandler;

  GraphConfiguration copyWith({
    //! ===== X-AXIS ===== //
    String? xLabel,
    double? xRangePad,
    AxisConfiguration? xAxisConfig,
    //! ===== Y-AXIS ===== //
    double? minY,
    double? maxY,
    bool? reverseScale,
    double? yRangePad,
    AxisConfiguration? yAxisConfig,
    List<SeriesConfiguration>? series,
    //! ===== GENERIC ===== //
    AxisValueFormatter? valueFormatter,
    double? rightGap,
    bool? showZeroValueLabels,
    bool? connectSeparatedPoints,
    Color? backgroundColor,
    SeriesConfiguration? highlightSeriesOpts,
    Color? highlightSeriesBackgroundColor,
    double? highlightSeriesBackgroundAlpha,
    //! ===== LEGEND ===== //
    LegendConfiguration? legendConfig,
    //! ===== EXTRA LINES ===== //
    List<ExtraLineConfiguration>? extraLines,
    //! ===== TAGS ===== //
    List<TagConfiguration>? tags,
    //! ===== CALLBACKS ===== //
    GraphClickCallback? clickCallback,
    PointClickCallback? pointClickCallback,
    HighlightCallback? highlightCallback,
    UnhighlightCallback? unhighlightCallback,
    DrawCallback? drawCallback,
    ZoomCallback? zoomCallback,
    UnderlayCallback? underlayCallback,
    //! ===== INTERACTION MODEL ===== //
    InteractionHandler? mouseupHandler,
  }) => GraphConfiguration(
    //! ===== X-AXIS ===== //
    xLabel: xLabel ?? this.xLabel,
    xRangePad: xRangePad ?? this.xRangePad,
    xAxisConfig: xAxisConfig ?? this.xAxisConfig,
    //! ===== Y-AXIS ===== //
    minY: minY ?? this.minY,
    maxY: maxY ?? this.maxY,
    reverseScale: reverseScale ?? this.reverseScale,
    yRangePad: yRangePad ?? this.yRangePad,
    yAxisConfig: yAxisConfig ?? this.yAxisConfig,
    series: series ?? this.series,
    //! ===== GENERIC ===== //
    valueFormatter: valueFormatter ?? this.valueFormatter,
    rightGap: rightGap ?? this.rightGap,
    showZeroValueLabels: showZeroValueLabels ?? this.showZeroValueLabels,
    connectSeparatedPoints: connectSeparatedPoints ?? this.connectSeparatedPoints,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    highlightSeriesOpts: highlightSeriesOpts ?? this.highlightSeriesOpts,
    highlightSeriesBackgroundColor: highlightSeriesBackgroundColor ?? this.highlightSeriesBackgroundColor,
    highlightSeriesBackgroundAlpha: highlightSeriesBackgroundAlpha ?? this.highlightSeriesBackgroundAlpha,
    //! ===== LEGEND ===== //
    legendConfig: legendConfig ?? this.legendConfig,
    //! ===== EXTRA LINES ===== //
    extraLines: extraLines ?? this.extraLines,
    //! ===== TAGS ===== //
    tags: tags ?? this.tags,
    //! ===== CALLBACKS ===== //
    clickCallback: clickCallback ?? this.clickCallback,
    pointClickCallback: pointClickCallback ?? this.pointClickCallback,
    highlightCallback: highlightCallback ?? this.highlightCallback,
    unhighlightCallback: unhighlightCallback ?? this.unhighlightCallback,
    drawCallback: drawCallback ?? this.drawCallback,
    zoomCallback: zoomCallback ?? this.zoomCallback,
    underlayCallback: underlayCallback ?? this.underlayCallback,
    //! ===== INTERACTION MODEL ===== //
    mouseupHandler: mouseupHandler ?? this.mouseupHandler,
  );

  JSGraphConfiguration get toJS => JSGraphConfiguration(
    xLabel: xLabel,
    xRangePad: xRangePad,
    xAxisConfig: xAxisConfig?.toJS,
    minY: minY,
    maxY: maxY,
    yRangePad: yRangePad,
    yAxisConfig: yAxisConfig?.toJS,
    series: [...series.map((e) => e.toJS)].toJS,
    valueFormatter: valueFormatter == null ? null : createJSInteropWrapper(AxisValueFormatterWrapper(valueFormatter!)),
    rightGap: rightGap,
    showZeroValueLabels: showZeroValueLabels,
    connectSeparatedPoints: connectSeparatedPoints,
    backgroundColor: backgroundColor.toCSS,
    highlightSeriesOpts: highlightSeriesOpts?.toJS,
    highlightSeriesBackgroundColor: highlightSeriesBackgroundColor.toCSS,
    highlightSeriesBackgroundAlpha: clampDouble(highlightSeriesBackgroundAlpha, 0, 1),
    legendConfig: legendConfig?.toJS,
    reverseScale: reverseScale,
    extraLines: extraLines.map((e) => e.toJS).toList().toJS,
    tags: tags.map((e) => e.toJS).toList().toJS,
    clickCallback: clickCallback == null ? null : createJSInteropWrapper(GraphClickCallbackWrapper(clickCallback!)),
    pointClickCallback: pointClickCallback == null
        ? null
        : createJSInteropWrapper(PointClickCallbackWrapper(pointClickCallback!)),
    highlightCallback: highlightCallback == null
        ? null
        : createJSInteropWrapper(HighlightCallbackWrapper(highlightCallback!)),
    unhighlightCallback: unhighlightCallback == null
        ? null
        : createJSInteropWrapper(UnhighlightCallbackWrapper(unhighlightCallback!)),
    drawCallback: drawCallback == null ? null : createJSInteropWrapper(DrawCallbackWrapper(drawCallback!)),
    zoomCallback: zoomCallback == null ? null : createJSInteropWrapper(ZoomCallbackWrapper(zoomCallback!)),
    underlayCallback: underlayCallback == null
        ? null
        : createJSInteropWrapper(UnderlayCallbackWrapper(underlayCallback!)),
    mouseupHandler: mouseupHandler == null ? null : createJSInteropWrapper(InteractionHandlerWrapper(mouseupHandler!)),
  );

  @override
  List<Object?> get props => [
    xLabel,
    xRangePad,
    xAxisConfig,
    minY,
    maxY,
    reverseScale,
    yRangePad,
    yAxisConfig,
    series,
    valueFormatter,
    rightGap,
    showZeroValueLabels,
    connectSeparatedPoints,
    backgroundColor,
    highlightSeriesOpts,
    highlightSeriesBackgroundColor,
    highlightSeriesBackgroundAlpha,
    legendConfig,
    extraLines,
    tags,
    clickCallback,
    pointClickCallback,
    highlightCallback,
    unhighlightCallback,
    drawCallback,
    zoomCallback,
    underlayCallback,
    mouseupHandler,
  ];
}

extension type JSGraphConfiguration._(JSObject _) implements JSObject {
  external factory JSGraphConfiguration({
    required String xLabel,
    required double? xRangePad,
    required JSAxisConfiguration? xAxisConfig,
    required double? minY,
    required double? maxY,
    required bool reverseScale,
    required double? yRangePad,
    required JSAxisConfiguration? yAxisConfig,
    required JSArray<JSSeriesConfiguration> series,
    required JSObject? valueFormatter,
    required double rightGap,
    required bool showZeroValueLabels,
    required bool connectSeparatedPoints,
    required String backgroundColor,
    required JSSeriesConfiguration? highlightSeriesOpts,
    required String? highlightSeriesBackgroundColor,
    required double? highlightSeriesBackgroundAlpha,
    required JSLegendConfiguration? legendConfig,
    required JSArray<JSExtraLineConfiguration> extraLines,
    required JSArray<JSTagConfiguration> tags,
    required JSObject? clickCallback,
    required JSObject? pointClickCallback,
    required JSObject? highlightCallback,
    required JSObject? unhighlightCallback,
    required JSObject? drawCallback,
    required JSObject? zoomCallback,
    required JSObject? underlayCallback,
    required JSObject? mouseupHandler,
  });
}
