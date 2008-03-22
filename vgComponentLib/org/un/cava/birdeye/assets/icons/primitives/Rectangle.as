package org.un.cava.birdeye.assets.icons.primitives
{
	import mx.core.UIComponent;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.InterpolationMethod;
	import flash.geom.Matrix;
	import mx.effects.Rotate;

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
	public class Rectangle extends UIComponent {
		
		/* our current color setting. */
		private var _color:int;
		
		/* width and height of the rectangle */
		private var _width:int;
		private var _height:int;
		
		/* default constructor (empty) */
		
		/** 
		 * set the color of the rectangle.
		 * @param c The color of the rectangle as integer value 
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
		 * Set the width of the rectangle. (A UIComponent also has
		 * width already).
		 * @param w The width of the rectangle in pixel.
		 * */
		public function set recWidth(w:int): void {
			_width = w;
			invalidateDisplayList(); 
		}
		/**
		 * @private
		 * */
		public function get recWidth():int {
			return _width;
		}
		
		/** 
		 * Set the height of the rectangle. (A UIComponent also has
		 * height already).
		 * @param h The height of the rectangle in pixel.
		 * */
		public function set recHeighth(h:int): void {
			_height = h;
			invalidateDisplayList(); 
		}
		/**
		 * @private
		 * */
		public function get recHeight():int {
			return _height;
		}
		
			
		/**
		 * In order to actually draw the rectangle, we override updateDisplayList
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
										
			/* now we draw the rectangle */
			graphics.drawRect(unscaledWidth / 2,unscaledHeight / 2, _width, _height);

			/* done */
			graphics.endFill();
		}
	}
}