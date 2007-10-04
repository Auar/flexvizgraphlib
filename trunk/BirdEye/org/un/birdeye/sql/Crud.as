// ActionScript file
import org.un.birdeye.images.EmbeddedIcons;
		
  		// Filter functions
  		
  		public function onInit():void {
  			filterNodeMeta.source = dpNodeMeta;
  			callLater(setFilterFunction);
  		}
  		
  		public function setFilterFunction():void {
  			
  			filterNodes.filterFunction=processNodesFilter;
			filterEdges.filterFunction=processEdgesFilter;
			filterNodeMeta.filterFunction=processNodeMetaFilter;
			filterNodeType.filterFunction=processNodeTypeFilter;
			filterEdgeType.filterFunction=processEdgeTypeFilter;
 		}
  		
 		// Nodes Filter Function 
    	public function processNodesFilter(item:Object):Boolean {
       	var result:Boolean=false;
 
        // If no filter text, or a match, then true 
       	if (( !item.NodeName.length || item.NodeName.toUpperCase().indexOf(NodeNameFilter.text.toUpperCase()) >= 0) 
       	 && ( !item.NodeDesc.length || item.NodeDesc.toUpperCase().indexOf(NodeDescFilter.text.toUpperCase()) >= 0)) result=true;

		return result;
	    }

		// Edges Filter Function
    	public function processEdgesFilter(item:Object):Boolean {
       	var result:Boolean=false;
 
        // If no filter text, or a match, then true 
        if (( !item.SourceName.length || item.SourceName.toUpperCase().indexOf(EdgeSourceFilter.text.toUpperCase()) >= 0) 
       	 && ( !item.TargetName.length || item.TargetName.toUpperCase().indexOf(EdgeTargetFilter.text.toUpperCase()) >= 0)) result=true;
            
		return result;
		}
		
		// Nodes Filter Function 
    	public function processNodeMetaFilter(item:Object):Boolean {
       	var result:Boolean=false;
 
        // If no filter text, or a match, then true 
       	if (( !item.MetaFieldLabel.length || item.MetaFieldLabel.toUpperCase().indexOf(MetaFieldLabelFilter.text.toUpperCase()) >= 0) 
       	 && ( !item.MetaFieldData.length || item.MetaFieldData.toUpperCase().indexOf(MetaFieldDataFilter.text.toUpperCase()) >= 0)) result=true;

		return result;
	    }
	    
	    // Node Types Filter Function
	    public function processNodeTypeFilter(item:Object):Boolean {
       	var result:Boolean=false;
 
        // If no filter text, or a match, then true 
       	if ( !item.NodeTypeName.length || item.NodeTypeName.toUpperCase().indexOf(NodeTypeNameFilter.text.toUpperCase()) >= 0) result=true;

		return result;
	    }
	    
	    // Edge Types Filter Function
	    public function processEdgeTypeFilter(item:Object):Boolean {
       	var result:Boolean=false;
 
        // If no filter text, or a match, then true 
       	if ( !item.EdgeTypeName.length || item.EdgeTypeName.toUpperCase().indexOf(EdgeTypeNameFilter.text.toUpperCase()) >= 0) result=true;

		return result;
	    }
	    
	    
  		
  		// CRUD Section
  		// Nodes
		public function getChildNodes(selectedNode:Object):void {
			selectedNode.NodeID=dgNodeRequest.selectedItem.NodeID;
			getLinkedNodes(selectedNode);
		}
		
		public function getNodeMeta(selectedNode:Object):void {
			selectedNode.NodeID=dgNodeRequest.selectedItem.NodeID;
			getNodeMetaData(selectedNode);
		}
	
		 public function submitNode():void {
			var Node:Object = new Object();
			//Node.NodeID=nodeModule.NodeID.text;
			Node.NodeName=nodeModule.NodeName.text;
			Node.NodeDesc=nodeModule.NodeDesc.text;
			Node.NodeType=nodeModule.NodeType.text;
			
			createNode(Node);
			nodeControl.selectedIndex = 0;
			
		} 
		
		public function editNode():void {
			var Node:Object = new Object();
			//Node.NodeID=nodeModule.NodeID.text;
			Node.NodeName=nodeModule.NodeName.text;
			Node.NodeDesc=nodeModule.NodeDesc.text;
			Node.NodeType=nodeModule.NodeType.text;
			
			updateNode(Node);
			nodeControl.selectedIndex = 0;
			
		}

		public function delNode():void {
			var Node:Object = new Object();
			//Node.NodeID=nodeModule.NodeID.text;
			Node.NodeName=nodeModule.NodeName.text;
			Node.NodeDesc=nodeModule.NodeDesc.text;
			Node.NodeType=nodeModule.NodeType.text;
			
			deleteNode(Node);
			nodeControl.selectedIndex = 0;
			
		}
		
		public function addNode(e:Event):void
		{
			nodeControl.selectedIndex = 1;
			nodeModule.nodevs.selectedIndex = 0;
		}

