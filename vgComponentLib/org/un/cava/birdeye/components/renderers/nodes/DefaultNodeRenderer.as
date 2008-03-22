package org.un.cava.birdeye.components.renderers.nodes {
	
	// Flash classes
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.un.cava.birdeye.assets.icons.EmbeddedIcons;
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	import org.un.cava.birdeye.assets.icons.primitives.Rectangle;

	
	/**
	 * This _image displays the graph nodes as
	 * primitive icon or as embedded image
	 * */
	public class DefaultNodeRenderer extends BaseNodeRenderer {
	
		/* this is the actual image object */
		private var _imageObject:UIComponent;
		
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
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* in between could be other components added
			 * like images */
			createImageComponent();
			this.addChild(_imageObject);
			 
			/* now the link button */
			initLinkButton();
			
			/* and the label */
			initLabel();
		}


		private function createImageComponent():void {
			
			/* again attributes are pulled from XML */
			var type:String = this.data.data.@nodeClass;
			var size:int = this.data.data.@nodeSize;
			var color:int = this.data.data.@nodeColor;
			
			/* first create the image object node */
			switch(type) {
		    	
				case "earth":
				case "tree":
				case "leaf":
					setImageNode(type);
			        break;
			    	
			    /* maybe we want degrafa objects here? */
			    
			    
		    	case "rectangle":
					_imageObject = new Rectangle();
					_imageObject.setStyle("color", color);
					_imageObject.width=size;
					_imageObject.height=size;
					break;

				case "circle":
					_imageObject = new Circle();
					_imageObject.setStyle("color", color);
					_imageObject.width=size;
					_imageObject.height=size;
					break;

				default:
			        // trace("Out of range");
			        _imageObject.setStyle("color", color);
			        break;
			}
			/* for any _imageObject */
			_imageObject.toolTip = this.data.data.@name;
			_imageObject.scaleX = GlobalParams.scaleFactor;
			_imageObject.scaleY = GlobalParams.scaleFactor;
		}
		
		private function setImageNode(type:String):void {
			_imageObject = new Image();
			_imageObject.width = 32;
			_imageObject.height = 32;	
			switch(type) {
				case "earth":
		    		(_imageObject as Image).source = EmbeddedIcons.earthIcon;
		        	break;
		        case "tree":
		    		(_imageObject as Image).source = EmbeddedIcons.treeIcon;
		        	break;
		        case "leaf":
			    	(_imageObject as Image).source = EmbeddedIcons.leafIcon;
			        break;
			    default:
					trace("Illegal type for image node:"+type+" setting to leaf icon");
					(_imageObject as Image).source = EmbeddedIcons.leafIcon;
					break;
			}
		}
	}
}

