export const SeriesPlotters = {
    Bar: barChartPlotter
};

function barChartPlotter(e) {
    const ctx = e.drawingContext;
    const pts = e.points;
    let g = e.dygraph;

    if (pts.length === 0) return;

    const yBottom = g.toDomYCoord(g.yAxisRange()[0]);

    const series = e.setName || e.seriesName;
    const borderColor = g.getOption('strokeBorderColor', series);
    const strokeBorderWidth = g.getOption('strokeBorderWidth', series);
    const barWidthRatio = g.getOption('barWidthRatio', series);
    const plotterColorCallback = g.getOption('plotterColorCallback', series);

    let barWidth = (g.getArea().w / pts.length) * barWidthRatio ?? 0.8;
    let borderWidth = barWidth < 3 ? 0 : Math.min(strokeBorderWidth, barWidth * 0.3);

    ctx.fillStyle = e.color;

    pts.forEach(p => {
        if(plotterColorCallback != null) ctx.fillStyle = plotterColorCallback.call(p.xval, p.yval);

        const x = p.canvasx - barWidth / 2.0;
        const y = Math.min(yBottom, p.canvasy);
        const height = Math.abs(yBottom - p.canvasy);

        ctx.fillRect(x, y, barWidth, height);

        if (borderWidth != 0) {
            ctx.strokeStyle = borderColor;
            ctx.strokeRect(x - borderWidth / 2, y, barWidth + 2 * borderWidth, height);
        }
    });
}