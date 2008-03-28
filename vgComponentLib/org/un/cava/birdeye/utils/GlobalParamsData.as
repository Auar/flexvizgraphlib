/*
 * The MIT License
 *
 * Copyright (c) 2008
 * United Nations Office at Geneva
 * Center for Advanced Visual Analytics
 * http://cava.unog.ch
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
package org.un.cava.birdeye.utils {
	
	import flexlib.containers.WindowShade;
	
	import mx.containers.Accordion;
	import mx.controls.CheckBox;
	import mx.controls.Text;
	import mx.controls.TextArea;
	
	/**
	 * This class will hold global params in static
	 * variables related to all data presentation
	 * controls and components.
	 * */
	public class GlobalParamsData {
		
		
		/**
		 * This mapping holds all instantiated SearchFilterGrid
		 * components. They are indexed by their component id.
		 * */		
		public static var searchFilterGrids:Object;
		
	
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