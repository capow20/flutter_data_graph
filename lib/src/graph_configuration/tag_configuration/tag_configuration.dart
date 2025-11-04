import 'dart:js_interop';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/src/graph_configuration/tag_configuration/tag_click_handler.dart';
import 'package:flutter_data_graph/src/util/js_extensions.dart';

/// Configuration for tags drawn on the graph's canvas.
///
/// Tags are drawn in the shape of rectangle (tag) on top of a stick (pin).
class TagConfiguration extends Equatable {
  const TagConfiguration({
    required this.xValue,
    required this.color,
    required this.backgroundColor,
    this.strokeColor,
    this.strokeWidth = 1.0,
    this.text = '\uf129',
    this.font = '900 16px "Font Awesome 6 Free"',
    this.tagShape = TagShape.rectangle,
    this.tagHeight = 22,
    this.tagWidth = 22,
    this.pinHeight = 7,
    this.pinWidth = 1,
    this.onTap,
    this.showTooltip = false,
    this.tooltipHtml = '',
    this.tooltipFontSize = '12px',
    this.tooltipFontFamily = '',
    this.tooltipColor = Colors.black,
    this.tooltipBackgroundColor = Colors.white,
    this.tooltipPadding = '3px 6px',
    this.tooltipBorder = '',
    this.tooltipBorderRadius = '0px',
  });

  /// The value along the x-axis at which the tag will be centered.
  final double xValue;

  /// The color to use for [text].
  final Color color;

  /// The color of the tag and pin that [text] will be drawn on.
  final Color backgroundColor;

  /// The color of the border surrounding the tag
  final Color? strokeColor;

  /// The thickness of the border surrounding the tag
  final double strokeWidth;

  /// The text to be drawn on the tag using {ctx.fillText()}
  /// Default value represents the unicode for info icon from font awesome's free collection (fa-info)
  final String text;

  /// The font to be used for the text drawn on the tag.
  /// Defaults to 900 weight 16px Font Awesome 6 Free to allow unicode icons to work
  final String font;

  /// The shape the tag will be drawn with.
  final TagShape tagShape;

  /// The height of the rectangular tag in pixels
  final double tagHeight;

  /// The width of the rectangular tag in pixels
  final double tagWidth;

  /// The height of the pin that connects the tag to the base of the graph in pixels
  final double pinHeight;

  /// The width of the pin that connects the tag to the base of the graph in pixels
  final double pinWidth;

  /// Called when this tag is clicked/tapped.
  final TagClickHandler? onTap;

  /// Whether or not a tooltip should be shown when this tag is hovered over.
  final bool showTooltip;

  /// The html to display within the tooltip.
  final String tooltipHtml;

  /// The font size to use for the tooltip's text.
  final String tooltipFontSize;

  /// The font family to use for the tooltip's text.
  final String tooltipFontFamily;

  /// The color to use for the tooltip's text.
  final Color tooltipColor;

  /// The background color of the tooltip.
  final Color tooltipBackgroundColor;

  /// The CSS string representing the tooltip's padding.
  final String tooltipPadding;

  /// The CSS string representing the tooltip's border.
  final String tooltipBorder;

  /// The CSS string representing the tooltip's border radius.
  final String tooltipBorderRadius;

  JSTagConfiguration get toJS => JSTagConfiguration(
    xValue: xValue,
    color: color.toCSS,
    backgroundColor: backgroundColor.toCSS,
    strokeColor: strokeColor?.toCSS,
    strokeWidth: strokeWidth,
    text: text,
    font: font,
    tagShape: tagShape.toString(),
    tagHeight: tagHeight,
    tagWidth: tagWidth,
    pinHeight: pinHeight,
    pinWidth: pinWidth,
    onTap: onTap == null ? null : createJSInteropWrapper(TagClickHandlerWrapper(onTap!)),
    showTooltip: showTooltip,
    tooltipHtml: tooltipHtml,
    tooltipFontSize: tooltipFontSize,
    tooltipFontFamily: tooltipFontFamily,
    tooltipColor: tooltipColor.toCSS,
    tooltipBackgroundColor: tooltipBackgroundColor.toCSS,
    tooltipPadding: tooltipPadding,
    tooltipBorder: tooltipBorder,
    tooltipBorderRadius: tooltipBorderRadius,
  );

  @override
  List<Object?> get props => [
    xValue,
    color,
    backgroundColor,
    strokeColor,
    strokeWidth,
    text,
    font,
    tagHeight,
    tagWidth,
    pinHeight,
    pinWidth,
    onTap,
    showTooltip,
    tooltipHtml,
    tooltipFontSize,
    tooltipFontFamily,
    tooltipColor,
    tooltipBackgroundColor,
    tooltipPadding,
    tooltipBorder,
    tooltipBorderRadius,
  ];
}

enum TagShape {
  rectangle,
  triangle;

  @override
  String toString() => switch (this) {
    TagShape.rectangle => 'Rectangle',
    TagShape.triangle => 'Triangle',
  };
}

extension type JSTagConfiguration._(JSObject _) implements JSObject {
  external factory JSTagConfiguration({
    required double xValue,
    required String color,
    required String backgroundColor,
    required String? strokeColor,
    required double strokeWidth,
    required String text,
    required String font,
    required String tagShape,
    required double tagHeight,
    required double tagWidth,
    required double pinHeight,
    required double pinWidth,
    required JSAny? onTap,
    required bool showTooltip,
    required String tooltipHtml,
    required String tooltipFontSize,
    required String tooltipFontFamily,
    required String tooltipColor,
    required String tooltipBackgroundColor,
    required String tooltipPadding,
    required String tooltipBorder,
    required String tooltipBorderRadius,
  });
}
