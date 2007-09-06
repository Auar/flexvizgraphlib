/* 
 * The MIT License
 *
 * Copyright (c) 2007 The SixDegrees Project Team
 * (Jason Bellone, Juan Rodriguez, Segolene de Basquiat, Daniel Lang).
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
package org.un.flex.unComponentToolbox.icons {
	import mx.core.ClassFactory;
	
	/**
	 * This class contains all embedded icons as public
	 * static classes as some form of image library, but
	 * as they are embedded they do not need to be bundled
	 * separately.
	 * */
	public class EmbeddedIcons {
		
	 	[Embed(source="images/activity.png")]
	 	static public var activityNode:Class;
		
	 	[Embed(source="images/visualization.png")]
	 	static public var sixDegreeNode:Class;
		
	 	[Embed(source="images/policy.png")]
	 	static public var policyNode:Class;

	 	[Embed(source="images/plan.png")]
	 	static public var planNode:Class;

	 	[Embed(source="images/m.png")]
	 	static public var maleNode:Class;
		
	 	[Embed(source="images/f.png")]
	 	static public var femaleNode:Class;
	 	
	 	[Embed(source="images/RightButton.png")]
	 	static public var rightButton:Class;
	 	
	 	[Embed(source="images/LeftButton.png")]
	 	static public var leftButton:Class;
	 	
	 	[Embed(source="images/refresh.png")]
	 	static public var refreshIcon:Class;
	 	
	 	[Embed(source="images/auditsm.png")]
	 	static public var auditIcon:Class;
	 	
	 	[Embed(source="images/budgetsm.png")]
	 	static public var budgetIcon:Class;
	 	
	 	[Embed(source="images/valitsm.png")]
	 	static public var valitIcon:Class;
	 	
	 	[Embed(source="images/environment.png")]
	 	static public var environmentIcon:Class;
	 	
	 	[Embed(source="images/sox.png")]
	 	static public var soxIcon:Class;
	 	
	 	[Embed(source="images/sixsigma.png")]
	 	static public var sixsigmaIcon:Class;
	 	
	}
}