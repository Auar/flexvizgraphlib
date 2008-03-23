package org.un.cava.birdeye.components.renderers {
	

	import mx.controls.Image;
	import mx.core.UIComponent;
	
	import org.un.cava.birdeye.assets.icons.EmbeddedIcons;
	import org.un.cava.birdeye.assets.icons.primitives.Circle;
	import org.un.cava.birdeye.assets.icons.primitives.Rectangle;
	
	/**
	 * This class provides infrastructure to create an image
	 * to be used as icon in a renderer
	 * */
	public class RendererIconFactory {
	
		/**
		 * This method generates an icon based on the
		 * type and returns it as an UIComponent.
		 * 
		 * The type format is as follows: prefix::string
		 * The prefix can be any of
		 * <ul>
		 * 	<li>embed - The icon string is looked up a list of embedded icons</li>
		 *  <li>primitive - The icon string is searched in a list of primitive geometric icons</li>
		 *  <li>url - The icon string is interpreted as URL and directly passed to the source param of an Image object</li>
		 * </ul>
		 * @param type The type of the icon.
		 * @param size The size of the icon (as a square)
		 * @param color The color of the icon (if a primitive)
		 * @returns The icon as UIComponent
		 * */
		public static function createIcon(type:String, size:int, color:int = 0):UIComponent {
			
			var icon:UIComponent;
			var pattern:RegExp;
			var result:Array;
			var prefix:String;
			var suffix:String;
		
			/* create pattern to match the prefix
			 * in the pattern we name the matching group
			 * before the :: 'prefix' and the one after 'suffix'
			 * for easy assignment. See ASDocs about RegExp
			 * for details how this works (or perl regexp, etc.)
			 */
			pattern = /^(?P<prefix>[^:]+)::(?P<suffix>.*)$/;
			
			/* now assign the results */
			result = pattern.exec(type);
			prefix = result.prefix;
			suffix = result.suffix;
			
			/* now switch depending on the prefix to how to handle
			 * the generation */
			switch(prefix) {
				case "embed":
					icon = EmbeddedIcons.generateImage(suffix,size);
					break;
				case "primitive":
					icon = getPrimitiveIcon(suffix,size,color);
					break;
				case "url":
					icon = getUrlbasedIcon(suffix,size);
					break;
				default:
					trace("Unknown icon prefix:"+prefix+" ,defaulting to URL based");
					icon = getUrlbasedIcon(suffix,size);
					break;
			}
			return icon;
		}
		
		/**
		 * This generates a UIComponent with a primitive geometric
		 * object. Right now this uses very basic code, however,
		 * the Degrafa library would also offer this kind of stuff,
		 * so we need to investigate how we could make use of that.
		 * */
		public static function getPrimitiveIcon(name:String, size:int, color:int):UIComponent {
		
			var img:UIComponent;
			
			switch(name) {
		    	case "rectangle":
					img = new Rectangle();
					img.setStyle("color", color);
					img.width=size;
					img.height=size;
					break;
				case "circle":
					img = new Circle();
					img.setStyle("color", color);
					img.width=size;
					img.height=size;
					break;
				default:
			        // trace("Out of range");
			        trace("unsupported primitive shape: "+name);
			        img.setStyle("color", color);
			        break;
			}
			return img;
		}
		
		/**
		 * returns an image object with the source set
		 * to the url provided.
		 * */
		public static function getUrlbasedIcon(url:String,size:int):Image {
			var img:Image = new Image();
			img.height = size;
			img.width = size;
			img.source = url;
			return img;
		}
		
		/**
		 * just for the sake of the uniformity of the
		 * interface, we also provide a method to get an embedded icon,
		 * however this is directly passed to EmbeddedIcons.
		 * */
		public static function getEmbeddedIcon(name:String,size:int):Image {
			return EmbeddedIcons.generateImage(name,size);
		}
	}
}

