package org.un.cava.birdeye.components.renderers.edgeLabels {
	
	// Flash classes
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.controls.LinkButton;
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.components.renderers.RendererIconFactory;
	import org.un.cava.birdeye.components.renderers.nodes.BaseNodeRenderer;
	import org.un.cava.birdeye.utils.GlobalParams;
	
	/**
	 * This renderer displays the graph nodes as
	 * primitive icon or as embedded image or URL
	 * depending on the XML specification
	 * */
	public class WFBEdgeLabelRenderer extends BaseNodeRenderer {
	
		/**
		 * Base Constructor
		 * */
		public function WFBEdgeLabelRenderer() {
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
			
			/* set the tool tip */
			this.toolTip = this.data.data.@edgeLabel;
			
			/* add the image */
			img = RendererIconFactory.createIcon("primitive::rectangle",8,0x666666);
			img.toolTip = this.data.data.@edgeLabel;
			this.addChild(img);
			 
			/* now the link button */
			initLinkButton();
		
		}
		
		/**
		 * @inheritDoc
		 * */
		override protected function initLinkButton():LinkButton {
			
			/* initialise the original link button */
			super.initLinkButton();
			
			/* now override some specs */
			lb.label = this.data.data.@edgeLabel;
			lb.width = 65;
			lb.height = 15;
			lb.visible = false;
			lb.scaleX = GlobalParams.scaleFactor;
			lb.scaleY = GlobalParams.scaleFactor;
			lb.toolTip = this.data.data.@edgeDescription;
			
			return lb;
		}
	}
}