// Edges
		public function detailEdge(selectedEdge:Object):void {
			selectedEdge.EdgeSource=dgEdgeRequest.selectedItem.EdgeSource;
	
		}

		public function submitEdge():void {
			var Edge:Object = new Object();
			Edge.EdgeSource=edgeModule.EdgeSource.text;
			Edge.EdgeTarget=edgeModule.EdgeTarget.text
			Edge.EdgeType=edgeModule.EdgeType.text;
			Edge.EdgeDesc=edgeModule.EdgeDesc.text;
			
 			createEdge(Edge); 
 			getEdges();
			edgeControl.selectedIndex = 0;
			detailEdge(Edge);
		}
		
		public function editEdge():void {
			var Edge:Object = new Object();
 			Edge.EdgeSource=edgeModule.EdgeSource.text;
			Edge.EdgeTarget=edgeModule.EdgeTarget.text
			Edge.EdgeType=edgeModule.EdgeType.text;
			Edge.EdgeDesc=edgeModule.EdgeDesc.text;
	
			updateEdge(Edge);
			edgeControl.selectedIndex = 0;
			detailEdge(Edge);
		}

		public function delEdge():void {
			var Edge:Object = new Object();
 			Edge.EdgeSource=edgeModule.EdgeSource.text; 
			Edge.EdgeTarget=edgeModule.EdgeTarget.text;
			Edge.EdgeType=edgeModule.EdgeType.text;
			Edge.EdgeDesc=edgeModule.EdgeDesc.text;
			
			deleteEdge(Edge);
			edgeControl.selectedIndex = 0;
			detailEdge(Edge);
		}
		
		public function addEdge(e:Event):void {
			edgeControl.selectedIndex = 1;
			edgeModule.edgevs.selectedIndex = 2;
		}
		
		
		// Node Meta CRUD
		
		public function submitNodeMeta():void {
			var NodeMeta:Object = new Object();
			//NodeMeta.NodeID=nodeMetaModule.NodeMetaID.text;
			NodeMeta.MetaFieldLabel=nodeMetaModule.MetaFieldLabel.text;
			NodeMeta.MetaFieldType=nodeMetaModule.MetaFieldType.text;
			NodeMeta.MetaFieldData=nodeMetaModule.MetaFieldData.text;
			NodeMeta.NodeID=nodeMetaModule.NodeID.text;
						
			createNodeMeta(NodeMeta);
			nodeMetaControl.selectedIndex = 0;
			
		} 
		
		public function editNodeMeta():void {
			var NodeMeta:Object = new Object();
			//NodeMeta.NodeID=nodeMetaModule.NodeMetaID.text;
			NodeMeta.MetaFieldLabel=nodeMetaModule.MetaFieldLabel.text;
			NodeMeta.MetaFieldType=nodeMetaModule.MetaFieldType.text;
			NodeMeta.MetaFieldData=nodeMetaModule.MetaFieldData.text;
			NodeMeta.NodeID=nodeMetaModule.NodeID.text;
			
			updateNode(NodeMeta);
			nodeControl.selectedIndex = 0;
			
		}

		public function delNodeMeta():void {
			var NodeMeta:Object = new Object();
			//NodeMeta.NodeID=nodeMetaModule.NodeMetaID.text;
			NodeMeta.MetaFieldLabel=nodeMetaModule.MetaFieldLabel.text;
			NodeMeta.MetaFieldType=nodeMetaModule.MetaFieldType.text;
			NodeMeta.MetaFieldData=nodeMetaModule.MetaFieldData.text;
			NodeMeta.NodeID=nodeMetaModule.NodeID.text;
			
			deleteNodeMeta(NodeMeta);
			nodeMetaControl.selectedIndex = 0;
			
		}
		
		public function addNodeMeta(e:Event):void
		{
			nodeMetaControl.selectedIndex = 1;
			nodeMetaModule.nodemetavs.selectedIndex = 0;
		}
			
		