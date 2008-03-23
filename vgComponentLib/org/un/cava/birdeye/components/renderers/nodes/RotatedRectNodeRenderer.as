package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.components.renderers.RendererIconFactory;
	import org.un.flex.graphLayout.visual.IVisualNode;
		
	/**
	 * This is a simple renderer, similar to the filtered circle
	 * but renders a rectangle which is rotated according to the
	 * angle of the corresponding visualNode
	 * */
	public class RotatedRectNodeRenderer extends EffectBaseNodeRenderer  {
		
		/**
		 * Default constructor
		 * */
		public function RotatedRectNodeRenderer() {
			super();
		}
	
		/**
		 * @inheritDoc
		 * */
		override protected function initComponent(e:Event):void {
			
			var rc:UIComponent;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a primitive rectangle
			 * as well the XML should be checked before */
			rc = RendererIconFactory.createIcon("primitive::rectangle",
				this.data.data.@nodeSize,
				this.data.data.@nodeColor);
			rc.toolTip = this.data.data.@name; // needs check
			
			/* rotate. Note that this will only rotate on init
			 * i.e. all will be triggered only on creation complete
			 * this was the same in the original vgExplorer
			 * maybe it was not intended */
			if(this.data is IVisualNode) {
				rc.rotation =  (this.data as IVisualNode).orientAngle;
			}
			
			this.addChild(rc);
			
			/* now add the filters to the circle */
			reffects.addDSFilters(rc);
			 
			/* now the link button */
			initLinkButton();
		}
	}
}