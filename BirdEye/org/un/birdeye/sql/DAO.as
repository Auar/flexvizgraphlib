// ActionScript file

/*

Table and Field Definitions

Table: xnodes
Fields:

NodeID
NodeName
NodeDec
NodeType

Table: xedges
Fields:

EdgeID
EdgeSource
EdgeTarget
EdgeType
EdgeDesc
EdgeFlow

Table: nodemetas
Fields:

NodeMetaID
NodeFieldLabel
NodeFieldType
NodeFieldData
NodeMetaLink
NodeID

Table: nodetypelookups
Fields:

NodeTypeID
NodeTypeName
NodeTypeImage
NodeTypeColor

Table: edgetypelookups
Fields:

EdgeTypeID
EdgeTypeName

*/

		import flash.data.SQLConnection;
		import flash.data.SQLResult;
		import flash.data.SQLStatement;
		import flash.events.SQLEvent;
		import flash.filesystem.File;
		
		import mx.collections.ArrayCollection;
		import mx.controls.Alert;
		import mx.managers.CursorManager;
		
		private var _dbFile:File;
		private var _conn:SQLConnection;
		
		// Container for SQL result statements
		[Bindable]
		/*public var myData:ArrayCollection = new ArrayCollection(); JR*/ 
		[Bindable]
		public var nodesAC:ArrayCollection = new ArrayCollection();
		[Bindable]
		public var edgesAC:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var filterNodeMeta:ArrayCollection = new ArrayCollection();
		
		// DPs for CRUD
  		[Bindable]
		public var dpNodeMeta:Array;
		[Bindable]
		public var dpNodeType:Array;
		[Bindable]
		public var dpNodes:Array;
		[Bindable]
		public var dpEdges:Array;
		[Bindable]
		public var dpEdgeView:Array;
		[Bindable]
		public var dpLinkedNodes:Array;
		[Bindable]
		public var dpNodeMetaRecords:Array;
		// Lookups
		[Bindable]
		public var dpLookupEdgeTypes:Array;
		[Bindable]
		public var dpLookupNodeTypes:Array;
		
		[Bindable]
		public var rootNode:XML = <Graph />;
		//JR
				public var rootData:XML = <Data />;
		//		
		public function dbInit():void
		{
			
			_dbFile = new File("app-resource:/db/birdeye.db");
			_conn = new SQLConnection();
			_conn.addEventListener(Event.OPEN, openDatabaseComplete);
			_conn.addEventListener(SQLErrorEvent.ERROR, openDatabaseError);
			_conn.open(_dbFile);
			
			CursorManager.setBusyCursor();	
			trace("Connecting...");
		}
		
		// ------- Data event handling -------
		// --- Create/open database command ---
		
		private function openDatabaseComplete(event:Event):void
		{
			var target:EventDispatcher = event.target as EventDispatcher;
			target.removeEventListener(Event.COMPLETE, openDatabaseComplete);
			target.removeEventListener(SQLErrorEvent.ERROR, openDatabaseError);
			
			CursorManager.removeBusyCursor();
			trace("Connected to " + _dbFile.name);
			//JR
			getXMLData();
			//
			getXMLNodes();
			getNodes();
			getEdges();
			getEdgeView();
			getNodeMetas(),
			lookupNodeTypes(),
			lookupEdgeTypes();
		 	}
		
		private function openDatabaseError(event:SQLErrorEvent):void
		{
			var target:EventDispatcher = event.target as EventDispatcher;
			target.removeEventListener(Event.COMPLETE, openDatabaseComplete);
			target.removeEventListener(SQLErrorEvent.ERROR, openDatabaseError);
			
			Alert.show(event.error.message, "Error creating/opening database");
		}
		
		private function selectError(event:SQLErrorEvent):void
		{
			trace("Error code:", event.error.code);
			trace("Details:", event.error.message);
		}
		
		// To create GraphML Format dp
	//JR
		public function getXMLData():void
		{
			// create the SQL statement
			var selectStmt:SQLStatement = new SQLStatement();
			selectStmt.sqlConnection = _conn;
			//JR
			//selectStmt.text = "SELECT * FROM xnodes";
		 	/*SelectStmt.text = "SELECT xnodes.NodeID, nodemetas.NodeMetaID, nodemetas.MetaFieldLabel,nodemetas.MetaFieldData, nodemetas.MetaFieldType, nodemetas.NodeMetaLink, " +   
					"nodemetas1.NodeMetaID, nodemetas1.MetaFieldLabel,nodemetas1.MetaFieldData, nodemetas1.MetaFieldType" + 
					"FROM xnodes JOIN nodemetas ON (xnodes.NodeID=nodemetas.NodeID)" +
					"INNER JOIN nodemetas nodemetas1 ON (nodemetas.NodeMetaLink=nodemetas1.NodeMetaID)"+
					"AND (nodemetas.NodeID=nodemetas1.NodeID)";*/
			selectStmt.text = "SELECT xnodes.NodeID, xnodes.NodeName, xnodes.NodeType, nodemetas.NodeMetaID, nodemetas.MetaFieldLabel,nodemetas.MetaFieldData, nodemetas.MetaFieldType, nodemetas.NodeMetaLink, " +   
					"nodemetas1.MetaFieldLabel as MetaFieldLabel_1,nodemetas1.MetaFieldData as MetaFieldData_1, nodemetas1.MetaFieldType as MetaFieldType_1 " + 
					"FROM xnodes JOIN nodemetas ON (xnodes.NodeID=nodemetas.NodeID) " +
					"INNER JOIN nodemetas nodemetas1 ON (nodemetas.NodeMetaLink=nodemetas1.NodeMetaID) AND (nodemetas.NodeID=nodemetas1.NodeID) ";
					
			//trace(selectStmt.text);
			
  
			// register listeners for the result and error events
			selectStmt.addEventListener(SQLEvent.RESULT, 
				function (event:SQLEvent):void
				{
					var result:SQLResult = selectStmt.getResult();		
					nodesAC.source = result.data;
					
					
					var nodesACLength:int=nodesAC.length;
					var i:int = 0;
					while (i < nodesACLength)
					{
						var s:XML = <value />;
						s.@nodeId = nodesAC.getItemAt(i).NodeID;
						// JB - we need NodeName and NodeType
							s.@nodeName = nodesAC.getItemAt(i).NodeName;
							s.@nodeType = nodesAC.getItemAt(i).NodeType; 
						var NodeMetaLink:int = nodesAC.getItemAt(i).NodeMetaLink;
						while (i < nodesACLength  && NodeMetaLink == nodesAC.getItemAt(i).NodeMetaLink )
						{ 
							s.@[nodesAC.getItemAt(i).MetaFieldLabel] = nodesAC.getItemAt(i).MetaFieldData ;
							trace(s);
							i++;
						}
						//s = s + " />"
						rootData.appendChild(s);
						trace(rootData)
					}
					
					/*for each (var item:* in nodesAC)
					{
						rootData.appendChild(<value nodeId={item.NodeID} nodeMetaId={item.NodeMetaID} {item.MetaFieldLabel}={item.MetaFieldData} 
						/>);
						trace(rootData);
					}*/ 
				});
				
			selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
			// execute the statement
			selectStmt.execute();
			parentDocument.gDataXML = rootData;
		}
