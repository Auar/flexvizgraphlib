/*
* Base class for pod content.
*/

package org.un.birdeye.measure.view
{
import flash.xml.XMLNode;
import mx.containers.VBox;
import mx.controls.Alert;
import mx.events.FlexEvent;
import mx.rpc.events.FaultEvent;
import mx.rpc.events.ResultEvent;
import mx.rpc.http.HTTPService;
import mx.utils.ObjectProxy;
import mx.events.IndexChangedEvent;

public class PodContentBase extends VBox
{
	function PodContentBase()
	{
		super();
		percentWidth = 100;
		percentHeight = 100;
		
		
	}
	
	
	
}
}