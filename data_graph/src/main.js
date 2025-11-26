import Dygraph from 'dygraphs';
import FontFaceObserver from 'fontfaceobserver';
import { getSelectedTag, drawTag } from './utils/tag_utils';
import { drawExtraLine } from './utils/extra_line_utils';
import { drawCircleAtPoint } from './utils/circle_utils';
import { SeriesPlotters } from './utils/plotting_utils';

//! ========== CONSTANTS ==========

/** Index of the graph's container's css rule */
const chartDivRuleIndex = 1;

/** Index of the graph's legend's css rule */
const legendDivRuleIndex = 2;

/** Index of the x-axis labels' css rule */
const xAxisLabelRuleIndex = 3;

/** Index of the y-axis labels' css rule */
const yAxisLabelRuleIndex = 4;

//! ========== GLOBALS ==========

/**
 * The graph to be displayed.
 * 
 * @type {Dygraph}
 */
let graph = null;

/**
 * The full range of the y-axis.
 * 
 * @type {[number, number]}
 */
let fullYRange = [0, 0];

/**
 * List of currently circled points and their circle's configuration.
 * @type {{x: number, y: number, config: datagraph.CircleConfiguration}[]}
 */
let circledPoints = [];


/**
 * The list of tags with their dom coordinates attached
 * @type {datagraph.TagConfiguration[]}
 */
let tags = [];

//! ========== INTERACTION MODEL DELEGATES ==========
/**
 * Function to be called in graph's interaction model mouseup event.
 * 
 * Held as a delegate here to avoid stale capture issues when using values from Flutter state in the hanlder itself.
 */
let mouseupDelegate = null;

//! ========== INTEROP FUNCTIONS ==========
/**
* Initializes the graph with the provided data and configuration.
* 
* After initialization, `click` and `mousemove` event handlers are added to the graph's canvas
* to handle Tag hover and clicks.
* @param {number[][]} data The data that will be displayed in the graph. Each data point must be represented in the format: [x, y1, y2, y3, ...]
* @param {datagraph.GraphConfiguration} config Configuration for many aspects of the graph.
* @returns {void}
*/
function initGraph(data, config) {
  graph = new Dygraph(
    //! Div Element for Graph
    document.getElementById("graph"),
    //! Data
    data,
    //! Options
    buildOptions(config)
  );

  graph.ready(async (g) => {
    var fontAwesomeObserver = new FontFaceObserver('Font Awesome 6 Free', { weight: 900 });
    try {
      await fontAwesomeObserver.load();
    } catch (err) { }
    updateYRange(config.minY, config.maxY, config.reverseScale, config.yRangePad);
  });
}

/**
* Updates the options used by the graph. 
* 
* Used to alter configuration after graph has been initialized.
* @param {datagraph.GraphConfiguration} config Configuration for many aspects of the graph.
*/
function updateConfig(config) {
  graph.updateOptions(buildOptions(config));
  updateYRange(config.minY, config.maxY, config.reverseScale);
}

/**
* Updates the data presented by the graph. 
* 
* Used to alter data after graph has been initialized.
* @param {number[][]} data The data that will be displayed in the graph. Each data point must be represented in the format: [x, y1, y2, y3, ...]
*/
function updateData(data) { graph.updateOptions({ file: data }); }

/**
 * Focuses the graph on the specified x and y-axis ranges.
 * @param {{min: number, max: number} | null} xRange 
 * @param {{min: number, max: number} | null} yRange 
 */
function zoom(xRange, yRange) {
  graph.updateOptions({
    ...(xRange != null && { dateWindow: [xRange.min, xRange.max] }),
    ...(yRange != null && { valueRange: [yRange.min, yRange.max] }),
  });
}

/**
 * Draws a circle centered on the provided `x` and `y` coordinates.
 * @param {number} x The x coordinate for the circle to be centered on.
 * @param {number} y The y coordinate for the circle to be centered on.
 * @param {number} persist Whether the circle should persist until manually cleared or automatically clear when the user zooms or pans
 * @param {datagraph.CircleConfiguration} config Styling options for the circle.
 */
