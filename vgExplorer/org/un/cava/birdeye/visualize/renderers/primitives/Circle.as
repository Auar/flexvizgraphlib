package org.un.cava.birdeye.visualize.renderers.primitives
{
	import mx.core.UIComponent;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.InterpolationMethod;
	import flash.geom.Matrix;
	import mx.effects.Rotate;

	public class Circle extends UIComponent
	{
		/** the color that this circle will be */
		public function set color(i: int): void {
			_color = i;
			
			invalidateDisplayList(); 
		}
		
		/** our current color setting. */
		private var _color: int;
		
		/** redraws the component, using our current color, height, and width settings.
		 *  This function is called whenever the flex framework decides it's time to redraw the component. */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			graphics.clear();
			graphics.beginGradientFill(GradientType.RADIAL, [0xffffff, _color], [1, 1], [0, 127], 
				null, SpreadMethod.PAD, InterpolationMethod.RGB, 0.75);
			graphics.drawCircle(unscaledWidth / 2, unscaledHeight / 2, unscaledHeight / 2);
			graphics.endFill();
		}
	}
}