//
		public function getXMLNodes():void
		{
			// create the SQL statement
			var selectStmt:SQLStatement = new SQLStatement();
			selectStmt.sqlConnection = _conn;
			selectStmt.text = "SELECT * FROM xnodes";
			
			// register listeners for the result and error events
			selectStmt.addEventListener(SQLEvent.RESULT, 
				function (event:SQLEvent):void
				{
					var result:SQLResult = selectStmt.getResult();		
					nodesAC.source = result.data;
					
					for each (var item:* in nodesAC)
					{
						rootNode.appendChild(<Node id={item.NodeID} name={item.NodeName} description={item.NodeDesc}
								nodeType={item.NodeType} />);
						//trace(rootNode);
					} 
				});
			selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
			// execute the statement
			selectStmt.execute();
			getXMLEdges();
		}
		
		public function getXMLEdges():void
		{
			// create the SQL statement
			var selectStmt:SQLStatement = new SQLStatement();
			selectStmt.sqlConnection = _conn;
			selectStmt.text = "SELECT * FROM xedges";
			
			// register listeners for the result and error events
			selectStmt.addEventListener(SQLEvent.RESULT, 
				function (event:SQLEvent):void
				{
					var result:SQLResult = selectStmt.getResult();
					edgesAC.source = result.data;
					
					for each (var item:* in edgesAC)
					{
						rootNode.appendChild(<Edge fromID={item.EdgeSource} toID={item.EdgeTarget} edgeType={item.EdgeType} edgeDesc={item.EdgeDesc} flow="4" />);
						//trace(rootNode);					
					}
				});
			selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
			// execute the statement
			selectStmt.execute();
			}
		
	// Nodes
 	public function getNodes():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT * FROM xnodes";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpNodes = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
		
	}
	
	public function createNode(Node:Object):void
	{
		// Table: xnodes
		// Fields:
		// NodeID
		// NodeName
		// NodeDesc
		// NodeType
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		//Node.NodeDate = formatDate(Node.NodeDate);
		selectStmt.text = "INSERT INTO xnodes (NodeName, NodeDesc, NodeType)  values('"+Node.NodeName+"','"+Node.NodeDesc+"','"+Node.NodeType+"')";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodes();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
	public function updateNode(Node:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "UPDATE xnodes SET NodeID='"+Node.NodeID+"', NodeName='"+Node.NodeName+"', NodeDesc='"+Node.NodeDesc+"', NodeType='"+Node.NodeType+"' WHERE NodeID='"+Node.NodeID+"'";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodes();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
	public function deleteNode(Node:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "DELETE FROM xnodes WHERE NodeID='"+Node.NodeID+"'";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodes();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
	
	public function getLinkedNodes(Node:Object):void 
	{
 		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT xedges.EdgeType, edgeTargetName.NodeName AS TargetName, edgeSourceName.NodeName AS SourceName, xedges.EdgeSource, xedges.EdgeTarget FROM xedges INNER JOIN xnodes edgeSourceName ON (xedges.EdgeSource=edgeSourceName.NodeID) INNER JOIN xnodes edgeTargetName ON (xedges.EdgeTarget=edgeTargetName.NodeID) WHERE EdgeSource='"+Node.NodeID+"'";
		
		
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpLinkedNodes = result.data;
				if (result.complete) {
					parentDocument.filterEdges.source = dpLinkedNodes;
					parentDocument.filterEdges.refresh();
					parentDocument.tbMain.selectedIndex=1; // Move to Edge Canvas
					parentDocument.edgeControl.selectedIndex = 0; // Keep focus on first panel of Accordion
				}
			});
		selectStmt.execute();
	}
	
	public function getNodeMetaData(Node:Object):void 
	{
 		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT * FROM nodemetas WHERE NodeID='"+Node.NodeID+"'";
		
		
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpNodeMetaRecords = result.data;
				if (result.complete) {
					parentDocument.filterNodeMeta.source = dpNodeMetaRecords;
					parentDocument.filterNodeMeta.refresh();
					
				}
			});
		selectStmt.execute();
	}
	
