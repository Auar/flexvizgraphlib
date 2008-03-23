package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.effects.Zoom;
	
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	
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
			
			var cc:Circle;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a simple circle as in the base class */
			cc = addCircle();
			
			/* now add the filters to the circle */
			reffects.addDSFilters(cc);
			 
			/* now the link button */
			initLinkButton();
		}
	
		/**
		 * create a UIComponent with a cimple circle
		 * and add it do this object
		 * @returns the circle, may be useful for derived classes 
		 * */
		private function addCircle():Circle {
			
			var cc:Circle = new Circle();
			
			cc.id = "circle";
			cc.toolTip = this.data.data.@name; // needs check
			cc.color = this.data.data.@nodeColor; // here too
			cc.width = this.data.data.@nodeSize;
			cc.height = this.data.data.@nodeSize; // ...
			this.addChild(cc);
			return cc;
		}

	}
}