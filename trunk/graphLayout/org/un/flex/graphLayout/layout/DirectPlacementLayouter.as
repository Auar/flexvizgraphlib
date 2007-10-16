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

	import flash.utils.Dictionary;
	
	import org.un.flex.graphLayout.data.INode;
	import org.un.flex.graphLayout.visual.IVisualGraph;
	import org.un.flex.graphLayout.visual.IVisualNode;
	
	/**
	 * This layouter does not use any algorithm for node placement,
	 * but relys on coordinate information (x,y-coordinates) specified
	 * in each nodes associated XML object.
	 * It also takes a relative height and width parameter (which may be
	 * calculated by autofit) to put the specified coordinates into
	 * perspective.
	 * */
	public class DirectPlacementLayouter extends BaseLayouter implements ILayoutAlgorithm {
		
		/* this holds the data for the Hierarchical layout drawing */
		//XXX probably not needed private var _currentDrawing:HierarchicalLayoutDrawing;
		
		/* hold the relative height and width of the specified coordinates */
		private var _relativeHeight:Number;
		private var _relativeWidth:Number;
		
		/**
		 * The constructor only initialises some data structures.
		 * @inheritDoc
		 * */
		public function DirectPlacementLayouter(vg:IVisualGraph = null):void {
			super(vg);
			
			_relativeHeight = 1000;
			_relativeWidth = 1000;
		}

		/**
		 * @inheritDoc
		 * */
		override public function resetAll():void {			
			
			super.resetAll();
			
			/* invalidate all trees in the graph */
			_stree = null;
			_graph.purgeTrees();
		}

		/**
		 * This main interface method computes and
		 * and executes the new layout.
		 * @return Currently the return value is not set or used.
		 * */
		override public function layoutPass():Boolean {

			var i:int;
			var n:INode;
			var visVNodes:Dictionary;
			var vn:IVisualNode;
			var cindex:int;
			var nsiblings:int;
			var rv:Boolean;
			var children:Array;
			
			//trace("layoutPass called");
			
			if(!_vgraph) {
				throw Error("No Vgraph set in PCRLayouter, aborting");
			}
			
			if(!_vgraph.currentRootVNode) {
				throw Error("This Layouter always requires a root node!");
			}
			
			/* nothing to do if we have no nodes */
			if(_graph.noNodes < 1) {
				return false;
			}
			
					
			/* establish the spanning tree */
			//_graph.purgeTrees();
			_stree = _graph.getTree(_root,true);

			/* check if the root is visible, if not
			 * this is an issue */
			if(!_root.vnode.isVisible) {
				throw Error("Invisible root node, this is probably due to wrong initialisation of nodes or wrong defaults");
			}

			/* this is complicated. */
			if(_autoFitEnabled) {
				/* now we calculate the best spacing */
				calculateAutoFit();
			}

			/* now place the nodes according to their specified coordinates */
			placeNodes();
		
			_layoutChanged = true;
			return rv;
		}
	
		/**
		 * Access the relative height for the y coordinates specified.
		 * Default is 1000.
		 * */
		public function set relativeHeight(rh:Number):void {
				_relativeHeight = rh;
		}
		
		/**
		 * @private
		 * */
		public function get relativeHeight():void {
			return _relativeHeight;
		}
		
		/**
		 * Access the relative width for the x coordinates specified.
		 * Default is 1000.
		 * */
		public function set relativeWidth(rw:Number):void {
				_relativeWidth = rw;
		}
		
		/**
		 * @private
		 * */
		public function get relativeWidth():void {
			return _relativeWidth;
		}
		
		/**
		 * @internal
		 * Places the nodes according to the specified coordinates
		 * in the XML data of each node. Interprets the coordinates
		 * relative to the Height and Width specified (default 1000).
		 * If autoFit is enabled, it will in addition take that
		 * into account.
		 * */
		private placeNodes():void {
			var visVNodes:Array;
			
			
			
			
			
		}
		
		/**
		 * @internal
		 * do autofitting the layer distance. The node distance cannot
		 * be pre-computed, so we leave it alone.
		 * */
		private function calculateAutoFit():void {
			
		}
	}
}