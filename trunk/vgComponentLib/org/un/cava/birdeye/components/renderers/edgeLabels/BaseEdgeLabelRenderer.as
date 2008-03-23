package org.un.cava.birdeye.components.renderers.edgeLabels {
	
	// Flash classes
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.controls.Spacer;
	import mx.core.IDataRenderer;
	import mx.events.FlexEvent;
	
	import org.un.cava.birdeye.components.renderers.BaseRenderer;
	import org.un.cava.birdeye.utils.GlobalParams;
	
	/**
	 * This is an extension to the base renderer
	 * specific to Nodes, i.e. it populates various
	 * label fields and icons with node XML data.
	 * */
	public class BaseEdgeLabelRenderer extends BaseRenderer {
	
		/**
		 * Base Constructor
		 * */
		public function BaseEdgeLabelRenderer() {
			super();
		}
			
		/**
		 * @inheritDoc
		 * */
		override protected function getDetails(e:Event):void {
			// trace("Show Details");
			
			/* do the checks in the super class */
			super.getDetails(e);
			
			/* set the name of the XML object as title */
			if(GlobalParams.visualDetailTitle != null) {
				/* make sure we have the XML attribute */
				if(this.data.data.@edgeLabel != null) {
					GlobalParams.visualDetailTitle.text = this.data.data.@edgeLabel;
				} else {
					trace("XML data object has no 'edgeLabel' attribute");
				}
			} else {
				throw Error("GlobalParams.visualDetailTitle not initialised!");
			}
			
			/* now the description */
			if(GlobalParams.visualDetailDesc != null) {
				if(this.data.data.@edgeDescription != null) {
					GlobalParams.visualDetailDesc.text = this.data.data.@edgeDescription;
				} else {
					trace("XML data object has no 'edgeDescription' attribute");
				}
			} else {
				throw Error("GlobalParams.visualDetailDesc not initialised!");
			}
			
			/* this is a bit obscure and should be done through a constant
			 * basically the index 2 in the current implementation means to
			 * open the detailed description pane.
			 * All this could possibly be better resolved using events
			 * ...
			 */
			if(GlobalParams.visualLeftAccordion != null) {
				GlobalParams.visualLeftAccordion.selectedIndex = 2;
			} else {
				throw Error("GlobalParams.visualLeftAccordion not initialised!");
			}
		}
		
		/**
		 * @inheritDoc
		 * 
		 * Make sure we call the init methods of THIS
		 * class and not the base class.
		 * */
		override protected function initComponent(e:Event):void {
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* in between could be other components added
			 * like images */
			 
			/* now the link button */
			initLinkButton();
			
			/* or the label both would be overkill */
			//initLabel();
		}

		/**
		 * @inheritDoc
		 * */
		override protected function initTopPart():void {
			
			/* create the top part using super class */
			super.initTopPart();
			
			/* set the tool tip to be the name attribute of the XML object
			 * we should also check here about the correctness of all
			 * the data objects, just as in getDetails(), even more important
			 * since this will be called earlier....
			 * maybe it is all not so critical... anyway, we don't abort,
			 * so just some diagnostic messages are printed... */
			if(this.data.data.@name != null) {
				this.toolTip = this.data.data.@edgeLabel;
			} else {
				trace("XML data object has no 'edgeLabel' attribute");
			}
		}

		/**
		 * @inheritDoc
		 * */
		override protected function initLinkButton():LinkButton {
			
			/* create the linkbutton using 
			 * the super class */
			super.initLinkButton();
			
			/* add node specific data;
			 * here no check, but should be done */
			lb.label = this.data.data.@edgeLabel;
			
			return lb;
		}
		
		/**
		 * @inheritDoc
		 * */
		override protected function initLabel():Label {
			
			/* base init */
			super.initLabel();
			
			/* again we should do checks here */
			ll.text = this.data.data.@edgeLabel;
			
			return ll;
		}
	}
}

