package org.un.birdeye.visualize.renderers {
	
	import com.flexibleexperiments.primitiveIcons.*;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.VBox;
	import mx.controls.Image;
	import mx.controls.LinkButton;
	import mx.controls.Spacer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.un.birdeye.GlobalParams;
	import org.un.birdeye.images.EmbeddedIcons;
	
	/**
	 * This _image displays the graph nodes as
	 * primitive icon or as embedded image
	 * */
	public class PrimitiveIconRenderer extends VBox {
	
		/* this is the actual image object */
		private var _imageObject:UIComponent;
		
		
		public function PrimitiveIconRenderer() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
			
		}
			
		
		private function getDetails(e:Event):void {
			// trace("Show Details");
			
			if(org.un.birdeye.GlobalParams.visualLeftAccordion != null) {
				org.un.birdeye.GlobalParams.visualLeftAccordion.selectedIndex = 2;
			}
			if(org.un.birdeye.GlobalParams.visualDetailTitle != null) {
				org.un.birdeye.GlobalParams.visualDetailTitle.text = this.data.data.@name;
			}
			if(org.un.birdeye.GlobalParams.visualDetailDesc != null) {
				org.un.birdeye.GlobalParams.visualDetailDesc.text = this.data.data.@description;
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
			lb.scaleX = org.un.birdeye.GlobalParams.scaleFactor;
			lb.scaleY = org.un.birdeye.GlobalParams.scaleFactor;
			lb.toolTip = "Click to View Details";
			lb.setStyle("fontWeight","normal");
			lb.setStyle("rollOverColor",0xcccccc);
			
			lb.addEventListener(MouseEvent.CLICK, getDetails);
			
			this.addChild(lb);
		}


		private function createImageComponent():void {
			
			var type:String = this.data.data.@nodeType;
			
			/* first create the image object node */
			switch(type) {
		    	
				case "Globe":
				case "GoalOne":
				case "GoalTwo":
				case "GoalThree":
				case "GoalFour":
				case "GoalFive":
				case "GoalSix":
				case "GoalSeven":
				case "GoalEight":
				case "UNlogo":
				
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
			        // trace("Out of range");
			        setPolygonNode(type);
			        _imageObject.toolTip=this.data.data.@name;
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
			_imageObject.scaleX = org.un.birdeye.GlobalParams.scaleFactor;
			_imageObject.scaleY = org.un.birdeye.GlobalParams.scaleFactor;
		}
		
		private function setImageNode(type:String):void {
			_imageObject = new Image();
				
			switch(type) {
				case "Globe":
		    		(_imageObject as Image).source = EmbeddedIcons.globeNode;
		        	break;
		        case "GoalOne":
			    	(_imageObject as Image).source = EmbeddedIcons.goalOneNode;
			        break;
			    case "GoalTwo":
			    	(_imageObject as Image).source = EmbeddedIcons.goalTwoNode;
			        break;
			    case "GoalThree":
			    	(_imageObject as Image).source = EmbeddedIcons.goalThreeNode;
			        break;
			    case "GoalFour":
			    	(_imageObject as Image).source = EmbeddedIcons.goalFourNode;
			        break;
			    case "GoalFive":
			    	(_imageObject as Image).source = EmbeddedIcons.goalFiveNode;
			        break;
			    case "GoalSix":
			    	(_imageObject as Image).source = EmbeddedIcons.goalSixNode;
			        break;
		        case "GoalSeven":
			    	(_imageObject as Image).source = EmbeddedIcons.goalSevenNode;
			        break;
			    case "GoalEight":
			    	(_imageObject as Image).source = EmbeddedIcons.goalEightNode;
			        break;
			    case "UNlogo":
			    	(_imageObject as Image).source = EmbeddedIcons.unLogoNode;
			        break;
			    
				default:
					trace("Illegal type for image node:"+type+" setting to globeNode");
					(_imageObject as Image).source = EmbeddedIcons.globeNode;
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

