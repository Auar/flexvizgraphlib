package org.un.birdeye.report {
	
	import mx.containers.VBox;
	import mx.core.UIComponent;
	import com.flexibleexperiments.primitiveIcons.*;
	import mx.controls.Image;
	import mx.events.FlexEvent;
	import flash.events.MouseEvent;
	import mx.controls.Spacer;
	import mx.controls.LinkButton;
	import flash.events.Event;
	import org.un.birdeye.images.EmbeddedIcons;
	
	/**
	 * This _image displays the graph nodes as
	 * primitive icon or as embedded image
	 * */
	public class PrimitiveIconRendererReport extends VBox {
	
		/* this is the actual image object */
		private var _imageObject:UIComponent;
		
		
		public function PrimitiveIconRendererReport() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
			
		}
			
		
		
			
	
		
		private function initComponent(e:Event):void {
			
			
			
			/* set id */
			this.id = "detailView";
			
			/* set styles */
			this.setStyle("horizontalAlign","center");
			
			/* set the tool tip */
			// this.toolTip = this.data.@name;
			

			
			/* create the Image component */
			createImageComponent();
			
			/* add the image component */
			this.addChild(_imageObject);
		

		}


		private function createImageComponent():void {
			
			var type:String = this.data.data.@nodeType;
			
			/* first create the image object node */
			switch(type) {
		    	
				case "GlobalClimateChange":
				case "Agriculture":
				
					setImageNode(type);
			        break;
			    	
		    	case "PrimitivePolygon":
		    	case "PrimitiveSquare":
		    	case "PrimitiveTriangle":
		    		setPolygonNode(type);
		    		break;
			    		
				case "PrimitiveStar":
					_imageObject = new PrimitiveStar();
					(_imageObject as PrimitiveStar).points = 9;
					_imageObject.setStyle("backgroundColor", "0x666666");
					_imageObject.width=15;
					_imageObject.height=15;
					break;
			    	
				case "PrimitiveBurst":
					_imageObject = new PrimitiveBurst();
					_imageObject.setStyle("backgroundColor", "0x0000cc");
					_imageObject.width=15;
					_imageObject.height=15;
					break;

				case "PrimitiveCircle":
					_imageObject = new PrimitiveCircle();
					_imageObject.setStyle("backgroundColor", "0x0000cc");
					_imageObject.width=10;
					_imageObject.height=10;
					break;

				case "PrimitiveGear":
					_imageObject = new PrimitiveGear();
					(_imageObject as PrimitiveGear).outerRadius = 23;
					(_imageObject as PrimitiveGear).innerRadius = 36;
					(_imageObject as PrimitiveGear).points = 9;
					(_imageObject as PrimitiveGear).holeRadius = 10;
					(_imageObject as PrimitiveGear).holePoints = 9;
					(_imageObject as PrimitiveGear).angle = 90;
					_imageObject.setStyle("backgroundColor", "0x0000cc");
					_imageObject.width=10;
					_imageObject.height=10;
					break;

				case "PrimitiveReverseBurst":
					_imageObject = new PrimitiveReverseBurst();
					_imageObject.setStyle("backgroundColor", "0xFF0000");
					_imageObject.width=10;
					_imageObject.height=10;
					break;

		    	default:
			        trace("Out of range");
			        setPolygonNode(type);
			        _imageObject.toolTip="Node Primitive Not Defined";
			        _imageObject.setStyle("backgroundColor", "0xcccccc");
			        break;
			}
				
			/* styles for any Primitive object */
			if(_imageObject is BasePrimitive) {
				(_imageObject as BasePrimitive).setStyle("borderColor",0x333333);
				(_imageObject as BasePrimitive).setStyle("shadowEnabled",true);
				(_imageObject as BasePrimitive).setStyle("shadowColor",0x000000);
				(_imageObject as BasePrimitive).setStyle("shadowAngle",57);
				(_imageObject as BasePrimitive).setStyle("shadowDistance",3);
				(_imageObject as BasePrimitive).setStyle("shadowAlpha",0.5);
			}
				
			/* for any _imageObject */
			// _imageObject.scaleX = parentDocument.scaleFactor;
			// _imageObject.scaleY = parentDocument.scaleFactor;
		}
		
		private function setImageNode(type:String):void {
			_imageObject = new Image();
				
			switch(type) {
				case "GlobalClimateChange":
		    		(_imageObject as Image).source = EmbeddedIcons.globalClimateChangeNode;
		        break;
		        case "Agriculture":
			    	(_imageObject as Image).source = EmbeddedIcons.agricultureNode;
			        break;
		        
				default:
					trace("Illegal type for image node:"+type+" setting to globalClimateChangeNode");
					(_imageObject as Image).source = EmbeddedIcons.globalClimateChangeNode;
					break;
			}
		}
		
		private function setPolygonNode(type:String):void {
			_imageObject = new PrimitivePolygon();
			// _imageObject.setStyle("backgroundColor", 0x8b008b);
			_imageObject.width=15;
			_imageObject.height=15;

			switch(type) {
				case "PrimitivePolygon":
					(_imageObject as PrimitivePolygon).setStyle("backgroundColor", 0x8b008b);
					break;
				case "PrimitiveSquare":
					(_imageObject as PrimitivePolygon).points = 4;
					(_imageObject as PrimitivePolygon).setStyle("backgroundColor", 0x800080);
					break;
				case "PrimitiveTriangle":
					(_imageObject as PrimitivePolygon).points = 3;
					(_imageObject as PrimitivePolygon).setStyle("backgroundColor", 0x008000);
					break;
				default:
					trace("Illegal type for polygon node:"+type+" setting to square");
					(_imageObject as PrimitivePolygon).points = 4;
					break;
			}
		}
	}
}

