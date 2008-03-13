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
package org.un.flex.graphLayout.visual {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.containers.Canvas;
	import mx.controls.Label;
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.events.EffectEvent;
	import mx.utils.ObjectUtil;
	
	import org.un.flex.graphLayout.data.GraphWalkingDirectionsEnum;
	import org.un.flex.graphLayout.data.IEdge;
	import org.un.flex.graphLayout.data.IGraph;
	import org.un.flex.graphLayout.data.INode;
	import org.un.flex.graphLayout.layout.ILayoutAlgorithm;

	/**
	 *  Dispatched when there is any change to the nodes and/or links of this graph.
	 *
	 *  @eventType flash.events.Event
	 */
	[Event(name="vgraphChanged", type="flash.events.Event")]

	/**
	 * This component can visualize and layout a graph data structure in 
	 * a Flex application. It is derived from canvas and thus behaves much
	 * like that in general.
	 * 
	 * Currently the graphs are required to be connected. And for most layouts
	 * a root node is required (as they are tree based).
	 * 
	 * A graph object needs to be specified as well as a layouter object
	 * that implements the ILayoutAlgorithm interface.
	 * 
	 * XXX provide example code here
	 * */
	public class VisualGraph extends Canvas implements IVisualGraph {

		/**
		 * We keep a reference to ourselves (this) in this attribute.
		 * Not really necessary, but it makes the code more clear if
		 * a method is called, that really belongs to the super class.
		 * */
		private var _canvas:Canvas;

		/**
		 * This property holds the Graph object with the graph
		 * data, that is supposed to be visualised. This is also
		 * the only data structure that keeps track of nodes and
		 * edges.
		 * */
		private var _graph:IGraph = null;
	
		/**
		 * This property holds the layouter object. The layouter does the 
		 * calculation of the layout and the placement of the nodes.
		 * It may be exchanged on the fly.
		 * */
		private var _layouter:ILayoutAlgorithm;

		/**
		 * This is a drawing surface to draw the edges on. It is only
		 * used for the edges and is added as a child to the canvas.
		 * */
		private var _drawingSurface:UIComponent; 

		/**
		 * for cleanup we also need a reference source for
		 * vnodes and vedges
		 * */
		private var _vnodes:Dictionary;
		private var _vedges:Dictionary;

		/**
		 * Every visual node is associated with an UIComponent that 
		 * will be the actual visual representation of the node in the
		 * Flashplayer. This UIComponent (which is typically an ItemRenderer)
		 * is called a "view". Node's views are now mainly created on
		 * demand and destroyed if the node is currently not visible
		 * to save resources. This map keeps track of which VNode belongs
		 * to which view. This is required as in certain events, we get
		 * only access to the UIComponent and we need to get hold of
		 * the corresponding node.
		 * */
		private var _viewToVNodeMap:Dictionary;

		/**
		 * A similar map needs to exist for edges
		 * */
		private var _viewToVEdgeMap:Dictionary;

		/**
		 * The standard origin is the upper left corner, but if
		 * the graph is scrolled, this origin may change, so we keep
		 * track of that here.
		 * */
        private var _origin:Point;
        
		/* drag and drop support */
        
        /**
         * This is the current UIComponent that is dragged by the mouse.
         * */
        private var _dragComponent:UIComponent;

		/**
		 * These two maps keep the drag cursor offset positions
		 * for each dragged component. This allows to (theoretically)
		 * drag more than one component at once and to correctly reposition the
		 * component during the drag and at the drop.
		 * */
		private var _drag_x_offsetMap:Dictionary;
		private var _drag_y_offsetMap:Dictionary;
		
		/**
		 * There is generally support to restrict dragging and dropping
		 * to a certain area. These bounds are kept for each dragged
		 * component in this map.
		 * */
		private var _drag_boundsMap:Dictionary;

		/**
		 * The drag cursors starting position is required
		 * if we do a "background drag", i.e. scroll the whole
		 * VisualGraph around. All this does is basically moving all
		 * components with the mouse, thus creating the effect of a 
		 * background drag.
		 * */
        private var _dragCursorStartX:Number;
        private var _dragCursorStartY:Number;
        
		/**
		 * To distinguish an active mouse move drag that drags
		 * a component from one that should drag the background, 
		 * we need this property.
		 * */
        private var _backgroundDragInProgress:Boolean = false;
				
		/**
		 * To enable/disable scrolling while background is being
		 * dragged 
		 * */
    private var _scrollBackgroundInDrag:Boolean = true;
		
		/**
		 * To enable/disable movement while node is being
		 * dragged 
		 * */
    private var _moveNodeInDrag:Boolean = true;

		/* Rendering */

		/**
		 * We allow the specification of an EdgeRenderer object
		 * that draws the Edges using the graphics part of the
		 * drawing surface.
		 * */
        private var _edgeRenderer:IEdgeRenderer = null;

		/**
		 * We allow the specification of an ItemRenderer (i.e. an IFactory)
		 * that allows us to specify the view's for each node in MXML
		 * */
        private var _itemRendererFactory:IFactory = null;
        
        /**
         * Also allow the specification of an IFactory for edge
         * labels.
         * */
        private var _edgeLabelRendererFactory:IFactory = null;
        
        /**
         * Specify whether edge labels should be displayed or not
         * */
        private var _displayEdgeLabels:Boolean = true;
        
        private var _scale : Number = 1
        
        /* Spring Graph also allowed a specification of an IViewFactory
         * which is a custom implementation of a factory that returns
         * UIComponents to be used as a view for a node.
         * Currently not implemented, nor needed.
        private var _viewFactory:IViewFactory = null;
         */

		/**
		 * We keep the default parameters
		 * to draw edges (line width, color, alpha channel)
		 * in this object. The params to be expected are all
		 * params which can be accepted by the lineStyle()
		 * method of the Graphics class.
		 * We keep a separate default set for regular edges and
		 * for distinguished edges.
		 * */
		private var _defaultEdgeStyle:Object = {
			thickness:1,
			alpha:1.0,
			color:0xcccccc,
			pixelHinting:false,
			scaleMode:"normal",
			caps:null,
			joints:null,
			miterLimit:3
		}
		/* currently inactive *
		private var _defaultDistEdgeSettings:Object = {
			thickness:1,
			alpha:1.0,
			color:0xff0000,
			pixelhinting:false,
			scaleMode:"normal",
			caps:null,
			joints:null,
			miterLimit:3
		}
		*/

		/* The visibility of nodes can be controlled in a few ways.
		 * The principal limit is to restrict nodes to only be visible if they
		 * are within a certain distance (in degrees of separation) from the
		 * current root node. In addition previous root nodes can be
		 * made visible */

		/**
		 * This property controls if any visibility limit is currently
		 * active at all. Strongly recommended for large graphs.
		 * The application will be brought to its knees if thousands of nodes
		 * should be displayed. 
		 * */
		private var _visibilityLimitActive:Boolean = true;
		
		/**
		 * Controls the maximum distance from the root that a node
		 * can have to still be visible.
		 * */
		private var _maxVisibleDistance:uint = uint.MAX_VALUE;

		/**
		 * This object hash contains all node ids 
		 * of nodes which are currently within the visible
		 * distance limit. This hash is typically initialised from
		 * from the Graph object. These nodes are NOT all
		 * visible nodes (since the history nodes are also
		 * visible).
		 * */
		private var _nodeIDsWithinDistanceLimit:Dictionary;
		
		/**
		 * This object contains the previuos hash of nodes
		 * within the distance. To keep this helps to avoid
		 * running through all nodes to render the olds
		 * invisible and the new ones visible.
		 * */
		private var _prevNodeIDsWithinDistanceLimit:Dictionary;
		
		/**
		 * This is the number of nodes within the distance
		 * limit.
		 * */
		private var _noNodesWithinDistance:uint;
		
		/**
		 * This Dictionary holds all visible nodes,
		 * i.e. those within the limit and the history
		 * nodes (if the history is enabled), or even all
		 * nodes, if the visibility limitation is disabled.
		 * This directory is indexed by VNode and the values
		 * are the same VNode.
		 * */
		private var _visibleVNodes:Dictionary;
		
		/**
		 * The number of currently visible VNodes.
		 * */
		private var _noVisibleVNodes:int;
		
		/**
		 * This Dictionary keeps track of all currently
		 * visible edges. An edge is visible iff both
		 * attached nodes are visible. This hash is indexed
		 * with Edges and the values are the same Edge objects.
		 * (We do not work really with VEdges, so we keep the
		 * Graph Edges here).
		 * */
		private var _visibleEdges:Dictionary;
		
		/* root nodes, distinguished nodes and history */
		
		/**
		 * This is the current focused / root node. It will be
		 * used as the root for any tree computations and
		 * currently all layouters depend on this.
		 * Typically the root node is selected by double-click.
		 * */
		private var _currentRootVNode:IVisualNode = null;
				
		/**
		 * There is currently a "distinguished" node, which is
		 * different from the root node. The distinguished node is
		 * selected by single-click. The current effect of having
		 * a distinguished node, is that it's attached edges are
		 * drawn in a different colour. This may be changed.
		 * */
		private var _distinguishedNode:IVisualNode = null;
	
		/**
		 * This hash keeps track of all the past root VNodes
		 * thus being the history. If showHistory is enabled,
		 * these nodes are also visible even if they are outside
		 * the visible distance.
		 * */
		private var _currentVNodeHistory:Array = null;
		
		/**
		 * This flag controls whether to show the history nodes or not.
		 * */
		private var _showCurrentNodeHistory:Boolean = false;


		/* public attributes */

		/**
		 * Default visibility setting for new nodes. If
		 * set all new nodes are created visible and with
		 * a view component. Beware of that if you have
		 * many nodes.
		 * */
		public var newNodesDefaultVisible:Boolean = false;

		/**
		 * This property controls whether the mouse cursor
		 * should be locked in the dragged node's center or not.
		 * */
		public var dragLockCenter:Boolean = false;

		/**
		 * If set, this effect will be applied if a view
		 * is created (e.g. while a node becomes visible
		 * or if a new node is created).
		 * */
		public var addItemEffect:Effect;
		
		/**
		 * If set, this effect will be applied if a view
		 * is removed (e.g. a node becomes invisible or
		 * is removed).
		 * */
		public var removeItemEffect:Effect;

		/* for debugging purposes we need a component counter */
		private var _componentCounter:int = 0;

		/**
		 * The constructor just initialises most data structures, but not all
		 * required. Currently it does neither set a Graph object, nor a 
		 * Layouter object. Reasonable defaults may be added as an option.
		 * */
		public function VisualGraph():void {
			
			/* call super class constructor */
			super();
			
			/* initialize maps for drag and drop */
			_drag_x_offsetMap = new Dictionary;
			_drag_y_offsetMap = new Dictionary;
			_drag_boundsMap = new Dictionary;
			
			
			/* set an edge renderer, for now we use the Default,
			 * but at a later stage this could be set externally */
			_edgeRenderer = new DefaultEdgeRenderer();
			
			/* initialise view/ItemRenderer and visibility mapping */
			_vnodes = new Dictionary;
			_vedges = new Dictionary;
			_viewToVNodeMap = new Dictionary;
			_viewToVEdgeMap = new Dictionary;
			_visibleVNodes = new Dictionary;
			_visibleEdges = new Dictionary;
			_noVisibleVNodes = 0;
			_visibilityLimitActive = true;
			
			/* init the history array */
			_currentVNodeHistory = new Array;
			
			/* set the drawing surface for the edges */
			_drawingSurface = new UIComponent();
			
			/* initialize the canvas, we are our own canvas obviously */
			_canvas = this;
			_canvas.addChild(_drawingSurface);
			
			/* disable scrollbars */
			_canvas.verticalScrollPolicy = "off";
			_canvas.horizontalScrollPolicy = "off";
			
			/* add event handlers for background drag/drop i.e. scrolling */
			_canvas.addEventListener(MouseEvent.MOUSE_DOWN,backgroundDragBegin);
			_canvas.addEventListener(MouseEvent.MOUSE_UP,dragEnd);
			
			_origin = new Point(0,0);
		}
		
		/**
		 * This property allows access and setting of the underlying
		 * graph object. If set, it will automatically initialise the VGraph
		 * from the Graph object, i.e. create VNodes and VEdges for each
		 * Graph node and Graph edge.
		 * If there was already a Graph present, the VGraph is purged, but no other
		 * cleanup is done, which means that there could still be
		 * some references floating around thus leaking memory.
		 * For now, avoid setting it more than once in the same
		 * VGraph.
		 * @param g The Graph object to be assigned.
		 * */
		public function set graph(g:IGraph):void {

			
			if(_graph != null) {
				trace("WARNING: _graph in VisualGraph was not null when new graph was assigned."+
					" Some cleanup done, but this may leak memory");
				/* this cleanes the VGraph so we are pristine */
				clearHistory();
				purgeVGraph();
				_graph.purgeGraph();
				_layouter.resetAll();
				_nodeIDsWithinDistanceLimit = null;
				_prevNodeIDsWithinDistanceLimit = null;
				_noNodesWithinDistance = 0;
			}
			
			/* assign defaults */
			_graph = g;
			
			/* better safe than sorry even if it is an empty one */
			initFromGraph();
			
			/* invalidate old root node */
			_currentRootVNode = null;
			
			/* now use the first node as the new default root node */
			if(_graph.nodes.length > 0) {
				_currentRootVNode = (_graph.nodes[0] as INode).vnode;
			}
			
			trace("WARNING: setting a new graph object invalidates the root node,"+
				" a new default root node was set, but it may not be what you want");
		}

		/**
		 * @private
		 * */
		public function get graph():IGraph {
			return _graph;
		}

		/**
		 * @inheritDoc
		 * */
		public function set itemRenderer(ifac:IFactory):void {
			_itemRendererFactory = ifac;
		}
		
		/**
		 * @inheritDoc
		 * */
		public function set edgeRenderer(er:IEdgeRenderer):void {
			_edgeRenderer = er;
		}

		/**
		 * @inheritDoc
		 * */
		public function set edgeLabelRenderer(elr:IFactory):void {
			_edgeLabelRendererFactory = elr;
		}

		/**
		 * @inheritDoc
		 * */
		public function set displayEdgeLabels(del:Boolean):void {
			var e:IEdge;
			
			if(_displayEdgeLabels == del) {
				// no change
			} else {
				_displayEdgeLabels = del;
				updateVisibility();
				this.invalidateDisplayList(); // maybe this is enough
			}
				
				/* removed code which probably made problems 
				
				/* from false to true *
				if(del == true) {
					/* walk through all visible edges and create and display their labels *
					for each(e in _visibleEdges) {
						createVEdgeView(e.vedge);
					}
				/* true to false *
				} else {
					/* walk again, but remove labels this time *
					for each(e in _visibleEdges) {
						removeVEdgeView(e.vedge.labelView);
					}
				}
			}
			*/
		}

		/**
		 * @private
		 * */
		public function get displayEdgeLabels():Boolean {
			return _displayEdgeLabels;
		}

		/**
		 * @inheritDoc
		 * */
		public function get layouter():ILayoutAlgorithm {
			return _layouter;
		}
	
		/**
		 * @private
		 * */
		public function set layouter(l:ILayoutAlgorithm):void {
			if(_layouter != null) {
				_layouter.resetAll(); // to stop any pending animations
			}
			_layouter = l;
		}

		/**
		 * @inheritDoc
		 * */
		public function get origin():Point {
			return _origin;
		}
		
		/**
		 * @inheritDoc
		 * */
		public function get center():Point {
			return new Point(_canvas.width / 2.0, _canvas.height / 2.0);
		}

		/**
		 * @inheritDoc
		 * */
		public function get visibleVNodes():Dictionary {
			return _visibleVNodes;
		}

		/**
		 * @inheritDoc
		 * */
		public function get noVisibleVNodes():uint {
			return _noVisibleVNodes;
		}

		/**
		 * @inheritDoc
		 * */
		public function get visibleEdges():Dictionary {
			return _visibleEdges;
		}
		
		/**
		 * @inheritDoc
		 * */
		[Bindable]
		public function get visibilityLimitActive():Boolean {
			return _visibilityLimitActive;
		}
		/**
		 * @private
		 * */
		public function set visibilityLimitActive(ac:Boolean):void {
			/* check for a change */
			if(_visibilityLimitActive != ac) {	
				/* execute the change */
				_visibilityLimitActive = ac;
				/* activate? */
				if(ac) {
					if(_currentRootVNode == null) {
						trace("No root selected, not creating limited graph, not doing anything.");
						return;
					}
					//trace("getting limited node ids with limit:"+_maxVisibleDistance);
					
					/* 1. Get the spanning tree, rooted in our current root node from
					 *    the graph object.
					 * 2. Get the hash from this tree, that contains only the nodes
					 *    within the set distance.
					 * 3. Use this to set our properties for the nodes within the distance
					 *    limit.
					 */
					setDistanceLimitedNodeIds(_graph.getTree(_currentRootVNode.node,false, false, GraphWalkingDirectionsEnum.BOTH).
						getLimitedNodes(_maxVisibleDistance));
					
					/* now update all other visibility data structure
					 * this also forces a redraw() (and layout) of the 
					 * visualisation */
					updateVisibility();
				}
				/* when we deactivate this limit, we render all nodes
				 * visible! */
				else {
					setAllVisible();
				}
			}
		}
		

		/**
		 * @inheritDoc
		 * */
		[Bindable]
		public function get maxVisibleDistance():int {
			return _maxVisibleDistance;
		}
		
		/**
		 * @private
		 * */
		public function set maxVisibleDistance(md:int):void {
			/* check if there was a change */
			if(_maxVisibleDistance != md) {
				/* if yes, apply the change */
				_maxVisibleDistance = md;
				//trace("visible distance changed to: "+md);
				
				/* if our current limits are active we create a new
				 * set of nodes within the distance and update the
				 * visibility */
				if(_visibilityLimitActive) {
					if(_currentRootVNode == null) {
						trace("No root selected, not creating limited graph");
						return;
					} else {
						setDistanceLimitedNodeIds(_graph.getTree(_currentRootVNode.node,false,false,GraphWalkingDirectionsEnum.BOTH).
							getLimitedNodes(_maxVisibleDistance));
						updateVisibility();
					}
				}
			}
		}
		
		
		/**
		 * This was added for testing. It may be removed
		 * again.
		 * */
		public function get currentRootSID():String {
			return _currentRootVNode.node.stringid;
		}
		
		/**
		 * @inheritDoc
		 * */
		[Bindable]
		public function get currentRootVNode():IVisualNode {
			return _currentRootVNode;
		}
		/**
		 * @private
		 * */
		public function set currentRootVNode(vn:IVisualNode):void {
			/* check for a change */
			if(_currentRootVNode != vn) {
				
				/* apply the change */
				_currentRootVNode = vn;

				/* now update the history with the new node */
				_currentVNodeHistory.unshift(_currentRootVNode);
				
				//trace("node:"+_currentRootVNode.id+" added to history");
				
				/* if we are currently limiting node visibility,
				 * update the set of visible nodes since we 
				 * have changed the root, the spanning tree has changed
				 * and thus the set of visible nodes */
				if(_visibilityLimitActive) {
					setDistanceLimitedNodeIds(_graph.getTree(_currentRootVNode.node,false,false,GraphWalkingDirectionsEnum.BOTH).
						getLimitedNodes(_maxVisibleDistance));
					updateVisibility();
				} else {
					/* if we do not limit visibility, we still need
					 * to force a new layout and redraw()
					 * (in the other case, this is done by updateVisibility()) */
					draw();
				}
			}
		}		

		public function set scrollBackgroundInDrag(f:Boolean):void {
			_scrollBackgroundInDrag = f;
		}
		
		public function set moveNodeInDrag(f:Boolean):void {
			_moveNodeInDrag = f;
		}
		/**
		 * @inheritDoc
		 * */
		public function get showHistory():Boolean {
			return _showCurrentNodeHistory;
		}

		
		/**
		 * @private
		 * */
		public function set showHistory(h:Boolean):void {
			/* check for a change */
			if(_showCurrentNodeHistory != h) {
				_showCurrentNodeHistory = h;
			
				/* makes no sense without root set */
				if(_currentRootVNode != null) {
					/* becomes only active if we have the limit active */
					if(_visibilityLimitActive) {
						/* now update the visibility. This also applies the
						 * history information to the node visibility */
						updateVisibility();
					}
				}
			}
		}

		public function set scale(s : Number) : void
		{
			const s0 : Number = scaleX
			scaleX = s
			scaleY = s
			scroll(center.x * (1 - s / s0) / s, center.y * (1 - s / s0) / s)
			refresh()
			_scale = s
		}
		
		public function get scale() : Number
		{
			return _scale
		}

		/**
		 * This initialises a VGraph from a Graph object.
		 * I.e. it crates a VNode for every Node found in
		 * the Graph and a VEdge for every Edge in the Graph.
		 * Careful, this currently does not check if the VGraph
		 * was already initialised and it does not purge anything.
		 * Things could break of used on an already initialized VGraph.
		 * */
		public function initFromGraph():void {
			
			var node:INode;
			var edge:IEdge;
			
			/* create the vnode from the node */
			for each(node in _graph.nodes) {
				this.createVNode(node);
				trace("created VNode for node:"+node.id);
			}
			
			/* we also create the edge objects, since they
			 * may carry additional label information or something
			 * like that, but they do not have a view */
			for each(edge in _graph.edges) {
				this.createVEdge(edge);
			}
		}
		
		/**
		 * @inheritDoc
		 * */
		public function clearHistory():void {
			_currentVNodeHistory = new Array();
		}



		/**
		 * @inheritDoc
		 * */
		public function calcNodesBoundingBox():Rectangle {
			
			var children:Array;
			var result:Rectangle;
			
			/* get all children of our canvas, these should only
			 * be node views and the edge drawing surface. */
			children = _canvas.getChildren();
			
			/* init the rectangle with some large values. 
			 * Originally I wanted to use Number.MAX_VALUE / Number.MIN_VALUE but
			 * ran into serious numerical problems, thus 
			 * we use +/- 999999 for now, although this is 
			 * more like a hack.
			 * Note that the coordinates are reversed, i.e. the origin of the rectangle
			 * has been pushed to the far bottom right, and the height and width
			 * are negative */
			result = new Rectangle(999999, 999999, -999999, -999999);

			//trace("THIS CANVAS currently HAS:"+children.length+" children!!");

			/* if there are no children at all, there may be something
			 * wrong as it should at least contain the drawing surface */
			if(children.length == 0) {
				trace("Canvas has no children, not even the drawing surface!");
				return null;
			}
			
			/* The children should only be the visible node's views and
			 * the drawing surface for the edges, so we
			 * add a safeguard here to see of these are actually much more */
			
			/* since the edge labels were introduced this no longer works
			 * because we also need to count each displayed edge label
			 * but we have no counter yet for that, so the check is commented
			 * for now
			if(children.length > _noVisibleVNodes + 1) {
				throw Error("Children are more than visible nodes plus drawing surface");
			}
			*/
			
			/* now walk through all children, which are UIComponents
			 * and not our drawing surface and expand the result rectangle */
			for(var i:int = 0;i < children.length; ++i) {
					
				var view:UIComponent = (children[i] as UIComponent);
				
				/* only consider currently visible views */
				if(view.visible) {
					if(view != _drawingSurface) {
						result.left = Math.min(result.left, view.x);
						result.right = Math.max(result.right, view.x + view.width);
						result.top = Math.min(result.top, view.y);
						result.bottom = Math.max(result.bottom, view.y+view.height);
					} else {
						if(children.length == 1) {
							/* only child is the drawing surface, we return an empty Rectangle
							 * anchored in the middle */
							return new Rectangle(_canvas.width / 2, _canvas.height / 2, 0, 0);
						}
					}
				}
			}
			return result;
		}
		
		/** 
		 * @inheritDoc
		 * */
		public function createNode(sid:String = "", o:Object = null):IVisualNode {
			
			var gnode:INode;
			var vnode:IVisualNode;
			
			/* first add a new node to the underlying graph */
			gnode = _graph.createNode(sid,o);
			
			/* Then create the VNode with associated with the graph node */
			vnode = createVNode(gnode);
			
			/* since it is a requirement from most layouters
			 * to always have a current root node
			 * we assign the current root node to the newly
			 * created node so we have one. Note that this does
			 * not affect the root node history. */
			_currentRootVNode = vnode;

			return vnode;
		}
	
		/**
		 * @inheritDoc
		 * */
		public function removeNode(vn:IVisualNode):void {
			
			var n:INode;
			var e:IEdge;
			var ve:IVisualEdge;
			var i:int;
			
			n = vn.node;
					
			/* if the current root node is the
			 * node to be removed it must be
			 * changed.
			 *
			 * First, we set it to null, then we remove the
			 * node, then at the end we reset it
			 * to the first node still in the
			 * nodes array */
			if(vn == _currentRootVNode) {
				/* temporary set to null */
				_currentRootVNode = null;
			}
			
			/* remove all incoming edges */
			while(n.inEdges.length > 0) {
				e = n.inEdges[0] as IEdge;
				ve = e.vedge;
				removeVEdge(ve);
				_graph.removeEdge(e);
			}
			
			/* remove all outgoing edges */
			while(n.outEdges.length > 0) {
				e = n.outEdges[0] as IEdge;
				ve = e.vedge;
				removeVEdge(ve);
				_graph.removeEdge(e);
			}
			
			/* remove the vnode */
			removeVNode(vn);
			
			/* remove the node from the graph */
			_graph.removeNode(n);
			
			/* now set a new root node, implies that there is
			 * still a node */
			if(_currentRootVNode == null && _graph.noNodes > 0) {
				_currentRootVNode = (_graph.nodes[0] as INode).vnode;
			}
			
			/* since we removed also edges, we need a refresh */
			refresh();
		}
	
		
		/** 
		 * @inheritDoc
		 * */
		public function linkNodes(v1:IVisualNode, v2:IVisualNode):IVisualEdge {
			
			var n1:INode;
			var n2:INode;
			var e:IEdge;
			var ve:IVisualEdge;
			
			/* make sure both nodes do exist */
			if(v1 == null || v2 == null) {
				throw Error("linkNodes: one of the nodes does not exist");
				//return null;
			}
			
			n1 = v1.node;
			n2 = v2.node;
			
			/* now first link the graph nodes and create the corresponding edge */
			e = _graph.link(n1,n2,null);
			
			/* if the edge existed already, e is just the
			 * already existing edge. But if it existed
			 * previously it might already have a VEdge.
			 * So we only create a new VEdge, if it did not exist
			 * already. */		
			if(e == null) {
				throw Error("Could not create or find Graph edge!!");
			} else {
				if(e.vedge == null) {
					/* we have a new edge, so we create a new VEdge */
					ve = createVEdge(e);
				} else {
					/* existing one, so we use the existing vedge */
					trace("Edge already existed, returning existing vedge");
					ve = e.vedge;
				}
			}
	
			//trace("linkNodes, created edge "+(e as Object).toString()+" from nodes: "+n1.id+", "+n2.id);

			/* this changes the layout, so we have to do a full redraw */
			// if we link nodes we may not necesarily want to draw();
			/* just refresh the edges */
			refresh();
			return ve;
		}

		/** 
		 * @inheritDoc
		 * */
		public function unlinkNodes(v1:IVisualNode, v2:IVisualNode):void {

			var n1:INode;
			var n2:INode;
			var e:IEdge;
			var ve:IVisualEdge;
			
			/* make sure both nodes exist */
			if(v1 == null || v2 == null) {
				throw Error("unlink nodes: one of the nodes does not exist");
				return;
			}
			
			n1 = v1.node;
			n2 = v2.node;
			
			/* find the graph edge */
			e = _graph.getEdge(n1,n2);
			
			/* if we do not get an edge, it may simply not exist */
			if(e == null) {
				trace("No edge found between: "+n1.id+" and "+n2.id);
				return;
			}
			
			/* now get and remove the VEdge first */
			ve = e.vedge;			
			removeVEdge(ve);
	
			/* now remove the edge itself, basically
			 * unlinking the nodes */
			_graph.removeEdge(e);

			//trace("removed edge: "+e.id+" : "+n1.id+" and "+n2.id);			
			
			/* again a full redraw is required */
			//draw();
			/* no just refresh the edges */
			refresh();
		}


		/**
		 * @inheritDoc
		 * */
		public function scroll(deltaX:Number, deltaY:Number):void {
			
			var i:uint;
			var children:Array;
			var view:UIComponent;
			
			children = _canvas.getChildren();
			
			/* we walk through all children of the canvas, which
			 * are not the drawing surface and which are UIComponents
			 * (they should be all node views) and move them according
			 * to the scroll offset */
			for each(view in children) {
				if(view != _drawingSurface) {
					//trace("scrolling view of:"+(view as IDataRenderer).data.id);
					view.x += deltaX;
					view.y += deltaY;
				}
			}
			
			/* adjust the current origin of the canvas
			 * (not 100% sure if this is a good idea but seems
			 * to work) XXX */
			_origin.offset(deltaX,deltaY);
			//trace("Setting new origin to:"+_origin.toString());
		}

		/**
		 * @inheritDoc
		 * */
		public function refresh():void {
			/* this forces the next call of updateDisplayList()
			 * to redraw all edges */
			if(_layouter) {
				_layouter.layoutChanged = true;
			}
			_canvas.invalidateDisplayList();
		}

		/**
		 * @inheritDoc
		 * */
		public function draw():void {	
			
			/* first refresh does layoutChanges to true and
			 * invalidate display list */
			refresh();
			
			/* then force a layout pass in the layouter */
			if(_layouter && _currentRootVNode && (_graph.noNodes > 0)) {
				_layouter.layoutPass();
			}
			
			/* after the layout was passed, the layout has
			 * probably changed again, the layouter will have
			 * itself set to that, but has maybe not
			 * invalidated the display list, so we make sure it
			 * happens here (may not always be necessary) */
			_canvas.invalidateDisplayList();
			
			/* dispatch this change event, so some UI items
			 * in the application can poll for updated values
			 * for labels or something.
			 * XXX To do: define a proper event for this or
			 * use an appropriate event from the canvas.
			 */
			dispatchEvent(new Event("vgraphChanged"));
		}


		/**
		 * This calls the base updateDisplayList() method of the
		 * Canvas and in addition redraws all edges if the layouter
		 * indicates that the layout has changed.
		 * 
		 * @inheritDoc
		 * */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			/* call the original function */
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			/* now add part to redraw edges */
			if(_layouter && _layouter.layoutChanged) {
				redrawEdges();
				/* reset the flag */
				_layouter.layoutChanged = false;
			}
		}

		/* private methods */

		/**
		 * Creates VNode and requires a Graph node to associate
		 * it with. Originally also created the view, but we no
		 * longer do that directly but only on demand.
		 * @param n The graph node to be associated with.
		 * @return The created VisualNode.
		 * */
		private function createVNode(n:INode):IVisualNode {
			
			var vnode:IVisualNode;
			
			/* as an id we use the id of the graph node for simplicity
			 * for now, it is not really used separately anywhere
			 * we also use the graph data object as our data object.
			 * the view is set to null and remains so. */
			vnode = new VisualNode(this, n, n.id, null, n.data);
			
			/* if the node should be visible by default 
			 * we need to make sure that the view is created */
			if(newNodesDefaultVisible) {
				setNodeVisibility(vnode, true);
			}

			/* now set the vnode in the node */
			n.vnode = vnode;
			
			/* add the node to the hash to keep track */
			_vnodes[vnode] = vnode;
			
			
			return vnode;
		}

		/**
		 * Removes a VNode, this also removes the node's view
		 * if it existed, but does not touch the Graph node.
		 * @param vn The VisualNode to be removed.
		 * */
		private function removeVNode(vn:IVisualNode):void {
			
			var view:UIComponent;
			
			/* get access to the node's view, but get the 
			 * raw view to avoid unnecessary creation of a view
			 */
			view = vn.rawview;
			
			/* delete reference to the view from the node */
			vn.view = null;
			
			/* remove the reference to this node from the graph node */
			vn.node.vnode = null;
			
			/* now remove the view component if it existed */
			if(view != null) {
				removeComponent(view);
			}
			
			/* remove from the visible vnode map if present */
			if(_visibleVNodes[vn] != undefined) {
				delete _visibleVNodes[vn];
				--_noVisibleVNodes;
			}
			
			/* remove from tracking hash */
			delete _vnodes[vn];
			
			/* this should clean up all references to this VNode
			 * thus freeing it for garbage collection */
		}


		/**
		 * Creates a VEdge from a graph Edge.
		 * @param e The Graph Edge.
		 * @return The created VEdge.
		 * */
		private function createVEdge(e:IEdge):IVisualEdge {
			
			var vedge:IVisualEdge;
			var n1:INode;
			var n2:INode;
			var lStyle:Object;
			var edgeAttrs:XMLList;
			var attr:XML;
			var attname:String;
			var attrs:Array;
		
			/* create a copy of the default style */
			lStyle = ObjectUtil.copy(_defaultEdgeStyle);
			
			/* extract style data from associated XML data for each parameter */
			attrs = ObjectUtil.getClassInfo(lStyle).properties;
			
			for each(attname in attrs) {
				if(e.data != null && (e.data as XML).attribute(attname).length() > 0) {
					lStyle[attname] = e.data.@[attname];
				}
			}
			
			vedge = new VisualEdge(this, e, e.id, e.data, null, lStyle);
			
			/* set the VisualEdge reference in the graph edge */
			e.vedge = vedge;
			
			/* check if the edge is supposed to be visible */
			n1 = e.node1;
			n2 = e.node2;
			
			if(n1.vnode.isVisible && n2.vnode.isVisible) {
				_visibleEdges[e] = e;
			}
			
			/* add to tracking hash */
			_vedges[vedge] = vedge;
			
			return vedge;
		}

		/**
		 * Remove a VisualEdge, but leaves the Graph Edge alone.
		 * @param ve The VisualEdge to be removed.
		 * */
		private function removeVEdge(ve:IVisualEdge):void {
			
			/* just in case */
			if(ve == null) {
				return;
			}
			
			/* see if the edge has a view and remove that */
			if(ve.labelView != null) {
				removeVEdgeView(ve.labelView);
			}
			
			/* remove the reference from the real edge */
			ve.edge.vedge = null;
			
			/* remove the visible edge if present */
			delete _visibleEdges[ve.edge];
			
			/* remove from tracking hash */
			delete _vedges[ve];
			
			/* that should actually do */
		}
	
		/**
		 * Purges the VGraph by dropping all VNodes and VEdges.
		 * This is a bit tricky, since we do not really
		 * keep track of them in the VGraph, they are only referenced
		 * by the Graph nodes and egdes.
		 * */
		private function purgeVGraph():void {
			
			var ves:Array = new Array;
			var vns:Array = new Array;
			var ve:IVisualEdge;
			var vn:IVisualNode;
			
			/* this appears rather inefficient, however
			 * ObjectUtil.copy does not work on dictionaries
			 * currently I have no other solution
			 */
			for each(ve in _vedges) {
				ves.unshift(ve);
			}
			for each(vn in _vnodes) {
				vns.unshift(vn);
			}
			
			trace("purgeVGraph called");
			
			if(_graph != null) {
				for each(ve in ves) {
					removeVEdge(ve);
				}
				for each(vn in vns) {
					removeVNode(vn);
				}
			} else {
				trace("we had no graph to purge from, so nothing was done");
			}				
		}
	
		/**
		 * Redraw all edges, this is called from the updateDisplayList()
		 * method.
		 * @inheritDoc
		 * */
		public function redrawEdges():void {
			
			var vn1:IVisualNode;
			var vn2:IVisualNode;
			var color:int;
			var edge:IEdge;
			
			/* make sure we have a graph */
			if(_graph == null) {
				throw Error("_graph object in VisualGraph is null");
			}
	
			/* clear the drawing surface and remove previous
			 * edges */
			_drawingSurface.graphics.clear();
			
			/* now walk through all currently visible egdes */
			for each(edge in _visibleEdges) {
				
				/* get the two nodes attached to the edge */
				vn1 = edge.node1.vnode;
				vn2 = edge.node2.vnode;
				
				/* all nodes should be visible, so we make an assertion
				 * here */
				if(!vn1.isVisible || !vn2.isVisible) {
					throw Error("One of the nodes of the checked edge is not visible, but should be!");
				}
				
				/* XXX THIS DOES CURRENTLY NO LONGER WORK
				 * The following controls the colouring but this should
				 * be optimised and handled more flexible */
				/*
				if(vn1 == _distinguishedNode || vn2 == _distinguishedNode) {
					distinguished = true;
				} else {
					distinguished = false;
				}
				*/

				/* now check if we should display edge labels, and if so
				 * create an edge view to display the label, if it is not
				 * there already */
				if(_displayEdgeLabels) {
					if(edge.vedge.labelView == null) {
						trace("Created missing labelView for edge:"+edge.id);
						createVEdgeView(edge.vedge);
					}
				}


				/* Change: we do not pass the nodes or the vnodes, but the
				 * edge. The reason is that the edge can have properties
				 * assigned with it that affect the drawing. Right now we 
				 * pass the fact if this is a 'distinguished' edge and leave
				 * the color choice up to the edgerenderer */
				drawEdge(edge);
			}
			// we are done, so we reset the indicator
			_layouter.layoutChanged = false;
		}
		
		/**
		 * this currently ONLY calls the edge renderer, this 
		 * method is basically useless and we could move the call
		 * into redrawEdges(). For now we leave it like this
		 * 
		 * */
		private function drawEdge(edge:IEdge):void {
			_edgeRenderer.draw(_drawingSurface.graphics, edge, _displayEdgeLabels);
		}
		

		/**
		 * Lookup a node by its UIComponent. This is more a convenience
		 * method with some sanity check. Primarily used by event handlers.
		 * @param c The component to find the VisualNode for.
		 * @return The found Node.
		 * @throws An Error if the component was not registered in the map.
		 * */
		private function lookupNode(c:UIComponent):IVisualNode {
			var vn:IVisualNode = _viewToVNodeMap[c];
			if(vn == null) {
				throw Error("Component not in viewToVNodeMap");
			}
			return vn;
		}
		
		
		
		/**
		 * Create a "view" object (UIComponent) for the given node and
		 * return it. These methods are only exported to be used by
		 * the VisualNode. Alas, AS does not provide the "friend" directive.
		 * Not sure how to get around this problem right now.
		 * @param vn The node to replace/add a view object.
		 * @return The created view object.
		 * */
		private function createVNodeComponent(vn:IVisualNode):UIComponent {
			
			var mycomponent:UIComponent = null;
			
			 /*
			  * a possible view factory is our own implementation
			  * of such a Factory, currently not used.
			 if(_viewFactory != null) {
			 	result = viewFactory.getView(VNode) as UIComponent;
			 }
			 */

			if(_itemRendererFactory != null) {
				mycomponent = _itemRendererFactory.newInstance();
			} else {
				mycomponent = new UIComponent();
			}			
				
			/* assigns the item (VisualNode) to the IDataRenderer part of the view
			 * this is important to access the data object of the VNode
			 * which contains information for rendering. */		
			if(mycomponent is IDataRenderer) {
				(mycomponent as IDataRenderer).data = vn;
			}
			
			/* set initial x/y values */
			mycomponent.x = origin.x + _canvas.width / 2.0;
			mycomponent.y = origin.y + _canvas.height / 2.0;
			
			/* add event handlers for dragging and double click */			
			mycomponent.doubleClickEnabled = true;
			mycomponent.addEventListener(MouseEvent.DOUBLE_CLICK, nodeDoubleClick);
			mycomponent.addEventListener(MouseEvent.MOUSE_DOWN,nodeMouseDown);
			mycomponent.addEventListener(MouseEvent.MOUSE_UP, dragEnd);

			/* add the component to its parent component */
			_canvas.addChild(mycomponent);
			
			/* do we have an effect set for addition of
			 * items? If yes, create and start it. */
			if(addItemEffect != null) {
				addItemEffect.createInstance(mycomponent).startEffect();
			}
			
			/* register it the view in the vnode and the mapping */
			vn.view = mycomponent;
			_viewToVNodeMap[mycomponent] = vn;
			
			/* increase the component counter */
			++_componentCounter;
			
			/* assertion there should not be more components than
			 * visible nodes */
			if(_componentCounter > (_noVisibleVNodes)) {
				throw Error("Got too many components:"+_componentCounter+" but only:"+_noVisibleVNodes
				+" nodes visible");
			}
			
			/* we need to invalidate the display list since
			 * we created new children */
			refresh();
			
			return mycomponent;
		}
		
		/**
		 * Remove a "view" object (UIComponent) for the given node and specify whether
		 * this should honor any specified add/remove effects.
		 * These methods are only exported to be used by
		 * the VisualNode. Alas, AS does not provide the "friend" directive.
		 * Not sure how to get around this problem right now.
		 * @param component The UIComponent to be removed.
		 * @param honorEffect To specify whether the effect should be applied or not.
		 * */
		private function removeComponent(component:UIComponent, honorEffect:Boolean = true):void {
			
			var vn:IVisualNode;
			
			/* if there is an effect, start the effect and register a
			 * handler that actually calls this method again, but
			 * with honorEffect set to false */
			if(honorEffect && (removeItemEffect != null)) {
				removeItemEffect.addEventListener(EffectEvent.EFFECT_END,
												   removeEffectDone);
				removeItemEffect.createInstance(component).startEffect();
			} else {
				/* remove the component from it's parent (which should be the canvas) */
				if(component.parent != null) {
					component.parent.removeChild(component);
				}
				
				/* remove event mouse listeners */
				component.removeEventListener(MouseEvent.DOUBLE_CLICK,nodeDoubleClick);
				component.removeEventListener(MouseEvent.MOUSE_DOWN,nodeMouseDown);
				component.removeEventListener(MouseEvent.MOUSE_UP, dragEnd);
				
				/* get the associated VNode and remove the view from it
				 * and also remove the map entry */
				vn = _viewToVNodeMap[component];
				vn.view = null;
				delete _viewToVNodeMap[component];
				
				/* decreate component counter */
				--_componentCounter;
				
				//trace("removed component from node:"+vn.id);
			}
		}
		
		/**
		 * Create a "view" object (UIComponent) for the given edge and
		 * return it.
		 * @param ve The edge to replace/add a view object.
		 * @return The created view object.
		 * */
		private function createVEdgeView(ve:IVisualEdge):UIComponent {
			
			var mycomponent:UIComponent = null;

			if(_edgeLabelRendererFactory != null) {
				mycomponent = _edgeLabelRendererFactory.newInstance();
			} else {
				mycomponent = new Label; // this is our default label.
				mycomponent.setStyle("textAlign","center");
			}			
				
			/* assigns the edge to the IDataRenderer part of the view
			 * this is important to access the data object of the VEdge
			 * which contains information for rendering. */		
			if(mycomponent is IDataRenderer) {
				(mycomponent as IDataRenderer).data = ve;
			}
			
			/* set initial x/y values */
			mycomponent.x = _canvas.width / 2.0;
			mycomponent.y = _canvas.height / 2.0;
			
			/* add the component to its parent component
			 * this can create problems, we have to see where we
			 * check for all children
			 * Add after the edges layer, but below all other elements such as nodes */
			_canvas.addChildAt(mycomponent, 1);
			
			/* register it the view in the vnode and the mapping */
			/*
			if(ve.labelView != null) {
				trace("Edge:"+ve.edge.id+" has already view:"+ve.labelView.toString()+" will be overwritten");
			} else {
				trace("Edge:"+ve.edge.id+" gets new view.");
			}
			*/
			
			
			ve.labelView = mycomponent;
			_viewToVEdgeMap[mycomponent] = ve;
			
			/* increase the component counter */
			//++_componentCounter;
			
			/* assertion there should not be more components than
			 * visible nodes */
			/*
			if(_componentCounter > (_noVisibleVNodes)) {
				throw Error("Got too many components:"+_componentCounter+" but only:"+_noVisibleVNodes
				+" nodes visible");
			}
			*/
			
			/* we need to invalidate the display list since
			 * we created new children */
			refresh();
			
			return mycomponent;
		}
		
		/**
		 * Remove a "view" object (UIComponent) for the given edge.
		 * @param component The UIComponent to be removed.
		 * */
		private function removeVEdgeView(component:UIComponent):void {
			
			var ve:IVisualEdge;
			
			
			/* remove the component from it's parent (which should be the canvas) */
			if(component.parent != null) {
				component.parent.removeChild(component);
			}

			/* get the associated VEdge and remove the view from it
			 * and also remove the map entry */
			ve = _viewToVEdgeMap[component];
			ve.labelView = null;
			delete _viewToVEdgeMap[component];
				
			/* decreate component counter */
			//--_componentCounter;
			
			//trace("removed component from node:"+vn.id);
		}
		
		
		/**
		 * Event handler for a removal node procedure. Calls
		 * removeComponent with a flag to avoid doing the effect again.
		 * */
		private function removeEffectDone(event:EffectEvent):void {
			var mycomponent:UIComponent = event.effectInstance.target as UIComponent;
			/* call remove component again, but specify to ignore the effect */
			removeComponent(mycomponent, false);
		}
		
		/**
		 * Event handler to work on double-click events.
		 * Any double click also counts as a drop event to
		 * the layouter. But primarily the double click
		 * sets a new root node.
		 * @param e The corresponding event.
		 * */
		private function nodeDoubleClick(e:MouseEvent):void {
			var comp:UIComponent;
			var vnode:IVisualNode;
			
			/* get the view object that was klicked on (actually
			 * the one that has the event handler registered, which
			 * is the VNode's view */
			comp = (e.currentTarget as UIComponent);
			
			/* get the associated VNode */
			vnode = lookupNode(comp);
			
			//trace("double click!");
			
			/* Now we change the root node, we go through
			 * our public setter method to get all associated
			 * updates done. */
			this.currentRootVNode = vnode;
			
			//trace("currentVNode:"+this.currentRootVNode.id);
			
		}

		/**
		 * This is the event handler for a single click 
		 * event. Currently does two things:
		 * 1. It highlights the node that
		 *    was clicked on (highlight in terms of making it
		 *    a distinguished node, which changes the colours
		 *    of its associated edges).
		 * 2. Starts a drag operation of this node.
		 * @param e The associated event.
		 * */
		private function nodeMouseDown(e:MouseEvent):void {
			highlightNode(e);
			dragBegin(e);
		}
		/**
		 * Highlight a node that was target of the passed
		 * event by making it the distinguished node.
		 * @param event The Mouse event that was triggered by click.
		 * */
		private function highlightNode(event:MouseEvent):void {
			var comp:UIComponent;
			var vnode:IVisualNode;
			
			/* get the view object that was klicked on (actually
			 * the one that has the event handler registered, which
			 * is the VNode's view */
			comp = (event.currentTarget as UIComponent);
			
			/* get the associated VNode */
			vnode = lookupNode(comp);
			
			
			
			if(vnode) {				
				/* set the node as distinguished */
				_distinguishedNode = vnode;
				
				/* make sure the edges are redrawn so that
				 * the changed color is shown */
				refresh();
			}
		}
		
		/**
		 * Start a drag operation. This sets the drag node and
		 * registeres a 'MouseMove' event handler with the
		 * VNode, so it can follow the mouse movement.
		 * @param event The MouseEvent that was triggered by clicking on the node.
		 * @see handleDrag()
		 * */
		private function dragBegin(event:MouseEvent):void {
			
			var ecomponent:UIComponent;
			var evnode:IVisualNode;
			var pt:Point;
			
			//trace("DragBegin was called...");
			
			/* if there is an animation in progress, we ignore
			 * the drag attempt */
			if(_layouter.animInProgress) {
				trace("Animation in progress, drag attempt ignored");
				return;
			}
			
			/* make sure we get the right component */
			if(event.currentTarget is UIComponent) {
				
				ecomponent = (event.currentTarget as UIComponent);
				
				/* get the associated VNode of the view */
				evnode = _viewToVNodeMap[ecomponent];
				
				/* stop propagation to prevent a concurrent backgroundDrag */
				event.stopImmediatePropagation();
				
				if(evnode != null) {
					if(!dragLockCenter) {
						// lockCenter is false, use the mouse coordinates at the point
						pt = ecomponent.localToGlobal(new Point(ecomponent.mouseX, ecomponent.mouseY));
					} else {
						// lockCenter is true, ignore the mouse coordinates
						// and use (0,0) instead as the point
						//TODO: change to the components`s center instead
						pt = ecomponent.localToGlobal(new Point(0,0));
					}
			
					/* Save the offset values in the map 
					 * so we can compute x and y correctly in case
					 * we use lockCenter */
					_drag_x_offsetMap[ecomponent] = pt.x / scaleX - ecomponent.x;
					_drag_y_offsetMap[ecomponent] = pt.y / scaleY - ecomponent.y;
			
					/* now we would need to set the bounds
					 * rectangle in _drag_boundsMap, but this is
					 * currently not implemented *
					_drag_boundsMap[ecomponent] = rectangle;
					 */
					
					/* Registeran eventListener with the component's stage that
					 * handles any mouse move. This wires the component
					 * to the mouse. On every mouse move, the event handler
					 * is called, which updates its coordinates.
					 * We need to save the drag component, since we have to 
					 * register the event handler with the stage, not the component
					 * itself. But from the stage we have no way to get back to
					 * the component or the VNode in case of the mouse move or 
					 * drop event. 
					 */
					_dragComponent = ecomponent;
					ecomponent.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
			
					/* also register a drop event listener */
					// ecomponent.stage.addEventListener(MouseEvent.MOUSE_UP, dragEnd);
					
					/* and inform the layouter about the dragEvent */
					_layouter.dragEvent(event, evnode);
				} else {
					throw Error("Event Component was not in the viewToVNode Map");
				}
			} else {
				throw Error("MouseEvent target was no UIComponent");
			}
		}

		/**
		 * Called everytime the mouse moves after the dragBegin() method has
		 * been called.  Updates the position of the Component based on
		 * the location of the mouse cursor.
		 * @param event The MouseMove event that has been triggered.
		 */
		private function handleDrag(event:MouseEvent):void {
			var myvnode:IVisualNode;
			var sp:UIComponent;
			
			//var bounds:Rectangle;
			
			/* we set our Component to be the saved
			 * dragComponent, because we cannot access it
			 * through the event. */
			sp = _dragComponent;
			
			/* Sometimes we get spurious events */
			if(_dragComponent == null) {
				trace("received handleDrag event but _dragComponent is null, ignoring");
				return;
			}
			
			/* bounds are not implemented:
			bounds = _drag_boundsMap[sp];
			*/

			if (_moveNodeInDrag) {
				/* update the coordinates with the current
				 * event's stage coordinates (i.e. current mouse position),
				 * modified by the lock-center offset */
				sp.x = event.stageX / scaleX - _drag_x_offsetMap[sp];
				sp.y = event.stageY / scaleY - _drag_y_offsetMap[sp];
				
				/* bounds code, currently unused 
				if ( bounds != null ) {
					if ( sp.x < bounds.left ) {
						sp.x = bounds.left;
					} else if ( sp.x > bounds.right ) {
						sp.x = bounds.right;
					}	
					if ( sp.y < bounds.top ) {
						sp.y = bounds.top;	
					} else if ( sp.y > bounds.bottom ) {
						sp.y = bounds.bottom;	
					}
				}
				*/
			}
			
			/* and inform the layouter about the dragEvent */
			myvnode = _viewToVNodeMap[_dragComponent];
			_layouter.dragContinue(event, myvnode);
			
			/* make sure flashplayer does an update after the event */
			refresh();
			event.updateAfterEvent();			
		}

		/**
		 * This handles a background drag (i.e. scroll). The
		 * event listener is usually registered with the canvas,
		 * i.e. this object.
		 * @param event The triggered event.
		 * */
		private function backgroundDragBegin(event:MouseEvent):void {
		
			var mycomponent:UIComponent;
		
			/* if there is an animation in progress, we ignore
			 * the drag attempt */
			if(_layouter.animInProgress) {
				trace("Animation in progress, drag attempt ignored");
				return;
			}
			
			/* this should be the canvas, i.e. "this" */
			mycomponent = (event.currentTarget as UIComponent);
			
			/* check for validity */
			if(mycomponent == null) {
				throw Error("Got backgroundDragBegin without UIComponent target!");
			}
			
			/* set the progress flag and save the starting coordinates */
			_backgroundDragInProgress = true;
			_dragCursorStartX = event.stageX;
			_dragCursorStartY = event.stageY;
			
			/* register the backgroundDrag listener to react to
			 * the mouse movements */
			mycomponent.addEventListener(MouseEvent.MOUSE_MOVE, backgroundDragContinue);
			
			/* and inform the layouter about the dragEvent */
			_layouter.bgDragEvent(event);
		}
		
		/**
		 * This does the actual background drag by having
		 * all UIComponents move to follow the mouse
		 * @param event The triggered mouse move event.
		 * */ 
		private function backgroundDragContinue(event:MouseEvent):void {
			
			var deltaX:Number;
			var deltaY:Number;
			
			if (_scrollBackgroundInDrag) {
				/* compute the movement offset of this move by
				 * subtracting the current mouse position from
				 * the last mouse position */
				deltaX = event.stageX - _dragCursorStartX;
				deltaY = event.stageY - _dragCursorStartY;
			 
				deltaX /= scaleX
				deltaY /= scaleY
			
				/* scroll all objects by this offset */
				scroll(deltaX, deltaY);
			}
			/* and inform the layouter about the dragEvent */
			_layouter.bgDragContinue(event);
			
			/* reset the drag start point for the next step */
			_dragCursorStartX = event.stageX;
			_dragCursorStartY = event.stageY;
			
			/* make sure edges are redrawn */
			//_drawingSurface.invalidateDisplayList();
			refresh();
		}


		/**
		 * This method handles the drop event (usually MOUSE_UP).
		 * It stops any dragging in progress (including background drag)
		 * and unregisters the current dragged node.
		 * @param event The triggered event.
		 * */
		private function dragEnd(event:MouseEvent):void {
			
			var mycomp:UIComponent;
			var myback:DisplayObject;
			var myvnode:IVisualNode;
			
			if(_backgroundDragInProgress) {
				/* if it was a background drag we stop it here */
				_backgroundDragInProgress = false;
				
				/* get the background drag object, which is usually
				 * the canvas */
				myback = (event.currentTarget as DisplayObject);
				if(myback == null) {
					/* this can happen if we let go of the button
					 * outside of the window */
					trace("dragEnd: background drop event target was no DisplayObject but "+event.currentTarget.toString());
				}
				
				/* unregister event handler */				
				myback.removeEventListener(MouseEvent.MOUSE_MOVE,backgroundDragContinue);
				// myback.removeEventListener(MouseEvent.MOUSE_MOVE,dragEnd);
				
				/* and inform the layouter about the dropEvent */
				_layouter.bgDropEvent(event);
				
			} else {
				
				/* if it was no background drag, the component
				 * is the saved dragComponent */
				mycomp = _dragComponent;
				
				/* But sometimes the dragComponent was already null, 
				 * in this case we have to ignore the thing. */
				if(mycomp == null) {
					trace("dragEnd: received dragEnd but _dragComponent was null, ignoring");
					return;
				}
				
				/* remove the event listeners */
				//mycomp.stage.removeEventListener(MouseEvent.MOUSE_DOWN, dragEnd);
				// HACK: I have to check the stage because there are eventual components not added to the display list
				if (mycomp.stage != null)
				{
					mycomp.stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
				}
				
				/* get the associated VNode to notify the layouter */
				myvnode = _viewToVNodeMap[mycomp];
				_layouter.dropEvent(event, myvnode);
				
				/* reset the dragComponent */
				_dragComponent = null;
				
			}
			
			/* and stop propagation, as otherwise we could get the
			 * event multiple times */
			event.stopImmediatePropagation();			
		}
		
		/** 
		 * 1. saves the old nodeID hash object.
		 * 2. sets the new _nodeIDsWithinDistanceLimit Object from the object
		 *    provided (typically provided from the GTree of a Graph).
		 * 3. updates the amount of nodes in that object, by linearly
		 *    counting them. This may be optimized...
		 * @param vnids Object containing a hash with all node id's currently within the distance limit.
		 * */
		private function setDistanceLimitedNodeIds(vnids:Dictionary):void {
			var val:Boolean;
			var amount:uint;
			var vn:IVisualNode;
			var n:INode;
			
			/* reset the amount */
			amount = 0;
			
			/* save the old hash */
			_prevNodeIDsWithinDistanceLimit = _nodeIDsWithinDistanceLimit;
			
			/* set the new hash object */
			_nodeIDsWithinDistanceLimit = new Dictionary;
			
			/* walk through the hash and build the distanceLimit hash */
			for each(n in vnids) {
				vn = n.vnode;
				_nodeIDsWithinDistanceLimit[vn] = vn;
				
				/* increase the amount */
				++amount;
			}
		
			/* count all entries in this hash */
			for each(val in vnids) {
				if(val) {
					++amount;
				}
			}
			/* set the new amount */
			_noNodesWithinDistance = amount;
			
			//trace("current visible nodeids:"+_noNodesWithinDistance);
		}
		
		/**
		 * This needs to walk through all nodes in the graph, as some nodes
		 * have become invisible and other have become visible. There may be
		 * a better way to do this, when adjusting the visibility but it is
		 * not that clear.
		 * 
		 * walk through the graph and the limitedGraph and
		 * turn off visibility for those that are not listed in
		 * both
		 * beware that the limited graph has no VItems, so 
		 * we don't really need it, we would rather need
		 * an array of node ids....
		 * */
		private function updateVisibility():void {
			var n:INode;
			var e:IEdge;
			var edges:Array;
			var treeparents:Dictionary;
			var vn:IVisualNode;
			var vno:IVisualNode;
			
			var newVisibleNodes:Dictionary;
			var toInvisibleNodes:Dictionary;
			
			/* since a layouter that uses timer based iterations
			 * might find itself on a changing node set, we need
			 * to stop/reset anything before altering the node
			 * visibility */
			if(_layouter != null) {
				_layouter.resetAll();
			}
			
			
			//trace("update node visibility");
			
			/* create a copy of the currently visible 
			 * node set, as the set for nodes to potentially
			 * turned invisible */
			toInvisibleNodes = new Dictionary;
			for each(vn in _visibleVNodes) {
				toInvisibleNodes[vn] = vn;
			}
			
			/* now populate the set of nodes which should be
			 * turned visible, first by using the nodes  within
			 * distance limit */
			newVisibleNodes = new Dictionary;
			
			for each(vn in _nodeIDsWithinDistanceLimit) {
				newVisibleNodes[vn] = vn;
			}
			
			/* now add the history nodes to the set of new visible
			 * nodes if the history is enabled */
			/* Step 3: render all (new?) history nodes and nodes on the path visible (if applicable) */
			if(_showCurrentNodeHistory) {
		
				/* this is mapping in the tree that provides a parent
				 * for each single node in the tree 
				 * we need this to find the trace to the root */
				treeparents = _graph.getTree(_currentRootVNode.node,false,false,GraphWalkingDirectionsEnum.BOTH).parents;
				
				for each(vn in _currentVNodeHistory) {
					n = vn.node;		
					/* we cannot use vn here, because it is n that is changed
					 * in this while loop. Basically we are walking the tree
					 * backward from the current vnode's node n to the root
					 * for every vn in the history */
					while(n.vnode != _currentRootVNode) {
						
						/* set it visible */
						newVisibleNodes[n.vnode] = n.vnode;
						//setNodeVisibility(n.vnode, true);
						
						/* move to the parent node */
						n = treeparents[n];
						if(n == null) {
							throw Error("parent node was null but node was not root node");
						}
					}
				}
			}
			
			/* now from each set remove the common nodes, these
			 * are the nodes that should remain visible, so they
			 * must not be turned invisible and should also not
			 * be turned visible again. */
			
			for each(vn in toInvisibleNodes) {
				if(newVisibleNodes[vn] != null) {
					/* this is a common node, remove it from
					 * both dictionaries 
					 */
					delete toInvisibleNodes[vn];
					delete newVisibleNodes[vn];
				} 
			}
			
			/* now finally turn all toInvisibleNodes invisible
			 * likewise any edge adjacent to an invisible node
			 * will become invisible */
			for each(vn in toInvisibleNodes) {
				setNodeVisibility(vn, false);
				
				/* remove the edges */
				edges = vn.node.inEdges.concat(vn.node.outEdges);
				for each(e in edges) {
					if(e.vedge.labelView != null) {
						removeVEdgeView(e.vedge.labelView);
					}
					delete _visibleEdges[e];
				}
			}
			
			/* and all new visible nodes to visible */
			for each(vn in newVisibleNodes) {
				setNodeVisibility(vn, true);
				
				/* now here we have to test each edges othernode
				 * if it is also visible */
				edges = vn.node.inEdges;
				edges = edges.concat(vn.node.outEdges);
				for each(e in edges) {
					/* get the other node at the end of the edge */
					vno = e.othernode(vn.node).vnode;
					
					/* if this node either is still visible or in the
					 * list to become visible, then the edge is also
					 * visible */
					if(vno.isVisible || (newVisibleNodes[vno] != null)) {
						_visibleEdges[e] = e;
						/* check if there is no view and we need one */
						if(_displayEdgeLabels && e.vedge.labelView == null) {
							createVEdgeView(e.vedge);
						}
					}
				}
			}
			
			/* this restarts any layouting */
			/* maybe not a good idea?? */
			draw();
		}

		/**
		 * Reset visibility of all nodes, all nodes are back to visible.
		 * This can be a very very heavy operation if you have many nodes. 
		 * */
		private function setAllVisible():void {
			var n:INode;
			var e:IEdge;
			
			/* since a layouter that uses timer based iterations
			 * might find itself on a changing node set, we need
			 * to stop/reset anything before altering the node
			 * visibility */
			if(_layouter != null) {
				_layouter.resetAll();
			}
			
			/* recreate those, this is cheaper probably */
			_visibleVNodes = new Dictionary;
			_noVisibleVNodes = 0;
			
			if(_graph)
				for each(n in _graph.nodes) {
					setNodeVisibility(n.vnode, true);
				}
			
			/* same for edges */
			_visibleEdges = new Dictionary;
			if(_graph)
				for each(e in _graph.edges) {
					_visibleEdges[e] = e;
				}
			
			/* maybe not XXX */
			draw();
		}
	
		/**
		 * This sets a VNode visible or invisible, updating all related
		 * data.
		 * @param vn The VisualNode to be turned invisible or not.
		 * @param visible The indicator if visible or not.
		 * */	
		private function setNodeVisibility(vn:IVisualNode, visible:Boolean):void {
			
			var comp:UIComponent;
			
			/* was there actually a change, if not issue a warning */
			if(vn.isVisible === visible) {
				trace("Tried to set node:"+vn.id+" visibility to:"+visible.toString()+" but it was already.");
				return;
			}
			
			if(visible == true) {
				
				/* set the node to visible, this might create a view for it */
				vn.isVisible = true;
				/* add it to the hash of currently visible nodes */
				_visibleVNodes[vn] = vn;
				/* increase the counter */
				++_noVisibleVNodes;
				
				/* create the node's view */
				comp = createVNodeComponent(vn);
				
				/* set it to visible, should be default anyway */
				comp.visible = true;
				
			} else { // i.e. set to invisible 
				/* render node invisible, thus potentially destroying its view */
				vn.isVisible = false;
				/* remove it from the hash */
				delete _visibleVNodes[vn];
				/* decrease the counter */
				--_noVisibleVNodes;
				
				/* remove the view if there is one */
				if(vn.view != null) {
					removeComponent(vn.view, false);
				}
			}
		}
	}
}