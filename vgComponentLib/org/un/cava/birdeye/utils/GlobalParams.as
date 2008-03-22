package org.un.cava.birdeye.utils {
	
	import flexlib.containers.WindowShade;
	
	import mx.containers.Accordion;
	import mx.controls.CheckBox;
	import mx.controls.Text;
	import mx.controls.TextArea;
	import mx.controls.VSlider;
	
	import org.un.flex.graphLayout.layout.ILayoutAlgorithm;
	import org.un.flex.graphLayout.visual.IVisualGraph;
	
	
	/**
	 * This class will hold global params in static
	 * variables in order to facilitate the passing of params
	 * and to avoid issues with parentDocument and/or 
	 * parentApplication (and other issues)
	 * */
	public class GlobalParams {
		
		/**
		 * Core objects for VisualGraph
		 * */
		public static var layouter:ILayoutAlgorithm;
		public static var vgraph:IVisualGraph;
			
		
		/** 
		 * zoom factor for rendered items */
		public static var zoom:VSlider;
		/* scale factor for rendered items */
		public static var scaleFactor:Number = 1;
		
		/* some components in Visualize.mxml that have to 
		 * communicate with the icon renderer to handle mouse events */
		public static var visualLeftAccordion:Accordion;
		public static var visualDetailTitle:TextArea;
		public static var visualDetailDesc:TextArea;
		
		public static var visualDetailContinent:Text;
		public static var visualDetailCountry:Text;
		public static var visualDetailCapital:Text;
		public static var visualDetailGovernment:Text;
		public static var visualDetailDoI:Text;
		public static var visualDetailGDP:Text;
		public static var visualDetailInflation:Text;
		public static var visualDetailIM:Text;
		public static var visualDetailPopGrowth:Text;
		public static var visualDetailPop:Text;
		
		public static var visualNodeLabel:CheckBox;
		
		public static var visualShade:WindowShade;
		
	}
}