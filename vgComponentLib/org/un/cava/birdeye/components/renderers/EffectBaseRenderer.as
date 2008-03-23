package org.un.cava.birdeye.components.renderers {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.core.UIComponent;
	import mx.effects.Zoom;
	
	/**
	 * This renderer extends the very simple one by
	 * having an instance of the RendererEffects
	 * available.
	 * */
	public class EffectBaseRenderer extends BaseRenderer {
		
		/* the effect to be used, default is zoom, so we call it
		 * like that */
		protected var reffects:RendererEffects;
		
		/**
		 * Default constructor, inits the zoom effect */
		public function EffectBaseRenderer() {
			super();
			reffects = new RendererEffects();
		}
	
		/**
		 * @inheritDoc
		 * */
		override protected function initComponent(e:Event):void {
						
			super.initComponent(e);
	
			/* add the MouseEvent listeners to the circle for zooming
			   consider to add them to the whole component instead... */
			this.addEventListener(MouseEvent.ROLL_OVER,reffects.doZoom);
			this.addEventListener(MouseEvent.ROLL_OUT,reffects.doZoom);
		}
	}
}