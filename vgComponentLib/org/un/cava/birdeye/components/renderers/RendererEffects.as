package org.un.cava.birdeye.components.renderers {
	
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.core.UIComponent;
	import mx.effects.Effect;
	import mx.effects.Zoom;
	
	/**
	 * This class provides a set of effects to
	 * a renderer.
	 * */
	public class RendererEffects {
		
		/* the effect to be used, default is zoom */
		public var effect:Effect;
		
		/**
		 * Default constructor, inits the zoom effect */
		public function RendererEffects() {
			/* init the zoom effect */
			initEffect();
		}
	
        /**
         * add a simple filter to the component. Obviously this
         * is hardcoding the filter, so it is really here for
         * demo purposes right now.
         * @param c The UIComponent to filter.
         * */ 
		public function addDSFilters(c:UIComponent):void {
        	var ndsf:DropShadowFilter = 
        		new DropShadowFilter(4, 45, 0x666666, 0.8, 8, 8, 0.65, 1, false, false);
			
			/* add the filter. Note that the "filters" property expects an Array
			 * so multiple filters could be applied, hence the [] */	
			c.filters = [ndsf];
     	}
	
		/**
		 * execute the zoom effect, this is an event handler.
		 * @param event The Mouse event received (rollOver or rollOut)
		 * */
		public function doZoom(event:MouseEvent):void {
			
        	/* if we are already playing reverse the effect
        	 * If this is a ROLL_OUT event, play the effect backwards
        	 * If this is a ROLL_OVER event, play the effect forwards.
        	 * */
        	if(effect.isPlaying) {
        		effect.reverse();
        	} else {
        		/* event.target should be "this" */
        		effect.play([event.target], 
        			(event.type == MouseEvent.ROLL_OUT) ? true : false
        		);
        	}
		}
		
		/**
		 * initialize the zoom effect
		 * */
		private function initEffect():void {
			var ef:Zoom = new Zoom();
			
			ef.zoomWidthFrom = 1;
			ef.zoomHeightFrom = 1;
			ef.zoomWidthTo = 2;
			ef.zoomHeightTo = 2;
			
			effect = ef;
		}
	}
}