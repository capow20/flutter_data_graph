function getEventCoordinates(canvas, e) {
    var rect = canvas.getBoundingClientRect();
    var x = e.clientX - rect.left;
    var y = e.clientY - rect.top;

    return { x, y };
}

function between(v, min, max) { return v >= min && v <= max }

function pointInRect(px, py, tag) {
  return between(px, tag.x, tag.x + tag.w) && between(py, tag.y, tag.y + tag.h);
}

function pointInTriangle(px, py, tag, ep = 0.0001) {
  const { x, y, w, h } = tag;

  if (py < y - ep || py > y + h + ep) return false;

  const t = (py - y) / h;
  if (t < -ep || t > 1 + ep) return false;

  const cx = x + w / 2;
  const half = (w / 2) * t + ep;

  return px >= cx - half && px <= cx + half;
}

function isPointInTag(x, y, tag) {
    if(tag.tagShape == 'Rectangle')  return pointInRect(x, y, tag);
    if(tag.tagShape == 'Triangle') return pointInTriangle(x, y, tag);
   
}

export function getSelectedTag(event, canvas, tags) {
    var { x, y } = getEventCoordinates(canvas, event);

    for (var i = 0; i < tags.length; i++) {
        if (isPointInTag(x, y, tags[i])) {
            return tags[i];
        }
    }
}
/**
 * Draws a tag on the graph using the provided ctx
 * @param {CanvasRenderingContext2D} ctx The context for the graph's canvas.
 * @param {datagraph.TagConfiguration} tag The tag to be drawn on the graph's canvas.
 * @param {number} domX The x coordinate on the canvas/div that represents the tag's xValue.
 * @param {number} domY The y coordinate on the canvas/div that represents the bottom of the graph.
 */
export function drawTag(ctx, tag, domX, domY) {
    tag.h = tag.tagHeight + tag.pinHeight;
    tag.w = tag.tagWidth;
    tag.x = domX - (tag.w / 2.0);
    tag.y = domY - tag.h;

    var rect = tag.tagShape == 'Rectangle';

    //! Start clearing 1 px to the left of actual tag
    //! so that there is a small gap between tags
    if (rect) {
        ctx.clearRect(tag.x - 1, tag.y, tag.w + 2, tag.tagHeight);
    } else {
        ctx.save();
        ctx.beginPath();
        ctx.moveTo(tag.x - 1, domY - tag.pinHeight);
        ctx.lineTo(domX, tag.y - 1);
        ctx.lineTo(domX + (tag.w / 2.0) + 1, domY - tag.pinHeight);
        ctx.closePath();
        ctx.clip();

        ctx.fillStyle = "rgba(0, 0, 0, 0)"; // Transparent black
        ctx.globalCompositeOperation = 'destination-out'; // This setting erases pixels
        ctx.fill();

        ctx.restore();
    }

    ctx.fillStyle = tag.backgroundColor;
    if(tag.strokeColor != null) {
        ctx.strokeStyle = tag.strokeColor;
        ctx.lineWidth = tag.strokeWidth;
    }

    //! Draw pin
    ctx.fillRect(domX, domY - tag.pinHeight, tag.pinWidth, tag.pinHeight);

    //! Draw tag
    if (rect) {
        ctx.fillRect(tag.x, tag.y, tag.w, tag.tagHeight);
        if(tag.strokeColor != null) ctx.strokeRect(tag.x, tag.y, tag.w, tag.tagHeight);
    } else {
        ctx.beginPath();
        ctx.moveTo(tag.x, domY - tag.pinHeight);
        ctx.lineTo(domX, tag.y);
        ctx.lineTo(domX + (tag.w / 2.0), domY - tag.pinHeight);
        ctx.closePath();
        ctx.fill();
        if(tag.strokeColor != null) ctx.stroke();
    }
    
    //! Draw icon
    ctx.fillStyle = tag.color;
    ctx.textAlign = "center";
    ctx.font = tag.font;
    ctx.fillText(tag.text, domX, domY - tag.pinHeight - (tag.tagHeight * (rect ? 0.25 : 0.10)), tag.w * (rect ? 1.0 : 0.5));
}