function circlePoint(x, y, persist, config) {
  let [cx, cy] = graph.toDomCoords(x, y);

  drawCircleAtPoint(graph.hidden_ctx_, cx, cy, config);

  if (persist) circledPoints.push({ x: x, y: y, config: config });
}

/**
 * Clears the circle from point centered at `(x, y)`
 * 
 * Only clears circles drawn with persist set to true.
 * @param {number} x x-axis value for center of point.
 * @param {number} y y-axis value for center of point.
 */
function clearCircledPoint(x, y) {
  let i = circledPoints.findIndex((e) => (e.x == x && e.y == y));

  if (i != -1) circledPoints.splice(i, 1);

  graph.updateOptions({});
}

/** Clears all circles drawn with persist set to true. */
function clearAllCircledPoints() {
  circledPoints = [];

  graph.updateOptions({});
}

//! ========== INTEROP FUNCTION EXPORTS ==========
window.initGraph = initGraph;
window.updateConfig = updateConfig;
window.updateData = updateData;
window.zoom = zoom;
window.cancelZoom = function () { g.clearZoomRect_() };

window.circlePoint = circlePoint;
window.clearCircledPoint = clearCircledPoint;
window.clearAllCircledPoints = clearAllCircledPoints;

window.dispose = function () { graph.destroy(); };

// Pseudo getters for axis range values.
window.yAxisExtremes = function () { return fullYRange; }
window.visibleYAxisRange = function () { return graph.yAxisRange(); }
window.xAxisExtremes = function () { return graph.xAxisExtremes(); }
window.visibleXAxisRange = function () { return graph.xAxisRange(); }

//! ========== GRAPH/CONFIG UTILITY FUNCTIONS ==========
/**
 * Finds the new full range of y-axis from either config or axis extremes.
 * @param {number | null} minY The minY value provided in config.
 * @param {number | null} maxY The maxY value provided in config.
 * @param {boolean} reverseScale The reverseScale value provided in config.
 */
function updateYRange(minY, maxY, reverseScale) {
  if (minY != null && maxY != null) {
    fullYRange = [minY, maxY];
  } else {
    let [lower, upper] = graph.yAxisExtremes()[0];

    fullYRange = [minY ?? (reverseScale ? upper : lower), maxY ?? (reverseScale ? lower : upper)];
  }

  graph.updateOptions({ valueRange: fullYRange });
}

/**
 * Applies styling options from config to items that require CSS rule manipulation.
 * @param {datagraph.GraphConfiguration} config 
 */
function applyCssStyles(config) {
  const stylesheet = document.styleSheets[1];

  let chartDivRule = stylesheet.cssRules[chartDivRuleIndex];
  let legendDivRule = stylesheet.cssRules[legendDivRuleIndex];
  let yAxisLabelRule = stylesheet.cssRules[yAxisLabelRuleIndex];
  let xAxisLabelRule = stylesheet.cssRules[xAxisLabelRuleIndex];

  chartDivRule.style.backgroundColor = config.backgroundColor ?? 'white';

  if (config.legendConfig != null) {
    let c = config.legendConfig;
    legendDivRule.style.backgroundColor = c.backgroundColor;
    legendDivRule.style.color = c.color;
    legendDivRule.style.padding = c.padding;
    legendDivRule.style.border = c.border;
    legendDivRule.style.borderRadius = c.borderRadius;

    if (c.type !== 'follow') {
      legendDivRule.style.left = c.left;
      legendDivRule.style.top = c.top;
      legendDivRule.style.right = c.right;
      legendDivRule.style.bottom = c.bottom;
    }
  }

  yAxisLabelRule.style.color = config.yAxisConfig?.axisLabelColor ?? 'black';
  xAxisLabelRule.style.color = config.xAxisConfig?.axisLabelColor ?? 'black';
}

/**
 * 
 * @param {MouseEvent} e 
 * @param {Dygraph} g 
 */