// Edges	
	public function getEdges():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT * FROM xedges";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpEdges = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
	}
	
	public function getEdgeView():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT xedges.EdgeType, xedges.EdgeDesc, edgeTargetName.NodeName AS TargetName, edgeSourceName.NodeName AS SourceName, xedges.EdgeSource, xedges.EdgeTarget FROM xedges INNER JOIN xnodes edgeSourceName ON (xedges.EdgeSource=edgeSourceName.NodeID) INNER JOIN xnodes edgeTargetName ON (xedges.EdgeTarget=edgeTargetName.NodeID)";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpEdgeView = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
		
	}
	
	public function createEdge(Edge:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "INSERT INTO xedges (EdgeSource, EdgeTarget, EdgeType, EdgeDesc) values ('"+Edge.EdgeSource+"','"+Edge.EdgeTarget+"','"+Edge.EdgeType+"','"+Edge.EdgeDesc+"')";
		trace(selectStmt.text);
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getEdgeView();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
	public function updateEdge(Edge:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "UPDATE xedges SET EdgeSource='"+Edge.EdgeSource+"', EdgeTarget='"+Edge.EdgeTarget+"', EdgeType='"+Edge.EdgeType+"', EdgeDesc='"+Edge.EdgeDesc+"' WHERE EdgeSource='"+Edge.EdgeSource+"'";
		trace(selectStmt.text);
		selectStmt.addEventListener(SQLEvent.RESULT,
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getEdgeView();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
	public function deleteEdge(Edge:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "DELETE FROM xedges WHERE EdgeSource='"+Edge.EdgeSource+"' AND EdgeTarget='"+Edge.EdgeTarget+"'";
		selectStmt.addEventListener(SQLEvent.RESULT,
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getEdgeView();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
// NodeMetas
 	public function getNodeMetas():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT * FROM nodemetas";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpNodeMeta = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
		
	}
	
	public function createNodeMeta(NodeMeta:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		//Node.NodeDate = formatDate(Node.NodeDate);
		selectStmt.text = "INSERT INTO nodemetas (NodeMetaName, NodeNodelDesc, NMNodeNameLabel, NMNodeDescLabel, NMNodeTypeLabel, NMValALabel, NMValBLabel, NMNodeBlobObjectLabel, NMNodeDateLabel)  values('"+NodeMeta.NodeMetaName+"','"+NodeMeta.NodeMetaDesc+"','"+NodeMeta.NodeType+"','"+NodeMeta.NodeLabelA+"','"+NodeMeta.NodeDataA+"','"+NodeMeta.NodeLabelB+"','"+NodeMeta.NodeDataB+"','"+NodeMeta.NodeAxisLabelA+"','"+NodeMeta.NodeAxisDataA+"','"+NodeMeta.NodeAxisLabelB+"','"+NodeMeta.NodeAxisDataB+"','"+NodeMeta.NodeDate+"')";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodeMetas();
			    }
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		selectStmt.execute();
	}
	
	public function updateNodeMeta(NodeMeta:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "UPDATE xnodes SET NodeID='"+NodeMeta.NodeID+"', NodeName='"+NodeMeta.NodeName+"', NodeDescription='"+NodeMeta.NodeDescription+"', NodeType='"+NodeMeta.NodeType+"',NodeLabelA='"+NodeMeta.NodeLabelA+"', NodeDataA='"+NodeMeta.NodeDataA+"', NodeLabelB='"+NodeMeta.NodeLabelB+"', NodeDataB='"+NodeMeta.NodeDataB+"',NodeAxisLabelA='"+NodeMeta.NodeAxisLabelA+"', NodeAxisDataA='"+NodeMeta.NodeAxisDataA+"', NodeAxisLabelB='"+NodeMeta.NodeAxisLabelB+"', NodeAxisDataB='"+NodeMeta.NodeAxisDataB+"', NodeDate='"+NodeMeta.NodeDate+"' WHERE NodeID='"+NodeMeta.NodeID+"'";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodes();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
	public function deleteNodeMeta(NodeMeta:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "DELETE FROM nodemetas WHERE NodeMetaID='"+NodeMeta.NodeMetaID+"'";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodes();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}

// NodeTypes
 	public function getNodeTypes():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT * FROM nodetypelookups";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpNodeType = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
		
	}
	
	public function createNodeType(NodeType:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		//Node.NodeDate = formatDate(Node.NodeDate);
		selectStmt.text = "INSERT INTO nodetypelookups (NodeTypeName, NodeTypeImage, NodeTypeColor)  values ('"+NodeType.NodeTypeName+"','"+NodeType.NodeTypeImage+"','"+NodeType.NodeTypeColor+"')";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodeTypes();
			    }
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		selectStmt.execute();
	}
	
	public function updateNodeType(NodeType:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "UPDATE xnodes SET NodeID='"+NodeType.NodeID+"', NodeName='"+NodeType.NodeName+"', NodeDescription='"+NodeType.NodeDescription+"', NodeType='"+NodeType.NodeType+"',NodeLabelA='"+NodeType.NodeLabelA+"', NodeDataA='"+NodeType.NodeDataA+"', NodeLabelB='"+NodeType.NodeLabelB+"', NodeDataB='"+NodeType.NodeDataB+"',NodeAxisLabelA='"+NodeType.NodeAxisLabelA+"', NodeAxisDataA='"+NodeType.NodeAxisDataA+"', NodeAxisLabelB='"+NodeType.NodeAxisLabelB+"', NodeAxisDataB='"+NodeType.NodeAxisDataB+"', NodeDate='"+NodeType.NodeDate+"' WHERE NodeID='"+NodeType.NodeID+"'";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodes();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}
	
	public function deleteNodeType(NodeType:Object):void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "DELETE FROM nodetypelookups WHERE NodeTypeID='"+NodeType.NodeTypeID+"'";
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				if (_conn.totalChanges >= 1)
			    {
			    	getNodes();
			    	getXMLNodes();
			    }
			});
		selectStmt.execute();
	}

// Lookups

	public function lookupNodeTypes():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT * FROM nodetypelookups";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpLookupNodeTypes = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
	}
	
	public function lookupEdgeTypes():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT * FROM edgetypelookups";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpLookupEdgeTypes = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
	}
	
