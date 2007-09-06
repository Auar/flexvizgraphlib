// ActionScript file

		import mx.collections.ArrayCollection;
			
		import mx.controls.Alert;
		import flash.data.SQLConnection;
		import flash.data.SQLResult;
		import flash.data.SQLStatement;
		import flash.filesystem.File;
		import mx.events.FlexEvent;
		import mx.managers.CursorManager;
		import flash.events.SQLEvent;
		import mx.formatters.DateFormatter;
		
		private var _dbFile:File;
		private var _conn:SQLConnection;
		
		// Container for SQL result statements
		[Bindable]
		public var myData:ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public var nodesAC:ArrayCollection = new ArrayCollection();
		[Bindable]
		public var edgesAC:ArrayCollection = new ArrayCollection();
		
		// DPs for Nodes and Edges
  		[Bindable]
		public var dpNodes:Array;
		[Bindable]
		public var dpEdges:Array;
		[Bindable]
		public var dpEdgeView:Array;
		[Bindable]
		public var dpLinkedNodes:Array;
		[Bindable]
		public var dpLookupAssociation:Array;
		// DPs for SubDomains and SubDomain Children
		
		[Bindable]
		public var rootNode:XML = <Graph />;
		
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
			
			// null out these commands, since they're not needed anymore
			// _openDatabaseCmd = null;
			
			CursorManager.removeBusyCursor();
			trace("Connected to " + _dbFile.name);
			getXMLNodes();
			
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
					
					for each (var item in nodesAC)
					{
						rootNode.appendChild(<Node id={item.NodeID} name={item.NodeName} description={item.NodeDescription}
								nodeType={item.NodeType} labelA={item.NodeLabelA} dataA={item.NodeDataA} labelB={item.NodeLabelB} dataB={item.NodeDataB} 
								axisLabelA={item.NodeAxisLabelA} axisDataA={item.NodeAxisDataA} axisLabelB={item.NodeAxisLabelB} axisDataB={item.NodeAxisDataB}
								date={item.NodeDate} />);
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
					
					for each (var item in edgesAC)
					{
						rootNode.appendChild(<Edge fromID={item.EdgeSource} toID={item.EdgeTarget} associationType={item.AssociationType} associationDescription={item.AssociationDescription} />);
						// trace(rootNode);
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
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		//Node.NodeDate = formatDate(Node.NodeDate);
		selectStmt.text = "INSERT INTO xnodes (NodeName, NodeDescription, NodeType, NodeLabelA, NodeDataA, NodeLabelB, NodeDataB, NodeAxisLabelA, NodeAxisDataA, NodeAxisLabelB, NodeAxisDataB, NodeDate)  values('"+Node.NodeName+"','"+Node.NodeDescription+"','"+Node.NodeType+"','"+Node.NodeLabelA+"','"+Node.NodeDataA+"','"+Node.NodeLabelB+"','"+Node.NodeDataB+"','"+Node.NodeAxisLabelA+"','"+Node.NodeAxisDataA+"','"+Node.NodeAxisLabelB+"','"+Node.NodeAxisDataB+"','"+Node.NodeDate+"')";
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
		selectStmt.text = "UPDATE xnodes SET NodeID='"+Node.NodeID+"', NodeName='"+Node.NodeName+"', NodeDescription='"+Node.NodeDescription+"', NodeType='"+Node.NodeType+"',NodeLabelA='"+Node.NodeLabelA+"', NodeDataA='"+Node.NodeDataA+"', NodeLabelB='"+Node.NodeLabelB+"', NodeDataB='"+Node.NodeDataB+"',NodeAxisLabelA='"+Node.NodeAxisLabelA+"', NodeAxisDataA='"+Node.NodeAxisDataA+"', NodeAxisLabelB='"+Node.NodeAxisLabelB+"', NodeAxisDataB='"+Node.NodeAxisDataB+"', NodeDate='"+Node.NodeDate+"' WHERE NodeID='"+Node.NodeID+"'";
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
		selectStmt.text = "SELECT xedges.AssociationType, edgeTargetName.NodeName AS TargetName, edgeSourceName.NodeName AS SourceName, xedges.EdgeSource, xedges.EdgeTarget FROM xedges INNER JOIN xnodes edgeSourceName ON (xedges.EdgeSource=edgeSourceName.NodeID) INNER JOIN xnodes edgeTargetName ON (xedges.EdgeTarget=edgeTargetName.NodeID) WHERE EdgeSource='"+Node.NodeID+"'";
		
		
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpLinkedNodes = result.data;
				if (result.complete) {
					filterEdges.source = dpLinkedNodes;
					filterEdges.refresh();
					tbMain.selectedIndex=2;
					edgeControl.selectedIndex = 0; // Keep focus on first panel of Accordion
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
		selectStmt.text = "SELECT xedges.AssociationType, xedges.AssociationDescription, edgeTargetName.NodeName AS TargetName, edgeSourceName.NodeName AS SourceName, xedges.EdgeSource, xedges.EdgeTarget FROM xedges INNER JOIN xnodes edgeSourceName ON (xedges.EdgeSource=edgeSourceName.NodeID) INNER JOIN xnodes edgeTargetName ON (xedges.EdgeTarget=edgeTargetName.NodeID)";
		
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
		selectStmt.text = "INSERT INTO xedges (EdgeSource, EdgeTarget, AssociationType, AssociationDescription) values ('"+Edge.EdgeSource+"','"+Edge.EdgeTarget+"','"+Edge.AssociationType+"','"+Edge.AssociationDescription+"')";
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
		selectStmt.text = "UPDATE xedges SET EdgeSource='"+Edge.EdgeSource+"', EdgeTarget='"+Edge.EdgeTarget+"', AssociationType='"+Edge.AssociationType+"', AssociationDescription='"+Edge.AssociationDescription+"' WHERE EdgeSource='"+Edge.EdgeSource+"'";
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

	public function lookupAssociation():void
	{
		// create the SQL statement
		var selectStmt:SQLStatement = new SQLStatement();
		selectStmt.sqlConnection = _conn;
		selectStmt.text = "SELECT DISTINCT AssociationType FROM xedges";
		
		// register listeners for the result and error events
		selectStmt.addEventListener(SQLEvent.RESULT, 
			function (event:SQLEvent):void
			{
				var result:SQLResult = selectStmt.getResult();
				dpLookupAssociation = result.data;
			});
		selectStmt.addEventListener(SQLErrorEvent.ERROR, selectError);
		// execute the statement
		selectStmt.execute();
	}


		