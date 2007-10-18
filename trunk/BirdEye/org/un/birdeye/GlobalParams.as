package org.un.birdeye {
	import mx.containers.Accordion;
	import mx.controls.TextArea;
	
	
	/**
	 * This class will hold global params in static
	 * variables in order to facilitate the passing of params
	 * and to avoid issues with parentDocument and/or 
	 * parentApplication (and other issues)
	 * */
	public class GlobalParams {
		
		/* scale factor for rendered items */
		public static var scaleFactor:Number = 1;
		
		/* some components in Visualize.mxml that have to 
		 * communicate with the icon renderer to handle mouse events */
		public static var visualLeftAccordion:Accordion;
		public static var visualDetailTitle:TextArea;
		public static var visualDetailDesc:TextArea;
		
	}
}