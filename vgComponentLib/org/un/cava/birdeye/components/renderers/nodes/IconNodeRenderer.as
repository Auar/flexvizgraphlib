package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.components.renderers.RendererIconFactory;
	
	/**
	 * This a basic icon itemRenderer for a node. 
	 * Images are sourced by directory path and file name.
	 * Based on icons by Paul Davey aka Mattahan (http://mattahan.deviantart.com/).
	 * All rights reserved. 
	 * */
	public class IconNodeRenderer extends EffectBaseNodeRenderer  {
		
		/**
		 * Default constructor
		 * */
		public function IconNodeRenderer() {
			super();
			//initZoom();
		}
	
		/**
		 * @inheritDoc
		 * */
		override protected function initComponent(e:Event):void {
			
			var img:UIComponent;

			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add an icon as specified in the XML, this should
			 * be checked */
			img = RendererIconFactory.createIcon(this.data.data.@nodeIcon,32);
			img.toolTip = this.data.data.@name; // needs check
			this.addChild(img);
						
			/* now add the filters to the circle */
			reffects.addDSFilters(img);
			 
			/* now the link button */
			initLinkButton();
		}
		
		/**
		 * We want to use a different effect here, so we
		 * override the initialisation.
		 * */
		/* we first test if it does not work with the
		 * plain ole zoom 
		override protected function initZoom():void {
			_zoom = new Resize();
			_zoom.widthFrom = 32;
			_zoom.heightFrom = 32;
			_zoom.widthTo = 64;
			_zoom.heightTo = 64;
		}
		*/
	}
}