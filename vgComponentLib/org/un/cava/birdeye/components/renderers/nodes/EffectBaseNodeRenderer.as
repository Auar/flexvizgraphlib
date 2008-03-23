package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.effects.Zoom;
	
	/**
	 * This renderer extens the very simple one by applying
	 * a DropShadowFilter and a Zoom effect
	 * */
	public class EffectBaseNodeRenderer extends BaseNodeRenderer {
		
		/* the effect to be used, default is zoom, so we call it
		 * like that */
		protected var _zoom:Effect;
		
		/**
		 * Default constructor, inits the zoom effect */
		public function EffectBaseNodeRenderer() {
			super();
			
			/* init the zoom effect */
			initZoom();
		}
	
		/**
		 * @inheritDoc
		 * */
		override protected function initComponent(e:Event):void {
						
			/* initialize the upper part of the renderer */
			initTopPart();
	
			/* add the MouseEvent listeners to the circle for zooming
			   consider to add them to the whole component instead... */
			this.addEventListener(MouseEvent.ROLL_OVER,doZoom);
			this.addEventListener(MouseEvent.ROLL_OUT,doZoom);
			
			/* now the link button */
			initLinkButton();
			
			/* or the label */
			//initLabel();
		}
	
        /**
         * add a simple filter to the component. Obviously this
         * is hardcoding the filter, so it is really here for
         * demo purposes right now.
         * @param c The UIComponent to filter.
         * */ 
		protected function addDSFilters(c:UIComponent):void {
        	var ndsf:DropShadowFilter = 
        		new DropShadowFilter(4, 45, 0x666666, 0.8, 8, 8, 0.65, 1, false, false);
			
			/* add the filter. Note that the "filters" property expects an Array
			 * so multiple filters could be applied, hence the [] */	
			c.filters = [ndsf];
     	}
	
	
		/**
		 * initialize the zoom effect
		 * */
		protected function initZoom():void {
			_zoom = new Zoom();
			(_zoom as Zoom).zoomWidthFrom = 1;
			(_zoom as Zoom).zoomHeightFrom = 1;
			(_zoom as Zoom).zoomWidthTo = 2;
			(_zoom as Zoom).zoomHeightTo = 2;
		}
	
		/**
		 * execute the zoom effect, this is an event handler.
		 * @param event The Mouse event received (rollOver or rollOut)
		 * */
		private function doZoom(event:MouseEvent):void {
			
        	/* if we are already playing reverse the effect
        	 * If this is a ROLL_OUT event, play the effect backwards
        	 * If this is a ROLL_OVER event, play the effect forwards.
        	 * */
        	if(_zoom.isPlaying) {
        		_zoom.reverse();
        	} else {
        		/* event.target should be "this" */
        		_zoom.play([event.target], 
        					(event.type == MouseEvent.ROLL_OUT) ? true : false
        					);
        	}
		}
	}
}