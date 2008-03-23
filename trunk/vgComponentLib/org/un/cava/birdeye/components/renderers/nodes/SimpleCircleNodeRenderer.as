package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	
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
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* in between could be other components added
			 * like images */
			addPlainCircle();
			 
			/* now the link button */
			initLinkButton();
		}
		
		/**
		 * create a UIComponent with a cimple circle
		 * and add it do this object
		 * @returns the circle, may be useful for derived classes 
		 * */
		protected function addPlainCircle():Circle {
			
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