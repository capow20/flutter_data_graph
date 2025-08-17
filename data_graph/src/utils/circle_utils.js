/**
 * Draws a circle centered on (cx, cy) with the given context
 * 
 * @param {CanvasRenderingContext2D} ctx The canvas context to draw on.
 * @param {number} cx The canvas x coordinate the center the circle on.
 * @param {number} cy The canvas y coordinate the center the circle on.
 * @param {datagraph.CircleConfiguration} config Styling options for the circle.
 */
export function drawCircleAtPoint(ctx, cx, cy, config) {
    ctx.beginPath();
    ctx.arc(cx, cy, config.radius, 0, Math.PI * 2);
    if (config.fillColor !== null) {
        ctx.fillStyle = config.fillColor;
        ctx.fill();
    }

    if (config.strokeColor !== null) {
        ctx.strokeStyle = config.strokeColor;
        ctx.lineWidth = config.strokeWidth;
        ctx.setLineDash(config.strokePattern);
        ctx.stroke();
    }
}