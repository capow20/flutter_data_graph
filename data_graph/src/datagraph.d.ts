declare namespace datagraph {
    type AxisTicker = (a: number, b: number, pixels: number) => AxisTick[];
    type AxisValueFormatter = (value: number, series: string) => string;
    type AxisLabelFormatter = (value: number, granularity: number) => string;
    type TagClickHandler = (value: number) => void;

    /** Represents a tick on one of the graph's axes */
    interface AxisTick {
        v: number,
        label: string | null;
    }

    /** Represents a data point on the graph */
    interface DataPoint {
        series: string,
        x: number,
        y: number,
    }

    /** Used to set per-axis configuration settings.
    *
    * Will override global settings such as [GraphConfiguration.valueFormatter] for this axis.
    */
    interface AxisConfiguration {
        ticker: AxisTicker | null;
        labelFormatter: AxisLabelFormatter | null;
        valueFormatter: AxisValueFormatter | null;
        axisLabelFontSize: number,
        axisLabelColor: string,
        axisLabelWidth: number,
        axisLineColor: string,
        axisLineWidth: number,
        gridLineColor: string,
        gridLinePattern: number[],
        gridLineWidth: number,
    }

    /** Represents a series of data.
    *
    * Provides customization options for the given series.
    */
    interface SeriesConfiguration {
        name: string;
        color: string;
        strokeWidth: number;
        strokeBorderWidth: number | null;
        strokePattern: number[] | null;
        drawPoints: boolean;
        pointSize: number;
        highlightCircleSize: number;
        plotterType: SeriesPlotterType;
        barWidthRatio: number;
    }

    enum SeriesPlotterType { line, bar }

    /**
     * Customization options for the graph's legend.
     */
    interface LegendConfiguration {
        type: string;
        labelsSeparateLines: boolean;
        backgroundColor: string;
        color: string;
        left: string;
        top: string;
        right: string;
        bottom: string;
        padding: string;
        border: string | null;
        borderRadius: string | null;
    }

    /**
    * Used to configure lines outside of dataset to be drawn at constant y-values;
    */
    interface ExtraLineConfiguration {
        yValue: number;
        color: string;
        strokeWidth: number;
        strokePattern: number[];
    }

    /** Configuration for tags drawn on the graph's canvas.
    * 
    * Tags are drawn in the shape of rectangle (tag) on top of a stick (pin).
    */
    interface TagConfiguration {
        xValue: number;
        color: string;
        backgroundColor: string;
        strokeColor: string?;
        strokeWidth: number;
        text: string;
        font: string;
        tagShape: string;
        tagHeight: number;
        tagWidth: number;
        pinHeight: number;
        pinWidth: number;
        onTap: TagClickHandler | null;
        showTooltip: boolean;
        tooltipHtml: string;
        tooltipFontSize: string;
        tooltipFontFamily: string;
        tooltipColor: string;
        tooltipBackgroundColor: string;
        tooltipPadding: string;
        tooltipBorder: string;
        tooltipBorderRadius: string;
    }

    /** Configuration for custom circles drawn on the graph. */
    interface CircleConfiguration {
        radius: number;
        fillColor: string | null;
        strokeColor: string | null;
        strokeWidth: number;
        strokePattern: number[];
    }

    /**
    * Configuration for many aspects of the graph.
    * 
    * Used to update everything except data for the graph.
    */
    interface GraphConfiguration {
        //! ===== X AXIS ===== //
        xLabel: string;
        xRangePad: number | null;
        xAxisConfig: AxisConfiguration | null;

        //! ===== Y AXIS ===== //
        minY: number | null;
        maxY: number | null;
        reverseScale: boolean;
        yRangePad: number | null;
        yAxisConfig: AxisConfiguration | null;
        series: SeriesConfiguration[];

        //! ===== GENERIC ===== //
        valueFormatter: AxisLabelFormatter | null;
        rightGap: number;
        showZeroValueLabels: boolean;
        connectSeparatedPoints: boolean;
        backgroundColor: string;

        //! ===== LEGEND ===== //
        legendConfig: LegendConfiguration | null;

        //! ===== EXTRA LINES ===== //
        extraLines: ExtraLineConfiguration[];

        //! ===== TAGS ===== //
        tags: TagConfiguration[];

        //! ===== CALLBACKS ===== //
        clickCallback: ((value: number, points: DataPoint[]) => void) | null
        pointClickCallback: ((point: DataPoint) => void) | null;
    }
}