package org.un.cava.birdeye.visualize.renderers.nodes {
	
	// Flash classes
	import flash.events.Event;
	import flash.events.MouseEvent;
	// Flex classes
	import mx.containers.VBox;
	import mx.controls.Image;
	import mx.controls.LinkButton;
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	// Utility classes
	import org.un.cava.birdeye.assets.EmbeddedIcons;
	import org.un.cava.birdeye.utils.GlobalParams;
	import org.un.cava.birdeye.visualize.renderers.primitives.Circle;
	import org.un.cava.birdeye.visualize.renderers.primitives.Rectangle;
	
	/**
	 * This _image displays the graph nodes as
	 * primitive icon or as embedded image
	 * */
	public class NodeRenderer extends VBox {
	
		/* this is the actual image object */
		private var _imageObject:UIComponent;
		
		
		public function NodeRenderer() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
			
		}
			
		
		private function getDetails(e:Event):void {
			// trace("Show Details");
			
			if(GlobalParams.visualLeftAccordion != null) {
				GlobalParams.visualLeftAccordion.selectedIndex = 2;
			}
			if(GlobalParams.visualDetailTitle != null) {
				GlobalParams.visualDetailTitle.text = this.data.data.@name;
			}
			if(GlobalParams.visualDetailDesc != null) {
				GlobalParams.visualDetailDesc.text = this.data.data.@description;
			}
		}
		
		private function initComponent(e:Event):void {
			
			var spacer:Spacer;
			var lb:LinkButton;
			
			/* set id */
			this.id = "detailView";
			
			/* set styles */
			this.setStyle("horizontalAlign","center");
			
			/* set the tool tip */
			this.toolTip = this.data.data.@name;
			
			/* create and add a spacer */
			spacer = new Spacer();
			spacer.id = "makeimgalign";
			spacer.height = 18;
			this.addChild(spacer);
			
			/* create the Image component */
			createImageComponent();
			
			/* add the image component */
			this.addChild(_imageObject);
		
			/* and the linkbutton */
			lb = new LinkButton();
			lb.id = "viewDetails";
			lb.label = this.data.data.@name;
			lb.width = 100;
			lb.scaleX = GlobalParams.scaleFactor;
			lb.scaleY = GlobalParams.scaleFactor;
			lb.toolTip = "Click to View Details";
			lb.setStyle("fontWeight","normal");
			lb.setStyle("rollOverColor",0xcccccc);
			
			lb.addEventListener(MouseEvent.CLICK, getDetails);
			
			this.addChild(lb);
		}


		private function createImageComponent():void {
			
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
			_imageObject.toolTip=this.data.data.@name;
			_imageObject.scaleX = GlobalParams.scaleFactor;
			_imageObject.scaleY = GlobalParams.scaleFactor;
		}
		
		private function setImageNode(type:String):void {
			_imageObject = new Image();
			_imageObject.width=32;
			_imageObject.height=32;	
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

