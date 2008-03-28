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
	
	/**
	 * This class will hold global params in static
	 * variables related to VisualGraph properties.
	 * 
	 * Basically every instantiated component will register itself
	 * with this class. graphLayout based components will have to be
	 * registered from the application (but it is basically only VisualGraph
	 * and the layouter).
	 * */
	public class GlobalParamsVGraph {
		

		/* these hold maps of the references, indexed by 
		 * their id */
		
		/**
		 * This mapping holds all instantiated BirdEyeZoom
		 * components. They are indexed by their component id.
		 * */
		public static var birdEyeZoomControls:Object;
		
		/**
		 * This mapping holds all instantiated ScaleLabels
		 * components. They are indexed by their component id.
		 * */		
		public static var scaleLabelsControls:Object;

		/**
		 * This mapping holds all instantiated DegreeOfSeparation
		 * components. They are indexed by their component id.
		 * */		
		public static var degreeOfSeparationControls:Object;
		
		/**
		 * This mapping holds all instantiated NodeRendererSelector
		 * components. They are indexed by their component id.
		 * */		
		public static var nodeRendererSelectorControls:Object;

		/**
		 * This mapping holds all instantiated EdgeLabelSelector
		 * components. They are indexed by their component id.
		 * */		
		public static var edgeLabelSelectorControls:Object;

		/**
		 * This mapping holds all instantiated EdgeRendererSelector
		 * components. They are indexed by their component id.
		 * */		
		public static var edgeRendererSelectorControls:Object;

		/**
		 * This mapping holds all instantiated ToggleEdgeLabels
		 * components. They are indexed by their component id.
		 * */		
		public static var toggleEdgeLabelsControls:Object;

		/**
		 * This mapping holds all instantiated ToggleShowHistory
		 * components. They are indexed by their component id.
		 * */		
		public static var toggleShowHistoryControls:Object;

		/**
		 * This mapping holds all instantiated EdgeLabelControls
		 * components. This is a compount component of all EdgeLabel
		 * related controls.
		 * They are indexed by their component id.
		 * */		
		public static var edgeLabelControls:Object;

		/**
		 * This mapping holds all instantiated RendererControls
		 * components. This is a compount component of all renderer
		 * related controls.
		 * They are indexed by their component id.
		 * */		
		public static var rendererControls:Object;
		
		/**
		 * This mapping holds all instantiated ScaleControls
		 * components. This is a compount component of all scale
		 * related controls.
		 * They are indexed by their component id.
		 * */		
		public static var scaleControls:Object;	
		
	}
}