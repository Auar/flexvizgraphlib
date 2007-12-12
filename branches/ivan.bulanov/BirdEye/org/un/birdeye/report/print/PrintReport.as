// ActionScript file

            import mx.printing.*;
			import mx.printing.PrintAdvancedDataGrid;

			// Create a PrintJob instance.
			
			private function doPrint():void {

				// Create an instance of the FlexPrintJob class.
				var printJob:FlexPrintJob = new FlexPrintJob();

				// Initialize the PrintAdvancedDataGrid control.
				var printADG:PrintAdvancedDataGrid = new PrintAdvancedDataGrid();
				printADG.source = adgReport;

				// Start the print job.
				if (printJob.start() != true) return;

				// Add the object to print. Do not scale it.
				printJob.addObject(printADG, FlexPrintJobScaleType.NONE);

				// Send the job to the printer.
				printJob.send();
				}