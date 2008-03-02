package org.un.cava.birdeye.visualize.renderers.primitives
{
	import mx.core.UIComponent;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.InterpolationMethod;
	import flash.geom.Matrix;
	import mx.effects.Rotate;

	public class Rectangle extends UIComponent
	{
		/** the color that this circle will be */
		public function set color(i: int): void {
			_color = i;
			
			invalidateDisplayList(); 
		}
		
		public function set nwidth(j: int): void {
			_nwidth = j;
			
			invalidateDisplayList(); 
		}
		
		public function set nheight(k: int): void {
			_nheight = k;
			
			invalidateDisplayList(); 
		}
		/** our current color setting. */
		private var _color: int;
		private var _nwidth: int;
		private var _nheight: int;
		
		/** redraws the component, using our current color, height, and width settings.
		 *  This function is called whenever the flex framework decides it's time to redraw the component. */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			graphics.clear();
			graphics.beginGradientFill(GradientType.RADIAL, [0xffffff, _color], [1, 1], [0, 127], 
				null, SpreadMethod.PAD, InterpolationMethod.RGB, 0.75);
			graphics.drawRect(unscaledWidth / 2,unscaledHeight / 2, _nwidth, _nheight);
			graphics.endFill();
		}
	}
}