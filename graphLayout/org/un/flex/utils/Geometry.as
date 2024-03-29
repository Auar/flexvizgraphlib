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
package org.un.flex.utils {
	import flash.geom.Point;
	
	/**
	 * This is a class to provide some static functions
	 * to help with angles and geometry.
	 * */
	public class Geometry {
		
		/**
		 * Calculate the polar Angle of a Point.
		 * @param p The Point to which the Angle is needed.
		 * @return The polar angle in radians. The range is from 0 to 2 * PI. Returns 0 for the origin.
		 * */
		public static function polarAngle(p:Point):Number {
			
			/* the length is 0 if the node is the origin
			 * in this case the angle makes no sense and would
			 * be returned as NaN, so we return 0 in this case */
			if(p.length == 0) {
				return 0;
			} else {
				return normaliseAngle(Math.atan2(p.y, p.x));
			}
		}
		
		/**
		 * Calculate the polar Angle of a Point in degrees.
		 * @param p The Point to which the Angle is needed.
		 * @return The polar angle in degrees. The range is from 0 to 360. Returns 0 for the origin.
		 * */
		public static function polarAngleDeg(p:Point):Number {
			
			/* the length is 0 if the node is the origin
			 * in this case the angle makes no sense and would
			 * be returned as NaN, so we return 0 in this case */
			if(p.length == 0) {
				return 0;
			} else {
				return rad2deg(normaliseAngle(Math.atan2(p.y, p.x)));
			}
		}
		
		/**
		 * Calculate the polar radius for a given point. This just calles
		 * the length method of the Point object, which is the same. It is
		 * part of this class for consistency.
		 * @param p The point to receive the polar radius from.
		 * @return The polar radius.
		 * @see Point#length
		 * */
		public static function polarRadius(p:Point):Number {
			return p.length;
		}
		
		/**
		 * Calculate cartesian coordinates from polar coordinates,
		 * again this uses the polar method from the Point class,
		 * here for completeness.
		 * @param r The polar radius.
		 * @param a The polar angle in radians.
		 * @return A Point object with the cartesian coordinates.
		 * @see Point#polar()
		 * */
		public static function cartFromPolar(r:Number, a:Number):Point {
			return Point.polar(r,a);
		}
		
		/**
		 * Calculate cartesian coordinates from polar coordinates,
		 * again this uses the polar method from the Point class,
		 * here for completeness.
		 * @param r The polar radius.
		 * @param a The polar angle in degrees.
		 * @return A Point object with the cartesian coordinates.
		 * @see Point#polar()
		 * */
		public static function cartFromPolarDeg(r:Number, a:Number):Point {
			return Point.polar(r,deg2rad(a));
		}
		
		
		/**
		 * Normalizes angles to be within the range of 0 to 2*PI
		 * by adding or subtracting 2 * PI until the angle is within
		 * the range.
		 * @param a The angle to normalise in radians.
		 * @return The normalized angle.
		 * */
		public static function normaliseAngle(a:Number):Number {
			
			while(a >= (2 * Math.PI)) {
				a -= (2 * Math.PI);
			}
			while(a < 0) {
				a += (2 * Math.PI);
			}
			return a;
		}
		
		/**
		 * Normalizes angles to be within the range of 0 to 360
		 * by adding or subtracting 360 until the angle is within
		 * the range.
		 * @param a The angle to normalise in degrees.
		 * @return The normalized angle.
		 * */
		public static function normaliseAngleDeg(a:Number):Number {
			
			while(a >= 360) {
				a -= 360;
			}
			while(a < 0) {
				a += 360;
			}
			return a;
		}
		
		
		/**
		 * Turns an angle given in radians into degrees
		 * @param a The angle given in radians.
		 * @return The angle in degrees.
		 * */
		public static function rad2deg(a:Number):Number {
			return (a * 180 / Math.PI);

		}
		
		/**
		 * Turns an angle given in degrees into radians.
		 * @param a The angle given in degrees.
		 * @return The angle in radians.
		 * */
		public static function deg2rad(a:Number):Number {
			return (a * Math.PI / 180);
		}
		
		/**
		 * Returns sine hyperbolic function:
		 * <code>sinh(x) = 0.5*(e^x-e^(-x))</code>.
		 * @param x
		 * @return
		 */
    public static function sinh(x:Number):Number {
    	var expX:Number = Math.exp(x);
			return 0.5 * (expX - 1/expX);
    }
		
		/**
		 * Returns cosine hyperbolic function:
		 * <code>cosh(x) = 0.5*(e^x+e^(-x))</code>.
		 * @param x
		 * @return
		 */
    public static function cosh(x:Number):Number {
    	var expX:Number = Math.exp(x);
			return 0.5 * (expX + 1/expX);
    }
		
		/**
		 * Returns inverse of the sine hyperbolic function:
		 * <code>arsinh(x) = ln(x+sqrt(x^2+1))</code>.
		 * @param x
		 * @return
		 */
    public static function arsinh(x:Number):Number {
			return Math.log(x + Math.sqrt(x * x + 1));
    }
		
		/**
	   * Returns inverse of the sine hyperbolic function:
		 * <code>arcosh(x) = ln(x+sqrt(x^2-1))</code>.
		 * @param x
		 * @return
		 */
    public static function arcosh(x:Number):Number {
		  return Math.log(x + Math.sqrt(x * x - 1));
    }
	}
}