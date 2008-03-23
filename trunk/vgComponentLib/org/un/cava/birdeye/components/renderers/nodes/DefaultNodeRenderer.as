package org.un.cava.birdeye.components.renderers.nodes {
	
	// Flash classes
	import flash.events.Event;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.assets.icons.EmbeddedIcons;
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	import org.un.cava.birdeye.assets.icons.primitives.Rectangle;
	import org.un.cava.birdeye.components.renderers.RendererIconFactory;
	import org.un.cava.birdeye.utils.GlobalParams;
	
	/**
	 * This renderer displays the graph nodes as
	 * primitive icon or as embedded image or URL
	 * depending on the XML specification
	 * */
	public class DefaultNodeRenderer extends BaseNodeRenderer {
	
		/**
		 * Base Constructor
		 * */
		public function DefaultNodeRenderer() {
			super();
			//this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
		}
		
		/**
		 * Full initialisation of the renderer component, triggered
		 * after reception of the creation complete event.
		 * @param e the creation complete event (unused).
		 * */
		override protected function initComponent(e:Event):void {
			
			var img:UIComponent;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add the image */
			
			/* AGAIN ALL XML VALUES SHOULD BE VERIFIED */
			img = RendererIconFactory.createIcon(
				this.data.data.@nodeClass,
				this.data.data.@nodeSize,
				this.data.data.@nodeColor);
			img.toolTip = this.data.data.@name;
			img.scaleX = GlobalParams.scaleFactor;
			img.scaleY = GlobalParams.scaleFactor;
			this.addChild(img);
			 
			/* now the link button */
			initLinkButton();
			
			/* and the label */
			initLabel();
		}
	}
}

