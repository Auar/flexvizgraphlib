package org.un.cava.birdeye.components.renderers.nodes {
	
	// Flash classes
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.VBox;
	import mx.controls.Label;
	import mx.controls.LinkButton;
	import mx.controls.Spacer;
	import mx.core.IDataRenderer;
	import mx.events.FlexEvent;
	
	import org.un.cava.birdeye.utils.GlobalParams;
	
	/**
	 * This _image displays the graph nodes as
	 * primitive icon or as embedded image
	 * */
	public class BaseNodeRenderer extends VBox {
	
		/**
		 * Base Constructor
		 * */
		public function BaseNodeRenderer() {
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE,initComponent);
		}
			
		/**
		 * Sets various values in the GlobalParams class
		 * to make them available for detail display in a separate
		 * area. Basically this gets executed when a node is selected
		 * This requires this item (being an IDataRenderer) to have meaningful
		 * data in its 'data' field. Specifically it requires that the object
		 * in data is a VisualNode, which in turn has a data property which
		 * then must contain the corresponding XML object from the Node
		 * definition.
		 * @param e The event that this handler was triggered from. Unused.
		 * */
		protected function getDetails(e:Event):void {
			// trace("Show Details");
			
			/* check if we have a data object */
			if(this.data == null) {
				trace("Data object of this NodeRenderer is null. This should not happen, probably wrong usage");
				return;
			}
			
			/* if yes, it should be an IVisualNode, but actually we don't care
			 * we just need to make sure it also has a data object */
			if(!(this.data is IDataRenderer)) {
				trace("Data object is no IDataRenderer");
				return;
			}
			
			/* and it should not be null */
			if(this.data.data == null) {
				trace("Data object of data object is null");
				return;
			} 
			
			/* set the name of the XML object as title */
			if(GlobalParams.visualDetailTitle != null) {
				/* make sure we have the XML attribute */
				if(this.data.data.@name != null) {
					GlobalParams.visualDetailTitle.text = this.data.data.@name;
				} else {
					trace("XML data object has no 'name' attribute");
				}
			} else {
				throw Error("GlobalParams.visualDetailTitle not initialised!");
			}
			
			/* now the description */
			if(GlobalParams.visualDetailDesc != null) {
				if(this.data.data.@desc != null) {
					GlobalParams.visualDetailDesc.text = this.data.data.@desc;
				} else {
					trace("XML data object has no 'desc' attribute");
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
		 * Full initialisation of the renderer component, triggered
		 * after reception of the creation complete event.
		 * This method should be overriden by NodeRenderers
		 * which are more specific.
		 * @param e the creation complete event (unused).
		 * */
		protected function initComponent(e:Event):void {
			
			/* initialize the upper part of the renderer */
			initTopPart();
			
			/* in between could be other components added
			 * like images */
			 
			/* now the link button */
			initLinkButton();
			
			/* and the label */
			initLabel();
		}

		/**
		 * This method initialises the "upper" part of
		 * the rencerer and the general parts,
		 * i.e. title, tooltip, spacer */
		protected function initTopPart():void {
			
			var spacer:Spacer;
			
			/* set id so it is accessible from MXML */
			this.id = "detailView";
			
			/* set styles */
			this.setStyle("horizontalAlign","center");
			
			/* set the tool tip to be the name attribute of the XML object
			 * we should also check here about the correctness of all
			 * the data objects, just as in getDetails(), even more important
			 * since this will be called earlier....
			 * maybe it is all not so critical... anyway, we don't abort,
			 * so just some diagnostic messages are printed... */
			if(this.data.data.@name != null) {
				this.toolTip = this.data.data.@name;
			} else {
				trace("XML data object has no 'name' attribute");
			}
			
			/* create and add a spacer */
			spacer = new Spacer();
			spacer.id = "makeimgalign";
			spacer.height = 18;
			this.addChild(spacer);
		}

		/**
		 * this methods initialises and adds a 
		 * link button to the renderer
		 * */
		protected function initLinkButton():void {
			
			var lb:LinkButton;
			
			lb = new LinkButton();
			lb.id = "viewDetails";
			
			/* again here no check */
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
		
		/**
		 * this methods initialises and adds a label
		 * with visible text, if the node is selected
		 * */
		protected function initLabel():void {
			var ll:Label;
			
			ll = new Label();
			ll.id = "nodeLabel";
			/* again we should do checks here */
			ll.text = this.data.data.@name;
			/* some hardcoded values for now */
			ll.width = 75;
			ll.height = 11;
			ll.setStyle("textAlign","center");
			ll.setStyle("fontSize",10);
			
			this.addChild(ll);
			
			/* not sure yet how to incoroporate this
			if (GlobalParams.visualNodeLabel.selected==true){
				nodeText.visible=true
			} else {
				nodeText.visible=false
			}
			*/
		}
	}
}

