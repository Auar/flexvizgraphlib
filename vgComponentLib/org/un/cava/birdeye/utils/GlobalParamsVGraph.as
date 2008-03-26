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
	 * variables in order to facilitate the passing of params
	 * and to avoid issues with parentDocument and/or 
	 * parentApplication (and other issues)
	 * 
	 * This is essential for the proper functioning of
	 * all the provided control components for the graphLayout
	 * features. This is the main communication interface.
	 * 
	 * Basically every instantiated component will register itself
	 * with this class. graphLayout based components will have to be
	 * registered from the application (but it is basically only VisualGraph
	 * and the layouter).
	 * */
	public class GlobalParamsVGraph {
		
		
		/**
		 * This is the global instance of the VisualGraph
		 * object. Currently there can only be one right now.
		 * In a future time, this could be generalized, but then
		 * ALL other components registered here, have to be parametrized
		 * for each VisualGraph instance.
		 * */
		//public static var vgraph:IVisualGraph;
		
		/**
		 * This is the main instance for the currently
		 * active layouter in the VisualGraph object.
		 * Again currently only one instance is allowed, but
		 * it is less complicated to allow more than one
		 * (I wonder if there will be a demand for it, though).
		 * */
		//public static var layouter:ILayoutAlgorithm;
		
		/* these hold maps of the references, indexed by 
		 * their id */
		
		public static var layoutSelectorControls:Object;
		
		public static var linkLengthControls:Object;
		
		
	}
}