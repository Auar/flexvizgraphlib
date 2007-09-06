package org.un.birdeye.visualize.renderers {
	
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
	public class PrimitiveIconRenderer extends VBox {
	
		/* this is the actual image object */
		private var _imageObject:UIComponent;
		
		
		public function PrimitiveIconRenderer() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
			
		}
			
		
		private function getDetails(e:Event):void {
			// trace("Show Details");
			parentDocument.leftAccordion.selectedIndex = 2;
			parentDocument.detailTitle.text = this.data.data.@name;
			parentDocument.detailDesc.text = this.data.data.@description;
			
			/*
			parentDocument.labelA.text = this.data.data.@labelA;
			parentDocument.dataA.text = this.data.data.@dataA;
			
			parentDocument.labelB.text = this.data.data.@labelB;
			parentDocument.dataB.text = this.data.data.@dataB;
			
			parentDocument.axisLabelA.text = this.data.data.@axisLabelA;
			parentDocument.axisDataA.text = this.data.data.@axisDataA;
			
			parentDocument.axisLabelB.text = this.data.data.@axisLabelB;
			parentDocument.axisDataB.text = this.data.data.@axisDataB;
			
			parentDocument.nodeDate.text = this.data.data.@date;
			*/
			
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
			lb.scaleX = parentDocument.scaleFactor;
			lb.scaleY = parentDocument.scaleFactor;
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
		    	
				case "Agriculture":
				case "BioSphere":
				case "Causes":
				case "Clouds":
				case "Coastal":
				case "Death":
				case "Emissions":
				case "EnergyUses":
				case "Evidence":
				case "Extremes":
				case "Feedback":
				case "Fisheries":
				case "Floods":
				case "Forests":
				case "FreshWater":
				case "Glacier":
				case "GlobalClimateChange":
				case "GreenHouse":
				case "Habitability":
				case "HumanActivities":
				case "HumanHealth":
				case "HydrologicalCycle":
				case "Impacts":
				case "IndustrialActivities":
				case "Infectious":
				case "IntOrg":
				case "Keeling":
				case "Kyoto":
				case "LandUse":
				case "Mechanisms":
				case "MentalHealth":
				case "Microbial":
				case "Model":
				case "NaturalProcesses":
				case "Nutrition":
				case "Observations":
				case "Organization":
				case "PopulationIncrease":
				case "Precipitation":
				case "PredictedConsequences":
				case "PublicPolicy":
				case "RadiativeProcesses":
				case "Reflection":
				case "SeaIceMelting":
				case "SeaLevelRise":
				case "StormTracks":
				case "SunVariability":
				case "Trapping":
				case "Urbanization":
				
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
			_imageObject.scaleX = parentDocument.scaleFactor;
			_imageObject.scaleY = parentDocument.scaleFactor;
		}
		
		private function setImageNode(type:String):void {
			_imageObject = new Image();
				
			switch(type) {
				case "Agriculture":
			    	(_imageObject as Image).source = EmbeddedIcons.agricultureNode;
			        break;
		        case "BioSphere":
			    	(_imageObject as Image).source = EmbeddedIcons.bioSphereNode;
			        break;
		        case "Causes":
			    	(_imageObject as Image).source = EmbeddedIcons.causesNode;
			        break;
		        case "Clouds":
			    	(_imageObject as Image).source = EmbeddedIcons.cloudsNode;
			        break;
			     case "Coastal":
			    	(_imageObject as Image).source = EmbeddedIcons.coastalNode;
			        break;
			    case "Death":
			    	(_imageObject as Image).source = EmbeddedIcons.deathNode;
			        break;
			    case "Emissions":
			    	(_imageObject as Image).source = EmbeddedIcons.emissionsNode;
			        break;
				case "EnergyUses":
			    	(_imageObject as Image).source = EmbeddedIcons.energyUsesNode;
			        break;
			    case "Evidence":
			    	(_imageObject as Image).source = EmbeddedIcons.evidenceNode;
			        break;
			    case "Extremes":
			    	(_imageObject as Image).source = EmbeddedIcons.extremesNode;
			        break;
			    case "Feedback":
			    	(_imageObject as Image).source = EmbeddedIcons.feedbackNode;
			        break;
				case "Fisheries":
			    	(_imageObject as Image).source = EmbeddedIcons.fisheriesNode;
			        break;
			    case "Floods":
			    	(_imageObject as Image).source = EmbeddedIcons.floodsNode;
			        break;
			    case "Forests":
			    	(_imageObject as Image).source = EmbeddedIcons.forestsNode;
			        break;
			    case "FreshWater":
			    	(_imageObject as Image).source = EmbeddedIcons.freshWaterNode;
			        break;
			    case "Glacier":
			    	(_imageObject as Image).source = EmbeddedIcons.glacierNode;
			        break;
			    case "GlobalClimateChange":
		    		(_imageObject as Image).source = EmbeddedIcons.globalClimateChangeNode;
		        	break;
		        case "GreenHouse":
			    	(_imageObject as Image).source = EmbeddedIcons.greenHouseNode;
			        break;
			    case "Habitability":
			    	(_imageObject as Image).source = EmbeddedIcons.habitabilityNode;
			        break;
			    case "HumanActivities":
			    	(_imageObject as Image).source = EmbeddedIcons.humanActivitiesNode;
			        break;
			    case "HumanHealth":
			    	(_imageObject as Image).source = EmbeddedIcons.humanHealthNode;
			        break;
			    case "HydrologicalCycle":
			    	(_imageObject as Image).source = EmbeddedIcons.hydrologicalCycleNode;
			        break;
			    case "Impacts":
			    	(_imageObject as Image).source = EmbeddedIcons.impactsNode;
			        break;
		        case "IndustrialActivities":
			    	(_imageObject as Image).source = EmbeddedIcons.industrialActivitiesNode;
			        break;
			    case "Infectious":
			    	(_imageObject as Image).source = EmbeddedIcons.infectiousNode;
			        break;
			    case "IntOrg":
			    	(_imageObject as Image).source = EmbeddedIcons.intOrgNode;
			        break;
			    case "Keeling":
			    	(_imageObject as Image).source = EmbeddedIcons.keelingNode;
			        break;
		        case "Kyoto":
			    	(_imageObject as Image).source = EmbeddedIcons.kyotoNode;
			        break;
			    case "LandUse":
			    	(_imageObject as Image).source = EmbeddedIcons.landUseNode;
			        break;
		        case "Mechanisms":
			    	(_imageObject as Image).source = EmbeddedIcons.mechanismsNode;
			        break;
			    case "MentalHealth":
			    	(_imageObject as Image).source = EmbeddedIcons.mentalHealthNode;
			        break;
			    case "Microbial":
			    	(_imageObject as Image).source = EmbeddedIcons.microbialNode;
			        break;
		        case "Model":
			    	(_imageObject as Image).source = EmbeddedIcons.modelNode;
			        break;
			    case "NaturalProcesses":
			    	(_imageObject as Image).source = EmbeddedIcons.naturalProcessesNode;
			        break;
			    case "Nutrition":
			    	(_imageObject as Image).source = EmbeddedIcons.nutritionNode;
			        break;
			    case "Observations":
			    	(_imageObject as Image).source = EmbeddedIcons.observationsNode;
			        break;
			    case "Organization":
			    	(_imageObject as Image).source = EmbeddedIcons.organizationNode;
			        break;
				case "PopulationIncrease":
			    	(_imageObject as Image).source = EmbeddedIcons.populationIncreaseNode;
			        break;
				case "Precipitation":
			    	(_imageObject as Image).source = EmbeddedIcons.precipitationNode;
			        break;
			    case "PredictedConsequences":
			    	(_imageObject as Image).source = EmbeddedIcons.predictedConsequencesNode;
			        break;
			    case "PublicPolicy":
			    	(_imageObject as Image).source = EmbeddedIcons.publicPolicyNode;
			        break;
			    case "RadiativeProcesses":
			    	(_imageObject as Image).source = EmbeddedIcons.radiativeProcessesNode;
			        break;
			    case "Reflection":
			    	(_imageObject as Image).source = EmbeddedIcons.reflectionNode;
			        break;
			    case "SeaIceMelting":
			    	(_imageObject as Image).source = EmbeddedIcons.seaIceMeltingNode;
			        break;
			    case "SeaLevelRise":
			    	(_imageObject as Image).source = EmbeddedIcons.seaLevelRiseNode;
			        break;
			    case "StormTracks":
			    	(_imageObject as Image).source = EmbeddedIcons.stormTracksNode;
			        break;
			    case "SunVariability":
			    	(_imageObject as Image).source = EmbeddedIcons.sunVariabilityNode;
			        break;
				case "Trapping":
			    	(_imageObject as Image).source = EmbeddedIcons.trappingNode;
			        break;
		        case "Urbanization":
			    	(_imageObject as Image).source = EmbeddedIcons.urbanizationNode;
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

