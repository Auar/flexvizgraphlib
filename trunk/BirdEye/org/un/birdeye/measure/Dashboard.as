// ActionScript file

// Dashboard Pod
    import mx.events.FlexEvent;
    
    import org.un.birdeye.measure.events.LayoutChangeEvent;
    import org.un.birdeye.measure.managers.PodLayoutManager;
    import org.un.birdeye.measure.managers.StateManager;
    import org.un.birdeye.measure.view.Pod;
    import mx.events.IndexChangedEvent;


	private var podHash:Object = new Object();
	// Array of PodLayoutManagers
	private var podLayoutManagers:Array = new Array();
	// Pod has been created so update the respective PodLayoutManager.
	private var manager:PodLayoutManager = new PodLayoutManager();
	
	private function createPodManager():void
			{
					// Create a manager for the p1 canvas.
					
					manager.container = p1;
					manager.id = "view0";
					// manager.addEventListener(LayoutChangeEvent.UPDATE, StateManager.setPodLayout);
					podLayoutManagers.push(manager);
					
					
			}
	
	private function addPod(pod:Pod, podIndex:Number, podID:String):void{
		
		var viewId:String = manager.id;
		var podId:String = podID;
		
		
		manager.addItemAt(pod,podIndex,false);
		pod.addEventListener(IndexChangedEvent.CHANGE, onChangePodView);
		pod.addEventListener(FlexEvent.UPDATE_COMPLETE, onCreationCompletePod);
		podHash[pod] = manager;
		
		
	}
	
	
	private function onCreationCompletePod(e:FlexEvent):void
			{
				e.currentTarget.removeEventListener(FlexEvent.UPDATE_COMPLETE, onCreationCompletePod);
				var manager:PodLayoutManager = PodLayoutManager(podHash[e.currentTarget]);
				manager.removeNullItems();
				manager.updateLayout(false);
			}
			
	private function onChangePodView(e:IndexChangedEvent):void
			{
				var pod:Pod = Pod(e.currentTarget);
				var viewId:String = PodLayoutManager(podHash[pod]).id;
				StateManager.setPodViewIndex(viewId, pod.id, e.newIndex);
			}
	