function displayTooltipOnMouseMove(e, g) {
  let [xMin, xMax] = g.xAxisRange();
  var tag = getSelectedTag(e, g.canvas_, tags.filter(e => xMin <= e.xValue && e.xValue <= xMax));
  g.canvas_.style.cursor = tag == null ? "default" : "pointer";

  var rect = g.canvas_.getBoundingClientRect();
  var x = e.clientX - rect.left;
  var y = e.clientY - rect.top - 10;

  var tooltip = document.getElementById('tooltip');
  if (tag != null && tag.showTooltip) {
    tooltip.innerHTML = tag.tooltipHtml;
    tooltip.style.fontSize = tag.tooltipFontSize;
    tooltip.style.fontFamily = tag.tooltipFontFamily;
    tooltip.style.color = tag.tooltipColor;
    tooltip.style.background = tag.tooltipBackgroundColor;
    tooltip.style.padding = tag.tooltipPadding;
    tooltip.style.border = tag.tooltipBorder;
    tooltip.style.borderRadius = tag.tooltipBorderRadius;

    tooltip.style.maxWidth = `${rect.width / 2.0}px`;
    tooltip.style.whiteSpace = 'normal';
    tooltip.style.wordBreak = 'break-word';

    if (x + tooltip.offsetWidth > rect.width) x -= tooltip.offsetWidth;

    tooltip.style.left = x + 'px';
    tooltip.style.top = y + 'px';
    tooltip.style.visibility = 'visible';
  } else {
    tooltip.innerHTML = '';
    tooltip.style.visibility = 'hidden';
  }
}

