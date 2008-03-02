package org.un.cava.birdeye.assets {
	
	import mx.core.ClassFactory;
	
	public class EmbeddedIcons {
		
		// UI
		
		[Bindable]
		[Embed(source="ui/refresh.png")]
	 	static public var refreshIcon:Class;
	 	
	 	[Bindable]
		[Embed(source="ui/search.png")]
	 	static public var searchIcon:Class;
	 	
	 	[Bindable]
		[Embed(source="ui/zoomin.png")]
	 	static public var zoominIcon:Class;
	 	
	 	[Bindable]
		[Embed(source="ui/zoomout.png")]
	 	static public var zoomoutIcon:Class;
	 	
	 	// Nodes
	 	
	 	[Bindable]
		[Embed(source="nodes/Earth.png")]
	 	static public var earthIcon:Class;
	 	
	 	[Bindable]
		[Embed(source="nodes/Tree.png")]
	 	static public var treeIcon:Class;
	 	
	 	[Bindable]
		[Embed(source="nodes/Leaf.png")]
	 	static public var leafIcon:Class;
	 	 	
	 	
	 	// Edges
	 	
	 	[Bindable]
		[Embed(source="edges/Rain.png")]
	 	static public var rainIcon:Class;
	 	
	 	[Bindable]
		[Embed(source="edges/Sun.png")]
	 	static public var sunIcon:Class;
	 	
	 	
	}
}