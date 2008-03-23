package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	import mx.core.UIComponent;
	import mx.effects.Zoom;
	
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	
	/**
	 * Other version of the simple circle with zoom and dropshadowfilter
	 * added
	 * */
	public class FilteredSimpleCircleNodeRenderer extends EffectBaseNodeRenderer  {
		
		/**
		 * Default constructor
		 * */
		public function FilteredSimpleCircleNodeRenderer() {
			super();
		}
	
		/**
		 * @inheritDoc
		 * */
		override protected function initComponent(e:Event):void {
			
			var cc:Circle;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a simple circle as in the base class */
			cc = addPlainCircle();
			
			/* now add the filters to the circle */
			addDSFilters(cc);
			 
			/* now the link button */
			initLinkButton();
		}
	
		/**
		 * create a UIComponent with a cimple circle
		 * and add it do this object
		 * @returns the circle, may be useful for derived classes 
		 * */
		private function addPlainCircle():Circle {
			
			var cc:Circle = new Circle();
			
			cc.id = "circle";
			cc.toolTip = this.data.data.@name; // needs check
			cc.color = this.data.data.@nodeColor; // here too
			cc.width = 10;
			cc.height = 10;
			this.addChild(cc);
			return cc;
		}

	}
}