/**
* Builds Dygraph Options object from config.
* @param {datagraph.GraphConfiguration} config Configuration for many aspects of the graph.
* @returns {import("dygraphs").dygraphs.Options} 
*/
function buildOptions(config) {
  tags = config.tags;
  let labels = [config.xLabel];
  let series = {};

  config.series.forEach((e) => {
    labels.push(e.name);
    series[e.name] = e;

    if (e.plotterType == 1) series[e.name].plotter = SeriesPlotters.Bar;
  });

  mouseupDelegate = config.mouseupHandler;

  applyCssStyles(config);

  return {
    //! ========== GENERIC CONFIG ========== //
    labelsDiv: document.getElementById('legend'),
    labels: labels,
    rightGap: config.rightGap ?? 0,
    xRangePad: config.xRangePad,
    legend: config.legendConfig?.type,
    labelsSeparateLines: config.legendConfig?.labelsSeparateLines,
    connectSeparatedPoints: config.connectSeparatedPoints,
    highlightSeriesOpts: config.highlightSeriesOpts == null ? null : {
      color: config.highlightSeriesOpts?.color,
      strokeWidth: config.highlightSeriesOpts?.strokeWidth,
      strokeBorderWidth: config.highlightSeriesOpts?.strokeBorderWidth,
      strokeBorderColor: config.highlightSeriesOpts?.strokeBorderColor,
      strokePattern: config.highlightSeriesOpts?.strokePattern,
      drawPoints: config.highlightSeriesOpts?.drawPoints,
      pointSize: config.highlightSeriesOpts?.pointSize,
      highlightCircleSize: config.highlightSeriesOpts?.highlightCircleSize,
    },
    highlightSeriesBackgroundColor: config.highlightSeriesBackgroundColor,
    highlightSeriesBackgroundAlpha: config.highlightSeriesBackgroundAlpha,
    valueFormatter: (v, opt, series, g, row, col) => config.valueFormatter?.call(v, series) ?? v,
    interactionModel: {
      ...Dygraph.defaultInteractionModel,
      dblclick(e, g, ctx) {
        g.resetZoom();
        g.updateOptions({ valueRange: fullYRange });
      },
      mouseup(e, g, ctx) {
        try {
          mouseupDelegate?.call(e, g, ctx);
        } catch (_) { }
      },
      mousemove(e, g, ctx) {
        try {
          if (tags.length == 0) return;
          displayTooltipOnMouseMove(e, g);
        } catch (_) { }
      }
    },
    //! ========== AXIS CONFIG ========== //
    axes: {
      y: config.yAxisConfig == null ? undefined : {
        axisLabelFontSize: config.yAxisConfig?.axisLabelFontSize,
        axisLabelWidth: config.yAxisConfig?.axisLabelWidth,
        axisLineColor: config.yAxisConfig?.axisLineColor,
        axisLineWidth: config.yAxisConfig?.axisLineWidth,
        gridLineColor: config.yAxisConfig?.gridLineColor,
        gridLinePattern: config.yAxisConfig?.gridLinePattern,
        gridLineWidth: config.yAxisConfig?.gridLineWidth,
        ...(config.yAxisConfig?.ticker != null && { ticker: (a, b, pixels, opts, dygraph, vals) => config.yAxisConfig?.ticker?.call(a, b, pixels) }),
        ...(config.yAxisConfig?.labelFormatter != null && { axisLabelFormatter: (v, g, opts, graph) => config.yAxisConfig?.labelFormatter?.call(v, g) }),
        ...(config.yAxisConfig?.valueFormatter != null && { valueFormatter: (v, opts, series, graph, row, col) => config.yAxisConfig?.valueFormatter?.call(v, series) }),
      },
      x: config.xAxisConfig == null ? undefined : {
        axisLabelFontSize: config.xAxisConfig?.axisLabelFontSize ?? 14,
        axisLabelWidth: config.xAxisConfig?.axisLabelWidth,
        axisLineColor: config.xAxisConfig?.axisLineColor,
        axisLineWidth: config.xAxisConfig?.axisLineWidth,
        gridLineColor: config.xAxisConfig?.gridLineColor,
        gridLinePattern: config.xAxisConfig?.gridLinePattern,
        gridLineWidth: config.xAxisConfig?.gridLineWidth,
        ...(config.xAxisConfig?.ticker != null && { ticker: (a, b, pixels, opts, dygraph, vals) => config.xAxisConfig?.ticker?.call(a, b, pixels) }),
        ...(config.xAxisConfig?.labelFormatter != null && { axisLabelFormatter: (v, g, opts, graph) => config.xAxisConfig?.labelFormatter?.call(v, g) }),
        ...(config.xAxisConfig?.valueFormatter != null && { valueFormatter: (v, opts, series, graph, row, col) => config.xAxisConfig?.valueFormatter?.call(v, series) }),
      },
    },
    //! ========== SERIES ========== //
    series: series,
    //! ========== CALLBACKS ========== //
    clickCallback: function (e, x, points) {
      let tag = getSelectedTag(e, graph.canvas_, config.tags);
      if (tag == null) {
        config.clickCallback?.call(e, x, points);
      } else {
        tag.onTap?.call(tag.xValue);
      }

    },
    pointClickCallback: (e, point) => config.pointClickCallback?.call(e, point),
    highlightCallback: function (e, x, points, row, series) {
      config.highlightCallback?.call(e, x, points, row, series);
    },
    unhighlightCallback: (e) => config.unhighlightCallback?.call(e),
    drawCallback: function (g, initial) {
      circledPoints.forEach((e) => {
        let [cx, cy] = g.toDomCoords(e.x, e.y);
        drawCircleAtPoint(g.hidden_ctx_, cx, cy, e.config);
      });

      config.drawCallback?.call(g, initial);
    },
    zoomCallback: (minX, maxX, yRanges) => config.zoomCallback?.call(minX, maxX, yRanges),
    underlayCallback: function (ctx, area, g) {
      ctx.clearRect(0, 0, area.w, area.h);
      let [xMin, xMax] = g.xAxisRange();

      //! Draw extra lines
      config.extraLines.forEach((line) => {
        drawExtraLine(ctx, line, g.toDomCoords(xMin, line.yValue), g.toDomCoords(xMax, line.yValue));
      });

      ctx.setLineDash([]);

      //! Draw tags
      let domY = g.toDomYCoord(g.yAxisRange()[0])
      tags.forEach((e) => {
        if (e.xValue < xMin || e.xValue > xMax) return;

        drawTag(ctx, e, g.toDomXCoord(e.xValue), domY);
      });

      config.underlayCallback?.call(ctx, area, g);
    }
  };
}