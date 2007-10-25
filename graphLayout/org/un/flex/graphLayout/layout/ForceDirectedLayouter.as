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

	import org.un.flex.graphLayout.data.Graph;
	import org.un.flex.graphLayout.data.IGraph;
	import org.un.flex.graphLayout.data.IEdge;
	import org.un.flex.graphLayout.data.INode;
	
	import org.un.flex.graphLayout.visual.IVisualEdge;
	import org.un.flex.graphLayout.visual.IVisualGraph;
	import org.un.flex.graphLayout.visual.IVisualNode;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	/**
	 * This is an implementation of the ForceDirected/SpringGraph
	 * Layouting algorithm. The implementation took the general
	 * idea	from Mark Shepherd's SpringGraph component implementation
	 * which is itself based on TouchGraph (Java). However, apart from
	 * the general idea and some variable names, the code is a rewrite.
	 * 
	 * Here is the copyright information that was part of the code. I add
	 * it just in case someone might feel offended if it is not there:
	 * 
	 * Copyright of the original TouchGraph LLC code:
	 * (c) 2001-2002 Alexander Shapiro. All rights reserved.
	 * Copyright of the adaption to Flex:
	 * (c) Mark Shepherd, Adobe FlexBuilder Engineering, 2006.
	 * Copyright of this reimplementation in Flex:
	 * (c) Daniel Lang, United Nations, 2007.
	 * 
	 * See license infortmation at the top.
	 * */
	public class ForceDirectedLayouter extends IterativeBaseLayouter implements ILayoutAlgorithm {
		
		/*********************************************
		* CONSTANTS
		* ********************************************/
		
		/**
		 * @internal
		 * This controls the amount of adjustement passes during one
		 * layout cycle. */
		private const _RELAXPASSES:int = 5;
		
		/**
		 * @internal
		 * This is a maximum (neutral) length of a hypothetical spring.
		 * For a spring force expression Del_F = k (x - x_0), this corresponds to x_0
		 */
		private const _MAX_EDGE_LENGTH:int = 100;
		
		/**
		 * @internal
		 * This is a minimun (neutral) length of a hypothetical spring.
		 * For a spring force expression Del_F = k (x - x_0), this corresponds to x_0
		 * It also governs the minimum separation during repulsion
		 */
		private const _MIN_NODE_SEPARATION:int = 5;
		
		/**
		 * @internal
		 * The maximum scrolling step in autofit()
		 */
		private const _SCROLL_STEP:int = 2;
		
		/**
		 * @internal
		 * The unit charge on the nodes. The total charge is computed
		 * by taking typical dimensions of the node (width + height) as 
		 * a proxy; i.e., larger nodes have higher charge
		 */
		private const _UNIT_CHARGE_CONSTANT:Number = 0.07;
		
		/**
		 * @internal
		 * The rigidity constant of a spring. The actual _rigidity could be 
		 * a function and perhaps use this as a coefficient (LATER)
		 */
		private const _RIGIDITY_CONSTANT:Number = 0.05;
		
		/**
		 * @internal
		 * The repulsion constant of the (electrical) force field. As with
		 * the rigidity constant, this may be dynamically changed (LATER)
		 */
		private const _REPULSION_CONSTANT:Number = 0.05;

		/**
		 * @internal
		 * The maximum distance in pixels, that a node is allowed
		 * to move during one layout cycle */
		private const _MOVEPIXELLIMIT:int = 30;
		
		/**
		 * @internal
		 * The ideal coverage for autofit is 90% 
		 * */
		private const _AUTOFITCOVERAGE:Number = 0.9;
		
		/**
		 * @internal
		 * There is also a tolerance of 3% to be within
		 * the ideal coverage.
		 * */
		private const _AUTOFITCOVERTOLERANCE:Number = 0.03;
		
		/*********************************************
		* Parameters
		* ********************************************/
		
		/* the damper cools down the movement
		 * it may range be from 0.0 (no movement) to
		 * 1.0 (no damping) */
		private var _damper:Number = 1.0;
		
		/* max motion keeps track of the fastest moving nodes
		 * to see if the graph stabilises */
		private var _maxMotion:Number = 0.0;
		private var _maxMotionTmp:Number = 0.0;
		private var _lastMaxMotion:Number = 0.0;
		
		/* new variables for debugging */
		private var _maxSpringMotion:Number = 0.0;
		private var _maxRepulsiveMotion:Number = 0.0;
		
		/* this is used during motion limiting */
		private var _motionRatio:Number = 0.0;
		
		/* cutoff limit for max motion */
		private var _motionLimit:Number = 0.005;
		
		/* a constant with a similar effect as damping
		 * low means things go slow, too high will cause oscillation */
		private var _rigidity:Number = _RIGIDITY_CONSTANT;
		private var _newRigidity:Number = _RIGIDITY_CONSTANT;
		
		/* this is a global adjustement factor for the repulsion
		 * it's access MAY be controlled by the linkLength access
		 * methods. For now, we control _springLength instead */
		private var _repulsionFactor:Number;
		private var _prevRepulsionFactor:Number;

		/* this is a global factor that determines the 
		 * neutral length of the springs/rubberbands
		 * */
		private var _springLength:Number = _MIN_NODE_SEPARATION;
		
		/* required for this specific 
		 * autofit implementation */
		private var _prevCoverage:Number = 0;

		/*********************************************
		* Members
		* ********************************************/
		
		/* general setting whether to activate damping or not */
		private var _dampingActive:Boolean = true;
		
		/* current viewing bounds of the graph */
		private var _viewbounds:Rectangle;

		/* each node has it's own repulsion value, which is
		 * kept in this map. The values are calculated on the fly
		 * using updateRepulsion()
		 * keys are VisualNodes, values are Numbers */
		private var _repulsionMap:Dictionary;
		
		/* for each node we keep a 'delta' value for its
		 * coordinates. */
		private var _deltaPositions:Dictionary;
		/**
		 * The constructor only initialises the data structures and presets
		 * some parameters.
		 * */
		public function ForceDirectedLayouter(vg:IVisualGraph = null):void {
			super(vg);
			
			_repulsionMap = new Dictionary;
			_deltaPositions = new Dictionary;
		
			_repulsionFactor = _UNIT_CHARGE_CONSTANT;
			_prevRepulsionFactor = 0.0;
			//trace("Spring Motion\tRepulsive Motion\tMax Motion\tMotioRatio\tDamper");
		}

		/**
		 * Reset all layouting parameters, which may be
		 * required during a significant layout change.
		 * This is particularily important in this layouter,
		 * as it constantly updates the layout (using the timer).
		 * */
		override public function resetAll():void {
			super.resetAll();
			
			/* already reset in refreshInit() called in super.resetAll() */
			//_damper = 1.0;
			
			_maxMotion = 0.0;
			_maxMotionTmp = 0.0;
			_lastMaxMotion = 0.0;
		
			_motionRatio = 0.0;
			_dampingActive = true;
			_motionLimit = 0.01;
			
			_rigidity = _RIGIDITY_CONSTANT;
			_newRigidity = _RIGIDITY_CONSTANT;

			_deltaPositions = new Dictionary;
			_repulsionMap = new Dictionary;
			_repulsionFactor = _UNIT_CHARGE_CONSTANT;
			_prevRepulsionFactor = 0.0;
			_prevCoverage = 0;
			_layoutChanged = true;
		}

		/**
		 * In this implementation, this method resets the damper
		 * value.
		 * */
		override public function refreshInit():void {
			resetDamperValue();
		}
		
		/**
		 * @inheritDoc
		 * */
		override public function set linkLength(f:Number):void {
			/*
			* Two separate intents govern the value of springlength
			*  1. Auto-fit - expand/ contract the graph
			*  2. Setting linkLength to a given value
			* In force-directed layout, both should not control the spring length simultaneously
			*/
			if (!_autoFitEnabled) {
				_springLength = Math.max(_MIN_NODE_SEPARATION, Math.min(f, _MAX_EDGE_LENGTH));
				//trace("Set springLength:" + _springLength);
			}
			layoutIteration();
		}
		
		/**
		 * @private
		 * */
		override public function get linkLength():Number {
			return _springLength;
		}


		/**
		 * This is a local parameter specific to this layouter, that may
		 * be accessed from outside, if required. It handles how flexible
		 * the springy edges are.
		 * @param r The new rigidity value.
		 * */
		public function set rigidity(r:Number):void {
			_newRigidity = r;
		}

		/**
		 * This is a specific method for this layouter and
		 * specifies if damping should be used or not.
		 * */
		public function set dampingActive(da:Boolean):void {
	
			/* check for a change */
			if(_dampingActive != da) {
				/* set the new value */
				_dampingActive = da;
				
				/* reset the damper value if disabled */
				if(da == false) {
					_damper = 1.0;
				}
			}
		}
		
		/**
		 * @private
		 * */
		public function get dampingActive():Boolean {
			return _dampingActive;
		}
		
		/**
		 * Reset the damper value but keep damping.
		 * @internal
		 * */
		private function resetDamperValue():void {
			_dampingActive = true;
			_damper = 1.0;
		}
		
		/**
		 * Stabilises the graph gently by setting the damper
		 * to a low value.
		 * */
		private function stopMotion():void {
			_dampingActive = true;
			if(_damper > 0.3) {
				_damper = 0.3;
			} else {
				/* this stops all movement, until the damper is reset */
				_damper = 0.0;
			}
		}
		
		/**
		 * @internal
		 * experimental code with the motionThreshold
		 * may be eliminated.
		 * */
		private function set motionThreshold(t:Number):void {
			_motionLimit = t;
			_layoutChanged = true;
		}

		/**
		 * @private
		 * similarly experimental, do not expose it right now.
		 * */
		private function get motionThreshold():Number {
			return _motionLimit;
		}
		
		/*********************************************
		* Layout Methods - Computational Methods
		* ********************************************/
		
		/* Calculation step of the layout */
		override protected function calculateLayout():void {
			/* call the relax method to pull on the edges */
			calculateForces();
			
			if(_autoFitEnabled) {
				adjustRepulsion();
				scrollToFit();
			}
		}
		
		/* Terminating condition for the layout */
		override protected function isStable():Boolean {
			return (_damper <= 0.1 && _maxMotion <= _motionLimit);
		}

		/*********************************************
		* Layout Methods - Force Computations
		* ********************************************/
		/**
		 * @internal
		 * This is another wrapper function around several
		 * layout calculation steps.
		 * 1. It updates the repulsion value of each node.
		 * 2. It calls relaxEdges which pulls on the edges.
		 * 3. It works on each node to separate them by their size and taking the repulsion into account
		 * 4. It actually starts moving the nodes (but keeping some constraints).
		 * */
		private function calculateForces():void {
			
			var visVNodes:Dictionary;
			var vn:IVisualNode;
			var node:INode;
			
			/* work on all currently visible VNodes */
			visVNodes = _vgraph.visibleVNodes;
			for each(vn in visVNodes) {
				//trace("relax for each node: updating repulsion for: "+node.id);
				
				if(!vn.isVisible) {
					throw Error("Received invisible node while working on visible vnodes only");
				}
				
				/* first update each nodes repulsion value */
				updateRepulsion(vn);
				
				/* now update the coordinates set in the VNode from the vnodes real
				 * coordinates */
				vn.refresh();
				
				/* *
				trace("node: "+vn.id+" has dx:"+vn.dx+" dy:"+vn.dy+" x:"+vn.x+
				" y:"+vn.y+" viewX:"+vn.viewX+" viewY:"+vn.viewY+" repulsion:"+_repulsionMap[vn]);
				*/
			}
			
			/* now call the three methods to work on the layout
			 * so many times, as required and preset in the constant value */
			for(var i:int=0; i < _RELAXPASSES; ++i) {
				//trace("relaxEdges,applyRepulsion,moveNodes, pass: "+i);
				applySpringForce();
				applyRepulsion();		
				moveNodes();
				adjustDrag();
			}
			
			/* update rigidity, it may have been set new */
			if(_rigidity != _newRigidity) {
				_rigidity = _newRigidity;
			}
			
			/* commit all nodes, basically this sets the
			 * view.x to their _x attribute */
			for each(vn in visVNodes) {
				if(!vn.isVisible) {
				throw Error("Received invisible node while working on visible vnodes only");
				}
				vn.commit();
			}
		}

		/**
		 * @internal
		 * This method tenses up the edges and pulls the nodes
		 * closer. In order to optimize, it should only work on
		 * "visible" edges, i.e. edges for which both nodes
		 * are visible.
		 */
		private function applySpringForce():void {
			/* we need IEdges first */
			var edge:IEdge;
			var visEdges:Dictionary = _vgraph.visibleEdges;
			
			_maxSpringMotion = 0.0;
			
			for each(edge in visEdges) {
				/* now work on the edge */
				applySpringOnEdge(edge);
			}
		}
		
		/**
		 * @internal
		 * This methods works on each edge and tries to pull it
		 * together. It depends on the current edge length and
		 * the general rigidity of edges.
		 * @param e The edge which should be pulled together.
		 * */
		private function applySpringOnEdge(e:IEdge):void {
			
			var vedge:IVisualEdge = e.vedge;
			var vnode1:IVisualNode = e.node1.vnode;
			var vnode2:IVisualNode = e.node2.vnode;

			/* all nodes attached to the edge should be visible, 
			 * so we assert here that it is true */
			if(!vnode1.isVisible || !vnode2.isVisible) {
				throw Error("At least one node of the edge is not visible but it should be!");
			}
			
			/* beware, that this 'x' is not the x from the
			 * the UIComponent (view) but the attribute
			 * from the VisualNode */			
			var vx:Number = vnode2.x - vnode1.x; 
			var vy:Number = vnode2.y - vnode1.y;
			
			/* calculate the actual length of the edge */
			var edgelength:Number = Math.sqrt((vx * vx)+(vy * vy));
			
			/* calculate the average node side length of the two nodes */
			var linkLength:Number = Math.max((vnode1.view.width + vnode1.view.height + vnode2.view.width + vnode2.view.height) / 2.0,
																       (MINIMUM_NODE_HEIGHT + MINIMUM_NODE_WIDTH));
			//trace("edgelength:" + edgelength + "  linklength:" + linkLength);
			
			//var vx1:Number = vnode1.viewX - vnode2.viewX;
			//var vy1:Number = vnode1.viewY - vnode2.viewY;
			//var linkLength:Number = Math.sqrt(vx1*vx1 + vy1*vy1);
			var delta:Number = Math.max(0,edgelength - _springLength);
			
			/* apply the rigidity to make the edge tighter */
			var dx:Number = vx * _rigidity * delta / linkLength;
			var dy:Number = vy * _rigidity * delta / linkLength;
			
			//trace("Spring Force > dx:"+dx+" dy:"+dy+" edgelength:"+edgelength+" linklen:"+linkLength);
			/* update the motion value */
			var distanceMoved:Number = Math.sqrt(dx*dx + dy*dy);
			_maxSpringMotion = Math.max(distanceMoved, _maxSpringMotion);
			
			if(_deltaPositions[vnode1] == null) {
				_deltaPositions[vnode1] = new Point(0,0);
			}
			if(_deltaPositions[vnode2] == null) {
				_deltaPositions[vnode2] = new Point(0,0);
			}
			
			/* apply the position offset, add for vnode 1 */
			(_deltaPositions[vnode1] as Point).offset(dx, dy);
			
			/* subtract for vnode */
			(_deltaPositions[vnode2] as Point).offset(-dx, -dy);
			
			/*
			trace("pullEdges2 dx:"+dx+" dy:"+dy+" edgelength:"+edgelength);
			trace("pullEdges3 node: "+vnode1.id+" has dx:"+vnode1.dx+" dy:"+vnode1.dy+" x:"+vnode1.x+
					" y:"+vnode1.y+" viewX:"+vnode1.viewX+" viewY:"+vnode1.viewY+" repulsion:"+_repulsionMap[vnode1]);
			trace("pullEdges3 node: "+vnode2.id+" has dx:"+vnode2.dx+" dy:"+vnode2.dy+" x:"+vnode2.x+
				" y:"+vnode2.y+" viewX:"+vnode2.viewX+" viewY:"+vnode2.viewY+" repulsion:"+_repulsionMap[vnode2]);
			*/
		}

		/**
		 * @internal
		 * This methods (originally called avoidLabels()) applies
		 * the repulsion to the nodes in order to keep them apart
		 * (and consequently avoid their labels from overlapping).
		 * */
		private function applyRepulsion():void {

			var allVisVNodes:Dictionary = _vgraph.visibleVNodes;
			var vn_i:IVisualNode;
			var vn_j:IVisualNode;
			
			_maxRepulsiveMotion = 0.0;
			
			for each(vn_i in allVisVNodes) {
				if(!vn_i.isVisible) {
					throw Error("Received invisible node while working on visible vnodes only");
				}
				for each(vn_j in allVisVNodes) {
					if(!vn_j.isVisible) {
						throw Error("Received invisible node while working on visible vnodes only");
					}
					if(vn_i != vn_j) {
						/* call the actual code to apply the repulsion 
						 * between two nodes */
						applyNodeRepulsion(vn_i, vn_j);
					}
				}
			}
		}
		
		/**
		 * @internal
		 * This method actually applies the repulsion between any
		 * two visible nodes and adjustes their target coordinates
		 * accordingly. If two nodes would be on the same spot
		 * it also modifies their current coordinates to move them
		 * apart.
		 * @param vn1 The first node of the node pair to apply the repulsion.
		 * @param vn2 The second node of the node pair to apply the repulsion.
		 * */
		private function applyNodeRepulsion(vn1:IVisualNode, vn2:IVisualNode):void {
			
			var dx:Number = 0;
			var dy:Number = 0;
			
			var vx:Number = vn1.x - vn2.x;
			var vy:Number = vn1.y - vn2.y;
			var lenSquare:Number = (vx * vx) + (vy * vy);
			var minSquareDistance:Number = _MIN_NODE_SEPARATION * _MIN_NODE_SEPARATION;
			
			if (lenSquare < minSquareDistance) {
				lenSquare = minSquareDistance;
			}
			/* get the repulsion number for each node
			 * if for some reason we did not have it initialised 
			 * assert the repulsion map has an entry for each node */
			if(_repulsionMap[vn1] == null || _repulsionMap[vn2] == null) {
				throw Error("repulsionMap for a node not initialised");
			}
			/* Compute the repulsion force */
			var repforce:Number = _REPULSION_CONSTANT * _repulsionMap[vn1] * _repulsionMap[vn2] / lenSquare;
			
			dx = vx * repforce;
			dy = vy * repforce;
						
			//if(lenSquare < 360000) {
			///* if the nodes are too far, i.e. more than 600x600
			 //* we apply a special factor to prevent them from flying away */
				//dx /= lenSquare;
				//dy /= lenSquare;
			//}
				
			var distanceMoved:Number = Math.sqrt(dx*dx + dy*dy);
			_maxRepulsiveMotion = Math.max(distanceMoved, _maxRepulsiveMotion);
			
			/* init if not existing */
			if(_deltaPositions[vn1] == null) {
				_deltaPositions[vn1] = new Point(0,0);
			}
			if(_deltaPositions[vn2] == null) {
				_deltaPositions[vn2] = new Point(0,0);
			}
			
			/* add to vn1 */
			(_deltaPositions[vn1] as Point).offset(dx, dy);
			
			/* subtract from vn2 */
			(_deltaPositions[vn2] as Point).offset(-dx, -dy);
				
			//trace("applyRepulsion4: dx:"+dx+" dy:"+dy+" v1.dx:"+vn1.dx+" v1.dy:"+vn1.dy+" v2.dx:"+vn2.dx+" v2.dy:"+vn2.dy);
		}
		
		/*********************************************
		* Layout Methods - Actual update
		* ********************************************/
		/**
		 * @internal
		 * This method scrolls the view to fit the current
		 * graph view. This should have right behavior until
		 * the view bounds are updated
		 * */
		private function scrollToFit():void {
			
			var scrollX:Number;
			var scrollY:Number;
			
			/* the viewbounds describe the current bounding box of
			 * all nodes */
			if(_viewbounds) {
				/* check if we moved nodes out of bounds and 
				 * do some scrolling */
				if((_viewbounds.left < 0) || (_viewbounds.top < 0) ||
				   (_viewbounds.bottom > _vgraph.height) ||
				   (_viewbounds.right > _vgraph.width)) {
					
					scrollX = (_vgraph.width / 2) - (_viewbounds.x + (_viewbounds.width / 2));
					scrollY = (_vgraph.height / 2) - (_viewbounds.y + (_viewbounds.height / 2));
					
				  /* limit to _SCROLL_STEP pixels at a time */
					scrollX = Math.max(-_SCROLL_STEP, Math.min(scrollX, _SCROLL_STEP))
					scrollY = Math.max(-_SCROLL_STEP, Math.min(scrollY, _SCROLL_STEP))
					
					/* now scroll */
					if((scrollX != 0) || (scrollY != 0)) {
						_vgraph.scroll(scrollX, scrollY);
						_layoutChanged = true;
					}
				}
			}
		}
		
		/**
		 * @internal
		 * This method moves each node (i.e. sets the target coordinates)
		 * then it calls the damping function.
		 * There is some potential to eliminate this, particularily
		 * if the motionLimit things are not used....
		 * */
		private function moveNodes():void {
			
			var visVNodes:Dictionary = _vgraph.visibleVNodes;
			var vn:IVisualNode;
			
			_lastMaxMotion = _maxMotion; // save last maxMotion
			_maxMotionTmp = 0.0;
			
			/* again work on all visible nodes */
			for each(vn in visVNodes) {
				if(!vn.isVisible) {
					throw Error("Received invisible node while working on visible vnodes only");
				}
				/* work on the target coordinates of the node */
				modifyNodeTarget(vn);
			}

			/* maxMotionTmp will be updated during the function 
			 * calls above, so we can use it here */
			_maxMotion = _maxMotionTmp;
		}
		
		/**
		 * @internal
		 * This moves an indiviual node.
		 * It takes the destination coordinates
		 * in each node dx/dy, applies the damper, makes sure the
		 * node does not travel too far and calculates the distance
		 * it will move.
		 * @param vn The node which should be moved.
		 * */
		private function modifyNodeTarget(vn:IVisualNode):void {
			
			var dx:Number;
			var dy:Number;
			var distanceMoved:Number;
			
			/* again, the node should be visible, so we break if it
			 * is not
			 * XXX these checks are currently quite redundant, but
			 * at this maturity level of the code, it may not hurt.
			 * If the code proves to be very stable, some of these may
			 * be removed */
			if(!vn.isVisible) {
				throw Error("Node is not visible but should be!");
			}
			
			/* this should not really happen */
			if(_deltaPositions[vn] == null) {
				_deltaPositions[vn] = new Point(0,0);
			}
			
			dx = (_deltaPositions[vn] as Point).x;
			dy = (_deltaPositions[vn] as Point).y;
			
			//trace("modifyNodeTarget1 for "+vn.id+" dx:"+dx+" dy:"+dy+" damper:"+_damper);
				
			/* apply the damper now to slow things down and stabilise
			 * the movement. The lower the damper the lower the movement
			 * 0.0 means no movement 1.0 means no damping */
			if(_dampingActive 
			   //&& _damper > 0
				) {
				dx = dx * _damper;
				dy = dy * _damper;
			}
				
			/* reapply the value to the node attribite and half the movement
			 * again.
			 * This slows things down more, but don't stop but keep some momentum
			 * in moving nodes, to avoid a problem if some nodes are
			 * already very slow */
			_deltaPositions[vn] = new Point(dx / 2.0, dy / 2.0);
			
			//trace("modifyNodeTarget2 for "+vn.id+" dx:"+dx+" dy:"+dy+" damper:"+_damper);
				
			/* how far did the node move? */
			distanceMoved = Math.sqrt(dx*dx * dy*dy);
				
			//trace("modifyNodeTarget3 for "+vn.id+" distanceMoved:"+distanceMoved);
				
			/*
			trace("modifyNodeTarget4 for "+vn.id+" moveable:"+vn.moveable.toString());
			if(_dragNode != null) {
				trace(" dragnode:"+_dragNode.id);
			}
			*/
			
			/* move the node, but only if it is not currently dragged! */
			if(vn.moveable && vn != _dragNode) {
				//trace("modifyNodeTarget5 for "+vn.id+" vnx:"+vn.x+" vny:"+vn.y);
				vn.x = vn.x + Math.max(-_MOVEPIXELLIMIT, Math.min(_MOVEPIXELLIMIT, dx));
				vn.y = vn.y + Math.max(-_MOVEPIXELLIMIT, Math.min(_MOVEPIXELLIMIT, dy));
				//trace("modifyNodeTarget6 for "+vn.id+" vnx:"+vn.x+" vny:"+vn.y);
			}
			/* update the motion value */
			_maxMotionTmp = Math.max(distanceMoved,_maxMotionTmp);
		}

		/*********************************************
		* Layout Methods - Controlling Motion
		* ********************************************/
		
		/**
		 * @internal
		 * This method calculates and adjusts the neutral _spring 
		 * length, in order for the graph to
		 * fit into ~ 90 % of the available space.
		 * */
		private function adjustRepulsion():void {
			
			var hCoverage:Number;
			var vCoverage:Number;
			var coverage:Number;
			var missingCoverage:Number;
			var deltaCoverage:Number;
			var targetDelta:Number;
			
			// TO-DO: Should it be called here or with actual scrolling? How often?
			/* bounding box of nodes */
			_viewbounds = _vgraph.calcNodesBoundingBox();
			
			/* the viewbounds describe the current bounding box of
			 * all nodes */
			if(_viewbounds) {
				
				/* using the viewbounds the current percentage in coverage can be
				 * calculated */
				hCoverage = (_viewbounds.bottom - _viewbounds.top) / _vgraph.height;
				vCoverage = (_viewbounds.right - _viewbounds.left) / _vgraph.width;
				coverage = Math.max(hCoverage, vCoverage);
				
				//trace("FD af Coverage:" + coverage + " repulsionFactor:" + _repulsionFactor);
				
				if((_prevCoverage > 0) && (coverage > 0)) {
					
					/* calculate the missing coverage and if we are
					 * within the tolerance limit */
					missingCoverage = _AUTOFITCOVERAGE - coverage;
					
					if(Math.abs(missingCoverage) > _AUTOFITCOVERTOLERANCE) {
						/* We are still more away than the tolerance.
						 * Check how much we changed
						 * from last pass, positive result means
						 * we are still expanding, negative means
						 * we are contracting */
						deltaCoverage = coverage - _prevCoverage;
						targetDelta = missingCoverage * 0.2 // why?
						
						//trace("FD af deltaCov:"+deltaCoverage+" targetDelta:"+targetDelta + "Old Spring Length:" + _springLength);
						
						/* impose limits */
						targetDelta = Math.max(-0.05, Math.min(0.05, targetDelta));

						if(deltaCoverage < targetDelta) {
							/* expansion too slow, increase springLength */
							_springLength = Math.min(_springLength + 1, _MAX_EDGE_LENGTH);
						} else {
							/* expansion too fast, decrease springLength*/
							_springLength = Math.max(_springLength - 1, _MIN_NODE_SEPARATION);
						}
						//trace("New Spring Length:"+_springLength);
					}
				}
				_prevCoverage = coverage;
				
				//if(_prevRepulsionFactor != _repulsionFactor) {
					//_prevRepulsionFactor = _repulsionFactor;
				//}
			}
		}

		/**
		 * @internal
		 * This method checks for some motion limit parameters
		 * and to adjust drag parameter.
		 * */
		private function adjustDrag():void {
			/* calculate the motionRatio, the -1 is subtracted to
			 * make positive values mean things are moving faster
			 */
			if(_maxMotion > 0) {
				_motionRatio = (_lastMaxMotion / _maxMotion) - 1;
			} else {
				_motionRatio = 0.0;
			}
			/*
			trace(_maxSpringMotion + "\t"
					+ _maxRepulsiveMotion + "\t"
					+ _maxMotion + "\t"
					+ _motionRatio + "\t"
			    + _damper);
				*/
			/* adjust the value of the damper */
			if(_dampingActive) {
				
				/* Only damp if the graph starts to move faster.
				 * If things are slowing down, let them stabilise on their
				 * own, without damping */
				if(_motionRatio <= 0.005) {
					
					/* if maxMotion < 0.2 damp! OR
					 * if the damper has ticked to 0.9 and maxMotion still > 1, damp!
					 * damper must not be negative though */
					if((_maxMotion < 0.2 || (_maxMotion > 1 && _damper < 0.9)) &&
						_damper > 0.01) {
						_damper -= 0.01;
					}
					/* damp a bit less agressively now */
					else if(_maxMotion < 0.4 && _damper > 0.003) {
						_damper -= 0.003;
					}
					/* damp even less agressively */
					else if(_damper > 0.0001) {
						_damper -= 0.0001;
					}
				}
				
				/* damper 0 means no movement(!) */
				if(_maxMotion < _motionLimit) {
					_damper = 0.0;
				}
			}
		}

		/**
		 * @internal
		 * Updates the new repulsion value for the given node.
		 * @param vn The node to update its repulsion.
		 * */
		private function updateRepulsion(vn:IVisualNode):void {
			
			var newrep:Number;
			
			if(!vn.isVisible) {
				throw Error("Received invisible node while working on visible vnodes only");
			}
			
			/* maybe another factor was once multiplied with this.... */
			newrep = (vn.view.width + vn.view.height) * _repulsionFactor;
			
			if(newrep == 0) {
				newrep = _repulsionFactor;
			}
			
			/* update the value in the map */
			_repulsionMap[vn] = newrep;	
		
			//trace("updated repulsion for node:"+vn.id+" to:"+newrep);
		}
	}
}