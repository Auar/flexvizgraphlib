// ActionScript file
			
			
			
		// Report code
		
				// Button pop-up menu

		    import mx.containers.TitleWindow;
            import flash.events.*;
            import mx.managers.PopUpManager;
            import mx.controls.Button;
            import mx.core.IFlexDisplayObject;
            
            import org.un.birdeye.report.components.HideShowFields;
            import org.un.birdeye.report.components.QueryBuilder;
            import org.un.birdeye.report.components.HeaderFormat;
           
            
            
			// Query Builder Window
            // Method to instantiate and display a TitleWindow container.
            // This is the initial Button control's click event handler.
            public function openQueryBuilderWindow(event:MouseEvent):void {
                parentDocument.currentState = 'showSideBar';
                parentDocument.sideBarVS.selectedIndex = 0;
                
                    }
            
			// Header Format Window
            // Method to instantiate and display a TitleWindow container.
            // This is the initial Button control's click event handler.
            public function openHeaderFormatWindow(event:MouseEvent):void {
                // Set the TitleWindow container properties.
				parentDocument.currentState = 'showSideBar';
				parentDocument.sideBarVS.selectedIndex = 1;
            }
            
            

        	
        	    
			// Hide/Show Cols Window
            // Method to instantiate and display a TitleWindow container.
            // This is the initial Button control's click event handler.
            public function openHideShowWindow(event:MouseEvent):void {
                // Set the TitleWindow container properties.
               parentDocument.currentState = 'showSideBar';
               parentDocument.sideBarVS.selectedIndex = 3;
            }
            
            // Sparkline Window
            // Method to instantiate and display a TitleWindow container.
            // This is the initial Button control's click event handler.
           
            
            // printPreviewWindow
            
            public function openPrintPreviewWindow(event:MouseEvent):void 
            {
               
                if (parentDocument.printPreviewBtn.selected == true) {
                parentDocument.currentState = 'showSideBar';
                parentDocument.sideBarVS.selectedIndex = 5;
                parentDocument.mainBody.selectedIndex = 1;
                }
                
                else if (parentDocument.printPreviewBtn.selected == false) {
                
                parentDocument.mainBody.selectedIndex = 0;
                parentDocument.currentState = 'hideSideBar';
                }
            }
            
           		
			public function filterModels(event:Event):void
			{
				 // gapAnalysisReport.showRoot = true;
				
				
			}
			
			private function viewHeader(event:Event):void
			{
				 if(headerChkbx.selected == true) {              
                    header.visible = true;
                    header.includeInLayout = true;
                    header.height = 100;
                }
                
                else if (headerChkbx.selected == false)
				{
    				header.visible = false;
    				header.includeInLayout = false;
    				header.height = 0;
				}

			}

			private function viewFooter(event:Event):void
			{
				 if(footerChkbx.selected == true) {              
                    footer.visible = true;
                    footer.includeInLayout = true;
                    footer.height = 20;
                }
                
                else if (footerChkbx.selected == false)
				{
    				header.visible = false;
    				header.includeInLayout = false;
    				header.height = 0;
				}

			}

			
			private function expandTree():void 
			{
				if(expandAllChkbx.selected == true) {
					gapAnalysisReport.displayItemsExpanded = true;		
				}	
            	
            	else if(expandAllChkbx.selected == false) {
            		gapAnalysisReport.displayItemsExpanded = false;
            		gapAnalysisReport.collapseAll();
            	}
            
        	}	
			