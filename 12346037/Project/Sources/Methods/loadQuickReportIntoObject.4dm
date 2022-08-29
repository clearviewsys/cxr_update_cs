//%attributes = {}
// loadQuickReportIntoObject ( pointer to longint: ->QuickReportVar; text: ReportFileName)
// e.g. loadQReport(->MyQuickReportVar;"Customer Transaction Volume By Date.4qr")


// this method loads a ready-made report into a quick report editor object (longint)
// PRE: you need to do the query before calling this method or else the report cannot be printed or generated
// POST: the QReport variable will be loaded with the saved report on the disk. 



C_BLOB:C604($blob)
C_POINTER:C301($1; $quickReportPtr)
C_TEXT:C284($filePath; $reportName; $2)
C_POINTER:C301($filePtr; $3)
C_TEXT:C284($folderName; $tempPath)


C_LONGINT:C283(MyQReport)
C_DATE:C307(vFromDate; vToDate)
C_POINTER:C301($tablePtr)
$folderName:=""


Case of 
	: (Count parameters:C259=1)
		$quickReportPtr:=$1
		$reportName:="Customer Transaction Volume By Date"
		$tablePtr:=->[Registers:10]
		
	: (Count parameters:C259=2)
		
		$quickReportPtr:=$1
		$reportName:=$2
		$tablePtr:=quickReportTablePtr
		
	: (Count parameters:C259=3)
		
		$quickReportPtr:=$1
		$reportName:=$2
		$tablePtr:=$3
		
		
	Else 
		ASSERT:C1129(False:C215; "Wrong number of parameters sent to method loadQuickReportIntoObject")
		
		
End case 

$folderName:=Table name:C256($tablePtr)+pathSeparator
$tempPath:=getFilePathByID("ReportTemplatesPath")+$folderName
If (Test path name:C476($tempPath)=Is a folder:K24:2)
	$filePath:=$tempPath
Else 
	$filePath:=getFilePathByID("ReportTemplatesPath")
End if 

If ($filePath="")
	myAlert("First define the location of report templates on this machine (FilePath)")
	displayListFilePaths
	
Else 
	$filePath:=$filePath+$reportName
	
	loadBLOBFromFile(->$blob; $filePath)
	setErrorTrap("loadQReport: QR BLOB TO REPORT"; "A problem occured during report generation. ")
	If (OK=1)  // if opening the document was successful then load it into the blob
		
		QR BLOB TO REPORT:C771($quickReportPtr->; $blob)
		C_TEXT:C284($header; $footer)
		$header:="From "+String:C10(vFromDate)+" to "+String:C10(vTodate)
		$footer:=<>COPYRIGHT
		// QR SET HEADER AND FOOTER($quickReportPtr->;1;$footer;"";String(Current date);100)
		// QR SET HEADER AND FOOTER($quickReportPtr->;1;$footer;"";String(Current date);100)
		
		
	End if 
	endErrorTrap
	
End if 




CLEAR VARIABLE:C89($blob)  // good practice

