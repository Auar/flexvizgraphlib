package org.un.birdeye.visualize.minimap
{
	import mx.containers.Panel;
	import mx.controls.Image;
	import flash.events.TimerEvent;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import mx.core.UIComponent;
	import flash.display.Bitmap;
	import mx.core.Container;
	import flash.display.DisplayObject;
	import mx.containers.Canvas;
	import mx.effects.easing.Back;

	public class MiniMap extends Canvas
	{
		public static const WIDTH : Number = 200;
		public static const HEIGHT : Number = 400;
		
		public var targetUIComponent : UIComponent;
		
		private var tx : Number = 0;
		private var ty : Number = 0;
		private var ts : Number = 0;
		
		private var img : Image;
		private var bd : BitmapData;
		private var m : Matrix;
		private var timer : Timer;
		
		
		public function MiniMap()
		{
			super();
			// title = "Mini Map";
			horizontalScrollPolicy = "off";
			verticalScrollPolicy = "off"
			
			img = new Image();
			img.percentWidth = 100;
			img.visible = true;
			this.addChild( img );
			
			bd = new BitmapData( WIDTH, HEIGHT );
			m = new Matrix();
			
			timer = new Timer( 500 );
			timer.addEventListener( TimerEvent.TIMER, onTimerEvent );
			
			timer.start();
		}
		
		private function onTimerEvent( event : TimerEvent ) : void
		{
			try
			{
				
				if ( targetUIComponent != null )
				{
					var minx:int;
					var maxx:int;
					var miny:int;
					var maxy:int;
					var w:int = 0;
					var h:int = 0;
			
					if ( targetUIComponent.numChildren > 0 )
					{
						
						for ( var i : int = 0; i < targetUIComponent.numChildren; i ++ )
						{
							var child : DisplayObject = targetUIComponent.getChildAt( i );
							if ( i == 0 )
							{
								minx = child.x;
								maxx = child.x;
								miny = child.y + child.width;
								maxy = child.y + child.height;
							}
							else
							{
								minx = Math.min( minx, child.x );
								miny = Math.min( miny, child.y );
								maxx = Math.max( maxx, child.x + child.width );
								maxy = Math.max( maxy, child.y + child.height );
							}
							
						}
						
						w = maxx - minx;
						h = maxy - miny;
						
						tx = WIDTH / w ;
						ty = HEIGHT / h ;
					}
					else 
					{
						tx = WIDTH / (targetUIComponent.width / targetUIComponent.scaleX) ;
						ty = HEIGHT / (targetUIComponent.height / targetUIComponent.scaleY) ;
					}
					
					ts = Math.min( tx, ty );
					
					bd.fillRect( new Rectangle(0,0,WIDTH,HEIGHT), 0xFFFFFF );
					m.identity();
					m.scale( ts, ts );
					m.translate( -minx*ts, -miny*ts );
					bd.draw( targetUIComponent, m );
					img.source = new Bitmap( bd );
				
				}
			}
			catch( e:Error )
			{
				
			}
		}
		
	}
}