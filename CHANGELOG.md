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