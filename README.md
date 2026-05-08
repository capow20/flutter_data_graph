# flutter_data_graph

[![pub package](https://img.shields.io/pub/v/flutter_data_graph.svg)](https://pub.dev/packages/flutter_data_graph)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-Flutter%20Web-brightgreen.svg)](https://flutter.dev/web)

**Drop-in interactive line & bar charts for Flutter Web — zero JavaScript required.**

A Flutter package that wraps [Dygraph.js](https://dygraphs.com/) via Dart/JS interop, giving you high-performance, interactive numeric charts with a pure-Dart configuration API.

---

## Features

- **Line charts** — smooth, multi-series lines with custom colors, stroke widths, and dotted patterns
- **Bar charts** — switch any series to bars with `SeriesPlotterType.bar` and adjustable `barWidthRatio`
- **Dynamic bar colors** — per-bar coloring via `plotterColorCallback` based on data values
- **Multi-series** — overlay unlimited series on a single chart
- **Zoom & pan** — built-in mouse-driven zoom/pan plus programmatic zoom via `GraphController`
- **Legends** — four legend modes: `always`, `follow` (tracks cursor), `mouseOver`, `never`
- **Tags** — pin markers at x-values with custom shapes, tap handlers, and HTML tooltips
- **Reference lines** — horizontal dashed/solid lines at any y-value via `ExtraLineConfiguration`
- **Circle annotations** — programmatically circle data points with customizable radius, fill, and stroke
- **Axis customization** — tick increments, label formatters, value formatters, grid line styling
- **Tooltips** — rich HTML tooltips on tags with full styling control
- **Callbacks** — click, point click, highlight, unhighlight, draw, zoom, and underlay callbacks
- **Underlay drawing** — draw directly on the canvas behind the chart (shaded regions, custom markers)
- **Coordinate conversion** — convert between data and DOM coordinates via `Dygraph` in callbacks
- **Controller API** — `GraphController` for zoom, circle annotations, axis range queries, and live config/data updates
- **Null & gap handling** — `null` for missing points, `double.nan` for explicit line breaks
- **Reversed y-axis** — flip the y-axis with `reverseScale: true`
- **Connect separated points** — bridge gaps in data with `connectSeparatedPoints: true`
- **Immutable config** — `GraphConfiguration.copyWith()` for reactive state management
- **Draw points** — show data point markers with configurable size

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_data_graph: ^0.1.2
```

Then run:

```sh
flutter pub get
```

---

## Quick Start

A minimal single-series line chart:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_data_graph/flutter_data_graph.dart';

class SimpleLineChart extends StatelessWidget {
  const SimpleLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final data = <List<num>>[
      [0, 5],
      [1, 8],
      [2, 6],
      [3, 10],
      [4, 7],
    ];

    return DataGraph(
      data: data,
      config: const GraphConfiguration(
        xLabel: 'Index',
        series: [
          SeriesConfiguration(
            name: 'Values',
            color: Color(0xFF2196F3),
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
```

---

## Examples

### Multi-Series Line Chart with Legend

Two series with different visual styles and a follow-cursor legend:

```dart
DataGraph(
  data: <List<num>>[
    [0, 10, 3],
    [1, 15, 7],
    [2, 12, 9],
    [3, 18, 5],
    [4, 14, 11],
    [5, 20, 8],
  ],
  config: const GraphConfiguration(
    xLabel: 'Time',
    series: [
      SeriesConfiguration(
        name: 'Temperature',
        color: Color(0xFFE53935),
        strokeWidth: 2.5,
        drawPoints: true,
        pointSize: 3,
      ),
      SeriesConfiguration(
        name: 'Humidity',
        color: Color(0xFF1E88E5),
        strokeWidth: 2,
        strokePattern: [8, 4],
      ),
    ],
    legendConfig: LegendConfiguration(
      type: LegendType.follow,
      labelsSeparateLines: true,
      backgroundColor: Color(0xFFF5F5F5),
      borderRadius: '6px',
      padding: '8px 12px',
    ),
  ),
)
```

### Bar Chart with Dynamic Colors

Color bars green, yellow, or red based on value thresholds:

```dart
DataGraph(
  data: <List<num>>[
    [1, 85],
    [2, 62],
    [3, 91],
    [4, 45],
    [5, 73],
    [6, 30],
    [7, 88],
  ],
  config: GraphConfiguration(
    xLabel: 'Day',
    minY: 0,
    maxY: 100,
    series: [
      SeriesConfiguration(
        name: 'Score',
        color: const Color(0xFF4CAF50),
        plotterType: SeriesPlotterType.bar,
        barWidthRatio: 0.6,
        plotterColorCallback: (x, y) {
          if (y >= 80) return const Color(0xFF4CAF50); // green
          if (y >= 60) return const Color(0xFFFFC107); // yellow
          return const Color(0xFFF44336);              // red
        },
      ),
    ],
  ),
)
```

### Interactive Controller — Zoom & Circle Annotations

Use `onGraphCreated` to get a `GraphController`, then zoom or circle points programmatically:

```dart
class InteractiveChart extends StatefulWidget {
  const InteractiveChart({super.key});

  @override
  State<InteractiveChart> createState() => _InteractiveChartState();
}

class _InteractiveChartState extends State<InteractiveChart> {
  GraphController? _controller;

  final data = <List<num>>[
    [0, 20],  [1, 35],  [2, 28],  [3, 42],  [4, 31],
    [5, 50],  [6, 38],  [7, 55],  [8, 44],  [9, 60],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () => _controller?.zoom(
                (min: 2, max: 7),
                (min: 20, max: 55),
              ),
              child: const Text('Zoom In'),
            ),
            ElevatedButton(
              onPressed: () => _controller?.zoom(
                (min: 0, max: 9),
                (min: 20, max: 60),
              ),
              child: const Text('Reset Zoom'),
            ),
            ElevatedButton(
              onPressed: () => _controller?.circlePoint(
                x: 5,
                y: 50,
                config: const CircleConfiguration(
                  radius: 8,
                  fillColor: Color(0x554CAF50),
                  strokeColor: Color(0xFF4CAF50),
                  strokeWidth: 2,
                ),
              ),
              child: const Text('Circle Peak'),
            ),
            ElevatedButton(
              onPressed: () => _controller?.clearAllCircledPoints(),
              child: const Text('Clear Circles'),
            ),
          ],
        ),
        Expanded(
          child: DataGraph(
            data: data,
            onGraphCreated: (controller) => _controller = controller,
            config: const GraphConfiguration(
              xLabel: 'Step',
              series: [
                SeriesConfiguration(
                  name: 'Measurement',
                  color: Color(0xFF7B1FA2),
                  strokeWidth: 2,
                  drawPoints: true,
                  pointSize: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
```

### Tags, Tooltips & Reference Lines

Mark important x-values with tags, show tooltips on hover, and draw reference lines:

```dart
DataGraph(
  data: <List<num>>[
    [0, 4], [1, 7], [2, 5], [3, 11], [4, 8],
    [5, 6], [6, 9], [7, 12], [8, 10], [9, 7],
  ],
  config: GraphConfiguration(
    xLabel: 'Sample',
    minY: 0,
    maxY: 15,
    series: const [
      SeriesConfiguration(
        name: 'Signal',
        color: Color(0xFF00897B),
        strokeWidth: 2,
      ),
    ],
    extraLines: const [
      ExtraLineConfiguration(
        yValue: 10,
        color: Color(0xFFE53935),
        strokeWidth: 1.5,
        strokePattern: [10, 5],
      ),
    ],
    tags: [
      TagConfiguration(
        xValue: 3,
        color: Colors.white,
        backgroundColor: const Color(0xFFE53935),
        tagShape: TagShape.triangle,
        showTooltip: true,
        tooltipHtml: '<b>Peak</b><br/>Value: 11',
        tooltipBorderRadius: '4px',
        onTap: (x) => debugPrint('Tapped tag at x=$x'),
      ),
      TagConfiguration(
        xValue: 7,
        color: Colors.white,
        backgroundColor: const Color(0xFF1E88E5),
        showTooltip: true,
        tooltipHtml: '<b>Local Max</b><br/>Value: 12',
        tooltipBorderRadius: '4px',
        onTap: (x) => debugPrint('Tapped tag at x=$x'),
      ),
    ],
  ),
)
```

### Custom Axis Formatting & Underlay Drawing

Set fixed tick increments, format labels, and draw a shaded region behind the chart:

```dart
DataGraph(
  data: <List<num>>[
    [0, 22],  [10, 35],  [20, 28],  [30, 41],
    [40, 33], [50, 47],  [60, 39],  [70, 52],
  ],
  config: GraphConfiguration(
    xLabel: 'Distance (m)',
    minY: 0,
    maxY: 60,
    series: const [
      SeriesConfiguration(
        name: 'Elevation',
        color: Color(0xFF3F51B5),
        strokeWidth: 2,
      ),
    ],
    xAxisConfig: AxisConfiguration.withIncrement(
      increment: 10,
      labelFormatter: (v) => '${v.toInt()}m',
    ),
    yAxisConfig: AxisConfiguration.withIncrement(
      increment: 10,
      labelFormatter: (v) => '${v.toInt()} ft',
      gridLinePattern: [4, 4],
      gridLineColor: const Color(0xFFBDBDBD),
    ),
    underlayCallback: (ctx, area, g) {
      // Shade the "target zone" between y=30 and y=45
      final top = g.toDomYCoord(45);
      final bottom = g.toDomYCoord(30);
      ctx.fillStyle = 'rgba(76, 175, 80, 0.15)'.toJS;
      ctx.fillRect(area.x, top, area.w, bottom - top);
    },
  ),
)
```

---

## API Reference

### Configuration Classes

| Class | Description |
|-------|-------------|
| `GraphConfiguration` | Top-level chart config — axes, series, callbacks, legend, tags, extra lines |
| `SeriesConfiguration` | Per-series styling — color, stroke, plot type (line/bar), point markers |
| `AxisConfiguration` | Axis tick spacing, label/value formatters, grid line styling |
| `LegendConfiguration` | Legend display mode, positioning, and styling |
| `ExtraLineConfiguration` | Horizontal reference lines at a given y-value |
| `TagConfiguration` | Pin markers at x-values with shape, tooltip, and tap handler |
| `CircleConfiguration` | Circle annotation styling — radius, fill, stroke |
| `AxisTick` | Individual tick mark with value and optional label |

### GraphController Methods

| Method | Description |
|--------|-------------|
| `zoom(AxisRange xRange, AxisRange yRange)` | Programmatically set the visible x and y ranges |
| `circlePoint({x, y, persist, config})` | Draw a circle annotation at a data point |
| `clearCircledPoint({x, y})` | Remove a specific circle annotation |
| `clearAllCircledPoints()` | Remove all circle annotations |
| `updateConfig({config})` | Apply a new `GraphConfiguration` |
| `updateData({data})` | Replace the chart data |

### GraphController Properties

| Property | Type | Description |
|----------|------|-------------|
| `ready` | `bool` | Whether the graph has finished initializing |
| `config` | `GraphConfiguration` | Current configuration |
| `xAxisExtremes` | `List<double>` | Full x-axis data range `[min, max]` |
| `visibleXAxisRange` | `List<double>` | Currently visible x range `[min, max]` |
| `yAxisExtremes` | `List<double>` | Full y-axis data range `[min, max]` |
| `visibleYAxisRange` | `List<double>` | Currently visible y range `[min, max]` |

### Callback Types

| Callback | Signature |
|----------|-----------|
| `GraphClickCallback` | `void Function(MouseEvent e, double x, List<DataPoint> points)` |
| `PointClickCallback` | `void Function(MouseEvent e, DataPoint point)` |
| `HighlightCallback` | `void Function(MouseEvent e, double x, List<DataPoint> points, double row, String? series)` |
| `UnhighlightCallback` | `void Function(MouseEvent e)` |
| `ZoomCallback` | `void Function(double minX, double maxX, List<List<double>> yRanges)` |
| `DrawCallback` | `void Function(Dygraph g, bool initial)` |
| `UnderlayCallback` | `void Function(CanvasRenderingContext2D ctx, Area area, Dygraph g)` |
| `PlotterColorCallback` | `Color Function(double x, double y)` |

### Enums

| Enum | Values |
|------|--------|
| `SeriesPlotterType` | `line`, `bar` |
| `LegendType` | `always`, `follow`, `mouseOver`, `never` |
| `TagShape` | `rectangle`, `triangle` |

---

## Data Format

Data is passed as `List<List<num?>>` where each inner list is a row:

```
[x, y_series1, y_series2, ...]
```

- The first column is always the x-value and **must not be null**
- Y-values can be `null` to represent missing data points
- Use `double.nan` to create an explicit gap/break in a series line
- The number of y-columns must match the number of entries in `GraphConfiguration.series`

```dart
final data = <List<num?>>[
  [0, 10, 5],
  [1, 15, null],  // series 2 missing at x=1
  [2, double.nan, 8],  // series 1 has a gap at x=2
  [3, 20, 12],
];
```

---

## Platform Support

| Platform | Supported |
|----------|-----------|
| Web | Yes |
| Android | No |
| iOS | No |
| macOS | No |
| Windows | No |
| Linux | No |

**Requirements:** Dart SDK `^3.9.0` · Flutter `>=3.35.0`

---

## Contributing

Contributions are welcome! Feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

MIT License. See [LICENSE](LICENSE) for details.

## Acknowledgements

Built on top of the excellent [Dygraph.js](https://dygraphs.com/) charting library.
