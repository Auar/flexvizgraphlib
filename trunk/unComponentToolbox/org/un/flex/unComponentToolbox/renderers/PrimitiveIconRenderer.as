/* 
 * The MIT License
 *
 * Copyright (c) 2007 The SixDegrees Project Team
 * (Jason Bellone, Juan Rodriguez, Segolene de Basquiat, Daniel Lang).
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package org.un.flex.unComponentToolbox.renderers {
	
	import mx.containers.VBox;
	import mx.core.UIComponent;
	import com.flexibleexperiments.primitiveIcons.*;
	import mx.controls.Image;
	import mx.events.FlexEvent;
	import flash.events.MouseEvent;
	import mx.controls.Spacer;
	import mx.controls.LinkButton;
	import flash.events.Event;
	import org.un.flex.unComponentToolbox.icons.EmbeddedIcons;
	
	/**
	 * This renderer displays the graph nodes as
	 * primitive icon or as embedded image along with
	 * a text label. All data (whether primitive icon,
	 * if so, which one, or embedded image as well as text
	 * for the label are taken from the data object, which needs
	 * to be an XML object. The "name" attribute will be used
	 * for label and tooltip. The "nodeType" attribute will determine
	 * the icon.
	 * */
	public class PrimitiveIconRenderer extends VBox {
	
		/* this is the actual image object */
		private var _imageObject:UIComponent;
		
		/**
		 * Create an instance of the renderer.
		 * */
		public function PrimitiveIconRenderer() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
		}
			
		/**
		 * This method actually initialises the created
		 * renderer object. It is called on the creation
		 * complete event, which is required in order to
		 * initialise it.
		 * */
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
			lb.scaleX = parentApplication.scaleFactor;
			lb.scaleY = parentApplication.scaleFactor;
			lb.toolTip = "Click to View Details";
			lb.setStyle("fontWeight","normal");
			lb.setStyle("rollOverColor",0xcccccc);
			
			this.addChild(lb);
			
			this.addEventListener(MouseEvent.CLICK,parentApplication.singleClick);
		}

		/**
		 * Creates a UIComponent which is actually an image
		 * that will be the top of the vbox. The type determines
		 * whether an embedded image has to be used or if a primitive
		 * shape can be used.
		 * */
		private function createImageComponent():void {
			
			var type:String = this.data.data.@nodeType;
			
			/* first create the image object node */
			switch(type) {
		    	
				case "SixDegrees":
				case "Activity":
				case "Male":	        
				case "Female":
				case "Audit":
				case "Budget":
				case "ValIt":
				case "SoX":
				case "Environment":
				case "SixSigma":
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
					_imageObject.setStyle("backgroundColor", "0x003399");
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
			_imageObject.scaleX = parentApplication.scaleFactor;
			_imageObject.scaleY = parentApplication.scaleFactor;
		}
		
		/**
		 * If the image type requests an embedded image, this
		 * method selects and sets the one that matches the node type
		 * from the library.
		 * */
		private function setImageNode(type:String):void {
			_imageObject = new Image();
				
			switch(type) {
				case "SixDegrees":
		    		(_imageObject as Image).source = EmbeddedIcons.sixDegreeNode;
		        break;
		        case "Activity":
			    	(_imageObject as Image).source = EmbeddedIcons.activityNode;
			        break;
		        case "Male":
			    	(_imageObject as Image).source = EmbeddedIcons.maleNode;
			        break;
		        case "Female":
			    	(_imageObject as Image).source = EmbeddedIcons.femaleNode;
			        break;
				case "Audit":
			    	(_imageObject as Image).source = EmbeddedIcons.auditIcon;
			        break;
				case "Budget":
			    	(_imageObject as Image).source = EmbeddedIcons.budgetIcon;
			        break;
				case "ValIt":
			    	(_imageObject as Image).source = EmbeddedIcons.valitIcon;
			        break;
				case "SoX":
			    	(_imageObject as Image).source = EmbeddedIcons.soxIcon;
			        break;
				case "Environment":
			    	(_imageObject as Image).source = EmbeddedIcons.environmentIcon;
			        break;
				case "SixSigma":
			    	(_imageObject as Image).source = EmbeddedIcons.sixsigmaIcon;
			        break;
				default:
					trace("Illegal type for image node:"+type+" setting to sixDegreeNode");
					(_imageObject as Image).source = EmbeddedIcons.sixDegreeNode;
					break;
			}
		}
		
		/**
		 * If a polygon primitive icon will be used, this method
		 * creates the correct shape (i.e. number of points) from
		 * the node type.
		 * */
		private function setPolygonNode(type:String):void {
			_imageObject = new PrimitivePolygon();
			_imageObject.setStyle("backgroundColor", 0x0066cc);
			_imageObject.width=15;
			_imageObject.height=15;

			switch(type) {
				case "PrimitivePolygon":
					_imageObject.setStyle("backgroundColor", 0xff0000);
					break;
				case "PrimitiveSquare":
					(_imageObject as PrimitivePolygon).points = 4;
					_imageObject.setStyle("backgroundColor", 0x00ff00);
					break;
				case "PrimitiveTriangle":
					(_imageObject as PrimitivePolygon).points = 3;
					_imageObject.setStyle("backgroundColor", 0xff00ff);
					break;
				default:
					trace("Illegal type for polygon node:"+type+" setting to square");
					(_imageObject as PrimitivePolygon).points = 4;
					break;
			}
		}
	}
}

