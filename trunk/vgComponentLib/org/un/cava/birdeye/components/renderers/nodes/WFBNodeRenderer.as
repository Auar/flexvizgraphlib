package org.un.cava.birdeye.components.renderers.nodes {
	
	import flash.events.Event;
	
	import mx.effects.Zoom;
	
	import org.un.cava.birdeye.utils.GlobalParams;
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	
	/**
	 * Renderer for data from the CIA World Factbook
	 * */
	public class WFBNodeRenderer extends EffectBaseNodeRenderer  {
		
		/**
		 * Default constructor
		 * */
		public function WFBNodeRenderer() {
			super();
		}
	
		/**
		 * @inheritDoc
		 * */
		override protected function initComponent(e:Event):void {
			
			var cc:Circle;
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* add a simple circle as in the base class */
			cc = addCircle();
			
			/* now add the filters to the circle */
			reffects.addDSFilters(cc);
			 
			/* now the link button */
			initLinkButton();
		}
	
		override protected function getDetails(e:Event):void {
			/* call base method */
			super.getDetails(e);
			
			/* now add specifics
			 * all would need checks for presence of the XML attribute */
			if(GlobalParams.visualShade != null) {
				GlobalParams.visualShade.opened = true;
			}
			if(GlobalParams.visualDetailContinent != null) {
				GlobalParams.visualDetailContinent.text = this.data.data.@continent;
			}
			if(GlobalParams.visualDetailCountry != null) {
				GlobalParams.visualDetailCountry.text = this.data.data.@name;
			}
			if(GlobalParams.visualDetailCapital != null) {
				GlobalParams.visualDetailCapital.text = this.data.data.@capital;
			}
			if(GlobalParams.visualDetailGovernment != null) {
				GlobalParams.visualDetailGovernment.text = this.data.data.@government;
			}
			if(GlobalParams.visualDetailDoI != null) {
				GlobalParams.visualDetailDoI.text = this.data.data.@indep_date;
			}
			if(GlobalParams.visualDetailGDP != null) {
				GlobalParams.visualDetailGDP.text = this.data.data.@gdp_total;
			}
			if(GlobalParams.visualDetailInflation != null) {
				GlobalParams.visualDetailInflation.text = this.data.data.@inflation;
			}
			if(GlobalParams.visualDetailIM != null) {
				GlobalParams.visualDetailIM.text = this.data.data.@infant_mortality;
			}
			if(GlobalParams.visualDetailPopGrowth != null) {
				GlobalParams.visualDetailPopGrowth.text = this.data.data.@population_growth;
			}
			if(GlobalParams.visualDetailPop != null) {
				GlobalParams.visualDetailPop.text = this.data.data.@population;
			}
		}
	
		/**
		 * create a UIComponent with a cimple circle
		 * and add it do this object
		 * @returns the circle, may be useful for derived classes 
		 * */
		private function addCircle():Circle {
			
			var cc:Circle = new Circle();
			var nodeType:String = this.data.data.@nodeType; // needs check

			cc.id = "circle";
			cc.toolTip = this.data.data.@name; // needs check
			cc.width = 10;
			cc.height = 10;
			
			switch(nodeType) {
				case "center":
					cc.color = 0x333333;
					break;
				case "continent":
					cc.color = 0x999999;
					break;
				case "country":
					cc.color = 0x228b22;
					break;
				case "language":
					cc.color = 0x9932cc;
					break;
				case "ocean":
					cc.color = 0x4682b4;
					break;
				default:
					cc.color = 0x333333;
					break;
			}
			this.addChild(cc);
			return cc;
		}

	}
}