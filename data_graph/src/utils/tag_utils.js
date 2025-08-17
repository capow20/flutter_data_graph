function getEventCoordinates(canvas, e) {
    var rect = canvas.getBoundingClientRect();
    var x = e.clientX - rect.left;
    var y = e.clientY - rect.top;

    return { x, y };
}

function between(v, min, max) { return v >= min && v <= max }

function isPointInTag(x, y, tag) {
    return between(x, tag.x, tag.x + tag.w) && between(y, tag.y, tag.y + tag.h);
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

    //! Start clearing 1 px to the left of actual tag
    //! so that there is a small gap between tags
    ctx.clearRect(tag.x - 1, tag.y, tag.w + 2, tag.tagHeight);

    ctx.fillStyle = tag.backgroundColor;

    //! Draw pin
    ctx.fillRect(domX, domY - tag.pinHeight, tag.pinWidth, tag.pinHeight);
    //! Draw tag
    ctx.fillRect(tag.x, tag.y, tag.w, tag.tagHeight);

    //! Draw icon
    ctx.fillStyle = tag.color;
    ctx.textAlign = "center";
    ctx.font = tag.font;
    ctx.fillText(tag.text, domX, domY - tag.pinHeight - (tag.tagHeight * 0.25), tag.tagWidth);
}