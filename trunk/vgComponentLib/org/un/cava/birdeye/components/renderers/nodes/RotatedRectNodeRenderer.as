package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import org.un.flex.graphLayout.visual.IVisualNode;
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	import org.un.cava.birdeye.assets.icons.primitives.Rectangle;
	
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
			
			var rc:Rectangle;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a simple circle as in the base class */
			rc = addRectangle();
			
			/* now add the filters to the circle */
			addDSFilters(rc);
			 
			/* now the link button */
			initLinkButton();
			
			/* and the label */
			initLabel();
		}
	
		/**
		 * create a UIComponent with a simple rectangle
		 * and add it. Rotate the rectangle according to the
		 * layout.
		 * @returns the Rectangle, may be useful for derived classes 
		 * */
		private function addRectangle():Rectangle {
			
			var rc:Rectangle = new Rectangle();
			
			rc.id = "rectangle";
			rc.toolTip = this.data.data.@name; // needs check
			rc.color = this.data.data.@nodeColor; // here too
			rc.recHeight = 10;
			rc.recWidth = this.data.data.@nodeSize; // and here too
			
			/* rotate. Note that this will only rotate on init
			 * i.e. all will be triggered only on creation complete
			 * this was the same in the original vgExplorer
			 * maybe it was not intended */
			if(this.data is IVisualNode) {
				rc.rotation =  (this.data as IVisualNode).orientAngle;
			}
			
			this.addChild(rc);
			return rc;
		}
	}
}