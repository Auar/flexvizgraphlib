package com.flexibleexperiments.primitiveIcons
{
	import mx.core.UIComponent;
	import com.flexibleexperiments.primitiveIcons.DrawUtils; 
	import com.flexibleexperiments.primitiveIcons.BasePrimitive;
			
	public class PrimitiveReverseBurst extends BasePrimitive
	{
		public function PrimitiveReverseBurst():void
		{
			super();
		}		
		
		[Bindable]
		[Inspectable]
		private var _outerRadius:Number=50;
		public function set outerRadius(value:Number):void
		{
			_outerRadius = value;
			
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get outerRadius():Number
		{
			return _outerRadius;
		}
		
		[Bindable]
		[Inspectable]
		private var _innerRadius:Number=25;
		public function set innerRadius(value:Number):void
		{
			_innerRadius = value;
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get innerRadius():Number
		{
			return _innerRadius;
		}
					
		[Bindable]
		[Inspectable]
		private var _points:Number=5;
		public function set points(value:Number):void
		{
			_points = value;
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get points():Number
		{
			return _points;
		}
		
		[Bindable]
		[Inspectable]
		private var _angle:Number = 90;
		public function set angle(value:Number):void
		{
			_angle = value;
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get angle():Number
		{
			return _angle;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
		{
												
			super.updateDisplayList(unscaledWidth,unscaledHeight);
									
			//get the ratio of the difference for the inner and outer radius
			var ratio:Number= innerRadius/outerRadius; 	
			
			//use the smallest of the width and height to do the 
			//size so we can use as much space as possible
			var maxSize:Number = Math.min(unscaledHeight, unscaledWidth);
			DrawUtils.burst(this,unscaledWidth/2,unscaledHeight/2,points,(maxSize/2),(maxSize/2)/ratio,angle);	
				
		}
		
	}
		
}
/*
Copyright 2005-2006 Adobe Systems Inc., Adobe Consulting, and Peter Baird with
thanks to Ryan Hicks.  

This work is licensed under a Creative Commons License.  You may freely 
duplicate, distribute, display and alter this application for both 
commercial and non-commercial uses, but you must include this attribution, 
as well as the links to Adobe Systems and Adobe Consulting in the footer 
of the application.

For more information contact pbaird@adobe.com.

******************************************************************************
Extended to support primitive objects by Jason Hawryluk 03/2007
Flexible Experiments http://flexibleexperiments.wordpress.com

All contents provided by Jason Hawryluk fall under the same creative commons 
license as stated above.
******************************************************************************
*/