package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	import org.un.cava.birdeye.components.renderers.RendererIconFactory;
	
	/**
	 * This is a very very simple Renderer that just
	 * uses a plain small circle for the icon 
	 * */
	public class SimpleCircleNodeRenderer extends BaseNodeRenderer {
		
		/* default constructor */
		public function SimpleCircleNodeRenderer() {
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
			 
			/* now the link button */
			initLinkButton();
		}
	}
}