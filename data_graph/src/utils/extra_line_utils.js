/**
 * Draws a line on the graph using the provided ctx
 * @param {CanvasRenderingContext2D} ctx The context for the graph's canvas.
 * @param {datagraph.ExtraLineConfiguration} line The line to be drawn on the graph's canvas.
 * @param {[number, number]} start The coordinates of the line's starting point on the canvas/div.
 * @param {[number, number]} end The coordinates of the line's ending point on the canvas/div.
 */
export function drawExtraLine(ctx, line, start, end) {
    ctx.setLineDash(line.strokePattern);
    ctx.strokeStyle = line.color;
    ctx.lineWidth = line.strokeWidth;

    let roundedY = Math.round(start[1]) - 0.5

    ctx.beginPath();
    ctx.moveTo(start[0], roundedY);
    ctx.lineTo(end[0], roundedY);
    ctx.stroke();
}