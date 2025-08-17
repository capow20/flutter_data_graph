import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Configuration for the graph's legend.
class LegendConfiguration extends Equatable {
  const LegendConfiguration({
    this.type = LegendType.mouseOver,
    this.labelsSeparateLines = false,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.color = Colors.black,
    this.left = 'auto',
    this.top = 'auto',
    this.right = 'auto',
    this.bottom = 'auto',
    this.padding = '10px',
    this.border,
    this.borderRadius,
  });

  /// Where and when the graph's legend will appear.
  final LegendType type;

  /// Whether or not to put new lines between each label in the legend.
  final bool labelsSeparateLines;

  /// The background color of the legend.
  final Color backgroundColor;

  /// The color of the label's value text.
  final Color color;

  /// The value to use for legend's `left` CSS property.
  ///
  /// Has no effect when [type] is set to [LegendType.follow]
  final String left;

  /// The value to use for legend's `top` CSS property.
  ///
  /// Has no effect when [type] is set to [LegendType.follow]
  final String top;

  /// The value to use for legend's `left` CSS property.
  ///
  /// Has no effect when [type] is set to [LegendType.follow]
  final String right;

  /// The value to use for legend's `bottom` CSS property.
  ///
  /// Has no effect when [type] is set to [LegendType.follow]
  final String bottom;

  /// The value to use for the legend's `padding` CSS property.
  final String padding;

  /// The value to use for the legend's `border` CSS property.
  final String? border;

  /// The value to use for the legend's `border-radius` CSS property.
  final String? borderRadius;

  JSLegendConfiguration get toJS => JSLegendConfiguration(
    type: type.toJS,
    labelsSeparateLines: labelsSeparateLines,
    backgroundColor: backgroundColor.toCSS,
    color: color.toCSS,
    left: left,
    top: top,
    right: right,
    bottom: bottom,
    padding: padding,
    border: border,
    borderRadius: borderRadius,
  );

  @override
  List<Object?> get props => [
    type,
    labelsSeparateLines,
    backgroundColor,
    color,
    left,
    top,
    right,
    bottom,
    padding,
    border,
    borderRadius,
  ];
}

extension type JSLegendConfiguration._(JSObject _) implements JSObject {
  external factory JSLegendConfiguration({
    required JSString type,
    required bool labelsSeparateLines,
    required String backgroundColor,
    required String color,
    required String left,
    required String top,
    required String right,
    required String bottom,
    required String padding,
    required String? border,
    required String? borderRadius,
  });
}

/// Options to control where and when the graph's legend appears.
enum LegendType {
  /// Legend is always shown.
  always,

  /// Legend will follow highlighted point (mouse).
  follow,

  /// Legend will appear in fixed location when mouse is within graph.
  mouseOver,
  // Legend will never appear.
  never;

  JSString get toJS => switch (this) {
    LegendType.always => 'always',
    LegendType.follow => 'follow',
    LegendType.mouseOver => 'onmouseover',
    LegendType.never => 'never',
  }.toJS;
}
