## 0.0.9+1
- Added support for dynamic bar coloring in bar charts with SeriesConfiguration.plotterColorCallback

## 0.0.8+1
- Added preliminary support for plotting individual series as bars rather than lines

## 0.0.8
- Fixed bug causing tooltips to not be displayed after rebuilds.

## 0.0.7
- Altered logic for tooltip wrap and positioning to prevent horizontal overflows

## 0.0.6
- Moved tag detection for tooltips/cursor to interaction model's mousemove event to fix missed detection when at high zoom levels.

## 0.0.5
- Reverted hover and click detection for all tags to use rectangular logic.

## 0.0.4
- Fix for issue causing tooltips for tags that are not visible to be shown while zoomed.
- Fix for tooltips to not be shown correctly for triangular tags while zoomed.

## 0.0.3
- Added option to TagConfiguration to allow for rectangular or triangular tag shape.
- Added options to TagConfiguration to allow for displaying a tool tip when a tag is hovered.

## 0.0.2
- Updated Dart and Flutter sdk versions

## 0.0.1+1

### Updated
- Updated README.md links to use https.
- Added topics to pubspec.yaml

## 0.0.1

### Added
- Initial release of **flutter_data_graph**, a Flutter Web wrapper around **Dygraph.js** for interactive **numeric** line charts.
- `GraphConfiguration` with:
  - **X-axis**: `xLabel`, `xRangePad`, `xAxisConfig`
  - **Y-axis**: `minY`, `maxY`, `reverseScale`, `yRangePad`, `yAxisConfig`
  - **Series**: `series` (`SeriesConfiguration` styling options )
  - **Legend**: `legendConfig` (`LegendConfiguration` styling and behavioral options )
  - **Extras**: `extraLines` (constant y-value reference lines), `tags`
  - **Styling**: `backgroundColor`, `rightGap`, `showZeroValueLabels`, `connectSeparatedPoints`
  - **Highlighting**: `highlightSeriesOpts`, `highlightSeriesBackgroundColor`, `highlightSeriesBackgroundAlpha`
  - **Callbacks**: `clickCallback`, `pointClickCallback`, `highlightCallback`, `unhighlightCallback`, `drawCallback`, `zoomCallback`, `underlayCallback`
  - **Interaction model (advanced)**: `mouseupHandler`
- Dart/JS interop layer to bridge configuration and callbacks to Dygraph.

### Known Limitations
- **Numeric-only** datasets (no `DateTime`/time-series support yet).
- Single y-axis (multi-axis not yet supported).
- Subset of Dygraph features; some plug-ins and advanced interaction models are not exposed yet.
- Optimized for **Flutter Web** (browser environment required).