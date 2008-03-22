package org.un.cava.birdeye.assets.icons.primitives
{
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	
	import mx.core.UIComponent;

	/**
	 * This class implements a very basic Circle object
	 * as UIComponent. It just draws a circle on the graphics
	 * object of the UIComponent with the specified color and
	 * styles...
	 * 
	 * Generally we should probably scrap this in favour of the
	 * degrafa classes, although they work differently and we
	 * first have to learn how to use them.
	 * */
	public class Circle extends UIComponent	{

		/** our current color setting. */
		private var _color:int;
		
		/* default constructor */
		
		
		/** 
		 * set the color of the circle.
		 * @param c The color of the circle as integer value 
		 * */
		public function set color(c:int): void {
			_color = c;
			invalidateDisplayList(); 
		}
		
		/**
		 * @private
		 * */
		public function get color():int {
			return _color;
		}
		
		
		/**
		 * In order to actually draw the circle, we override updateDisplayList
		 * and then add the code to draw on the graphics object.
		 * @inheritDoc		
		 * */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			
			/* clear the existing drawing */
			graphics.clear();
			
			/* we want a gradient filled circle */
			graphics.beginGradientFill(GradientType.RADIAL,
										[0xffffff, _color],
										[1, 1],
										[0, 127], 
										null,
										SpreadMethod.PAD,
										InterpolationMethod.RGB,
										0.75);
			/* now we draw the circle, it's radius is half the size of the height of the UIComponent,
			 * thus it will always fill a square one. However, if we resize the width the circle
			 * might be too large...? 
			 */
			graphics.drawCircle(unscaledWidth / 2, unscaledHeight / 2, unscaledHeight / 2);

			/* done */
			graphics.endFill();
		}
	}
}