//%attributes = {}
// tbar_report (->listboxptr; ->table)


//C_LONGINT(mainListBox)

C_POINTER:C301($listboxPtr; $1)
C_POINTER:C301($tablePtr; $2)

Case of 
	: (Count parameters:C259=0)
		$listboxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")  //->mainListBox
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=1)
		$listboxPtr:=$1
		$tablePtr:=Current form table:C627
		
	: (Count parameters:C259=2)
		$listboxPtr:=$1
		$tablePtr:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If (Not:C34(Is nil pointer:C315($tablePtr)))
	Case of 
		: (Form event code:C388=On Load:K2:1)
			enableButtonIf(isUserAuthorizedToPrint($tablePtr); "reportButton")
			
		: (Form event code:C388=On Clicked:K2:4)
			//READ ONLY([Reports])
			//QUERY([Reports];[Reports]TableNo=Table($tablePtr))
			//ALL RECORDS([Reports])
			//If (Records in selection([Reports])>0)
			
			If (Macintosh option down:C545)
				//iRPT_ExecuteRpt
				//C_LONGINT($1;$iTable)  //parent table to base report on
				//C_LONGINT($2;$iReportType)  //1=quick report; 2=hmReport
				//C_TEXT($3;$tReportPath)  //path to the report template on disk
				//C_LONGINT($4;$iDestination)  //destination type -- default is printer
				
				//iRPT_ExecuteRpt (Table($tablePtr);1)
				
				//ARRAY TEXT($atChoice;0)
				//ARRAY TEXT($atChoiceID;0)
				//
				//SELECTION TO ARRAY([Reports]Name;$atChoice;[Reports]ID;$atChoiceID)
				//
				//INSERT IN ARRAY($atChoice;1)
				//INSERT IN ARRAY($atChoiceID;1)
				//$atChoice{1}:="Quick Report"
				//$atChoiceID{1}:="QRPT"
				//
				//$iElem:=choiceList ("Pick a report";->$atChoice)
				//
				//If (OK=1)
				//If ($atChoiceID{$iElem}="QRPT")
				//bQuickReport ($listboxPtr;$tablePtr)
				//Else 
				//
				//QUERY([Reports];[Reports]ID=$atChoiceID{$iElem})
				//
				//BLOB PROPERTIES([Reports]xReport;$iCompressed)  //check to see if compressed
				//If ($iCompressed#Is not compressed)  //if it is compress we need to expand first
				//EXPAND BLOB([Reports]xReport)
				//End if 
				//
				//$ihmReport:=hmRep_New Offscreen Area (0;0)
				//
				//$iError:=hmRep_Get Last Error ($ihmReport)
				//
				//hmRep_BLOB TO REPORT ($ihmReport;hmRep_Import_hmReports;[Reports]xReport)
				//
				//If (Current user="designer")
				//hmRep_SET PRINT OPTION ($ihmReport;hmRep_hide_printing_process;1;0;"")  //hide print progress
				//Else 
				//hmRep_SET PRINT OPTION ($ihmReport;hmRep_hide_printing_process;0;0;"")  //show print progress
				//End if 
				//  //hmRep_SET PRINT OPTION ($ihmReport;hmRep_orientation_option;$iOrientation;0;"")
				//  //hmRep_GET PRINT OPTION ($ihmReport;hmRep_orientation_option;$value1;$value2;$value3)
				//hmRep_SET PRINT OPTION ($ihmReport;hmRep_number_of_copies;1;0;"")  // Nov 10, 2012 12:14:50 -- I.Barclay Berry - default to 1
				//
				//  //hmRep_INSTALL CALLBACK ($ihmReport;"RPT_hmRep_PrintCallback")
				//  //hmRep_SET EVENT STATE ($ihmReport;hmRep_OnBeforePrintingPage;1)
				//  //hmRep_SET EVENT STATE ($ihmReport;hmRep_OnAfterPrinting;1)
				//  //hmRep_SET EVENT STATE ($ihmReport;hmRep_OnBeforePrinting;1)
				//
				//If (Macintosh option down)
				//hmRep_SET PRINT OPTION ($ihmReport;hmRep_destination_option;5)  //5-Preview for testing
				//Else 
				//hmRep_SET PRINT OPTION ($ihmReport;hmRep_destination_option;1)  //1-Printer
				//End if 
				//
				//$iResult:=hmRep_Print ($ihmReport;3)
				//
				//hmRep_DELETE OFFSCREEN AREA ($ihmReport)
				//
				//End if 
				//End if 
				
			Else 
				bQuickReport($listboxPtr; $tablePtr)
			End if 
			
	End case 
End if 
