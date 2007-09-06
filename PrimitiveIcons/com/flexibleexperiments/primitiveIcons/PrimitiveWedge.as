package com.flexibleexperiments.primitiveIcons
{
	import mx.core.UIComponent;
	import com.flexibleexperiments.primitiveIcons.DrawUtils; 
	import com.flexibleexperiments.primitiveIcons.BasePrimitive;
	
			
	public class PrimitiveWedge extends BasePrimitive
	{
		public function PrimitiveWedge():void
		{
			super();
		}		
		
		[Bindable]
		[Inspectable]
		private var _radius:Number=50;
		public function set radius(value:Number):void
		{
			_radius = value;
			
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get radius():Number
		{
			return _radius;
		}
		
		[Bindable]
		[Inspectable]
		private var _yRadius:Number=0;
		public function set yRadius(value:Number):void
		{
			_yRadius = value;
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get yRadius():Number
		{
			return _yRadius;
		}
		
		[Bindable]
		[Inspectable]
		private var _startAngle:Number = 90;
		public function set startAngle(value:Number):void
		{
			_startAngle = value;
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get startAngle():Number
		{
			return _startAngle;
		}
		
		[Bindable]
		[Inspectable]
		private var _arc:Number = 90;
		public function set arc(value:Number):void
		{
			_arc = value;
			invalidateProperties();
	        invalidateDisplayList();
		}
		public function get arc():Number
		{
			return _arc;
		}
					
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
		{
												
			super.updateDisplayList(unscaledWidth,unscaledHeight);
							
			//use the smallest of the width and height to do the 
			//size so we can use as much space as possible
			radius = Math.min(unscaledHeight/2, unscaledWidth/2);
			
			if (yRadius==0)
			{
				yRadius = radius;
			}
			
			DrawUtils.wedge(this,unscaledWidth/2,unscaledHeight/2,startAngle,arc,radius,yRadius);
				
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