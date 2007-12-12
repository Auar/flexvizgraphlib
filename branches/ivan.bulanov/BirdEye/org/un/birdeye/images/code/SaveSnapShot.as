// ActionScript file

// Pop-up Window
			
    import flash.events.*;
    import mx.managers.PopUpManager;
    import mx.controls.Button;
    import mx.core.IFlexDisplayObject;
	import mx.core.UIComponent;
	import mx.controls.Alert; 
	import mx.controls.TextInput;
	import mx.utils.ObjectUtil; 
	import mx.controls.Alert;
	import mx.containers.TitleWindow;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	import org.un.birdeye.ui.*;
	import mx.containers.HBox;
	import mx.containers.ApplicationControlBar;
	import mx.core.SoundAsset;
	import mx.events.CloseEvent;
	import mx.controls.Image;
	
	[Embed(source="org/un/birdeye/images/assets/shutter.mp3")]
	private var SnapshotSound:Class;
            
    // The variable for the TitleWindow container
    public var myTitleWindow:TitleWindow = new TitleWindow();
	public var targetImage:Image = new Image();
	public var txtFileName:TextInput = new TextInput();
    // Method to instantiate and display a TitleWindow container.
    // This is the initial Button control's click event handler.
    public function openWindow(event:MouseEvent):void {
        // Set the TitleWindow container properties.
         var bd : BitmapData = getBitmapData( UIComponent( tbMain ) );
			targetImage.source = new Bitmap( bd );
    
        myTitleWindow = new TitleWindow();
        myTitleWindow.title = "Snapshot";
        myTitleWindow.showCloseButton = true;
        myTitleWindow.width= 200;
        myTitleWindow.height= 200;
        
        // Call the method to add the Button control to the 
        // TitleWindow container.
        populateWindow();
        // Use the PopUpManager to display the TitleWindow container.
        PopUpManager.addPopUp(myTitleWindow, this, false);
        PopUpManager.centerPopUp(myTitleWindow);
    }

    // The method to create and add the Button child control to the
    // TitleWindow container.
    public function populateWindow():void {
        var tip:Image = new Image();
        var btn1:Button = new Button();
        var btn2:Button = new Button();
        var label:Label = new Label();
        var vBox:VBox = new VBox();
        
        tip.source="org/un/birdeye/images/ui/idea.png";
        tip.toolTip=toolTip="Type file name (e.g. chart.jpg) and click save.  Files are saved on desktop as jpg.";
        btn1.label="Cancel";
        btn1.addEventListener(MouseEvent.CLICK, closeTitleWindow);
        btn2.label="Save";
        btn2.toolTip = "Saves jpg image to desktop";
        
        label.text="Filename: ";
        btn2.addEventListener(MouseEvent.CLICK, onSave);
        vBox.addChild(tip);
        vBox.addChild(label);
        vBox.addChild(txtFileName);
        vBox.addChild(btn2);
        vBox.addChild(btn1);
        myTitleWindow.addChild(vBox);
        // myTitleWindow.addChild(targetImage);
        myTitleWindow.addEventListener(CloseEvent.CLOSE, closeTitleWindow);
         
    }
    // The method to close the TitleWindow container.
    public function closeTitleWindow(event:Event):void {
        PopUpManager.removePopUp(myTitleWindow);
    }
	
	/* Called when the user wants to save the file */
	private function onSave(event:Event):void
	{
		var bd : BitmapData = getBitmapData( UIComponent( tbMain ) );
			targetImage.source = new Bitmap( bd );
			
		
		var image:ByteArray;
		var fileName:String = txtFileName.text;
		
		// Create JPG encoder with 100% quality
		var imgEncoder:JPGEncoder = new JPGEncoder(100); 
		image = imgEncoder.encode(bd);
		
        // Get a reference to the desktop
        var desktop:File = File.desktopDirectory;
        
        // Create a reference to the file on the desktop in which we will save html
        var saveFile:File = desktop.resolve(fileName);
        
		// In case file exist; append version number (i)
        var name:String = fileName.substr(0,fileName.length-4);
		var ext:String = fileName.substr(fileName.length-4,4);
        var i:uint = 1;
			while(saveFile.exists) {
				fileName = name+"("+i.toString()+")"+ext;
				saveFile = File.desktopDirectory.resolve(fileName);
				i++;
			}
        
        //create a FileStream instance to write to the file
        var fs:FileStream = new FileStream();
        
        //open file in WRITE mode
        fs.open(saveFile, FileMode.WRITE);
        
        //write the string to the file
        fs.writeBytes(image, 0, image.length);
        
        //close the file / file stream
        fs.close();
        
        var snapshotSoundAsset:SoundAsset = new SnapshotSound() as SoundAsset;
		var snapshotSoundChannel:SoundChannel = new SoundChannel();
		snapshotSoundChannel = snapshotSoundAsset.play();		
		snapshotSoundChannel.addEventListener(Event.SOUND_COMPLETE, closeTitleWindow);
	}
	
   private function getBitmapData( target : UIComponent ) : BitmapData
   {
    var bd : BitmapData = new BitmapData( target.width, target.height );
    var m : Matrix = new Matrix();
    bd.draw( target, m );
    
    
    return bd;
   }
