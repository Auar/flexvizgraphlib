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
	
	
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.components.ui.controls.layouterControls.CommonLayoutControls;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.HierLayoutControls;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.LayoutSelector;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.LinkLength;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.NodeSpacing;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.OrientationSelector;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.PhiDial;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.ToggleAnimation;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.ToggleAutoFit;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.ToggleDamping;
	import org.un.cava.birdeye.components.ui.controls.layouterControls.ToggleSiblingSpread;
	import org.un.flex.graphLayout.layout.CircularLayouter;
	import org.un.flex.graphLayout.layout.ConcentricRadialLayouter;
	import org.un.flex.graphLayout.layout.DirectPlacementLayouter;
	import org.un.flex.graphLayout.layout.ForceDirectedLayouter;
	import org.un.flex.graphLayout.layout.HierarchicalLayouter;
	import org.un.flex.graphLayout.layout.Hyperbolic2DLayouter;
	import org.un.flex.graphLayout.layout.ILayoutAlgorithm;
	import org.un.flex.graphLayout.layout.ISOMLayouter;
	import org.un.flex.graphLayout.layout.ParentCenteredRadialLayouter;
	import org.un.flex.graphLayout.layout.PhylloTreeLayouter;
	import org.un.flex.graphLayout.visual.IVisualGraph;
	
	/**
	 * This class will hold global static methods
	 * necessary to control the layouter behaviour of the
	 * VGraph.
	 * */
	public class GlobalLayoutControls {
		
 		/**
		 * Set/Activate the layouter set in the corresponding
		 * global parameter.
		 * XXX Historically we had this as part of the layout selector,
		 * but actually the layouter can be specified independently of
		 * a combo-box selector and would still need to be applied
		 * thus we externalise the method to a global one.
		 * */
		public static function applyLayouter():void {
			
			var vgraph:IVisualGraph = GlobalParams.vgraph;
			var layouter:ILayoutAlgorithm;
			
			/* kill off animation in old layouter if present */
			if(GlobalParams.layouter != null) {
				GlobalParams.layouter.resetAll();
				/* remove also existing references thus
				 * destroying the object (maybe this is not needed?) */
				GlobalParams.layouter = null;
			}
			
			/* careful ... */
			if(vgraph != null) {
				vgraph.layouter = null;
			} else {
				trace("No valid vgraph object in GlobalParams, cannot continue");
				return;	
			}
			
			/* Prior to selection of a new layouter, 
			 * we disable all layouter specific controls.
			 * After, we enable only those relevant for the
			 * specific layouter.
			 */
			disableLayouterControls();

			/* now choose the selected layouter */
			switch(GlobalParamsLayout.currentLayouterName) {
				case "ConcentricRadial":
					layouter = new ConcentricRadialLayouter(vgraph);
					break;
				case "ParentCenteredRadial":
					layouter = new ParentCenteredRadialLayouter(vgraph);
					setAllInstancesEnabled(GlobalParamsLayout.phiDialControls, true);
					break;
				case "SingleCycleCircle":
					layouter = new CircularLayouter(vgraph);
					
					/* set the hyperbolic edge renderer type *
					vgraph.edgeRenderer = new CircularEdgeRenderer();
					vgraph.scrollBackgroundInDrag = false;
					vgraph.moveNodeInDrag = false;
					absoluteScaling = true;
					updateScale();
					*/
					break;
				case "Hyperbolic":
					layouter = new Hyperbolic2DLayouter(vgraph);
					
					/* set some layouter specific defaults:
					vgraph.edgeRenderer = new HyperbolicEdgeRenderer((layouter as Hyperbolic2DLayouter).projector);
					vgraph.scrollBackgroundInDrag = false;
					vgraph.moveNodeInDrag = false;
					absoluteScaling = false;
					*/
					break;
				case "Hierarchical":
					layouter = new HierarchicalLayouter(vgraph);
					setAllInstancesEnabled(GlobalParamsLayout.hierLayoutControls, true);
					/* apply the current values of all controls to the layouter */
					break;
				case "ForceDirected":
					layouter = new ForceDirectedLayouter(vgraph);
					setAllInstancesEnabled(GlobalParamsLayout.dampingControls, true);
					/* apply the damping value to the layouter */
					break;
				case "ISOM":
					layouter = new ISOMLayouter(vgraph);
					break;
				case "DirectPlacement":
					layouter = new DirectPlacementLayouter(vgraph);
					/* set some layouter specific values, i.e. create a control
					 * for these first, also they could be prepopulated from
					 * XML data
					(layouter as DirectPlacementLayouter).relativeHeight = 400;
					(layouter as DirectPlacementLayouter).relativeWidth = 400;
					 */
					/*
					/* set the orthogonal edge renderer type *
					vgraph.edgeRenderer = new OrthogonalEdgeRenderer();
					vgraph.scrollBackgroundInDrag = true;
					vgraph.moveNodeInDrag = true;
					absoluteScaling = true;
					updateScale();
					*/
					break;
				case "Phyllotactic":
					layouter = new PhylloTreeLayouter(vgraph);
					setAllInstancesEnabled(GlobalParamsLayout.phiDialControls, true);
					/* apply the current phidial value to the layouters .phi property */
					break;
				default:
					trace("Illegal Layouter selected, defaulting to ConcentricRadial"+
						GlobalParamsLayout.currentLayouterName);
					layouter = new ConcentricRadialLayouter(vgraph);
					break;
			}
			GlobalParams.layouter = layouter;
			vgraph.layouter = layouter;
			
			/* now re-enable all common layouter Controls */
			enableCommonLayouterControls();
			
		}
		
		/**
		 * Go through all registered layouter controls and
		 * set their enabled state to false.
		 * This may not be the best way to do it, but we start
		 * trying this way.
		 * */
		public static function disableLayouterControls():void {
			
			setAllInstancesEnabled(GlobalParamsLayout.layoutSelectorControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.linkLengthControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.autoFitControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.animationControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.dampingControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.phiDialControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.orientationControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.nodeSpacingControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.siblingSpreadControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.hierLayoutControls, false);
			setAllInstancesEnabled(GlobalParamsLayout.commonLayoutControls, false);
			
			/* disabled to see if general method works 
			if(GlobalParamsLayout.layoutSelectorControls != null) {
				for each(controlobj in 	GlobalParamsLayout.layoutSelectorControls) {
					if(controlobj is LayoutSelector) {
						(controlobj as LayoutSelector).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.linkLengthControls != null) {
				for each(controlobj in 	GlobalParamsLayout.linkLengthControls) {
					if(controlobj is LinkLength) {
						(controlobj as LinkLength).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.autoFitControls != null) {
				for each(controlobj in 	GlobalParamsLayout.autoFitControls) {
					if(controlobj is ToggleAutoFit) {
						(controlobj as ToggleAutoFit).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.animationControls != null) {
				for each(controlobj in 	GlobalParamsLayout.animationControls) {
					if(controlobj is ToggleAnimation) {
						(controlobj as ToggleAnimation).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.dampingControls != null) {
				for each(controlobj in 	GlobalParamsLayout.dampingControls) {
					if(controlobj is ToggleDamping) {
						(controlobj as ToggleDamping).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.phiDialControls != null) {
				for each(controlobj in 	GlobalParamsLayout.phiDialControls) {
					if(controlobj is PhiDial) {
						(controlobj as PhiDial).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.orientationControls != null) {
				for each(controlobj in 	GlobalParamsLayout.orientationControls) {
					if(controlobj is OrientationSelector) {
						(controlobj as OrientationSelector).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.nodeSpacingControls != null) {
				for each(controlobj in 	GlobalParamsLayout.nodeSpacingControls) {
					if(controlobj is NodeSpacing) {
						(controlobj as NodeSpacing).enabled = false;
					}
				}
			}
			
			if(GlobalParamsLayout.siblingSpreadControls != null) {
				for each(controlobj in 	GlobalParamsLayout.siblingSpreadControls) {
					if(controlobj is ToggleSiblingSpread) {
						(controlobj as ToggleSiblingSpread).enabled = false;
					}
				}
			}
			
			/* attention, this should re-disable the components of the compound component *
			if(GlobalParamsLayout.hierLayoutControls != null) {
				for each(controlobj in 	GlobalParamsLayout.hierLayoutControls) {
					if(controlobj is HierLayoutControls) {
						(controlobj as HierLayoutControls).enabled = false;
					}
				}
			}
			
			/* attention, this should re-disable the components of the compound component *
			if(GlobalParamsLayout.commonLayoutControls != null) {
				for each(controlobj in 	GlobalParamsLayout.commonLayoutControls) {
					if(controlobj is CommonLayoutControls) {
						(controlobj as CommonLayoutControls).enabled = false;
					}
				}
			}
			*/	
		}

		/**
		 * Go through all COMMON registered layouter controls and
		 * set their enabled state to true.
		 * */
		public static function enableCommonLayouterControls():void {	
			setAllInstancesEnabled(GlobalParamsLayout.layoutSelectorControls, true);
			setAllInstancesEnabled(GlobalParamsLayout.linkLengthControls, true);
			setAllInstancesEnabled(GlobalParamsLayout.autoFitControls, true);
			setAllInstancesEnabled(GlobalParamsLayout.animationControls, true);
			setAllInstancesEnabled(GlobalParamsLayout.commonLayoutControls, true);
		}


		/**
		 * This method assumes the passed object is a map of UIComponents
		 * and sets the enabled property of all these UIComponents to the
		 * specified value. Typically a map object from a GlobalParams
		 * static class could be specified. Maybe this method will be
		 * publized and moved to GlobalControls.
		 * 
		 * @param map An object with UIComponents indexed 
		 * @param value The boolean value to set the UIComponents to.
		 * */
		private static function setAllInstancesEnabled(map:Object, value:Boolean):void {
			var uicomp:Object;
			if(map != null) {
				for each(uicomp in map) {
					if(uicomp is UIComponent) {
						(uicomp as UIComponent).enabled = value;
					}
				}
			}
		}
	}
}