package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	import mx.effects.Zoom;
	
	import org.un.cava.birdeye.components.renderers.RendererIconFactory;
	
	/**
	 * Other version of the simple circle that changes in size
	 * */
	public class SizeByValueNodeRenderer extends EffectBaseNodeRenderer  {
		
		/**
		 * Default constructor
		 * */
		public function SizeByValueNodeRenderer() {
			
			super(); // ensures that _zoom is already initialised
			
			/* we want a different zoom factor here in the
			 * renderer */
			(reffects.effect as Zoom).zoomHeightTo = 1.3;
			(reffects.effect as Zoom).zoomWidthTo = 1.3;
		}
	
		/**
		 * @inheritDoc
		 * */
		override protected function initComponent(e:Event):void {
			
			var cc:UIComponent;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a primitive circle
			 * as well the XML should be checked before */
			cc = RendererIconFactory.createIcon("primitive::circle",
				this.data.data.@nodeSize,
				this.data.data.@nodeColor);
			cc.toolTip = this.data.data.@name; // needs check
			this.addChild(cc);
			
			/* now add the filters to the circle */
			reffects.addDSFilters(cc);
			 
			/* now the link button */
			initLinkButton();
		}
	}
}