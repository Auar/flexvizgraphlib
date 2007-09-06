// ActionScript file
import org.un.birdeye.images.EmbeddedIcons;
			
		
		
		public function onInit():void
   		{
   			// dbInit();

			// Set filter function       
			// Be careful to set filterFunction       
			// only after ArrayCollection has been       
			// populated. 
			
			getNodes();
			getEdges();
			getEdgeView();
			lookupAssociation();
			
			setFilterFunction();
		}
  		
  		public function setFilterFunction():void {
  		
  			filterNodes.filterFunction=processNodesFilter;
			filterEdges.filterFunction=processEdgesFilter;
			dgNodeRequest.dataProvider=filterNodes;
  			
  		}
  		
  		// Nodes
		public function detailNode(selectedNode:Object):void {
			selectedNode.NodeID=dgNodeRequest.selectedItem.NodeID;
			getLinkedNodes(selectedNode);
		}
	
		 public function submitNode():void {
			var Node:Object = new Object();
			//Node.NodeID=nodeModule.NodeID.text;
			Node.NodeName=nodeModule.NodeName.text;
			Node.NodeDescription=nodeModule.NodeDesc.text;
			Node.NodeType=nodeModule.NodeType.text;
			
			Node.NodeLabelA=nodeModule.NodeLabelA.text;
			Node.NodeDataA=nodeModule.NodeDataA.text;
			Node.NodeLabelB=nodeModule.NodeLabelB.text;
			Node.NodeDataB=nodeModule.NodeDataB.text;
			Node.NodeAxisLabelA=nodeModule.NodeAxisLabelA.text;
			Node.NodeAxisDataA=nodeModule.NodeAxisDataA.text;
			Node.NodeAxisLabelB=nodeModule.NodeAxisLabelB.text;
			Node.NodeAxisDataB=nodeModule.NodeAxisDataB.text;
			Node.NodeDate=nodeModule.selectedDate.text;
			
			createNode(Node);
			nodeControl.selectedIndex = 0;
			
		} 
		
		public function editNode():void {
			var Node:Object = new Object();
			Node.NodeID=nodeModule.selectedNodeID.text;
			Node.NodeName=nodeModule.selectedNodeName.text;
			Node.NodeDescription=nodeModule.selectedNodeDesc.text;
			Node.NodeType=nodeModule.selectedNodeType.text;
			
			Node.NodeLabelA=nodeModule.selectedNodeLabelA.text;
			Node.NodeDataA=nodeModule.selectedNodeDataA.text;
			Node.NodeLabelB=nodeModule.selectedNodeLabelB.text;
			Node.NodeDataB=nodeModule.selectedNodeDataB.text;
			Node.NodeAxisLabelA=nodeModule.selectedNodeAxisLabelA.text;
			Node.NodeAxisDataA=nodeModule.selectedNodeAxisDataA.text;
			Node.NodeAxisLabelB=nodeModule.selectedNodeAxisLabelB.text;
			Node.NodeAxisDataB=nodeModule.selectedNodeAxisDataB.text;
			Node.NodeDate=nodeModule.selectedNodeDate.text;
			
			updateNode(Node);
			nodeControl.selectedIndex = 0;
			
		}

		public function delNode():void {
			var Node:Object = new Object();
			Node.NodeID=nodeModule.selectedNodeID.text;
			Node.NodeName=nodeModule.selectedNodeName.text;
			Node.NodeDescription=nodeModule.selectedNodeDesc.text;
			Node.NodeType=nodeModule.selectedNodeType.text;
			
			Node.NodeLabelA=nodeModule.selectedNodeLabelA.text;
			Node.NodeDataA=nodeModule.selectedNodeDataA.text;
			Node.NodeLabelB=nodeModule.selectedNodeLabelB.text;
			Node.NodeDataB=nodeModule.selectedNodeDataB.text;
			Node.NodeAxisLabelA=nodeModule.selectedNodeAxisLabelA.text;
			Node.NodeAxisDataA=nodeModule.selectedNodeAxisDataA.text;
			Node.NodeAxisLabelB=nodeModule.selectedNodeAxisLabelB.text;
			Node.NodeAxisDataB=nodeModule.selectedNodeAxisDataB.text;
			Node.NodeDate=nodeModule.selectedNodeDate.text;
			
			deleteNode(Node);
			nodeControl.selectedIndex = 0;
			
		}
		
		public function addNode(e:Event):void
		{
			nodeControl.selectedIndex = 1;
			nodeModule.nodevs.selectedIndex = 2;
		}

// Edges
		public function detailEdge(selectedEdge:Object):void {
			selectedEdge.EdgeSource=dgEdgeRequest.selectedItem.EdgeSource;
	
		}

		public function submitEdge():void {
			var Edge:Object = new Object();
			Edge.EdgeSource=edgeModule.EdgeSource.selectedItem.NodeID;
			Edge.EdgeTarget=edgeModule.EdgeTarget.selectedItem.NodeID;
			Edge.AssociationType=edgeModule.AssociationType.selectedItem.AssociationType;
			Edge.AssociationDescription=edgeModule.AssociationDescription.text;
			
 			createEdge(Edge); 
 			getEdges();
			edgeControl.selectedIndex = 0;
			//detailEdge(Edge);
		}
		
		public function editEdge():void {
			var Edge:Object = new Object();
 			Edge.EdgeSource=edgeModule.selectedEdgeSource.text;
			Edge.EdgeTarget=edgeModule.selectedEdgeTarget.text
			Edge.AssociationType=edgeModule.selectedAssociationType.text;
			Edge.AssociationDescription=edgeModule.selectedAssociationDescription.text;
			
			updateEdge(Edge);
			edgeControl.selectedIndex = 0;
			detailEdge(Edge);
		}

		public function delEdge():void {
			var Edge:Object = new Object();
 			Edge.EdgeSource=edgeModule.selectedEdgeSource.text; 
			Edge.EdgeTarget=edgeModule.selectedEdgeTarget.text;
			Edge.AssociationType=edgeModule.selectedAssociationType.text;
			Edge.AssociationDescription=edgeModule.selectedAssociationDescription.text;
			
			deleteEdge(Edge);
			edgeControl.selectedIndex = 0;
			detailEdge(Edge);
		}
		
		public function addEdge(e:Event):void {
			edgeControl.selectedIndex = 1;
			edgeModule.edgevs.selectedIndex = 2;
		}
			
		// Filter functions

 		// Nodes Filter Function 
    	public function processNodesFilter(item:Object):Boolean {
       	var result:Boolean=false;
 
        // If no filter text, or a match, then true 
       	if (( !item.NodeName.length || item.NodeName.toUpperCase().indexOf(NodeNameFilter.text.toUpperCase()) >= 0) 
       	 && ( !item.NodeDescription.length || item.NodeDescription.toUpperCase().indexOf(NodeDescFilter.text.toUpperCase()) >= 0)) result=true;

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