package org.un.cava.birdeye.visualize.renderers.edges {
	
	// Flash classes
	import flash.events.Event;
	import flash.events.MouseEvent;
	// Flex classes
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.Image;
	import mx.controls.LinkButton;
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	// Util classes
	import org.un.cava.birdeye.utils.GlobalParams;
	import org.un.cava.birdeye.assets.EmbeddedIcons;
	import org.un.cava.birdeye.visualize.renderers.primitives.Circle;
	import org.un.cava.birdeye.visualize.renderers.primitives.Rectangle;
	/**
	 * This _image displays the graph edge renderers as
	 * primitive icon or as embedded image
	 * */
	public class EdgeRenderer extends VBox {
	
		/* this is the actual image object */
		private var _imageObject:UIComponent;
		private var lb:LinkButton;
				
		public function EdgeRenderer() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
			
		}
			
		
		private function getDetails(e:Event):void {
			// trace("Show Details");
			
			if(GlobalParams.visualLeftAccordion != null) {
				GlobalParams.visualLeftAccordion.selectedIndex = 2;
			}
			if(GlobalParams.visualDetailTitle != null) {
				GlobalParams.visualDetailTitle.text = this.data.data.@edgeLabel;
			}
			if(GlobalParams.visualDetailDesc != null) {
				GlobalParams.visualDetailDesc.text = this.data.data.@edgeDescription;
			}
		}
		
		private function toogleLabel(e:Event):void {
				if (lb.visible==false)
					{
    				lb.visible=true;
    				
					}
				else if (lb.visible==true)
					{
 				   	lb.visible=false;
    				
    				}
			}
		
		private function initComponent(e:Event):void {
			
			var spacer:Spacer;
			//var lb:LinkButton;
			
			/* set id */
			this.id = "detailView";
			
			/* set styles */
			this.setStyle("horizontalAlign","center");
			
			
			/* set the tool tip */
			this.toolTip = this.data.data.@edgeLabel;
			
			/* create and add a spacer */
			spacer = new Spacer();
			spacer.id = "makeimgalign";
			spacer.height = 15;
			this.addChild(spacer);
			
			/* create the Image component */
			createImageComponent();
			
			/* add the image component */
			this.addChild(_imageObject);
			
			/* and the linkbutton */
			lb = new LinkButton();
			lb.id = "viewDetails";
			lb.label = this.data.data.@edgeLabel;
			lb.width = 65;
			lb.height = 15;
			lb.visible=false;
			lb.scaleX = GlobalParams.scaleFactor;
			lb.scaleY = GlobalParams.scaleFactor;
			lb.toolTip = this.data.data.@edgeDescription;
			lb.setStyle("fontWeight","normal");
			lb.setStyle("rollOverColor",0xcccccc);
			
			lb.addEventListener(MouseEvent.CLICK, getDetails);
			
			this.addChild(lb);
		}


		private function createImageComponent():void {
			
			var type:String = this.data.data.@edgeClass;
			
			/* first create the image object node */
			switch(type) {
		    	
				case "sun":
				case "rain":
					setImageNode(type);
					break;
			    default:
			        // trace("Out of range");
			        setPrimitiveNode(type);
			        _imageObject.toolTip=this.data.data.@edgeLabel;
			        _imageObject.setStyle("backgroundColor", "0xcccccc");
			        break;
			}
			
				
			/* for any _imageObject */
			_imageObject.scaleX = GlobalParams.scaleFactor;
			_imageObject.scaleY = GlobalParams.scaleFactor;
		}
		
		private function setDefaultNode():void {
					
		}
		
		private function setImageNode(type:String):void {
			_imageObject = new Image();
			_imageObject.addEventListener(MouseEvent.CLICK, toogleLabel);
			_imageObject.id="edgeClass";
			_imageObject.toolTip=this.data.data.@edgeLabel;
			_imageObject.width=25;
			_imageObject.height=25;
				
			switch(type) {
				case "rain":
		    		(_imageObject as Image).source = EmbeddedIcons.rainIcon;
		        	break;
		        case "sun":
			    	(_imageObject as Image).source = EmbeddedIcons.sunIcon;
			        break;
			    default:
					trace("Illegal type for image node:"+type+" setting to naEdge");
					(_imageObject as Image).source = EmbeddedIcons.sunIcon;
					break;
			}
		}
		private function setPrimitiveNode(type:String):void {
			
			_imageObject.width=10;
			_imageObject.height=10;

			switch(type) {
				case "rectangle":
					_imageObject = new Rectangle();
					(_imageObject as Rectangle).setStyle("backgroundColor", 0x8b008b);
					break;
				case "circle":
					_imageObject = new Circle();
					(_imageObject as Circle).setStyle("backgroundColor", 0x8b008b);
					break;
				default:
					trace("Illegal type for node:"+type+" setting to circle");
					_imageObject = new Circle();
					(_imageObject as Circle).setStyle("backgroundColor", 0x8b008b);
					break;
			}
		}
	}
}


