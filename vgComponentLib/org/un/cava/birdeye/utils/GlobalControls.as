/*
 * The MIT License
 *
 * Copyright (c) 2008
 * United Nations Office at Geneva
 * Center for Advanced Visual Analytics
 * http://cava.unog.ch
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
package org.un.cava.birdeye.utils {
	
	import org.un.flex.graphLayout.visual.IVisualGraph;
	
	/**
	 * This class will hold global static methods
	 * necessary to control the main behaviour of the
	 * VGraph. This includes refreshment of Control components,
	 * refreshment of the whole VGraph, potential mouse
	 * event actions, etc. etc.
	 * */
	public class GlobalControls {
		
		
		/**
		 * Redraw the graph and reset linklength if 0.
		 * This is typically used to handle a resize event
		 * */
 		public static function redrawGraphLL():void {
 			if(GlobalParams.vgraph is IVisualGraph) {
	 			if(GlobalParams.vgraphInitOk) {
	 				/* it can happen that the linklength is reduced to 0
	 				 * in this case we reset it */
	 				if(GlobalParams.layouter.linkLength == 0) {
	 					GlobalParams.layouter.linkLength = 100; // current default
	 				}
	 				GlobalParams.vgraph.draw();	
	 			}
	 		} else {
	 			trace("Cannot redraw invalid GlobalParams.vgraph object");
	 		}
 		}
 		
 		
 		/**
 		 * Refresh the VGraph fully. I.e. recreate and
 		 * reassign all data objects, etc.
 		 * This is a heavy operation */
		public static function fullVGraphRefresh():void {
				
			var oldroot:IVisualNode;
			var oldsid:String;
			var newroot:INode;
			
			/* remove and create a new layouter */			
			if(GlobalParams.layouter != null) {
				GlobalParams.layouter.resetAll();
				GlobalParams.layouter = null;
			}
			
			/* init a graph object with the XML data */
			graph = new org.un.flex.graphLayout.data.Graph("XMLAsDocsGraph",false,xmldata,xmlNames);
			
			oldroot = vgraph.currentRootVNode;
			oldsid = oldroot.node.stringid;
			
			/* set the graph in the VGraph object, this automatically
			 * initializes the VGraph items */
			vgraph.graph = graph;
			
			setLayouter();
			
			/* setting a new graph invalidated our old root, we need to reset it */
			/* we try to find a node, that has the same string-id as the old root node */
			newroot = graph.nodeByStringId(oldsid);
			if(newroot != null) {
				startRoot = newroot.vnode;
				vgraph.currentRootVNode = startRoot; // this redraws the whole thing
			} else {
				throw Error("Cannot set a default root, bailing out");
			}
		}		
 		
 		
 		/**
 		 * Refresh all instantiated UI related control components
 		 * and update all labels, if not done through data binding
 		 * XXX: consider to delegate as much as possible to data binding
 		 * which is currently not really the case...
 		 * 
 		 * This can be used as an event handler for a vgraphChanged event
 		 * 
 		 * */
 		public static function refreshUIControls():void {
 			/* lets wait first, which ones we really need
 			 * to refresh, maybe it is not really required
 			 */	
 			
 			
 		}
	}
}