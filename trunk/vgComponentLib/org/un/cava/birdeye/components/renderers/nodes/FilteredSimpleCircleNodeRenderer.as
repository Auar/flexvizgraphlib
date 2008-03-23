package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.components.renderers.RendererIconFactory;
	
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
			
			var cc:UIComponent;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a primitive circle
			 * as well the XML should be checked before */
			cc = RendererIconFactory.createIcon("primitive::circle",10,this.data.data.@nodeColor);
			cc.toolTip = this.data.data.@name; // needs check
			this.addChild(cc);
			
			/* now add the filters to the circle */
			reffects.addDSFilters(cc);
			 
			/* now the link button */
			initLinkButton();
		}
	}
}