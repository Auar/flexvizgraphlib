/* 
 * The MIT License
 *
 * Copyright (c) 2007 The SixDegrees Project Team
 * (Jason Bellone, Juan Rodriguez, Segolene de Basquiat, Daniel Lang).
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package org.un.flex.graphLayout.layout {
	
	import org.un.flex.graphLayout.data.IGraph;
	import org.un.flex.graphLayout.data.IEdge;
	import org.un.flex.graphLayout.visual.IVisualEdge;
	import org.un.flex.graphLayout.visual.IVisualNode;
	import flash.display.Graphics;


	/**
	 * This is the default edge renderer, which draws the edges
	 * as straight lines from one node to another.
	 * */
	public class DefaultEdgeRenderer implements IEdgeRenderer {
		
		/* constructor does nothing and is therefore omitted
		 */
		
		/**
		 * The draw function, i.e. the main function to be used.
		 * Draws a straight line from one node of the edge to the other.
		 * The colour is determined by the "disting" parameter and
		 * a set of edge parameters, which are stored in an edge object.
		 * 
		 * @inheritDoc
		 * */
		public function draw(g:Graphics, edge:IEdge, disting:Boolean):void {
			
			/* first get the corresponding visual object */
			var vedge:IVisualEdge = edge.vedge;
			var fromNode:IVisualNode = edge.node1.vnode;
			var toNode:IVisualNode = edge.node2.vnode;
			
			/* now get some current data and calculate their middle */
			var fromX:Number = fromNode.view.x + (fromNode.view.width / 2.0);
			var fromY:Number = fromNode.view.y + (fromNode.view.height / 2.0);
			var toX:Number = toNode.view.x + (toNode.view.width / 2.0);
			var toY:Number = toNode.view.y + (toNode.view.height / 2.0);	
			
			/* XXX drawing parameters with default values, these could
			 * be taken from the graph object actually, although this
			 * should be rather in the VisualGraph */
			var alpha:Number;
			var thickness:int;
			var color:int;
			
			/* check if we have a data object associated with the vedge
			 * with instructions how to render it */
			var edgeSettings:Object;
			
			/* the name of the settings property should be a constant */
			if(vedge.data != null && vedge.data.hasOwnProperty("settings")) {
				edgeSettings = vedge.data.settings;
			} else {
				edgeSettings = vedge.vgraph.globalEdgeSettings;
			}
			alpha = edgeSettings.alpha;
			thickness = edgeSettings.thickness;

			if(disting) {
				color = edgeSettings.distcolor;
			} else {
				color = edgeSettings.color;
			}
			
			/* now we actually draw */
			g.lineStyle(thickness, color, alpha);
			g.beginFill(0);
			g.moveTo(fromX, fromY);
			g.lineTo(toX, toY);
			g.endFill();
		}
	}
}