package com.flexibleexperiments.primitiveIcons
{
	import mx.core.UIComponent;
	import com.flexibleexperiments.primitiveIcons.DrawUtils; 
	import com.flexibleexperiments.primitiveIcons.BasePrimitive;

	public class PrimitiveCircle extends BasePrimitive
	{
		public function PrimitiveCircle():void
		{
			super();
		}		
		
		override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void
		{
												
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			DrawUtils.circle(this,unscaledWidth/2,unscaledHeight/2,unscaledHeight/2);
				
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