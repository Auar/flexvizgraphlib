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
		
		/** 
		 * scale factor for rendered items */
		public static var scaleFactor:Number = 1;
		
		/**
		 * Reference to a component in Visualize.mxml, which
		 * must be available to the icon renderer, to handle
		 * certain mouse events. */
		public static var visualLeftAccordion:Accordion;
		
		/**
		 * Reference to a component in Visualize.mxml, which
		 * must be available to the icon renderer, to handle
		 * certain mouse events. */
		public static var visualDetailTitle:TextArea;
		
		/**
		 * Reference to a component in Visualize.mxml, which
		 * must be available to the icon renderer, to handle
		 * certain mouse events. */
		public static var visualDetailDesc:TextArea;
		
		/**
		 * A global mapping with strings as keys and images as objects
		 * to be used by IconRenderers and to be populated by the
		 * database, so that Icon images can be pulled from the database.
		 * */
		public static var iconMap:Object;
		
	}
}