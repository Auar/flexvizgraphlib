package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.controls.Image;
	import mx.effects.Resize;
	
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	
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
			
			var img:Image;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a simple circle as in the base class */
			img = addImage();
			
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
	
	
		/**
		 * create an Image initialised from XML
		 * and add it do this object
		 * @returns the image, may be useful for derived classes 
		 * */
		private function addImage():Image {
			
			var img:Image = new Image();
			
			img.id = "img";
			img.source = this.data.data.@nodeIcon; // needs check!!
			img.toolTip = this.data.data.@name; // needs check
			img.width = 32;
			img.height = 32;
			this.addChild(img);
			return img;
		}
	}
}