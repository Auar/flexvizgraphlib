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
	 * This class will hold global params and object
	 * references in static variables in order to facilitate the passing of params
	 * 
	 * In this module everything concerning layouter related
	 * controls and components are registered.
	 * 
	 * See also @see GlobalParams.
	 * */
	public class GlobalParamsLayout {
		
		/**
		 * This string contains the descriptive name of the
		 * currently selected layouter
		 * */
		public static var currentLayouterName:String;
		
		/**
		 * This mapping holds all instantiated LayoutSelecter
		 * components. They are indexed by their component id.
		 * */
		public static var layoutSelectorControls:Object;
		
		/**
		 * This mapping holds all instantiated LinkLength
		 * components. They are indexed by their component id.
		 * */		
		public static var linkLengthControls:Object;
		
		/**
		 * This mapping holds all instantiated ToggleAutoFit
		 * components. They are indexed by their component id.
		 * */		
		public static var autoFitControls:Object;

		/**
		 * This mapping holds all instantiated ToggleAnimation
		 * components. They are indexed by their component id.
		 * */		
		public static var animationControls:Object;

		/**
		 * This mapping holds all instantiated ToggleDamping
		 * components. They are indexed by their component id.
		 * */		
		public static var dampingControls:Object;
		
		/**
		 * This mapping holds all instantiated PhiDial
		 * components. They are indexed by their component id.
		 * */		
		public static var phiDialControls:Object;

		/**
		 * This mapping holds all instantiated Orientation
		 * components. They are indexed by their component id.
		 * */		
		public static var orientationControls:Object;
		
		/**
		 * This mapping holds all instantiated NodeSpacing
		 * components. They are indexed by their component id.
		 * */		
		public static var nodeSpacingControls:Object;

		/**
		 * This mapping holds all instantiated ToggleSiblingSpread
		 * components. They are indexed by their component id.
		 * */		
		public static var siblingSpreadControls:Object;		
		
		/**
		 * This mapping holds instantiated HierLayoutControls
		 * components, which aggregate as a compound component
		 * the OrientationSelector, NodeSpacing and SiblingSpread
		 * components.
		 * */
		public static var hierLayoutControls:Object;

		/**
		 * This mapping holds instantiated CommonLayoutControls
		 * components, which aggregate as a compound component
		 * all controls common to all layouters, currently 
		 * AutoFit, Animation and LinkLength.
		 * */
		public static var commonLayoutControls:Object;

	}
}