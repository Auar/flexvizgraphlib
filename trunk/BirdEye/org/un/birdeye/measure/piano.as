
import flexlib.controls.HSlider;
import flexlib.skins.SliderThumbHighlightSkin;

private function addSeries(event:Event):void{
		accordionIndex=leftAccordion.selectedIndex+1
		numberOfSerie[accordionIndex]=numberOfSerie[accordionIndex]+1;
		cnvs=Canvas(leftAccordion.getChildByName("piano"+accordionIndex))
		var strChart:String=ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbChartType")).selectedLabel.toString()
		if (myChart.chart.(@Type==strChart).Properties.Property.(@name=="barTypes").length() !=0){
	    	ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbDisplay")).alpha=1;
	    	ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbDisplay")).setStyle("color", 0x000000);
			Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblDisplay")).setStyle("color", 0x000000);
		}
		var myColor:uint = Math.round( Math.random()*0xFFFFFF );
		var sep:HRule=new HRule();
    		var lblSerieNum:Label=new Label();
    		var colPicker:ColorPicker=new ColorPicker();
    		var cbxAxis:ComboBox=new ComboBox();
    		var cbyAxis:ComboBox=new ComboBox();
    		var chkRemove:CheckBox=new CheckBox();
    		var cbRadius:ComboBox=new ComboBox();
    		var cbOpen:ComboBox=new ComboBox();
    		var cbClose:ComboBox=new ComboBox();
    		var cbCartSerie:ComboBox=new ComboBox();
    		var cbCartForm:ComboBox=new ComboBox();
    		
		if(strChart=="Area" || strChart=="Bar" || strChart=="Column" || strChart=="Line" || strChart=="Plot" || strChart=="Area3D" || strChart=="Bar3D" || strChart=="Column3D" || strChart=="Line3D"){
		
    		sep.id="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.name="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y;
    		sep.x=13;sep.width=210;
    		cnvs.addChild(sep);
    		
    		lblSerieNum.id="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.name="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.text= "Serie " + numberOfSerie[accordionIndex] + " :";
    		lblSerieNum.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		lblSerieNum.x=3;
    		cnvs.addChild(lblSerieNum);
    		
    		colPicker.id="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.name="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		colPicker.x=60;
    		colPicker.width=17;
    		colPicker.height=17;
    		colPicker.selectedColor=myColor;//0x6699CC;
    		colPicker.addEventListener(Event.CHANGE, refreshChartEvent);
    		cnvs.addChild(colPicker);
    		
    		
    		cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbyAxis.dataProvider=arrAxis;
    		cbyAxis.prompt="Select...";
    		cbyAxis.x=85;
    		cbyAxis.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+8;
    		cnvs.addChild(cbyAxis);
    		chkRemove.id="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.name="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.x=200;
    		chkRemove.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+9;
    		chkRemove.addEventListener(MouseEvent.CLICK, removeSeriesEvent);
    		cnvs.addChild(chkRemove);
		
    		Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y+38);
				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+38);
		
		}else if(strChart=="Bubble" || strChart=="Radar"){
				sep.id="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.name="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y;
    		sep.x=13;sep.width=210;
    		cnvs.addChild(sep);
    		
    		lblSerieNum.id="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.name="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.text= "Serie " + numberOfSerie[accordionIndex] + " :";
    		lblSerieNum.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		lblSerieNum.x=3;
    		cnvs.addChild(lblSerieNum);
    		
    		colPicker.id="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.name="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		colPicker.x=60;
    		colPicker.width=17;
    		colPicker.height=17;
    		colPicker.selectedColor=myColor;//0x6699CC;
    		colPicker.addEventListener(Event.CHANGE, refreshChartEvent);
    		cnvs.addChild(colPicker);
    		
    		cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbyAxis.dataProvider=arrAxis;
    		cbyAxis.prompt="Select...";
    		cbyAxis.x=85;
    		cbyAxis.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+8;
    		cnvs.addChild(cbyAxis);
				
				cbRadius.id="cnvs"+accordionIndex+"_cbRadius"+numberOfSerie[accordionIndex];
    		cbRadius.name="cnvs"+accordionIndex+"_cbRadius"+numberOfSerie[accordionIndex];
    		cbRadius.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbRadius.dataProvider=arrAxis;
    		cbRadius.prompt="Radius...";
				if(strChart=="Radar"){
						if(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadarSerie1")).selectedLabel.toString()=="Bubble"){
								cbRadius.alpha=1;
								cbRadius.setStyle("color", 0x000000);
						}else{
								cbRadius.alpha=0.3;
								cbRadius.setStyle("color", 0xCCCCCC);
						}
				}
    		cbRadius.x=85;
    		cbRadius.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+38;
    		cnvs.addChild(cbRadius);
				
				chkRemove.id="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.name="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.x=200;
    		chkRemove.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+9;
    		chkRemove.addEventListener(MouseEvent.CLICK, removeSeriesEvent);
    		cnvs.addChild(chkRemove);
				
				Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y+68);
				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+68);
		}else if(strChart=="Candlestick" || strChart=="HighLowOpenClose" ){
		sep.id="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.name="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y;
    		sep.x=13;sep.width=210;
    		cnvs.addChild(sep);
    		
    		lblSerieNum.id="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.name="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.text= "Serie " + numberOfSerie[accordionIndex] + " :";
    		lblSerieNum.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		lblSerieNum.x=3;
    		cnvs.addChild(lblSerieNum);
    		
    		colPicker.id="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.name="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		colPicker.x=60;
    		colPicker.width=17;
    		colPicker.height=17;
    		colPicker.selectedColor=myColor;//0x6699CC;
    		colPicker.addEventListener(Event.CHANGE, refreshChartEvent);
    		cnvs.addChild(colPicker);
    		
    		cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbyAxis.dataProvider=arrAxis;
    		cbyAxis.prompt="Low Field...";
    		cbyAxis.x=85;
    		cbyAxis.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+8;
    		cnvs.addChild(cbyAxis);
				
		cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis"+numberOfSerie[accordionIndex];
    		cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis"+numberOfSerie[accordionIndex];
    		cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbxAxis.dataProvider=arrAxis;
    		cbxAxis.prompt="High Field...";
    		cbxAxis.x=85;
    		cbxAxis.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+38;
    		cnvs.addChild(cbxAxis);
				
		cbOpen.id="cnvs"+accordionIndex+"_cbOpenField"+numberOfSerie[accordionIndex];
    		cbOpen.name="cnvs"+accordionIndex+"_cbOpenField"+numberOfSerie[accordionIndex];
    		cbOpen.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbOpen.dataProvider=arrAxis;
    		cbOpen.prompt="Open Field...";
    		cbOpen.x=85;
    		cbOpen.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+68;
    		cnvs.addChild(cbOpen);
    		
    		cbClose.id="cnvs"+accordionIndex+"_cbCloseField"+numberOfSerie[accordionIndex];
    		cbClose.name="cnvs"+accordionIndex+"_cbCloseField"+numberOfSerie[accordionIndex];
    		cbClose.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbClose.dataProvider=arrAxis;
    		cbClose.prompt="Close Field...";
    		cbClose.x=85;
    		cbClose.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+98;
    		cnvs.addChild(cbClose);
				
		chkRemove.id="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.name="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.x=200;
    		chkRemove.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+9;
    		chkRemove.addEventListener(MouseEvent.CLICK, removeSeriesEvent);
    		cnvs.addChild(chkRemove);
				
				Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y+128);
				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+128);
		}else if(strChart=="Pie" || strChart=="Pie3D" ){
		sep.id="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.name="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y;
    		sep.x=13;sep.width=210;
    		cnvs.addChild(sep);
    		
    		lblSerieNum.id="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.name="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.text= "Serie " + numberOfSerie[accordionIndex] + " :";
    		lblSerieNum.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		lblSerieNum.x=3;
    		cnvs.addChild(lblSerieNum);
    		
    		cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbyAxis.dataProvider=arrAxis;
    		cbyAxis.prompt="Select...";
    		cbyAxis.x=85;
    		cbyAxis.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+8;
    		cnvs.addChild(cbyAxis);
				
		chkRemove.id="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.name="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.x=200;
    		chkRemove.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+9;
    		chkRemove.addEventListener(MouseEvent.CLICK, removeSeriesEvent);
    		cnvs.addChild(chkRemove);
				
				Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y+38);
				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+38);
		
		}else if(strChart=="Cartesian"){
		sep.id="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.name="cnvs"+accordionIndex+"_sep"+numberOfSerie[accordionIndex];
    		sep.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y;
    		sep.x=13;sep.width=210;
    		cnvs.addChild(sep);
    		
    		lblSerieNum.id="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.name="cnvs"+accordionIndex+"_lblSerieNum"+numberOfSerie[accordionIndex];
    		lblSerieNum.text= "Serie " + numberOfSerie[accordionIndex] + " :";
    		lblSerieNum.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		lblSerieNum.x=3;
    		cnvs.addChild(lblSerieNum);
    		
    		colPicker.id="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.name="cnvs"+accordionIndex+"_cp"+numberOfSerie[accordionIndex];
    		colPicker.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+10;
    		colPicker.x=60;
    		colPicker.width=17;
    		colPicker.height=17;
    		colPicker.selectedColor=myColor;//0x6699CC;
    		colPicker.addEventListener(Event.CHANGE, refreshChartEvent);
    		cnvs.addChild(colPicker);
    		
		cbCartSerie.id="cnvs"+accordionIndex+"_cbCartSerie"+numberOfSerie[accordionIndex];
    		cbCartSerie.name="cnvs"+accordionIndex+"_cbCartSerie"+numberOfSerie[accordionIndex];
    		cbCartSerie.addEventListener(Event.CHANGE, refreshCartChartEvent);
    		cbCartSerie.dataProvider=myChart.chart.(@Type=="Cartesian").Properties.Property.Series.Serie;
    		cbCartSerie.prompt="Select...";
    		cbCartSerie.x=85;
    		cbCartSerie.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+8;
    		cnvs.addChild(cbCartSerie);
				
    		cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis"+numberOfSerie[accordionIndex];
    		cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbyAxis.dataProvider=arrAxis;
    		cbyAxis.prompt="Low Field...";
    		cbyAxis.x=85;
    		cbyAxis.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+38;
    		cnvs.addChild(cbyAxis);
				
		cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis"+numberOfSerie[accordionIndex];
    		cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis"+numberOfSerie[accordionIndex];
    		cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbxAxis.dataProvider=arrAxis;
    		cbxAxis.prompt="High Field...";
				cbxAxis.alpha=0.3;
				cbxAxis.setStyle("color", 0xCCCCCC);
    		cbxAxis.x=85;
    		cbxAxis.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+68;
    		cnvs.addChild(cbxAxis);
				
		cbOpen.id="cnvs"+accordionIndex+"_cbOpenField"+numberOfSerie[accordionIndex];
    		cbOpen.name="cnvs"+accordionIndex+"_cbOpenField"+numberOfSerie[accordionIndex];
    		cbOpen.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbOpen.dataProvider=arrAxis;
    		cbOpen.prompt="Open Field...";
				cbOpen.alpha=0.3;
				cbOpen.setStyle("color", 0xCCCCCC);
    		cbOpen.x=85;
    		cbOpen.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+98;
    		cnvs.addChild(cbOpen);
    		
    		cbClose.id="cnvs"+accordionIndex+"_cbCloseField"+numberOfSerie[accordionIndex];
    		cbClose.name="cnvs"+accordionIndex+"_cbCloseField"+numberOfSerie[accordionIndex];
    		cbClose.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbClose.dataProvider=arrAxis;
    		cbClose.prompt="Close Field...";
				cbClose.alpha=0.3;
				cbClose.setStyle("color", 0xCCCCCC);
    		cbClose.x=85;
    		cbClose.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+128;
    		cnvs.addChild(cbClose);
				
		cbRadius.id="cnvs"+accordionIndex+"_cbRadius"+numberOfSerie[accordionIndex];
    		cbRadius.name="cnvs"+accordionIndex+"_cbRadius"+numberOfSerie[accordionIndex];
    		cbRadius.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbRadius.dataProvider=arrAxis;
    		cbRadius.prompt="Radius...";
				cbRadius.alpha=0.3;
				cbRadius.setStyle("color", 0xCCCCCC);
    		cbRadius.x=85;
    		cbRadius.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+158;
    		cnvs.addChild(cbRadius);
				
		cbCartForm.id="cnvs"+accordionIndex+"_cbCartForm"+numberOfSerie[accordionIndex];
    		cbCartForm.name="cnvs"+accordionIndex+"_cbCartForm"+numberOfSerie[accordionIndex];
    		cbCartForm.addEventListener(Event.CHANGE, refreshChartEvent);
    		cbCartForm.dataProvider=myChart.chart.(@Type=="Cartesian").Properties.Property.cartForms.cartForm;
    		cbCartForm.prompt="Form...";
				cbCartForm.alpha=0.3;
				cbCartForm.setStyle("color", 0xCCCCCC);
    		cbCartForm.x=85;
    		cbCartForm.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+188;
    		cnvs.addChild(cbCartForm);
				
			chkRemove.id="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.name="cnvs"+accordionIndex+"_chkRemove"+numberOfSerie[accordionIndex];
    		chkRemove.x=200;
    		chkRemove.y=HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+9;
    		chkRemove.addEventListener(MouseEvent.CLICK, removeSeriesEvent);
    		cnvs.addChild(chkRemove);
				
				Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y+218);
				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y+218);
		
		}
	}
	
	private function removeSeriesEvent(event:Event):void{
		accordionIndex=leftAccordion.selectedIndex+1
		cnvs=Canvas(leftAccordion.getChildByName("piano"+accordionIndex))
		num=event.target.name.substr(15);
		var strChart:String=ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbChartType")).selectedLabel.toString()
		var i:int
		if(strChart=="Area" || strChart=="Bar" || strChart=="Column" || strChart=="Line" || strChart=="Plot" || strChart=="Area3D" || strChart=="Bar3D" || strChart=="Column3D" || strChart=="Line3D" ){
					cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+num));
      		
      		for (i=1; i<=numberOfSerie[accordionIndex]; i++) { 
      			if (i>num){
      				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).y-38);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).move(Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).x,Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).y-38);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).text="Serie " + (i-1) + " :";
      				ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).move(ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).x,ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).y-38);
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).y-38);
      				CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).move(CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).x,CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).y-38);
      				
      				cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i).name="cnvs"+accordionIndex+"_sep"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i).name="cnvs"+accordionIndex+"_lblSerieNum"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i).name="cnvs"+accordionIndex+"_cp"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i).name="cnvs"+accordionIndex+"_cbyAxis"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i).name="cnvs"+accordionIndex+"_chkRemove"+(i-1);
      			}
      		}
      		Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y-38);
      		HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y-38);
      		
		}else if(strChart=="Bubble" || strChart=="Radar"){
					cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+num));
      		
      		for (i=1; i<=numberOfSerie[accordionIndex]; i++) { 
      			if (i>num){
      				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).y-68);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).move(Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).x,Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).y-68);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).text="Serie " + (i-1) + " :";
      				ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).move(ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).x,ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).y-68);
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).y-68);
      				CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).move(CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).x,CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).y-68);
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i)).y-68);
      				
      				cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i).name="cnvs"+accordionIndex+"_sep"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i).name="cnvs"+accordionIndex+"_lblSerieNum"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i).name="cnvs"+accordionIndex+"_cp"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i).name="cnvs"+accordionIndex+"_cbyAxis"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i).name="cnvs"+accordionIndex+"_chkRemove"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i).name="cnvs"+accordionIndex+"_cbRadius"+(i-1);
      			}
      		}
      		Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y-68);
      		HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y-68);
      		
		}else if(strChart=="Candlestick" || strChart=="HighLowOpenClose" ){
			cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+num));
      		
      		for (i=1; i<=numberOfSerie[accordionIndex]; i++) { 
      			if (i>num){
      				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).y-128);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).move(Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).x,Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).y-128);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).text="Serie " + (i-1) + " :";
      				ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).move(ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).x,ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).y-128);
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).y-128);
      				CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).move(CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).x,CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).y-128);
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i)).y-128);
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i)).y-128);
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i)).y-128);
      				
      				cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i).name="cnvs"+accordionIndex+"_sep"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i).name="cnvs"+accordionIndex+"_lblSerieNum"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i).name="cnvs"+accordionIndex+"_cp"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i).name="cnvs"+accordionIndex+"_cbyAxis"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i).name="cnvs"+accordionIndex+"_chkRemove"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i).name="cnvs"+accordionIndex+"_cbxAxis"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i).name="cnvs"+accordionIndex+"_cbOpenField"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i).name="cnvs"+accordionIndex+"_cbCloseField"+(i-1);
      			}
      		}
      		Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y-128);
      		HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y-128);
      		
		}else if(strChart=="Pie" || strChart=="Pie3D"){
					cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+num));
      		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+num));
      		
      		for (i=1; i<=numberOfSerie[accordionIndex]; i++) { 
      			if (i>num){
      				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).y-38);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).move(Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).x,Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).y-38);
      				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).text="Serie " + (i-1) + " :";
      				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).y-38);
      				CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).move(CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).x,CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).y-38);
      				
      				cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i).name="cnvs"+accordionIndex+"_sep"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i).name="cnvs"+accordionIndex+"_lblSerieNum"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i).name="cnvs"+accordionIndex+"_cbyAxis"+(i-1);
      				cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i).name="cnvs"+accordionIndex+"_chkRemove"+(i-1);
      			}
      		}
      		Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y-38);
      		HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y-38);
      		
		}else if(strChart=="Cartesian"){
		
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+num));
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+num));
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+num));
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+num));
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+num));
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartSerie"+num));
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartForm"+num));
    		cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+num));
				cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+num));
      	cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+num));
      	cnvs.removeChild(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+num));
					
    		for (i=1; i<=numberOfSerie[accordionIndex]; i++) { 
    			if (i>num){
    				HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i)).y-218);
    				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).move(Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).x,Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).y-218);
    				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i)).text="Serie " + (i-1) + " :";
    				ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).move(ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).x,ColorPicker(cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i)).y-218);
    				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i)).y-218);
    				CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).move(CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).x,CheckBox(cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i)).y-218);
    				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartSerie"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartSerie"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartSerie"+i)).y-218);
    				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartForm"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartForm"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartForm"+i)).y-218);
    				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i)).y-218);
      			ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i)).y-218);
      			ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i)).y-218);
      			ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i)).move(ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i)).x,ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i)).y-218);
      				
    				cnvs.getChildByName("cnvs"+accordionIndex+"_sep"+i).name="cnvs"+accordionIndex+"_sep"+(i-1);
    				cnvs.getChildByName("cnvs"+accordionIndex+"_lblSerieNum"+i).name="cnvs"+accordionIndex+"_lblSerieNum"+(i-1);
    				cnvs.getChildByName("cnvs"+accordionIndex+"_cp"+i).name="cnvs"+accordionIndex+"_cp"+(i-1);
    				cnvs.getChildByName("cnvs"+accordionIndex+"_cbyAxis"+i).name="cnvs"+accordionIndex+"_cbyAxis"+(i-1);
    				cnvs.getChildByName("cnvs"+accordionIndex+"_chkRemove"+i).name="cnvs"+accordionIndex+"_chkRemove"+(i-1);
    				cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartSerie"+i).name="cnvs"+accordionIndex+"_cbCartSerie"+(i-1);
    				cnvs.getChildByName("cnvs"+accordionIndex+"_cbCartForm"+i).name="cnvs"+accordionIndex+"_cbCartForm"+(i-1);
						cnvs.getChildByName("cnvs"+accordionIndex+"_cbRadius"+i).name="cnvs"+accordionIndex+"_cbRadius"+(i-1);
						cnvs.getChildByName("cnvs"+accordionIndex+"_cbxAxis"+i).name="cnvs"+accordionIndex+"_cbxAxis"+(i-1);
      			cnvs.getChildByName("cnvs"+accordionIndex+"_cbOpenField"+i).name="cnvs"+accordionIndex+"_cbOpenField"+(i-1);
      			cnvs.getChildByName("cnvs"+accordionIndex+"_cbCloseField"+i).name="cnvs"+accordionIndex+"_cbCloseField"+(i-1);
    			}
    		}
    		Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).move(Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).x,Button(cnvs.getChildByName("cnvs"+accordionIndex+"_btnAddNewSerie")).y-218);
    		HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).move(HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).x,HRule(cnvs.getChildByName("cnvs"+accordionIndex+"_hrEnd")).y-218);
		}
		numberOfSerie[accordionIndex]=numberOfSerie[accordionIndex]-1;
		
		if (myChart.chart.(@Type==ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbChartType")).selectedLabel.toString()).Properties.Property.(@name=="barTypes").length() !=0){
	    	if(numberOfSerie[accordionIndex]==1){
				Label(cnvs.getChildByName("cnvs"+accordionIndex+"_lblDisplay")).setStyle("color", 0xCCCCCC);
				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbDisplay")).setStyle("color", 0xCCCCCC);
				ComboBox(cnvs.getChildByName("cnvs"+accordionIndex+"_cbDisplay")).alpha=0.3;
		
			}
		}
		refreshChart();
	}	
	
    public function changeTypeEvt(event:Event):void {
		accordionIndex=leftAccordion.selectedIndex+1
		cnvs=Canvas(leftAccordion.getChildByName("piano"+accordionIndex))
		var strChartType:String = event.target.selectedLabel.toString()
		var ChartTypeIndex:int=event.target.selectedIndex;
		cnvs.removeAllChildren();
		numberOfSerie[accordionIndex]=1;
		
		var lblChartType:Label=new Label();
		lblChartType.id="cnvs"+accordionIndex+"_lblChartType";
		lblChartType.name="cnvs"+accordionIndex+"_lblChartType";
		lblChartType.x=2;
		lblChartType.y=10;
		lblChartType.text="Chart type :"
		cnvs.addChild(lblChartType);

		var cbChartType:ComboBox=new ComboBox();
		cbChartType.id="cnvs"+accordionIndex+"_cbChartType";
		cbChartType.name="cnvs"+accordionIndex+"_cbChartType";
		cbChartType.dataProvider=myChart.chart.@Type;
		cbChartType.selectedIndex=ChartTypeIndex;
		cbChartType.addEventListener(Event.CHANGE, changeTypeEvt);
		cbChartType.x=73;
		cbChartType.y=8;
		cbChartType.width=160;
		cnvs.addChild(cbChartType);
		
		var lblForm:Label=new Label();
		var cbForm:ComboBox=new ComboBox();
		var lblDisplay:Label=new Label();
		var cbDisplay:ComboBox=new ComboBox();
		var hrChartType:HRule=new HRule();
		var chkDataType:CheckBox=new CheckBox();
		var chkLegend:CheckBox=new CheckBox();
		var chkGrid:CheckBox=new CheckBox();
		var hrSel:HRule=new HRule();
		var lblSerie:Label=new Label();
		var cp:ColorPicker=new ColorPicker();
		var lblxAxis:Label=new Label();
		var cbxAxis:ComboBox=new ComboBox();
		var lblyAxis:Label=new Label();
		var cbyAxis:ComboBox=new ComboBox();
		var lblxAxisType:Label=new Label();
		var cbxAxisType:ComboBox=new ComboBox();
		var lblxInterval1:Label=new Label();
		var txtxInterval:NumericStepper=new NumericStepper();
		var HBoxMinMaxx:HBox=new HBox();
		var lblxMin:Label=new Label();
		var minMaxxSlider:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblxMax:Label=new Label();
		var lblyAxisType:Label=new Label();
		var cbyAxisType:ComboBox=new ComboBox();
		var lblyInterval1:Label=new Label();
		var txtyInterval:NumericStepper=new NumericStepper();
		var HBoxMinMaxy:HBox=new HBox();
		var lblyMin:Label=new Label();
		var minMaxySlider:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblyMax:Label=new Label();
		var hrEnd:HRule=new HRule();
		var btnAddSerie:Button=new Button();
		var lblRadius:Label=new Label();
		var cbRadius:ComboBox=new ComboBox();
		var lblExplode:Label=new Label();
		var PieExplode:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblAngle:Label=new Label();
		var PieAngle:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblDonuts:Label=new Label();
		var PieDonuts:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblLabelPosition:Label=new Label();
		var cbLabelPosition:ComboBox=new ComboBox();
		var lblOpenField:Label=new Label();
		var cbOpenField:ComboBox=new ComboBox();
		var lblCloseField:Label=new Label();
		var cbCloseField:ComboBox=new ComboBox();
		var lblCartForm:Label=new Label();
		var cbCartForm:ComboBox=new ComboBox();
		var cbRadarSerie:ComboBox=new ComboBox();	
		var cbAlgo:ComboBox=new ComboBox();																			
		var lblAreaField:Label=new Label();
		var lblColorField:Label=new Label();
		var lblLabelField:Label=new Label();
		var cbAreaField:ComboBox=new ComboBox();
		var cbColorField:ComboBox=new ComboBox();
		var cbLabelField:ComboBox=new ComboBox();
		var lblcolorSheme:Label=new Label();
		var cbcolorSheme:ComboBox=new ComboBox();
		var cbCartSerie:ComboBox=new ComboBox();
		var chkSel:CheckBox=new CheckBox();
		var chkMultiSel:CheckBox=new CheckBox();
		var lblBg:Label=new Label();
		var cpBg:ColorPicker=new ColorPicker();
		var lbltxtBg:Label=new Label();
		var cptxtBg:ColorPicker=new ColorPicker();
		var lblBc:Label=new Label();
		var cpBc:ColorPicker=new ColorPicker();
		var hrStyle:HRule=new HRule();
		var lblElevation:Label=new Label();
		var Elevation:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblRotation:Label=new Label();
		var Rotation:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblZoom:Label=new Label();
		var Zoom:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblDepth:Label=new Label();
		var Depth:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblDepthGap:Label=new Label();
		var DepthGap:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblLightLatitude:Label=new Label();
		var LightLatitude:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblLightLongitude:Label=new Label();
		var LightLongitude:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var lblAmbiantLight:Label=new Label();
		var AmbiantLight:flexlib.controls.HSlider=new flexlib.controls.HSlider();
		var hr3D:HRule=new HRule();
			
		switch (strChartType) { 
		    case "Area" : 
		    
		    lblForm.id="cnvs"+accordionIndex+"_lblForm";
				lblForm.name="cnvs"+accordionIndex+"_lblForm";
				lblForm.x=3;
				lblForm.y=36;
				lblForm.text="Form :"
				cnvs.addChild(lblForm);
				
				
				cbForm.id="cnvs"+accordionIndex+"_cbForm";
				cbForm.name="cnvs"+accordionIndex+"_cbForm";
				cbForm.dataProvider=myChart.chart.(@Type=="Area").Properties.Property.Forms.Form;
				cbForm.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbForm.x=73;
				cbForm.y=34;
				cbForm.width=160;
				cnvs.addChild(cbForm);
				
				lblDisplay.id="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.name="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.text= "Display :";
				lblDisplay.y=62;
				lblDisplay.x=3;
				cnvs.addChild(lblDisplay);
				
				cbDisplay.id="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.name="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.addEventListener(Event.CHANGE, refreshChartEvent);
				cbDisplay.dataProvider=myChart.chart[0].Properties.Property.barTypes.barType;
				cbDisplay.x=73;
				cbDisplay.y=60;
				cnvs.addChild(cbDisplay);
				
				hrChartType.x=13;
				hrChartType.y=89;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=95;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=117;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=139;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=161;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=165;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=166;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=188;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=186;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=282;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=280;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=214;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);

				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Area").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=213;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=244;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=242;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=260;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=309;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Area").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=307;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=336;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=334;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=357;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0,0];// maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=380;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=390;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				break;
		    case "Bar" : 
		    	lblDisplay.id="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.name="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.text= "Display :";
				lblDisplay.y=36;
				lblDisplay.x=3;
				cnvs.addChild(lblDisplay);
				
				cbDisplay.id="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.name="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.addEventListener(Event.CHANGE, refreshChartEvent);
				cbDisplay.dataProvider=myChart.chart[0].Properties.Property.barTypes.barType;
				cbDisplay.x=73;
				cbDisplay.y=34;
				cnvs.addChild(cbDisplay);
				
				hrChartType.x=13;
				hrChartType.y=63;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=69;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=91;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=113;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=135;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=139;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=140;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=162;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=160;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=256;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=254;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=188;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Bar").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=187;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=218;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=216;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=234;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=283;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Bar").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=280;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=310;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=308;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=331;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=354;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=364;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				break; 
		    case "Bubble" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=42;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=64;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=86;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=108;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=112;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=113;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=138;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=136;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=229;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=227;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=161;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart[0].Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=160;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=191;
				lblxInterval1.x=123;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=189;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=207;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=256;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart[0].Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=253;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=283;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=281;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=304;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				lblRadius.id="cnvs"+accordionIndex+"_lblRadius1";
				lblRadius.name="cnvs"+accordionIndex+"_lblRadius1";
				lblRadius.text= "Radius :";
				lblRadius.y=329;
				lblRadius.x=3;
				cnvs.addChild(lblRadius);
				
				cbRadius.id="cnvs"+accordionIndex+"_cbRadius1";
				cbRadius.name="cnvs"+accordionIndex+"_cbRadius1";
				cbRadius.addEventListener(Event.CHANGE, refreshChartEvent);
				cbRadius.dataProvider=arrAxis;
				cbRadius.prompt="Select...";
				cbRadius.x=73;
				cbRadius.y=327;
				cnvs.addChild(cbRadius);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=352;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=362;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break; 
		    case "Candlestick" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=112;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=135;
				lblxAxis.text="High :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.prompt="Select...";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbxAxis.x=73;
				cbxAxis.y=133;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=217;
				lblyAxis.text="Low :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.prompt="Select...";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbyAxis.x=73;
				cbyAxis.y=215;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=161;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Candlestick").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=160;
				cnvs.addChild(cbxAxisType);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=244;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Candlestick").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=242;
				cnvs.addChild(cbyAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.setStyle("color", 0xCCCCCC);
				lblxInterval1.y=179;
				lblxInterval1.x=150;
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.x=197;
				txtxInterval.y=177;
				txtxInterval.width=36;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=195;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.setStyle("color", 0xCCCCCC);
				lblxMin.text= "min";
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.setStyle("color", 0xCCCCCC);
				lblxMax.text= "max";
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.setStyle("color", 0xCCCCCC);
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=273;
				lblyInterval1.x=150;
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.x=197;
				txtyInterval.y=271;
				txtyInterval.width=36;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=292;
				HBoxMinMaxy.percentWidth=100
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.setStyle("color", 0xCCCCCC);
				lblyMin.text= "min";
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.setStyle("color", 0xCCCCCC);
				lblyMax.text= "max";
				HBoxMinMaxy.addChild(lblyMax);
				
				hrSel.x=13;
				hrSel.y=108;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				chkDataType.x=10;
				chkDataType.y=42;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=64;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=86;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=113;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
				
		    	lblOpenField.id="cnvs"+accordionIndex+"_lblOpenField1";
				lblOpenField.name="cnvs"+accordionIndex+"_lblOpenField1";
				lblOpenField.text= "Open :";
				lblOpenField.y=322;
				lblOpenField.x=3;
				lblOpenField.width=55;
				cnvs.addChild(lblOpenField);
				
				cbOpenField.id="cnvs"+accordionIndex+"_cbOpenField1";
				cbOpenField.name="cnvs"+accordionIndex+"_cbOpenField1";
				cbOpenField.addEventListener(Event.CHANGE, refreshChartEvent);
				cbOpenField.prompt="Select...";
				cbOpenField.dataProvider=arrAxis;
				cbOpenField.x=73;
				cbOpenField.y=320;
				cnvs.addChild(cbOpenField);
				
				lblCloseField.id="cnvs"+accordionIndex+"_lblCloseField1";
				lblCloseField.name="cnvs"+accordionIndex+"_lblCloseField1";
				lblCloseField.text= "Close :";
				lblCloseField.y=345;
				lblCloseField.x=3;
				lblCloseField.width=55;
				cnvs.addChild(lblCloseField);
				
				cbCloseField.id="cnvs"+accordionIndex+"_cbCloseField1";
				cbCloseField.name="cnvs"+accordionIndex+"_cbCloseField1";
				cbCloseField.addEventListener(Event.CHANGE, refreshChartEvent);
				cbCloseField.dataProvider=arrAxis;
				cbCloseField.prompt="Select...";
				cbCloseField.x=73;
				cbCloseField.y=343;
				cnvs.addChild(cbCloseField)
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=370;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=380;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break; 
		    case "Column" : 
		        lblDisplay.id="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.name="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.text= "Display :";
				lblDisplay.y=36;
				lblDisplay.x=3;
				cnvs.addChild(lblDisplay);
				
				cbDisplay.id="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.name="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.addEventListener(Event.CHANGE, refreshChartEvent);
				cbDisplay.dataProvider=myChart.chart[0].Properties.Property.barTypes.barType;
				cbDisplay.x=73;
				cbDisplay.y=34;
				cnvs.addChild(cbDisplay);
				
				hrChartType.x=13;
				hrChartType.y=63;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=69;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=91;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=113;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=135;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=139;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=140;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=162;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=160;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=256;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=254;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=188;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Column").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=187;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=218;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=216;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=234;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=283;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Column").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=280;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=310;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=308;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=331;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=354;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=364;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				break; 
		    case "HighLowOpenClose" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=112;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=135;
				lblxAxis.text="High :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.prompt="Select...";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbxAxis.x=73;
				cbxAxis.y=133;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=217;
				lblyAxis.text="Low :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.prompt="Select...";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbyAxis.x=73;
				cbyAxis.y=215;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=161;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="HighLowOpenClose").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=160;
				cnvs.addChild(cbxAxisType);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=244;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="HighLowOpenClose").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=242;
				cnvs.addChild(cbyAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.setStyle("color", 0xCCCCCC);
				lblxInterval1.y=179;
				lblxInterval1.x=150;
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.x=197;
				txtxInterval.y=177;
				txtxInterval.width=36;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=195;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.setStyle("color", 0xCCCCCC);
				lblxMin.text= "min";
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.setStyle("color", 0xCCCCCC);
				lblxMax.text= "max";
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.setStyle("color", 0xCCCCCC);
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=273;
				lblyInterval1.x=150;
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.x=197;
				txtyInterval.y=271;
				txtyInterval.width=36;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=292;
				HBoxMinMaxy.percentWidth=100
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.setStyle("color", 0xCCCCCC);
				lblyMin.text= "min";
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.setStyle("color", 0xCCCCCC);
				lblyMax.text= "max";
				HBoxMinMaxy.addChild(lblyMax);
				
				hrSel.x=13;
				hrSel.y=108;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				chkDataType.x=10;
				chkDataType.y=42;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=64;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=86;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=113;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
				
		    	lblOpenField.id="cnvs"+accordionIndex+"_lblOpenField1";
				lblOpenField.name="cnvs"+accordionIndex+"_lblOpenField1";
				lblOpenField.text= "Open :";
				lblOpenField.y=322;
				lblOpenField.x=3;
				lblOpenField.width=55;
				cnvs.addChild(lblOpenField);
				
				cbOpenField.id="cnvs"+accordionIndex+"_cbOpenField1";
				cbOpenField.name="cnvs"+accordionIndex+"_cbOpenField1";
				cbOpenField.addEventListener(Event.CHANGE, refreshChartEvent);
				cbOpenField.prompt="Select...";
				cbOpenField.dataProvider=arrAxis;
				cbOpenField.x=73;
				cbOpenField.y=320;
				cnvs.addChild(cbOpenField);
				
				lblCloseField.id="cnvs"+accordionIndex+"_lblCloseField1";
				lblCloseField.name="cnvs"+accordionIndex+"_lblCloseField1";
				lblCloseField.text= "Close :";
				lblCloseField.y=345;
				lblCloseField.x=3;
				lblCloseField.width=55;
				cnvs.addChild(lblCloseField);
				
				cbCloseField.id="cnvs"+accordionIndex+"_cbCloseField1";
				cbCloseField.name="cnvs"+accordionIndex+"_cbCloseField1";
				cbCloseField.addEventListener(Event.CHANGE, refreshChartEvent);
				cbCloseField.dataProvider=arrAxis;
				cbCloseField.prompt="Select...";
				cbCloseField.x=73;
				cbCloseField.y=343;
				cnvs.addChild(cbCloseField)
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=370;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=380;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break; 
		    case "Line" : 
		    	lblForm.id="cnvs"+accordionIndex+"_lblForm";
				lblForm.name="cnvs"+accordionIndex+"_lblForm";
				lblForm.x=3;
				lblForm.y=36;
				lblForm.text="Form :"
				cnvs.addChild(lblForm);
				
				
				cbForm.id="cnvs"+accordionIndex+"_cbForm";
				cbForm.name="cnvs"+accordionIndex+"_cbForm";
				cbForm.dataProvider=myChart.chart[0].Properties.Property.Forms.Form;
				cbForm.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbForm.x=73;
				cbForm.y=34;
				cbForm.width=160;
				cnvs.addChild(cbForm);
				
				hrChartType.x=13;
				hrChartType.y=63;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=69;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=91;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=113;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=135;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=139;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=140;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=162;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=160;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=256;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=254;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=188;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Line").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=187;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=219;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=216;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=234;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=283;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Line").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=280;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=310;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=308;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=331;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=354;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=364;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				break; 
		    case "Pie" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=45;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=67;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
		    	hrSel.x=13;
				hrSel.y=89;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=93;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=115;
				lblyAxis.text="Field :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=115;
				cnvs.addChild(cbyAxis);
				
		    	lblExplode.id="cnvs"+accordionIndex+"_lblExplode";
				lblExplode.name="cnvs"+accordionIndex+"_lblExplode";
				lblExplode.text= "Distance of Separation";
				lblExplode.x=3;
				lblExplode.y=147;
				lblExplode.setStyle("fontSize",9);
				lblExplode.setStyle("textAlign","center");
				lblExplode.percentWidth=100;
				cnvs.addChild(lblExplode);
				
				PieExplode.id="cnvs"+accordionIndex+"_PieExplode";
				PieExplode.name="cnvs"+accordionIndex+"_PieExplode";
				PieExplode.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				PieExplode.allowTrackClick=true;
				PieExplode.allowThumbOverlap=true;
				PieExplode.liveDragging=true;
				PieExplode.showDataTip=true;
				PieExplode.setStyle("dataTipPlacement","bottom");
				PieExplode.setStyle("dataTipOffset",3);
				PieExplode.setStyle("showTrackHighlight",true);
				PieExplode.thumbCount=1;
				PieExplode.percentWidth=100;
				PieExplode.addEventListener(Event.CHANGE, refreshChartEvent);
				PieExplode.snapInterval=.01;
				PieExplode.minimum=0;
				PieExplode.maximum=1;
				PieExplode.values=[0];
				PieExplode.x=3;
				PieExplode.y=155;
				cnvs.addChild(PieExplode);
				
				lblAngle.id="cnvs"+accordionIndex+"_lblAngle";
				lblAngle.name="cnvs"+accordionIndex+"_lblAngle";
				lblAngle.text= "Angle of rotation";
				lblAngle.x=3;
				lblAngle.y=175;
				lblAngle.setStyle("fontSize",9);
				lblAngle.setStyle("textAlign","center");
				lblAngle.percentWidth=100;
				cnvs.addChild(lblAngle);
				
				PieAngle.id="cnvs"+accordionIndex+"_PieAngle";
				PieAngle.name="cnvs"+accordionIndex+"_PieAngle";
				PieAngle.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				PieAngle.allowTrackClick=true;
				PieAngle.allowThumbOverlap=true;
				PieAngle.liveDragging=true;
				PieAngle.showDataTip=true;
				PieAngle.setStyle("dataTipPlacement","bottom");
				PieAngle.setStyle("dataTipOffset",3);
				PieAngle.setStyle("showTrackHighlight",true);
				PieAngle.thumbCount=1;
				PieAngle.percentWidth=100;
				PieAngle.addEventListener(Event.CHANGE, refreshChartEvent);
				PieAngle.snapInterval=1;
				PieAngle.minimum=0;
				PieAngle.maximum=360;
				PieAngle.values=[0];
				PieAngle.x=3;
				PieAngle.y=183;
				PieAngle.dataTipFormatFunction=degrees_func
				cnvs.addChild(PieAngle);
				
				lblDonuts.id="cnvs"+accordionIndex+"_lblDonuts";
				lblDonuts.name="cnvs"+accordionIndex+"_lblDonuts";
				lblDonuts.text= "Donuts";
				lblDonuts.x=3;
				lblDonuts.y=203;
				lblDonuts.setStyle("fontSize",9);
				lblDonuts.setStyle("textAlign","center");
				lblDonuts.percentWidth=100;
				cnvs.addChild(lblDonuts);
				
				PieDonuts.id="cnvs"+accordionIndex+"_PieDonuts";
				PieDonuts.name="cnvs"+accordionIndex+"_PieDonuts";
				PieDonuts.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				PieDonuts.allowTrackClick=true;
				PieDonuts.allowThumbOverlap=true;
				PieDonuts.liveDragging=true;
				PieDonuts.showDataTip=true;
				PieDonuts.setStyle("dataTipPlacement","bottom");
				PieDonuts.setStyle("dataTipOffset",3);
				PieDonuts.setStyle("showTrackHighlight",true);
				PieDonuts.thumbCount=1;
				PieDonuts.percentWidth=100;
				PieDonuts.addEventListener(Event.CHANGE, refreshChartEvent);
				PieDonuts.snapInterval=0.01;
				PieDonuts.minimum=0;
				PieDonuts.maximum=1;
				PieDonuts.values=[0];
				PieDonuts.x=3;
				PieDonuts.y=211;
				cnvs.addChild(PieDonuts);
				
				lblLabelPosition.id="cnvs"+accordionIndex+"_lblLabelPosition";
				lblLabelPosition.name="cnvs"+accordionIndex+"_lblLabelPosition";
				lblLabelPosition.text= "Label Position :";
				lblLabelPosition.y=239;
				lblLabelPosition.x=3;
				cnvs.addChild(lblLabelPosition);
				
				cbLabelPosition.id="cnvs"+accordionIndex+"_cbLabelPosition";
				cbLabelPosition.name="cnvs"+accordionIndex+"_cbLabelPosition";
				cbLabelPosition.addEventListener(Event.CHANGE, refreshChartEvent);
				cbLabelPosition.dataProvider=myChart.chart.(@Type=="Pie").Properties.Property.labelPosition.value;
				cbLabelPosition.x=95;
				cbLabelPosition.y=239;
				cnvs.addChild(cbLabelPosition);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=273;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=283;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break; 
		    case "Plot" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=42;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=64;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=86;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=108;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=112;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=113;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=138;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=136;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=229;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=227;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=161;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Plot").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=160;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=191;
				lblxInterval1.x=123;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=189;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=207;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=256;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Plot").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=253;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=283;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=281;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=304;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=329;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=339;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break;
		    case "Radar" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=42;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=64;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				
				chkGrid.x=10;
				chkGrid.y=86;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=108;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=112;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=113;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
				
				
				cbRadarSerie.id="cnvs"+accordionIndex+"_cbRadarSerie1";
				cbRadarSerie.name="cnvs"+accordionIndex+"_cbRadarSerie1";
				cbRadarSerie.addEventListener(Event.CHANGE, radarSerieEvent);
				cbRadarSerie.dataProvider=myChart.chart.(@Type=="Radar").Properties.Property.(@name=="RadarSeries").RadarSerie;
				cbRadarSerie.prompt="Select...";
				cbRadarSerie.x=83;
				cbRadarSerie.y=111;
				cnvs.addChild(cbRadarSerie);
				
				
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=138;
				lblxAxis.text="Category Field :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbxAxis.prompt="Select...";
				cbxAxis.x=93;
				cbxAxis.y=136;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=165;
				lblyAxis.text="Data Field :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=93;
				cbyAxis.y=163;
				cnvs.addChild(cbyAxis);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=192;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Radar").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.prompt="Select...";
				cbyAxisType.x=73;
				cbyAxisType.y=189;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=215;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=217;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=240;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				lblRadius.id="cnvs"+accordionIndex+"_lblRadius1";
				lblRadius.name="cnvs"+accordionIndex+"_lblRadius1";
				lblRadius.text= "Radius :";
				lblRadius.setStyle("color", 0xCCCCCC);
				lblRadius.y=265;
				lblRadius.x=3;
				cnvs.addChild(lblRadius);
				
				cbRadius.id="cnvs"+accordionIndex+"_cbRadius1";
				cbRadius.name="cnvs"+accordionIndex+"_cbRadius1";
				cbRadius.addEventListener(Event.CHANGE, refreshChartEvent);
				cbRadius.dataProvider=arrAxis;
				cbRadius.prompt="Select...";
				cbRadius.setStyle("color", 0xCCCCCC);
				cbRadius.alpha=0.3;
				cbRadius.x=73;
				cbRadius.y=263;
				cnvs.addChild(cbRadius);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=288;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=298;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break;
		    case "TreeMap" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=45;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cbAlgo.id="cnvs"+accordionIndex+"_cbAlgo1";
				cbAlgo.name="cnvs"+accordionIndex+"_cbAlgo1";
				cbAlgo.addEventListener(Event.CHANGE, refreshChartEvent);
				cbAlgo.dataProvider=myChart.chart.(@Type=="TreeMap").Properties.Property.(@name=="algorithms").algorithm;
				cbAlgo.x=73;
				cbAlgo.y=43;
				cnvs.addChild(cbAlgo);
				
				lblAreaField.id="cnvs"+accordionIndex+"_lblAreaField1";
				lblAreaField.name="cnvs"+accordionIndex+"_lblAreaField1";
				lblAreaField.x=3;
				lblAreaField.y=68;
				lblAreaField.text="Area :";
				cnvs.addChild(lblAreaField);
				
				cbAreaField.id="cnvs"+accordionIndex+"_cbAreaField1";
				cbAreaField.name="cnvs"+accordionIndex+"_cbAreaField1";
				cbAreaField.prompt="Select...";
				cbAreaField.dataProvider=arrTreeAxis;
				cbAreaField.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbAreaField.x=73;
				cbAreaField.y=66;
				cnvs.addChild(cbAreaField);
				
				lblColorField.id="cnvs"+accordionIndex+"_lblColorField1";
				lblColorField.name="cnvs"+accordionIndex+"_lblColorField1";
				lblColorField.x=3;
				lblColorField.y=94;
				lblColorField.text="Color :";
				cnvs.addChild(lblColorField);
				
				cbColorField.id="cnvs"+accordionIndex+"_cbColorField1";
				cbColorField.name="cnvs"+accordionIndex+"_cbColorField1";
				cbColorField.prompt="Select...";
				cbColorField.dataProvider=arrTreeAxis;
				cbColorField.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbColorField.x=73;
				cbColorField.y=92;
				cnvs.addChild(cbColorField);
				
				lblLabelField.id="cnvs"+accordionIndex+"_lblLabelField1";
				lblLabelField.name="cnvs"+accordionIndex+"_lblLabelField1";
				lblLabelField.x=3;
				lblLabelField.y=120;
				lblLabelField.text="Label :";
				cnvs.addChild(lblLabelField);
				
				cbLabelField.id="cnvs"+accordionIndex+"_cbLabelField1";
				cbLabelField.name="cnvs"+accordionIndex+"_cbLabelField1";
				cbLabelField.prompt="Select...";
				cbLabelField.dataProvider=arrTreeAxis;
				cbLabelField.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbLabelField.x=73;
				cbLabelField.y=118;
				cnvs.addChild(cbLabelField);
				
				lblcolorSheme.id="cnvs"+accordionIndex+"_lblcolorSheme1";
				lblcolorSheme.name="cnvs"+accordionIndex+"_lblcolorSheme1";
				lblcolorSheme.x=3;
				lblcolorSheme.y=146;
				lblcolorSheme.text="Color scheme :";
				cnvs.addChild(lblcolorSheme);
				
				cbcolorSheme.id="cnvs"+accordionIndex+"_cbcolorSheme1";
				cbcolorSheme.name="cnvs"+accordionIndex+"_cbcolorSheme1";
				cbcolorSheme.dataProvider=myChart.chart.(@Type=="TreeMap").Styles.Style.(@name=="colorSchemes").colorScheme;
				cbcolorSheme.addEventListener(Event.CHANGE, refreshChartEvent); //parentDocument.
				cbcolorSheme.x=93;
				cbcolorSheme.y=144;
				cnvs.addChild(cbcolorSheme);
				
				hrSel.x=13;
				hrSel.y=175;
				hrSel.width=210;
				cnvs.addChild(hrSel);
				
				chkSel.x=10;
				chkSel.y=185;
				chkSel.label="Allow selection";
				chkSel.id="cnvs"+accordionIndex+"_chkSel";
				chkSel.name="cnvs"+accordionIndex+"_chkSel";
				chkSel.enabled=true;
				chkSel.selected=true;
				chkSel.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkSel);
				
				chkMultiSel.x=10;
				chkMultiSel.y=210;
				chkMultiSel.label="Allow multi selection";
				chkMultiSel.id="cnvs"+accordionIndex+"_chkMultiSel";
				chkMultiSel.name="cnvs"+accordionIndex+"_chkMultiSel";
				chkMultiSel.enabled=true;
				chkMultiSel.selected=false;
				chkMultiSel.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkMultiSel);
				
				hrStyle.x=13;
				hrStyle.y=245;
				hrStyle.width=210;
				hrStyle.height=1;
				cnvs.addChild(hrStyle);
				
				cpBg.id="cnvs"+accordionIndex+"_cpBg";
				cpBg.name="cnvs"+accordionIndex+"_cpBg";
				cpBg.y=255;
				cpBg.x=3;
				cpBg.width=17;
				cpBg.height=17;
				cpBg.selectedColor=0xFFFFFF;
				cpBg.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cpBg);
				
				lblBg.id="cnvs"+accordionIndex+"_lblBg";
				lblBg.name="cnvs"+accordionIndex+"_lblBg";
				lblBg.x=25;
				lblBg.y=253;
				lblBg.width=150;
				lblBg.text="Background color";
				cnvs.addChild(lblBg);
				
				cptxtBg.id="cnvs"+accordionIndex+"_cptxtBg";
				cptxtBg.name="cnvs"+accordionIndex+"_cptxtBg";
				cptxtBg.y=277;
				cptxtBg.x=3;
				cptxtBg.width=17;
				cptxtBg.height=17;
				cptxtBg.selectedColor=0xFFFFFF;
				cptxtBg.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cptxtBg);
				
				lbltxtBg.id="cnvs"+accordionIndex+"_lbltxtBg";
				lbltxtBg.name="cnvs"+accordionIndex+"_lbltxtBg";
				lbltxtBg.x=25;
				lbltxtBg.y=275;
				lbltxtBg.width=150;
				lbltxtBg.text="Text background color";
				cnvs.addChild(lbltxtBg);
				
				cpBc.id="cnvs"+accordionIndex+"_cpBc";
				cpBc.name="cnvs"+accordionIndex+"_cpBc";
				cpBc.y=299;
				cpBc.x=3;
				cpBc.width=17;
				cpBc.height=17;
				cpBc.selectedColor=0x000000;
				cpBc.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cpBc);
				
				lblBc.id="cnvs"+accordionIndex+"_lblBc";
				lblBc.name="cnvs"+accordionIndex+"_lblBc";
				lblBc.x=25;
				lblBc.y=297;
				lblBc.width=150;
				lblBc.text="Border color";
				cnvs.addChild(lblBc);
				
				
		        break;
		    case "GeoMap" : 
		        break; 
		   case "Cartesian" : 
		   	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=42;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=64;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=86;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=108;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=112;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=113;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
				
				cbCartSerie.id="cnvs"+accordionIndex+"_cbCartSerie1";
				cbCartSerie.name="cnvs"+accordionIndex+"_cbCartSerie1";
				cbCartSerie.addEventListener(Event.CHANGE, refreshCartChartEvent);
				cbCartSerie.dataProvider=myChart.chart.(@Type=="Cartesian").Properties.Property.Series.Serie;
				cbCartSerie.prompt="Select...";
				cbCartSerie.x=73;
				cbCartSerie.y=113;
				cnvs.addChild(cbCartSerie);
				
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=138;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=136;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=229;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=227;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=161;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Cartesian").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=160;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=191;
				lblxInterval1.x=123;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=189;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=207;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=256;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Cartesian").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=253;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=283;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=281;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=304;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				lblRadius.id="cnvs"+accordionIndex+"_lblRadius1";
				lblRadius.name="cnvs"+accordionIndex+"_lblRadius1";
				lblRadius.text= "Radius :";
				lblRadius.setStyle("color", 0xCCCCCC);
				lblRadius.y=329;
				lblRadius.x=3;
				cnvs.addChild(lblRadius);
				
				cbRadius.id="cnvs"+accordionIndex+"_cbRadius1";
				cbRadius.name="cnvs"+accordionIndex+"_cbRadius1";
				cbRadius.addEventListener(Event.CHANGE, refreshChartEvent);
				cbRadius.dataProvider=arrAxis;
				cbRadius.alpha=0.3;
				cbRadius.setStyle("color", 0xCCCCCC);
				cbRadius.x=73;
				cbRadius.y=327;
				cnvs.addChild(cbRadius);
				
				lblOpenField.id="cnvs"+accordionIndex+"_lblOpenField1";
				lblOpenField.name="cnvs"+accordionIndex+"_lblOpenField1";
				lblOpenField.text= "Open :";
				lblOpenField.setStyle("color", 0xCCCCCC);
				lblOpenField.y=352;
				lblOpenField.x=3;
				lblOpenField.width=55;
				cnvs.addChild(lblOpenField);
				
				cbOpenField.id="cnvs"+accordionIndex+"_cbOpenField1";
				cbOpenField.name="cnvs"+accordionIndex+"_cbOpenField1";
				cbOpenField.addEventListener(Event.CHANGE, refreshChartEvent);
				cbOpenField.prompt="Select...";
				cbOpenField.alpha=0.3;
				cbOpenField.setStyle("color", 0xCCCCCC);
				cbOpenField.dataProvider=arrAxis;
				cbOpenField.x=73;
				cbOpenField.y=350;
				cnvs.addChild(cbOpenField);
				
				lblCloseField.id="cnvs"+accordionIndex+"_lblCloseField1";
				lblCloseField.name="cnvs"+accordionIndex+"_lblCloseField1";
				lblCloseField.text= "Close :";
				lblCloseField.setStyle("color", 0xCCCCCC);
				lblCloseField.y=375;
				lblCloseField.x=3;
				lblCloseField.width=55;
				cnvs.addChild(lblCloseField);
				
				cbCloseField.id="cnvs"+accordionIndex+"_cbCloseField1";
				cbCloseField.name="cnvs"+accordionIndex+"_cbCloseField1";
				cbCloseField.addEventListener(Event.CHANGE, refreshChartEvent);
				cbCloseField.dataProvider=arrAxis;
				cbCloseField.prompt="Select...";
				cbCloseField.alpha=0.3;
				cbCloseField.setStyle("color", 0xCCCCCC);
				cbCloseField.x=73;
				cbCloseField.y=373;
				cnvs.addChild(cbCloseField);
				
				lblCartForm.id="cnvs"+accordionIndex+"_lblCatForm1";
				lblCartForm.name="cnvs"+accordionIndex+"_lblCatForm1";
				lblCartForm.text= "Form :";
				lblCartForm.setStyle("color", 0xCCCCCC);
				lblCartForm.y=398;
				lblCartForm.x=3;
				cnvs.addChild(lblCartForm);
				
				cbCartForm.id="cnvs"+accordionIndex+"_cbCartForm1";
				cbCartForm.name="cnvs"+accordionIndex+"_cbCartForm1";
				cbCartForm.addEventListener(Event.CHANGE, refreshChartEvent);
				cbCartForm.dataProvider=myChart.chart.(@Type=="Cartesian").Properties.Property.cartForms.cartForm;
				cbCartForm.alpha=0.3;
				cbCartForm.setStyle("color", 0xCCCCCC);
				cbCartForm.x=73;
				cbCartForm.y=396;
				cnvs.addChild(cbCartForm);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=425;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=435;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break; 
				case "Area3D" :
				lblForm.id="cnvs"+accordionIndex+"_lblForm";
				lblForm.name="cnvs"+accordionIndex+"_lblForm";
				lblForm.x=3;
				lblForm.y=36;
				lblForm.text="Form :"
				cnvs.addChild(lblForm);
				
				
				cbForm.id="cnvs"+accordionIndex+"_cbForm";
				cbForm.name="cnvs"+accordionIndex+"_cbForm";
				cbForm.dataProvider=myChart.chart.(@Type=="Area3D").Properties.Property.Forms.Form;
				cbForm.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbForm.x=73;
				cbForm.y=34;
				cbForm.width=160;
				cnvs.addChild(cbForm);
				
				lblDisplay.id="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.name="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.text= "Display :";
				lblDisplay.y=62;
				lblDisplay.x=3;
				cnvs.addChild(lblDisplay);
				
				cbDisplay.id="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.name="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.addEventListener(Event.CHANGE, refreshChartEvent);
				cbDisplay.dataProvider=myChart.chart.(@Type=="Area3D").Properties.Property.barTypes.barType;
				cbDisplay.x=73;
				cbDisplay.y=60;
				cnvs.addChild(cbDisplay);
				
				hrChartType.x=13;
				hrChartType.y=89;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=95;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=117;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=139;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=161;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=165;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=166;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=188;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=186;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=282;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=280;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=214;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);

				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Area3D").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); 
				cbxAxisType.x=73;
				cbxAxisType.y=213;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=244;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=242;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=260;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=309;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Area3D").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=307;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=336;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=334;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=357;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0,0];// maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hr3D.name="cnvs"+accordionIndex+"_hr3D";
				hr3D.id="cnvs"+accordionIndex+"_hr3D";
				hr3D.x=10;
				hr3D.y=385;
				hr3D.width=210;
				cnvs.addChild(hr3D);
				
				lblElevation.id="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.name="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.text= "Elevation";
				lblElevation.x=3;
				lblElevation.y=390;
				lblElevation.setStyle("fontSize",9);
				lblElevation.setStyle("textAlign","center");
				lblElevation.percentWidth=80;
				cnvs.addChild(lblElevation);
				
				Elevation.id="cnvs"+accordionIndex+"_Elevation";
				Elevation.name="cnvs"+accordionIndex+"_Elevation";
				Elevation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Elevation.allowTrackClick=true;
				Elevation.allowThumbOverlap=true;
				Elevation.liveDragging=true;
				Elevation.showDataTip=true;
				Elevation.setStyle("dataTipPlacement","bottom");
				Elevation.setStyle("dataTipOffset",3);
				Elevation.setStyle("showTrackHighlight",true);
				Elevation.thumbCount=1;
				Elevation.percentWidth=80;
				Elevation.addEventListener(Event.CHANGE, refreshChartEvent);
				Elevation.snapInterval=.01;
				Elevation.minimum=-90;
				Elevation.maximum=90;
				Elevation.values=[45];
				Elevation.x=3;
				Elevation.y=405;
				cnvs.addChild(Elevation);
				
				lblRotation.id="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.name="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.text= "Rotation";
				lblRotation.x=3;
				lblRotation.y=425;
				lblRotation.setStyle("fontSize",9);
				lblRotation.setStyle("textAlign","center");
				lblRotation.percentWidth=80;
				cnvs.addChild(lblRotation);
				
				Rotation.id="cnvs"+accordionIndex+"_Rotation";
				Rotation.name="cnvs"+accordionIndex+"_Rotation";
				Rotation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Rotation.allowTrackClick=true;
				Rotation.allowThumbOverlap=true;
				Rotation.liveDragging=true;
				Rotation.showDataTip=true;
				Rotation.setStyle("dataTipPlacement","bottom");
				Rotation.setStyle("dataTipOffset",3);
				Rotation.setStyle("showTrackHighlight",true);
				Rotation.thumbCount=1;
				Rotation.percentWidth=80;
				Rotation.addEventListener(Event.CHANGE, refreshChartEvent);
				Rotation.snapInterval=.01;
				Rotation.minimum=-90;
				Rotation.maximum=90;
				Rotation.values=[45];
				Rotation.x=3;
				Rotation.y=440;
				cnvs.addChild(Rotation);
				
				lblZoom.id="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.name="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.text= "Zoom";
				lblZoom.x=3;
				lblZoom.y=460;
				lblZoom.setStyle("fontSize",9);
				lblZoom.setStyle("textAlign","center");
				lblZoom.percentWidth=80;
				cnvs.addChild(lblZoom);
				
				Zoom.id="cnvs"+accordionIndex+"_Zoom";
				Zoom.name="cnvs"+accordionIndex+"_Zoom";
				Zoom.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Zoom.allowTrackClick=true;
				Zoom.allowThumbOverlap=true;
				Zoom.liveDragging=true;
				Zoom.showDataTip=true;
				Zoom.setStyle("dataTipPlacement","bottom");
				Zoom.setStyle("dataTipOffset",3);
				Zoom.setStyle("showTrackHighlight",true);
				Zoom.thumbCount=1;
				Zoom.percentWidth=80;
				Zoom.addEventListener(Event.CHANGE, refreshChartEvent);
				Zoom.snapInterval=.01;
				Zoom.minimum=0.50;
				Zoom.maximum=2;
				Zoom.values=[1];
				Zoom.x=3;
				Zoom.y=475;
				cnvs.addChild(Zoom);
				
				lblDepth.id="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.name="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.text= "Depth";
				lblDepth.x=3;
				lblDepth.y=495;
				lblDepth.setStyle("fontSize",9);
				lblDepth.setStyle("textAlign","center");
				lblDepth.percentWidth=80;
				cnvs.addChild(lblDepth);
				
				Depth.id="cnvs"+accordionIndex+"_Depth";
				Depth.name="cnvs"+accordionIndex+"_Depth";
				Depth.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Depth.allowTrackClick=true;
				Depth.allowThumbOverlap=true;
				Depth.liveDragging=true;
				Depth.showDataTip=true;
				Depth.setStyle("dataTipPlacement","bottom");
				Depth.setStyle("dataTipOffset",3);
				Depth.setStyle("showTrackHighlight",true);
				Depth.thumbCount=1;
				Depth.percentWidth=80;
				Depth.addEventListener(Event.CHANGE, refreshChartEvent);
				Depth.snapInterval=.1;
				Depth.minimum=1;
				Depth.maximum=100;
				Depth.values=[20];
				Depth.x=3;
				Depth.y=510;
				cnvs.addChild(Depth);
				
				lblDepthGap.id="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.name="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.text= "Depth Gap";
				lblDepthGap.x=3;
				lblDepthGap.y=530;
				lblDepthGap.setStyle("fontSize",9);
				lblDepthGap.setStyle("textAlign","center");
				lblDepthGap.percentWidth=80;
				cnvs.addChild(lblDepthGap);
				
				DepthGap.id="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.name="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				DepthGap.allowTrackClick=true;
				DepthGap.allowThumbOverlap=true;
				DepthGap.liveDragging=true;
				DepthGap.showDataTip=true;
				DepthGap.setStyle("dataTipPlacement","bottom");
				DepthGap.setStyle("dataTipOffset",3);
				DepthGap.setStyle("showTrackHighlight",true);
				DepthGap.thumbCount=1;
				DepthGap.percentWidth=80;
				DepthGap.addEventListener(Event.CHANGE, refreshChartEvent);
				DepthGap.snapInterval=.1;
				DepthGap.minimum=0;
				DepthGap.maximum=20;
				DepthGap.values=[0];
				DepthGap.x=3;
				DepthGap.y=545;
				cnvs.addChild(DepthGap);
				
				lblLightLatitude.id="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.name="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.text= "Light Latitude";
				lblLightLatitude.x=3;
				lblLightLatitude.y=565;
				lblLightLatitude.setStyle("fontSize",9);
				lblLightLatitude.setStyle("textAlign","center");
				lblLightLatitude.percentWidth=80;
				cnvs.addChild(lblLightLatitude);
				
				LightLatitude.id="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.name="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLatitude.allowTrackClick=true;
				LightLatitude.allowThumbOverlap=true;
				LightLatitude.liveDragging=true;
				LightLatitude.showDataTip=true;
				LightLatitude.setStyle("dataTipPlacement","bottom");
				LightLatitude.setStyle("dataTipOffset",3);
				LightLatitude.setStyle("showTrackHighlight",true);
				LightLatitude.thumbCount=1;
				LightLatitude.percentWidth=80;
				LightLatitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLatitude.snapInterval=.1;
				LightLatitude.minimum=-90;
				LightLatitude.maximum=+90;
				LightLatitude.values=[0];
				LightLatitude.x=3;
				LightLatitude.y=580;
				cnvs.addChild(LightLatitude);
				
				lblLightLongitude.id="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.name="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.text= "Light Latitude";
				lblLightLongitude.x=3;
				lblLightLongitude.y=600;
				lblLightLongitude.setStyle("fontSize",9);
				lblLightLongitude.setStyle("textAlign","center");
				lblLightLongitude.percentWidth=80;
				cnvs.addChild(lblLightLongitude);
				
				LightLongitude.id="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.name="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLongitude.allowTrackClick=true;
				LightLongitude.allowThumbOverlap=true;
				LightLongitude.liveDragging=true;
				LightLongitude.showDataTip=true;
				LightLongitude.setStyle("dataTipPlacement","bottom");
				LightLongitude.setStyle("dataTipOffset",3);
				LightLongitude.setStyle("showTrackHighlight",true);
				LightLongitude.thumbCount=1;
				LightLongitude.percentWidth=80;
				LightLongitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLongitude.snapInterval=.1;
				LightLongitude.minimum=-90;
				LightLongitude.maximum=90;
				LightLongitude.values=[0];
				LightLongitude.x=3;
				LightLongitude.y=615;
				cnvs.addChild(LightLongitude);
				
				lblAmbiantLight.id="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.name="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.text= "Light Latitude";
				lblAmbiantLight.x=3;
				lblAmbiantLight.y=635;
				lblAmbiantLight.setStyle("fontSize",9);
				lblAmbiantLight.setStyle("textAlign","center");
				lblAmbiantLight.percentWidth=80;
				cnvs.addChild(lblAmbiantLight);
				
				AmbiantLight.id="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.name="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				AmbiantLight.allowTrackClick=true;
				AmbiantLight.allowThumbOverlap=true;
				AmbiantLight.liveDragging=true;
				AmbiantLight.showDataTip=true;
				AmbiantLight.setStyle("dataTipPlacement","bottom");
				AmbiantLight.setStyle("dataTipOffset",3);
				AmbiantLight.setStyle("showTrackHighlight",true);
				AmbiantLight.thumbCount=1;
				AmbiantLight.percentWidth=80;
				AmbiantLight.addEventListener(Event.CHANGE, refreshChartEvent);
				AmbiantLight.snapInterval=0.01;
				AmbiantLight.minimum=0;
				AmbiantLight.maximum=1;
				AmbiantLight.values=[0.1];
				AmbiantLight.x=3;
				AmbiantLight.y=650;
				cnvs.addChild(AmbiantLight);
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=680;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=690;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				break;
		    case "Bar3D" : 
		    	lblForm.id="cnvs"+accordionIndex+"_lblForm";
				lblForm.name="cnvs"+accordionIndex+"_lblForm";
				lblForm.x=3;
				lblForm.y=36;
				lblForm.text="Form :"
				cnvs.addChild(lblForm);
				
				
				cbForm.id="cnvs"+accordionIndex+"_cbForm";
				cbForm.name="cnvs"+accordionIndex+"_cbForm";
				cbForm.dataProvider=myChart.chart.(@Type=="Bar3D").Properties.Property.Forms.Form;
				cbForm.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbForm.x=73;
				cbForm.y=34;
				cbForm.width=160;
				cnvs.addChild(cbForm);
				
		    	lblDisplay.id="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.name="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.text= "Display :";
				lblDisplay.y=62;
				lblDisplay.x=3;
				cnvs.addChild(lblDisplay);
				
				cbDisplay.id="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.name="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.addEventListener(Event.CHANGE, refreshChartEvent);
				cbDisplay.dataProvider=myChart.chart.(@Type=="Bar3D").Properties.Property.barTypes.barType;
				cbDisplay.x=73;
				cbDisplay.y=60;
				cnvs.addChild(cbDisplay);
				
				hrChartType.x=13;
				hrChartType.y=89;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=95;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=117;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=139;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=161;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=165;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=166;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=188;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=186;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=282;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=280;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=214;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Bar3D").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=213;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=244;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=242;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=260;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=309;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Bar3D").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=306;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=336;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=334;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=357;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hr3D.name="cnvs"+accordionIndex+"_hr3D";
				hr3D.id="cnvs"+accordionIndex+"_hr3D";
				hr3D.x=10;
				hr3D.y=385;
				hr3D.width=210;
				cnvs.addChild(hr3D);
				
				lblElevation.id="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.name="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.text= "Elevation";
				lblElevation.x=3;
				lblElevation.y=390;
				lblElevation.setStyle("fontSize",9);
				lblElevation.setStyle("textAlign","center");
				lblElevation.percentWidth=80;
				cnvs.addChild(lblElevation);
				
				Elevation.id="cnvs"+accordionIndex+"_Elevation";
				Elevation.name="cnvs"+accordionIndex+"_Elevation";
				Elevation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Elevation.allowTrackClick=true;
				Elevation.allowThumbOverlap=true;
				Elevation.liveDragging=true;
				Elevation.showDataTip=true;
				Elevation.setStyle("dataTipPlacement","bottom");
				Elevation.setStyle("dataTipOffset",3);
				Elevation.setStyle("showTrackHighlight",true);
				Elevation.thumbCount=1;
				Elevation.percentWidth=80;
				Elevation.addEventListener(Event.CHANGE, refreshChartEvent);
				Elevation.snapInterval=.01;
				Elevation.minimum=-90;
				Elevation.maximum=90;
				Elevation.values=[45];
				Elevation.x=3;
				Elevation.y=405;
				cnvs.addChild(Elevation);
				
				lblRotation.id="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.name="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.text= "Rotation";
				lblRotation.x=3;
				lblRotation.y=425;
				lblRotation.setStyle("fontSize",9);
				lblRotation.setStyle("textAlign","center");
				lblRotation.percentWidth=80;
				cnvs.addChild(lblRotation);
				
				Rotation.id="cnvs"+accordionIndex+"_Rotation";
				Rotation.name="cnvs"+accordionIndex+"_Rotation";
				Rotation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Rotation.allowTrackClick=true;
				Rotation.allowThumbOverlap=true;
				Rotation.liveDragging=true;
				Rotation.showDataTip=true;
				Rotation.setStyle("dataTipPlacement","bottom");
				Rotation.setStyle("dataTipOffset",3);
				Rotation.setStyle("showTrackHighlight",true);
				Rotation.thumbCount=1;
				Rotation.percentWidth=80;
				Rotation.addEventListener(Event.CHANGE, refreshChartEvent);
				Rotation.snapInterval=.01;
				Rotation.minimum=-90;
				Rotation.maximum=90;
				Rotation.values=[45];
				Rotation.x=3;
				Rotation.y=440;
				cnvs.addChild(Rotation);
				
				lblZoom.id="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.name="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.text= "Zoom";
				lblZoom.x=3;
				lblZoom.y=460;
				lblZoom.setStyle("fontSize",9);
				lblZoom.setStyle("textAlign","center");
				lblZoom.percentWidth=80;
				cnvs.addChild(lblZoom);
				
				Zoom.id="cnvs"+accordionIndex+"_Zoom";
				Zoom.name="cnvs"+accordionIndex+"_Zoom";
				Zoom.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Zoom.allowTrackClick=true;
				Zoom.allowThumbOverlap=true;
				Zoom.liveDragging=true;
				Zoom.showDataTip=true;
				Zoom.setStyle("dataTipPlacement","bottom");
				Zoom.setStyle("dataTipOffset",3);
				Zoom.setStyle("showTrackHighlight",true);
				Zoom.thumbCount=1;
				Zoom.percentWidth=80;
				Zoom.addEventListener(Event.CHANGE, refreshChartEvent);
				Zoom.snapInterval=.01;
				Zoom.minimum=0.50;
				Zoom.maximum=2;
				Zoom.values=[1];
				Zoom.x=3;
				Zoom.y=475;
				cnvs.addChild(Zoom);
				
				lblDepth.id="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.name="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.text= "Depth";
				lblDepth.x=3;
				lblDepth.y=495;
				lblDepth.setStyle("fontSize",9);
				lblDepth.setStyle("textAlign","center");
				lblDepth.percentWidth=80;
				cnvs.addChild(lblDepth);
				
				Depth.id="cnvs"+accordionIndex+"_Depth";
				Depth.name="cnvs"+accordionIndex+"_Depth";
				Depth.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Depth.allowTrackClick=true;
				Depth.allowThumbOverlap=true;
				Depth.liveDragging=true;
				Depth.showDataTip=true;
				Depth.setStyle("dataTipPlacement","bottom");
				Depth.setStyle("dataTipOffset",3);
				Depth.setStyle("showTrackHighlight",true);
				Depth.thumbCount=1;
				Depth.percentWidth=80;
				Depth.addEventListener(Event.CHANGE, refreshChartEvent);
				Depth.snapInterval=.1;
				Depth.minimum=1;
				Depth.maximum=100;
				Depth.values=[20];
				Depth.x=3;
				Depth.y=510;
				cnvs.addChild(Depth);
				
				lblDepthGap.id="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.name="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.text= "Depth Gap";
				lblDepthGap.x=3;
				lblDepthGap.y=530;
				lblDepthGap.setStyle("fontSize",9);
				lblDepthGap.setStyle("textAlign","center");
				lblDepthGap.percentWidth=80;
				cnvs.addChild(lblDepthGap);
				
				DepthGap.id="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.name="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				DepthGap.allowTrackClick=true;
				DepthGap.allowThumbOverlap=true;
				DepthGap.liveDragging=true;
				DepthGap.showDataTip=true;
				DepthGap.setStyle("dataTipPlacement","bottom");
				DepthGap.setStyle("dataTipOffset",3);
				DepthGap.setStyle("showTrackHighlight",true);
				DepthGap.thumbCount=1;
				DepthGap.percentWidth=80;
				DepthGap.addEventListener(Event.CHANGE, refreshChartEvent);
				DepthGap.snapInterval=.1;
				DepthGap.minimum=0;
				DepthGap.maximum=20;
				DepthGap.values=[0];
				DepthGap.x=3;
				DepthGap.y=545;
				cnvs.addChild(DepthGap);
				
				lblLightLatitude.id="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.name="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.text= "Light Latitude";
				lblLightLatitude.x=3;
				lblLightLatitude.y=565;
				lblLightLatitude.setStyle("fontSize",9);
				lblLightLatitude.setStyle("textAlign","center");
				lblLightLatitude.percentWidth=80;
				cnvs.addChild(lblLightLatitude);
				
				LightLatitude.id="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.name="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLatitude.allowTrackClick=true;
				LightLatitude.allowThumbOverlap=true;
				LightLatitude.liveDragging=true;
				LightLatitude.showDataTip=true;
				LightLatitude.setStyle("dataTipPlacement","bottom");
				LightLatitude.setStyle("dataTipOffset",3);
				LightLatitude.setStyle("showTrackHighlight",true);
				LightLatitude.thumbCount=1;
				LightLatitude.percentWidth=80;
				LightLatitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLatitude.snapInterval=.1;
				LightLatitude.minimum=-90;
				LightLatitude.maximum=+90;
				LightLatitude.values=[0];
				LightLatitude.x=3;
				LightLatitude.y=580;
				cnvs.addChild(LightLatitude);
				
				lblLightLongitude.id="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.name="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.text= "Light Latitude";
				lblLightLongitude.x=3;
				lblLightLongitude.y=600;
				lblLightLongitude.setStyle("fontSize",9);
				lblLightLongitude.setStyle("textAlign","center");
				lblLightLongitude.percentWidth=80;
				cnvs.addChild(lblLightLongitude);
				
				LightLongitude.id="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.name="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLongitude.allowTrackClick=true;
				LightLongitude.allowThumbOverlap=true;
				LightLongitude.liveDragging=true;
				LightLongitude.showDataTip=true;
				LightLongitude.setStyle("dataTipPlacement","bottom");
				LightLongitude.setStyle("dataTipOffset",3);
				LightLongitude.setStyle("showTrackHighlight",true);
				LightLongitude.thumbCount=1;
				LightLongitude.percentWidth=80;
				LightLongitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLongitude.snapInterval=.1;
				LightLongitude.minimum=-90;
				LightLongitude.maximum=90;
				LightLongitude.values=[0];
				LightLongitude.x=3;
				LightLongitude.y=615;
				cnvs.addChild(LightLongitude);
				
				lblAmbiantLight.id="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.name="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.text= "Light Latitude";
				lblAmbiantLight.x=3;
				lblAmbiantLight.y=635;
				lblAmbiantLight.setStyle("fontSize",9);
				lblAmbiantLight.setStyle("textAlign","center");
				lblAmbiantLight.percentWidth=80;
				cnvs.addChild(lblAmbiantLight);
				
				AmbiantLight.id="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.name="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				AmbiantLight.allowTrackClick=true;
				AmbiantLight.allowThumbOverlap=true;
				AmbiantLight.liveDragging=true;
				AmbiantLight.showDataTip=true;
				AmbiantLight.setStyle("dataTipPlacement","bottom");
				AmbiantLight.setStyle("dataTipOffset",3);
				AmbiantLight.setStyle("showTrackHighlight",true);
				AmbiantLight.thumbCount=1;
				AmbiantLight.percentWidth=80;
				AmbiantLight.addEventListener(Event.CHANGE, refreshChartEvent);
				AmbiantLight.snapInterval=0.01;
				AmbiantLight.minimum=0;
				AmbiantLight.maximum=1;
				AmbiantLight.values=[0.1];
				AmbiantLight.x=3;
				AmbiantLight.y=650;
				cnvs.addChild(AmbiantLight);
				
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=670;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=680;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				break; 
			case "Column3D" : 
				lblForm.id="cnvs"+accordionIndex+"_lblForm";
				lblForm.name="cnvs"+accordionIndex+"_lblForm";
				lblForm.x=3;
				lblForm.y=36;
				lblForm.text="Form :"
				cnvs.addChild(lblForm);
				
				cbForm.id="cnvs"+accordionIndex+"_cbForm";
				cbForm.name="cnvs"+accordionIndex+"_cbForm";
				cbForm.dataProvider=myChart.chart.(@Type=="Column3D").Properties.Property.Forms.Form;
				cbForm.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbForm.x=73;
				cbForm.y=34;
				cbForm.width=160;
				cnvs.addChild(cbForm);
				
		    	lblDisplay.id="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.name="cnvs"+accordionIndex+"_lblDisplay";
				lblDisplay.text= "Display :";
				lblDisplay.y=62;
				lblDisplay.x=3;
				cnvs.addChild(lblDisplay);
				
				cbDisplay.id="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.name="cnvs"+accordionIndex+"_cbDisplay";
				cbDisplay.addEventListener(Event.CHANGE, refreshChartEvent);
				cbDisplay.dataProvider=myChart.chart.(@Type=="Column3D").Properties.Property.barTypes.barType;
				cbDisplay.x=73;
				cbDisplay.y=60;
				cnvs.addChild(cbDisplay);
				
				hrChartType.x=13;
				hrChartType.y=89;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=95;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=117;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=131;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=161;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=145;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=166;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=188;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=186;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=282;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=280;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=214;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Column3D").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); 
				cbxAxisType.x=73;
				cbxAxisType.y=219;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=244;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=242;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=260;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=309;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Column3D").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); 
				cbyAxisType.x=73;
				cbyAxisType.y=306;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=336;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=334;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=357;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hr3D.name="cnvs"+accordionIndex+"_hr3D";
				hr3D.id="cnvs"+accordionIndex+"_hr3D";
				hr3D.x=10;
				hr3D.y=384;
				hr3D.width=210;
				cnvs.addChild(hr3D);
				
				lblElevation.id="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.name="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.text= "Elevation";
				lblElevation.x=3;
				lblElevation.y=390;
				lblElevation.setStyle("fontSize",9);
				lblElevation.setStyle("textAlign","center");
				lblElevation.percentWidth=80;
				cnvs.addChild(lblElevation);
				
				Elevation.id="cnvs"+accordionIndex+"_Elevation";
				Elevation.name="cnvs"+accordionIndex+"_Elevation";
				Elevation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Elevation.allowTrackClick=true;
				Elevation.allowThumbOverlap=true;
				Elevation.liveDragging=true;
				Elevation.showDataTip=true;
				Elevation.setStyle("dataTipPlacement","bottom");
				Elevation.setStyle("dataTipOffset",3);
				Elevation.setStyle("showTrackHighlight",true);
				Elevation.thumbCount=1;
				Elevation.percentWidth=80;
				Elevation.addEventListener(Event.CHANGE, refreshChartEvent);
				Elevation.snapInterval=.01;
				Elevation.minimum=-90;
				Elevation.maximum=90;
				Elevation.values=[45];
				Elevation.x=3;
				Elevation.y=405;
				cnvs.addChild(Elevation);
				
				lblRotation.id="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.name="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.text= "Rotation";
				lblRotation.x=3;
				lblRotation.y=425;
				lblRotation.setStyle("fontSize",9);
				lblRotation.setStyle("textAlign","center");
				lblRotation.percentWidth=80;
				cnvs.addChild(lblRotation);
				
				Rotation.id="cnvs"+accordionIndex+"_Rotation";
				Rotation.name="cnvs"+accordionIndex+"_Rotation";
				Rotation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Rotation.allowTrackClick=true;
				Rotation.allowThumbOverlap=true;
				Rotation.liveDragging=true;
				Rotation.showDataTip=true;
				Rotation.setStyle("dataTipPlacement","bottom");
				Rotation.setStyle("dataTipOffset",3);
				Rotation.setStyle("showTrackHighlight",true);
				Rotation.thumbCount=1;
				Rotation.percentWidth=80;
				Rotation.addEventListener(Event.CHANGE, refreshChartEvent);
				Rotation.snapInterval=.01;
				Rotation.minimum=-90;
				Rotation.maximum=90;
				Rotation.values=[45];
				Rotation.x=3;
				Rotation.y=440;
				cnvs.addChild(Rotation);
				
				lblZoom.id="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.name="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.text= "Zoom";
				lblZoom.x=3;
				lblZoom.y=460;
				lblZoom.setStyle("fontSize",9);
				lblZoom.setStyle("textAlign","center");
				lblZoom.percentWidth=80;
				cnvs.addChild(lblZoom);
				
				Zoom.id="cnvs"+accordionIndex+"_Zoom";
				Zoom.name="cnvs"+accordionIndex+"_Zoom";
				Zoom.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Zoom.allowTrackClick=true;
				Zoom.allowThumbOverlap=true;
				Zoom.liveDragging=true;
				Zoom.showDataTip=true;
				Zoom.setStyle("dataTipPlacement","bottom");
				Zoom.setStyle("dataTipOffset",3);
				Zoom.setStyle("showTrackHighlight",true);
				Zoom.thumbCount=1;
				Zoom.percentWidth=80;
				Zoom.addEventListener(Event.CHANGE, refreshChartEvent);
				Zoom.snapInterval=.01;
				Zoom.minimum=0.50;
				Zoom.maximum=2;
				Zoom.values=[1];
				Zoom.x=3;
				Zoom.y=475;
				cnvs.addChild(Zoom);
				
				lblDepth.id="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.name="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.text= "Depth";
				lblDepth.x=3;
				lblDepth.y=495;
				lblDepth.setStyle("fontSize",9);
				lblDepth.setStyle("textAlign","center");
				lblDepth.percentWidth=80;
				cnvs.addChild(lblDepth);
				
				Depth.id="cnvs"+accordionIndex+"_Depth";
				Depth.name="cnvs"+accordionIndex+"_Depth";
				Depth.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Depth.allowTrackClick=true;
				Depth.allowThumbOverlap=true;
				Depth.liveDragging=true;
				Depth.showDataTip=true;
				Depth.setStyle("dataTipPlacement","bottom");
				Depth.setStyle("dataTipOffset",3);
				Depth.setStyle("showTrackHighlight",true);
				Depth.thumbCount=1;
				Depth.percentWidth=80;
				Depth.addEventListener(Event.CHANGE, refreshChartEvent);
				Depth.snapInterval=.1;
				Depth.minimum=1;
				Depth.maximum=100;
				Depth.values=[20];
				Depth.x=3;
				Depth.y=510;
				cnvs.addChild(Depth);
				
				lblDepthGap.id="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.name="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.text= "Depth Gap";
				lblDepthGap.x=3;
				lblDepthGap.y=530;
				lblDepthGap.setStyle("fontSize",9);
				lblDepthGap.setStyle("textAlign","center");
				lblDepthGap.percentWidth=80;
				cnvs.addChild(lblDepthGap);
				
				DepthGap.id="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.name="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				DepthGap.allowTrackClick=true;
				DepthGap.allowThumbOverlap=true;
				DepthGap.liveDragging=true;
				DepthGap.showDataTip=true;
				DepthGap.setStyle("dataTipPlacement","bottom");
				DepthGap.setStyle("dataTipOffset",3);
				DepthGap.setStyle("showTrackHighlight",true);
				DepthGap.thumbCount=1;
				DepthGap.percentWidth=80;
				DepthGap.addEventListener(Event.CHANGE, refreshChartEvent);
				DepthGap.snapInterval=.1;
				DepthGap.minimum=0;
				DepthGap.maximum=20;
				DepthGap.values=[0];
				DepthGap.x=3;
				DepthGap.y=545;
				cnvs.addChild(DepthGap);
				
				lblLightLatitude.id="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.name="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.text= "Light Latitude";
				lblLightLatitude.x=3;
				lblLightLatitude.y=565;
				lblLightLatitude.setStyle("fontSize",9);
				lblLightLatitude.setStyle("textAlign","center");
				lblLightLatitude.percentWidth=80;
				cnvs.addChild(lblLightLatitude);
				
				LightLatitude.id="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.name="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLatitude.allowTrackClick=true;
				LightLatitude.allowThumbOverlap=true;
				LightLatitude.liveDragging=true;
				LightLatitude.showDataTip=true;
				LightLatitude.setStyle("dataTipPlacement","bottom");
				LightLatitude.setStyle("dataTipOffset",3);
				LightLatitude.setStyle("showTrackHighlight",true);
				LightLatitude.thumbCount=1;
				LightLatitude.percentWidth=80;
				LightLatitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLatitude.snapInterval=.1;
				LightLatitude.minimum=-90;
				LightLatitude.maximum=+90;
				LightLatitude.values=[0];
				LightLatitude.x=3;
				LightLatitude.y=580;
				cnvs.addChild(LightLatitude);
				
				lblLightLongitude.id="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.name="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.text= "Light Latitude";
				lblLightLongitude.x=3;
				lblLightLongitude.y=600;
				lblLightLongitude.setStyle("fontSize",9);
				lblLightLongitude.setStyle("textAlign","center");
				lblLightLongitude.percentWidth=80;
				cnvs.addChild(lblLightLongitude);
				
				LightLongitude.id="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.name="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLongitude.allowTrackClick=true;
				LightLongitude.allowThumbOverlap=true;
				LightLongitude.liveDragging=true;
				LightLongitude.showDataTip=true;
				LightLongitude.setStyle("dataTipPlacement","bottom");
				LightLongitude.setStyle("dataTipOffset",3);
				LightLongitude.setStyle("showTrackHighlight",true);
				LightLongitude.thumbCount=1;
				LightLongitude.percentWidth=80;
				LightLongitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLongitude.snapInterval=.1;
				LightLongitude.minimum=-90;
				LightLongitude.maximum=90;
				LightLongitude.values=[0];
				LightLongitude.x=3;
				LightLongitude.y=615;
				cnvs.addChild(LightLongitude);
				
				lblAmbiantLight.id="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.name="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.text= "Light Latitude";
				lblAmbiantLight.x=3;
				lblAmbiantLight.y=635;
				lblAmbiantLight.setStyle("fontSize",9);
				lblAmbiantLight.setStyle("textAlign","center");
				lblAmbiantLight.percentWidth=80;
				cnvs.addChild(lblAmbiantLight);
				
				AmbiantLight.id="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.name="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				AmbiantLight.allowTrackClick=true;
				AmbiantLight.allowThumbOverlap=true;
				AmbiantLight.liveDragging=true;
				AmbiantLight.showDataTip=true;
				AmbiantLight.setStyle("dataTipPlacement","bottom");
				AmbiantLight.setStyle("dataTipOffset",3);
				AmbiantLight.setStyle("showTrackHighlight",true);
				AmbiantLight.thumbCount=1;
				AmbiantLight.percentWidth=80;
				AmbiantLight.addEventListener(Event.CHANGE, refreshChartEvent);
				AmbiantLight.snapInterval=0.01;
				AmbiantLight.minimum=0;
				AmbiantLight.maximum=1;
				AmbiantLight.values=[0.1];
				AmbiantLight.x=3;
				AmbiantLight.y=650;
				cnvs.addChild(AmbiantLight);
				
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=670;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=680;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				
				break;
				case "Line3D" : 
		    	lblForm.id="cnvs"+accordionIndex+"_lblForm";
				lblForm.name="cnvs"+accordionIndex+"_lblForm";
				lblForm.x=3;
				lblForm.y=36;
				lblForm.text="Form :"
				cnvs.addChild(lblForm);
				
				
				cbForm.id="cnvs"+accordionIndex+"_cbForm";
				cbForm.name="cnvs"+accordionIndex+"_cbForm";
				cbForm.dataProvider=myChart.chart.(@Type=="Line3D").Properties.Property.Forms.Form;
				cbForm.addEventListener(Event.CHANGE, refreshChartEvent); 
				cbForm.x=73;
				cbForm.y=34;
				cbForm.width=160;
				cnvs.addChild(cbForm);
				
				hrChartType.x=13;
				hrChartType.y=63;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=69;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=91;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
				chkGrid.x=10;
				chkGrid.y=113;
				chkGrid.label="Show Grid";
				chkGrid.id="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.name="cnvs"+accordionIndex+"_chkGrid";
				chkGrid.enabled=true;
				chkGrid.selected=false;
				chkGrid.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkGrid);
				
				hrSel.x=13;
				hrSel.y=135;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=139;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				cp.id="cnvs"+accordionIndex+"_cp1";
				cp.name="cnvs"+accordionIndex+"_cp1";
				cp.y=140;
				cp.x=53;
				cp.width=17;
				cp.height=17;
				cp.selectedColor=0x6699CC;
				cp.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(cp);
		
				lblxAxis.id="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.name="cnvs"+accordionIndex+"_lblxAxis1";
				lblxAxis.x=3;
				lblxAxis.y=162;
				lblxAxis.text="xAxis :";
				cnvs.addChild(lblxAxis);
				
				cbxAxis.id="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.name="cnvs"+accordionIndex+"_cbxAxis1";
				cbxAxis.dataProvider=arrAxis;
				cbxAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbxAxis.prompt="Select...";
				cbxAxis.x=73;
				cbxAxis.y=160;
				cnvs.addChild(cbxAxis);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=256;
				lblyAxis.text="yAxis :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=254;
				cnvs.addChild(cbyAxis);
				
				lblxAxisType.id="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.name="cnvs"+accordionIndex+"_lblxAxisType1";
				lblxAxisType.x=3;
				lblxAxisType.y=188;
				lblxAxisType.text="xAxisType :";
				cnvs.addChild(lblxAxisType);
				
				cbxAxisType.id="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.name="cnvs"+accordionIndex+"_cbxAxisType1";
				cbxAxisType.dataProvider=myChart.chart.(@Type=="Line3D").Properties.Property.axis;
				cbxAxisType.addEventListener(Event.CHANGE, xAxisTypeChange); //parentDocument.
				cbxAxisType.x=73;
				cbxAxisType.y=187;
				cnvs.addChild(cbxAxisType);
				
				lblxInterval1.id="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.name="cnvs"+accordionIndex+"_lblxInterval1";
				lblxInterval1.text= "Interval :";
				lblxInterval1.y=219;
				lblxInterval1.x=150;
				lblxInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblxInterval1);
				
				txtxInterval.id="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.name="cnvs"+accordionIndex+"_txtxInterval1";
				txtxInterval.x=197;
				txtxInterval.y=216;
				txtxInterval.width=36;
				txtxInterval.setStyle("color", 0xCCCCCC);
				txtxInterval.alpha=0.3;
				txtxInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtxInterval);
				
				HBoxMinMaxx.id="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.name="cnvs"+accordionIndex+"_HBoxMinMaxx";
				HBoxMinMaxx.x=4;
				HBoxMinMaxx.y=234;
				HBoxMinMaxx.percentWidth=100
				cnvs.addChild(HBoxMinMaxx);
				
				lblxMin.id="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.name="cnvs"+accordionIndex+"_lblxMin1";
				lblxMin.text= "min";
				lblxMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMin);
				
				minMaxxSlider.id="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.name="cnvs"+accordionIndex+"_minMaxxSlider";
				minMaxxSlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxxSlider.allowTrackClick=true;
				minMaxxSlider.allowThumbOverlap=true;
				minMaxxSlider.liveDragging=true;
				minMaxxSlider.showDataTip=true;
				minMaxxSlider.setStyle("dataTipPlacement","bottom");
				minMaxxSlider.setStyle("dataTipOffset",3);
				minMaxxSlider.setStyle("showTrackHighlight",true);
				minMaxxSlider.thumbCount=2;
				minMaxxSlider.percentWidth=100;
				minMaxxSlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxxSlider.snapInterval=0.1;
				minMaxxSlider.setStyle("color", 0xCCCCCC);
				minMaxxSlider.alpha=0.3;
				//minMaxxSlider.maximum=maxxSlideValue;
				minMaxxSlider.values=[0, 0];//maxxSlideDefault
				HBoxMinMaxx.addChild(minMaxxSlider);
				
				lblxMax.id="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.name="cnvs"+accordionIndex+"_lblxMax1";
				lblxMax.text= "max";
				lblxMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxx.addChild(lblxMax);
				
				lblyAxisType.id="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.name="cnvs"+accordionIndex+"_lblyAxisType1";
				lblyAxisType.x=3;
				lblyAxisType.y=283;
				lblyAxisType.text="yAxisType :";
				cnvs.addChild(lblyAxisType);
				
				cbyAxisType.id="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.name="cnvs"+accordionIndex+"_cbyAxisType1";
				cbyAxisType.dataProvider=myChart.chart.(@Type=="Line").Properties.Property.axis;
				cbyAxisType.addEventListener(Event.CHANGE, yAxisTypeChange); //parentDocument.
				cbyAxisType.x=73;
				cbyAxisType.y=280;
				cnvs.addChild(cbyAxisType);
				
				lblyInterval1.id="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.name="cnvs"+accordionIndex+"_lblyInterval1";
				lblyInterval1.text= "Interval :";
				lblyInterval1.y=310;
				lblyInterval1.x=150;
				lblyInterval1.setStyle("color", 0xCCCCCC);
				cnvs.addChild(lblyInterval1);
				
				txtyInterval.id="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.name="cnvs"+accordionIndex+"_txtyInterval1";
				txtyInterval.x=197;
				txtyInterval.y=308;
				txtyInterval.width=36;
				txtyInterval.setStyle("color", 0xCCCCCC);
				txtyInterval.alpha=0.3;
				txtyInterval.addEventListener(Event.CHANGE, refreshChartEvent);
				cnvs.addChild(txtyInterval);
				
				HBoxMinMaxy.id="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.name="cnvs"+accordionIndex+"_HBoxMinMaxy";
				HBoxMinMaxy.x=4;
				HBoxMinMaxy.y=331;
				HBoxMinMaxy.percentWidth=100;
				cnvs.addChild(HBoxMinMaxy);
				
				lblyMin.id="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.name="cnvs"+accordionIndex+"_lblyMin1";
				lblyMin.text= "min";
				lblyMin.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMin);
				
				minMaxySlider.id="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.name="cnvs"+accordionIndex+"_minMaxySlider";
				minMaxySlider.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				minMaxySlider.allowTrackClick=true;
				minMaxySlider.allowThumbOverlap=true;
				minMaxySlider.liveDragging=true;
				minMaxySlider.showDataTip=true;
				minMaxySlider.setStyle("dataTipPlacement","bottom");
				minMaxySlider.setStyle("dataTipOffset",3);
				minMaxySlider.setStyle("showTrackHighlight",true);
				minMaxySlider.thumbCount=2;
				minMaxySlider.percentWidth=100;
				minMaxySlider.addEventListener(Event.CHANGE, refreshChartEvent);
				minMaxySlider.snapInterval=0.1;
				minMaxySlider.setStyle("color", 0xCCCCCC);
				minMaxySlider.alpha=0.3;
				//minMaxySlider.minimum=0;
				//minMaxySlider.maximum=maxySlideValue;
				minMaxySlider.values=[0, 0];//maxySlideDefault
				HBoxMinMaxy.addChild(minMaxySlider);
				
				lblyMax.id="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.name="cnvs"+accordionIndex+"_lblyMax1";
				lblyMax.text= "max";
				lblyMax.setStyle("color", 0xCCCCCC);
				HBoxMinMaxy.addChild(lblyMax);
				
				hr3D.name="cnvs"+accordionIndex+"_hr3D";
				hr3D.id="cnvs"+accordionIndex+"_hr3D";
				hr3D.x=10;
				hr3D.y=359;
				hr3D.width=210;
				cnvs.addChild(hr3D);
				
				lblElevation.id="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.name="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.text= "Elevation";
				lblElevation.x=3;
				lblElevation.y=364;
				lblElevation.setStyle("fontSize",9);
				lblElevation.setStyle("textAlign","center");
				lblElevation.percentWidth=80;
				cnvs.addChild(lblElevation);
				
				Elevation.id="cnvs"+accordionIndex+"_Elevation";
				Elevation.name="cnvs"+accordionIndex+"_Elevation";
				Elevation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Elevation.allowTrackClick=true;
				Elevation.allowThumbOverlap=true;
				Elevation.liveDragging=true;
				Elevation.showDataTip=true;
				Elevation.setStyle("dataTipPlacement","bottom");
				Elevation.setStyle("dataTipOffset",3);
				Elevation.setStyle("showTrackHighlight",true);
				Elevation.thumbCount=1;
				Elevation.percentWidth=80;
				Elevation.addEventListener(Event.CHANGE, refreshChartEvent);
				Elevation.snapInterval=.01;
				Elevation.minimum=-90;
				Elevation.maximum=90;
				Elevation.values=[45];
				Elevation.x=3;
				Elevation.y=379;
				cnvs.addChild(Elevation);
				
				lblRotation.id="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.name="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.text= "Rotation";
				lblRotation.x=3;
				lblRotation.y=399;
				lblRotation.setStyle("fontSize",9);
				lblRotation.setStyle("textAlign","center");
				lblRotation.percentWidth=80;
				cnvs.addChild(lblRotation);
				
				Rotation.id="cnvs"+accordionIndex+"_Rotation";
				Rotation.name="cnvs"+accordionIndex+"_Rotation";
				Rotation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Rotation.allowTrackClick=true;
				Rotation.allowThumbOverlap=true;
				Rotation.liveDragging=true;
				Rotation.showDataTip=true;
				Rotation.setStyle("dataTipPlacement","bottom");
				Rotation.setStyle("dataTipOffset",3);
				Rotation.setStyle("showTrackHighlight",true);
				Rotation.thumbCount=1;
				Rotation.percentWidth=80;
				Rotation.addEventListener(Event.CHANGE, refreshChartEvent);
				Rotation.snapInterval=.01;
				Rotation.minimum=-90;
				Rotation.maximum=90;
				Rotation.values=[45];
				Rotation.x=3;
				Rotation.y=414;
				cnvs.addChild(Rotation);
				
				lblZoom.id="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.name="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.text= "Zoom";
				lblZoom.x=3;
				lblZoom.y=434;
				lblZoom.setStyle("fontSize",9);
				lblZoom.setStyle("textAlign","center");
				lblZoom.percentWidth=80;
				cnvs.addChild(lblZoom);
				
				Zoom.id="cnvs"+accordionIndex+"_Zoom";
				Zoom.name="cnvs"+accordionIndex+"_Zoom";
				Zoom.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Zoom.allowTrackClick=true;
				Zoom.allowThumbOverlap=true;
				Zoom.liveDragging=true;
				Zoom.showDataTip=true;
				Zoom.setStyle("dataTipPlacement","bottom");
				Zoom.setStyle("dataTipOffset",3);
				Zoom.setStyle("showTrackHighlight",true);
				Zoom.thumbCount=1;
				Zoom.percentWidth=80;
				Zoom.addEventListener(Event.CHANGE, refreshChartEvent);
				Zoom.snapInterval=.01;
				Zoom.minimum=0.50;
				Zoom.maximum=2;
				Zoom.values=[1];
				Zoom.x=3;
				Zoom.y=449;
				cnvs.addChild(Zoom);
				
				lblDepth.id="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.name="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.text= "Depth";
				lblDepth.x=3;
				lblDepth.y=469;
				lblDepth.setStyle("fontSize",9);
				lblDepth.setStyle("textAlign","center");
				lblDepth.percentWidth=80;
				cnvs.addChild(lblDepth);
				
				Depth.id="cnvs"+accordionIndex+"_Depth";
				Depth.name="cnvs"+accordionIndex+"_Depth";
				Depth.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Depth.allowTrackClick=true;
				Depth.allowThumbOverlap=true;
				Depth.liveDragging=true;
				Depth.showDataTip=true;
				Depth.setStyle("dataTipPlacement","bottom");
				Depth.setStyle("dataTipOffset",3);
				Depth.setStyle("showTrackHighlight",true);
				Depth.thumbCount=1;
				Depth.percentWidth=80;
				Depth.addEventListener(Event.CHANGE, refreshChartEvent);
				Depth.snapInterval=.1;
				Depth.minimum=1;
				Depth.maximum=100;
				Depth.values=[20];
				Depth.x=3;
				Depth.y=484;
				cnvs.addChild(Depth);
				
				lblDepthGap.id="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.name="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.text= "Depth Gap";
				lblDepthGap.x=3;
				lblDepthGap.y=504;
				lblDepthGap.setStyle("fontSize",9);
				lblDepthGap.setStyle("textAlign","center");
				lblDepthGap.percentWidth=80;
				cnvs.addChild(lblDepthGap);
				
				DepthGap.id="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.name="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				DepthGap.allowTrackClick=true;
				DepthGap.allowThumbOverlap=true;
				DepthGap.liveDragging=true;
				DepthGap.showDataTip=true;
				DepthGap.setStyle("dataTipPlacement","bottom");
				DepthGap.setStyle("dataTipOffset",3);
				DepthGap.setStyle("showTrackHighlight",true);
				DepthGap.thumbCount=1;
				DepthGap.percentWidth=80;
				DepthGap.addEventListener(Event.CHANGE, refreshChartEvent);
				DepthGap.snapInterval=.1;
				DepthGap.minimum=0;
				DepthGap.maximum=20;
				DepthGap.values=[0];
				DepthGap.x=3;
				DepthGap.y=519;
				cnvs.addChild(DepthGap);
				
				lblLightLatitude.id="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.name="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.text= "Light Latitude";
				lblLightLatitude.x=3;
				lblLightLatitude.y=539;
				lblLightLatitude.setStyle("fontSize",9);
				lblLightLatitude.setStyle("textAlign","center");
				lblLightLatitude.percentWidth=80;
				cnvs.addChild(lblLightLatitude);
				
				LightLatitude.id="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.name="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLatitude.allowTrackClick=true;
				LightLatitude.allowThumbOverlap=true;
				LightLatitude.liveDragging=true;
				LightLatitude.showDataTip=true;
				LightLatitude.setStyle("dataTipPlacement","bottom");
				LightLatitude.setStyle("dataTipOffset",3);
				LightLatitude.setStyle("showTrackHighlight",true);
				LightLatitude.thumbCount=1;
				LightLatitude.percentWidth=80;
				LightLatitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLatitude.snapInterval=.1;
				LightLatitude.minimum=-90;
				LightLatitude.maximum=+90;
				LightLatitude.values=[0];
				LightLatitude.x=3;
				LightLatitude.y=554;
				cnvs.addChild(LightLatitude);
				
				lblLightLongitude.id="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.name="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.text= "Light Latitude";
				lblLightLongitude.x=3;
				lblLightLongitude.y=574;
				lblLightLongitude.setStyle("fontSize",9);
				lblLightLongitude.setStyle("textAlign","center");
				lblLightLongitude.percentWidth=80;
				cnvs.addChild(lblLightLongitude);
				
				LightLongitude.id="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.name="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLongitude.allowTrackClick=true;
				LightLongitude.allowThumbOverlap=true;
				LightLongitude.liveDragging=true;
				LightLongitude.showDataTip=true;
				LightLongitude.setStyle("dataTipPlacement","bottom");
				LightLongitude.setStyle("dataTipOffset",3);
				LightLongitude.setStyle("showTrackHighlight",true);
				LightLongitude.thumbCount=1;
				LightLongitude.percentWidth=80;
				LightLongitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLongitude.snapInterval=.1;
				LightLongitude.minimum=-90;
				LightLongitude.maximum=90;
				LightLongitude.values=[0];
				LightLongitude.x=3;
				LightLongitude.y=589;
				cnvs.addChild(LightLongitude);
				
				lblAmbiantLight.id="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.name="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.text= "Light Latitude";
				lblAmbiantLight.x=3;
				lblAmbiantLight.y=609;
				lblAmbiantLight.setStyle("fontSize",9);
				lblAmbiantLight.setStyle("textAlign","center");
				lblAmbiantLight.percentWidth=80;
				cnvs.addChild(lblAmbiantLight);
				
				AmbiantLight.id="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.name="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				AmbiantLight.allowTrackClick=true;
				AmbiantLight.allowThumbOverlap=true;
				AmbiantLight.liveDragging=true;
				AmbiantLight.showDataTip=true;
				AmbiantLight.setStyle("dataTipPlacement","bottom");
				AmbiantLight.setStyle("dataTipOffset",3);
				AmbiantLight.setStyle("showTrackHighlight",true);
				AmbiantLight.thumbCount=1;
				AmbiantLight.percentWidth=80;
				AmbiantLight.addEventListener(Event.CHANGE, refreshChartEvent);
				AmbiantLight.snapInterval=0.01;
				AmbiantLight.minimum=0;
				AmbiantLight.maximum=1;
				AmbiantLight.values=[0.1];
				AmbiantLight.x=3;
				AmbiantLight.y=624;
				cnvs.addChild(AmbiantLight);
				
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=644;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=654;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
				break; 
		    case "Pie3D" : 
		    	hrChartType.x=13;
				hrChartType.y=36;
				hrChartType.width=210;
				cnvs.addChild(hrChartType);
				
				chkDataType.x=10;
				chkDataType.y=45;
				chkDataType.label="Show DataTips";
				chkDataType.id="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.name="cnvs"+accordionIndex+"_chkDataType";
				chkDataType.enabled=true;
				chkDataType.selected=true;
				chkDataType.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkDataType);
				
				chkLegend.x=10;
				chkLegend.y=67;
				chkLegend.label="Show Legend";
				chkLegend.id="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.name="cnvs"+accordionIndex+"_chkLegend";
				chkLegend.enabled=true;
				chkLegend.selected=true;
				chkLegend.addEventListener(MouseEvent.CLICK, refreshChartEvent);
				cnvs.addChild(chkLegend);
				
		    	hrSel.x=13;
				hrSel.y=89;
				hrSel.width=210;
				hrSel.height=1;
				cnvs.addChild(hrSel);
				
				lblSerie.id="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.name="cnvs"+accordionIndex+"_lblSelectData";
				lblSerie.x=3;
				lblSerie.y=93;
				lblSerie.width=139;
				lblSerie.text="Serie 1 :";
				cnvs.addChild(lblSerie);
				
				lblyAxis.id="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.name="cnvs"+accordionIndex+"_lblyAxis1";
				lblyAxis.x=3;
				lblyAxis.y=115;
				lblyAxis.text="Field :";
				cnvs.addChild(lblyAxis);
				
				cbyAxis.id="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.name="cnvs"+accordionIndex+"_cbyAxis1";
				cbyAxis.dataProvider=arrAxis;
				cbyAxis.addEventListener(Event.CHANGE, refreshChartEvent);
				cbyAxis.prompt="Select...";
				cbyAxis.x=73;
				cbyAxis.y=115;
				cnvs.addChild(cbyAxis);
				
		    lblExplode.id="cnvs"+accordionIndex+"_lblExplode";
				lblExplode.name="cnvs"+accordionIndex+"_lblExplode";
				lblExplode.text= "Distance of Separation";
				lblExplode.x=3;
				lblExplode.y=147;
				lblExplode.setStyle("fontSize",9);
				lblExplode.setStyle("textAlign","center");
				lblExplode.percentWidth=100;
				cnvs.addChild(lblExplode);
				
				PieExplode.id="cnvs"+accordionIndex+"_PieExplode";
				PieExplode.name="cnvs"+accordionIndex+"_PieExplode";
				PieExplode.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				PieExplode.allowTrackClick=true;
				PieExplode.allowThumbOverlap=true;
				PieExplode.liveDragging=true;
				PieExplode.showDataTip=true;
				PieExplode.setStyle("dataTipPlacement","bottom");
				PieExplode.setStyle("dataTipOffset",3);
				PieExplode.setStyle("showTrackHighlight",true);
				PieExplode.thumbCount=1;
				PieExplode.percentWidth=100;
				PieExplode.addEventListener(Event.CHANGE, refreshChartEvent);
				PieExplode.snapInterval=.01;
				PieExplode.minimum=0;
				PieExplode.maximum=1;
				PieExplode.values=[0];
				PieExplode.x=3;
				PieExplode.y=155;
				cnvs.addChild(PieExplode);
				
				lblAngle.id="cnvs"+accordionIndex+"_lblAngle";
				lblAngle.name="cnvs"+accordionIndex+"_lblAngle";
				lblAngle.text= "Angle of rotation";
				lblAngle.x=3;
				lblAngle.y=175;
				lblAngle.setStyle("fontSize",9);
				lblAngle.setStyle("textAlign","center");
				lblAngle.percentWidth=100;
				cnvs.addChild(lblAngle);
				
				PieAngle.id="cnvs"+accordionIndex+"_PieAngle";
				PieAngle.name="cnvs"+accordionIndex+"_PieAngle";
				PieAngle.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				PieAngle.allowTrackClick=true;
				PieAngle.allowThumbOverlap=true;
				PieAngle.liveDragging=true;
				PieAngle.showDataTip=true;
				PieAngle.setStyle("dataTipPlacement","bottom");
				PieAngle.setStyle("dataTipOffset",3);
				PieAngle.setStyle("showTrackHighlight",true);
				PieAngle.thumbCount=1;
				PieAngle.percentWidth=100;
				PieAngle.addEventListener(Event.CHANGE, refreshChartEvent);
				PieAngle.snapInterval=1;
				PieAngle.minimum=0;
				PieAngle.maximum=360;
				PieAngle.values=[0];
				PieAngle.x=3;
				PieAngle.y=183;
				PieAngle.dataTipFormatFunction=degrees_func
				cnvs.addChild(PieAngle);
				
				lblDonuts.id="cnvs"+accordionIndex+"_lblDonuts";
				lblDonuts.name="cnvs"+accordionIndex+"_lblDonuts";
				lblDonuts.text= "Donuts";
				lblDonuts.x=3;
				lblDonuts.y=203;
				lblDonuts.setStyle("fontSize",9);
				lblDonuts.setStyle("textAlign","center");
				lblDonuts.percentWidth=100;
				cnvs.addChild(lblDonuts);
				
				PieDonuts.id="cnvs"+accordionIndex+"_PieDonuts";
				PieDonuts.name="cnvs"+accordionIndex+"_PieDonuts";
				PieDonuts.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				PieDonuts.allowTrackClick=true;
				PieDonuts.allowThumbOverlap=true;
				PieDonuts.liveDragging=true;
				PieDonuts.showDataTip=true;
				PieDonuts.setStyle("dataTipPlacement","bottom");
				PieDonuts.setStyle("dataTipOffset",3);
				PieDonuts.setStyle("showTrackHighlight",true);
				PieDonuts.thumbCount=1;
				PieDonuts.percentWidth=100;
				PieDonuts.addEventListener(Event.CHANGE, refreshChartEvent);
				PieDonuts.snapInterval=0.01;
				PieDonuts.minimum=0;
				PieDonuts.maximum=1;
				PieDonuts.values=[0];
				PieDonuts.x=3;
				PieDonuts.y=211;
				cnvs.addChild(PieDonuts);
				
				lblLabelPosition.id="cnvs"+accordionIndex+"_lblLabelPosition";
				lblLabelPosition.name="cnvs"+accordionIndex+"_lblLabelPosition";
				lblLabelPosition.text= "Label Position :";
				lblLabelPosition.y=239;
				lblLabelPosition.x=3;
				cnvs.addChild(lblLabelPosition);
				
				cbLabelPosition.id="cnvs"+accordionIndex+"_cbLabelPosition";
				cbLabelPosition.name="cnvs"+accordionIndex+"_cbLabelPosition";
				cbLabelPosition.addEventListener(Event.CHANGE, refreshChartEvent);
				cbLabelPosition.dataProvider=myChart.chart.(@Type=="Pie3D").Properties.Property.labelPosition.value;
				cbLabelPosition.x=95;
				cbLabelPosition.y=239;
				cnvs.addChild(cbLabelPosition);
				
				hr3D.name="cnvs"+accordionIndex+"_hr3D";
				hr3D.id="cnvs"+accordionIndex+"_hr3D";
				hr3D.x=10;
				hr3D.y=267;
				hr3D.width=210;
				cnvs.addChild(hr3D);
				
				lblElevation.id="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.name="cnvs"+accordionIndex+"_lblElevation";
				lblElevation.text= "Elevation";
				lblElevation.x=3;
				lblElevation.y=272;
				lblElevation.setStyle("fontSize",9);
				lblElevation.setStyle("textAlign","center");
				lblElevation.percentWidth=80;
				cnvs.addChild(lblElevation);
				
				Elevation.id="cnvs"+accordionIndex+"_Elevation";
				Elevation.name="cnvs"+accordionIndex+"_Elevation";
				Elevation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Elevation.allowTrackClick=true;
				Elevation.allowThumbOverlap=true;
				Elevation.liveDragging=true;
				Elevation.showDataTip=true;
				Elevation.setStyle("dataTipPlacement","bottom");
				Elevation.setStyle("dataTipOffset",3);
				Elevation.setStyle("showTrackHighlight",true);
				Elevation.thumbCount=1;
				Elevation.percentWidth=80;
				Elevation.addEventListener(Event.CHANGE, refreshChartEvent);
				Elevation.snapInterval=.01;
				Elevation.minimum=-90;
				Elevation.maximum=90;
				Elevation.values=[45];
				Elevation.x=3;
				Elevation.y=287;
				cnvs.addChild(Elevation);
				
				lblRotation.id="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.name="cnvs"+accordionIndex+"_lblRotation";
				lblRotation.text= "Rotation";
				lblRotation.x=3;
				lblRotation.y=307;
				lblRotation.setStyle("fontSize",9);
				lblRotation.setStyle("textAlign","center");
				lblRotation.percentWidth=80;
				cnvs.addChild(lblRotation);
				
				Rotation.id="cnvs"+accordionIndex+"_Rotation";
				Rotation.name="cnvs"+accordionIndex+"_Rotation";
				Rotation.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Rotation.allowTrackClick=true;
				Rotation.allowThumbOverlap=true;
				Rotation.liveDragging=true;
				Rotation.showDataTip=true;
				Rotation.setStyle("dataTipPlacement","bottom");
				Rotation.setStyle("dataTipOffset",3);
				Rotation.setStyle("showTrackHighlight",true);
				Rotation.thumbCount=1;
				Rotation.percentWidth=80;
				Rotation.addEventListener(Event.CHANGE, refreshChartEvent);
				Rotation.snapInterval=.01;
				Rotation.minimum=-90;
				Rotation.maximum=90;
				Rotation.values=[45];
				Rotation.x=3;
				Rotation.y=322;
				cnvs.addChild(Rotation);
				
				lblZoom.id="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.name="cnvs"+accordionIndex+"_lblZoom";
				lblZoom.text= "Zoom";
				lblZoom.x=3;
				lblZoom.y=342;
				lblZoom.setStyle("fontSize",9);
				lblZoom.setStyle("textAlign","center");
				lblZoom.percentWidth=80;
				cnvs.addChild(lblZoom);
				
				Zoom.id="cnvs"+accordionIndex+"_Zoom";
				Zoom.name="cnvs"+accordionIndex+"_Zoom";
				Zoom.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Zoom.allowTrackClick=true;
				Zoom.allowThumbOverlap=true;
				Zoom.liveDragging=true;
				Zoom.showDataTip=true;
				Zoom.setStyle("dataTipPlacement","bottom");
				Zoom.setStyle("dataTipOffset",3);
				Zoom.setStyle("showTrackHighlight",true);
				Zoom.thumbCount=1;
				Zoom.percentWidth=80;
				Zoom.addEventListener(Event.CHANGE, refreshChartEvent);
				Zoom.snapInterval=.01;
				Zoom.minimum=0.50;
				Zoom.maximum=2;
				Zoom.values=[1];
				Zoom.x=3;
				Zoom.y=357;
				cnvs.addChild(Zoom);
				
				lblDepth.id="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.name="cnvs"+accordionIndex+"_lblDepth";
				lblDepth.text= "Depth";
				lblDepth.x=3;
				lblDepth.y=377;
				lblDepth.setStyle("fontSize",9);
				lblDepth.setStyle("textAlign","center");
				lblDepth.percentWidth=80;
				cnvs.addChild(lblDepth);
				
				Depth.id="cnvs"+accordionIndex+"_Depth";
				Depth.name="cnvs"+accordionIndex+"_Depth";
				Depth.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				Depth.allowTrackClick=true;
				Depth.allowThumbOverlap=true;
				Depth.liveDragging=true;
				Depth.showDataTip=true;
				Depth.setStyle("dataTipPlacement","bottom");
				Depth.setStyle("dataTipOffset",3);
				Depth.setStyle("showTrackHighlight",true);
				Depth.thumbCount=1;
				Depth.percentWidth=80;
				Depth.addEventListener(Event.CHANGE, refreshChartEvent);
				Depth.snapInterval=.1;
				Depth.minimum=1;
				Depth.maximum=100;
				Depth.values=[20];
				Depth.x=3;
				Depth.y=392;
				cnvs.addChild(Depth);
				
				lblDepthGap.id="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.name="cnvs"+accordionIndex+"_lblDepthGap";
				lblDepthGap.text= "Depth Gap";
				lblDepthGap.x=3;
				lblDepthGap.y=412;
				lblDepthGap.setStyle("fontSize",9);
				lblDepthGap.setStyle("textAlign","center");
				lblDepthGap.percentWidth=80;
				cnvs.addChild(lblDepthGap);
				
				DepthGap.id="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.name="cnvs"+accordionIndex+"_DepthGap";
				DepthGap.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				DepthGap.allowTrackClick=true;
				DepthGap.allowThumbOverlap=true;
				DepthGap.liveDragging=true;
				DepthGap.showDataTip=true;
				DepthGap.setStyle("dataTipPlacement","bottom");
				DepthGap.setStyle("dataTipOffset",3);
				DepthGap.setStyle("showTrackHighlight",true);
				DepthGap.thumbCount=1;
				DepthGap.percentWidth=80;
				DepthGap.addEventListener(Event.CHANGE, refreshChartEvent);
				DepthGap.snapInterval=.1;
				DepthGap.minimum=0;
				DepthGap.maximum=20;
				DepthGap.values=[0];
				DepthGap.x=3;
				DepthGap.y=427;
				cnvs.addChild(DepthGap);
				
				lblLightLatitude.id="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.name="cnvs"+accordionIndex+"_lblLightLatitude";
				lblLightLatitude.text= "Light Latitude";
				lblLightLatitude.x=3;
				lblLightLatitude.y=447;
				lblLightLatitude.setStyle("fontSize",9);
				lblLightLatitude.setStyle("textAlign","center");
				lblLightLatitude.percentWidth=80;
				cnvs.addChild(lblLightLatitude);
				
				LightLatitude.id="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.name="cnvs"+accordionIndex+"_LightLatitude";
				LightLatitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLatitude.allowTrackClick=true;
				LightLatitude.allowThumbOverlap=true;
				LightLatitude.liveDragging=true;
				LightLatitude.showDataTip=true;
				LightLatitude.setStyle("dataTipPlacement","bottom");
				LightLatitude.setStyle("dataTipOffset",3);
				LightLatitude.setStyle("showTrackHighlight",true);
				LightLatitude.thumbCount=1;
				LightLatitude.percentWidth=80;
				LightLatitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLatitude.snapInterval=.1;
				LightLatitude.minimum=-90;
				LightLatitude.maximum=+90;
				LightLatitude.values=[0];
				LightLatitude.x=3;
				LightLatitude.y=462;
				cnvs.addChild(LightLatitude);
				
				lblLightLongitude.id="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.name="cnvs"+accordionIndex+"_lblLightLongitude";
				lblLightLongitude.text= "Light Latitude";
				lblLightLongitude.x=3;
				lblLightLongitude.y=482;
				lblLightLongitude.setStyle("fontSize",9);
				lblLightLongitude.setStyle("textAlign","center");
				lblLightLongitude.percentWidth=80;
				cnvs.addChild(lblLightLongitude);
				
				LightLongitude.id="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.name="cnvs"+accordionIndex+"_LightLongitude";
				LightLongitude.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				LightLongitude.allowTrackClick=true;
				LightLongitude.allowThumbOverlap=true;
				LightLongitude.liveDragging=true;
				LightLongitude.showDataTip=true;
				LightLongitude.setStyle("dataTipPlacement","bottom");
				LightLongitude.setStyle("dataTipOffset",3);
				LightLongitude.setStyle("showTrackHighlight",true);
				LightLongitude.thumbCount=1;
				LightLongitude.percentWidth=80;
				LightLongitude.addEventListener(Event.CHANGE, refreshChartEvent);
				LightLongitude.snapInterval=.1;
				LightLongitude.minimum=-90;
				LightLongitude.maximum=90;
				LightLongitude.values=[0];
				LightLongitude.x=3;
				LightLongitude.y=497;
				cnvs.addChild(LightLongitude);
				
				lblAmbiantLight.id="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.name="cnvs"+accordionIndex+"_lblAmbiantLight";
				lblAmbiantLight.text= "Light Latitude";
				lblAmbiantLight.x=3;
				lblAmbiantLight.y=517;
				lblAmbiantLight.setStyle("fontSize",9);
				lblAmbiantLight.setStyle("textAlign","center");
				lblAmbiantLight.percentWidth=80;
				cnvs.addChild(lblAmbiantLight);
				
				AmbiantLight.id="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.name="cnvs"+accordionIndex+"_AmbiantLight";
				AmbiantLight.setStyle("trackHighlightSkin",flexlib.skins.SliderThumbHighlightSkin);
				AmbiantLight.allowTrackClick=true;
				AmbiantLight.allowThumbOverlap=true;
				AmbiantLight.liveDragging=true;
				AmbiantLight.showDataTip=true;
				AmbiantLight.setStyle("dataTipPlacement","bottom");
				AmbiantLight.setStyle("dataTipOffset",3);
				AmbiantLight.setStyle("showTrackHighlight",true);
				AmbiantLight.thumbCount=1;
				AmbiantLight.percentWidth=80;
				AmbiantLight.addEventListener(Event.CHANGE, refreshChartEvent);
				AmbiantLight.snapInterval=0.01;
				AmbiantLight.minimum=0;
				AmbiantLight.maximum=1;
				AmbiantLight.values=[0.1];
				AmbiantLight.x=3;
				AmbiantLight.y=532;
				cnvs.addChild(AmbiantLight);
				
				
				hrEnd.name="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.id="cnvs"+accordionIndex+"_hrEnd";
				hrEnd.x=10;
				hrEnd.y=552;
				hrEnd.width=210;
				cnvs.addChild(hrEnd);
				
				btnAddSerie.id="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.name="cnvs"+accordionIndex+"_btnAddNewSerie";
				btnAddSerie.x=73;
				btnAddSerie.y=562;
				btnAddSerie.label="Add new serie";
				btnAddSerie.addEventListener(MouseEvent.CLICK, addSeries);
				cnvs.addChild(btnAddSerie);
		        break;  
		}
		drawChart(strChartType);
    }
   