//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FJ_Generate_EFTR_Report_wires
// Generate the Ascii EFTR Report for FIJI FIU  (Wires)
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 3/19/2019
// ------------------------------------------------------------------------------
C_TEXT:C284($1; $fileName)
C_DATE:C307($2; $refDate)
C_BLOB:C604($blobReport)
C_LONGINT:C283($countLines)
C_TEXT:C284($oldFileName)
$countLines:=0

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$refDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_LONGINT:C283($countLines; $i; $maxTx)
C_TEXT:C284($format; $rptInfo)


C_BOOLEAN:C305($progressBar; $loadListContinue)
$progressBar:=True:C214

If ($progressBar)
	C_REAL:C285($loadListCount; $loadListTotal)
	$loadListTotal:=Records in selection:C76([Invoices:5])
	
	
	C_LONGINT:C283($loadListProgress)
	$loadListProgress:=Progress New
	Progress SET WINDOW VISIBLE(True:C214)
	Progress SET PROGRESS($loadListProgress; 0)
	Progress SET MESSAGE($loadListProgress; "Completed 0 of "+String:C10($loadListTotal))
	Progress SET BUTTON ENABLED($loadListProgress; True:C214)
End if 

// Get the config information from the fiji.ini saved in the active 4D Database Folder
//FJ_GetEntityAndContactInfo 

// Generate the Report Header
FJ_SetReportHeader($fileName)


// ------------------------------------------------------------------------------------
// Create the Transactions report
// ------------------------------------------------------------------------------------

$maxTx:=Records in selection:C76([Wires:8])
FIRST RECORD:C50([Wires:8])

For ($i; 1; $maxTx)
	
	If ($progressBar)
		
		C_REAL:C285($loadListPrecent)
		$loadListPrecent:=$loadListCount/$loadListTotal
		Progress SET TITLE($loadListProgress; "Processing invoice: "+[Invoices:5]InvoiceID:1)
		Progress SET PROGRESS($loadListProgress; $loadListPrecent)
		Progress SET MESSAGE($loadListProgress; "Completed "+String:C10($loadListCount)+" of "+String:C10($loadListTotal))
		$loadListCount:=$loadListCount+1
		//DELAY PROCESS(Current process;40)
		$loadListContinue:=Not:C34(Progress Stopped($loadListProgress))
		
		
	End if 
	
	READ ONLY:C145([Invoices:5])
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[eWires:13]InvoiceNumber:29)
	
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
	
	READ ONLY:C145([Branches:70])
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[eWires:13]BranchID:50)
	
	$format:="SO"  // S2: SWIFT II format EFTR, S1: SWIFT I format EFTR, SO: Structured EFTR
	FJ_SetReportReportDetail($fileName; $format)
	
	// General Transactions Detail
	FJ_SetGeneralTxDetail_Wires($fileName)
	
	$countLines:=$countLines+1
	If (operationMode=0)  // Production  Mode?
		
		//GAML_SaveAMLReport ("IFT")  // Send report Type
		READ WRITE:C146([Wires:8])
		APPLY TO SELECTION:C70([Wires:8]; [Wires:8]wasReported:76:=True:C214)
		
	End if 
	
	NEXT RECORD:C51([Wires:8])
	
End for   // Loop Transactions

If ($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
	Progress QUIT($loadListProgress)
End if   // $progressBar


// EFTR file trailer record
$rptInfo:=""
$rptInfo:=$rptInfo+FJ_AddTagToReport("001"; "=Z01:TR"; True:C214)
//$rptInfo:=$rptInfo+FJ_AddTagToReport ("001";"=Z02:"+String(Records in selection([Wires]));True)
$rptInfo:=$rptInfo+FJ_AddTagToReport("001"; "=Z02:"+String:C10(countOccurrences($fileName; "=B01:")); True:C214)
//$rptInfo:=$rptInfo+FJ_AddTagToReport ("001";"=";True)


appendToFile($fileName; ->$rptInfo; False:C215)

REDUCE SELECTION:C351([Invoices:5]; 0)
REDUCE SELECTION:C351([Customers:3]; 0)
REDUCE SELECTION:C351([Registers:10]; 0)
REDUCE SELECTION:C351([Countries:62]; 0)
REDUCE SELECTION:C351([Links:17]; 0)


DOCUMENT TO BLOB:C525($fileName; $blobReport)
xmlFile:=BLOB to text:C555($blobReport; UTF8 text without length:K22:17)


QUERY WITH ARRAY:C644([Wires:8]WireNo:48; ARRALLEFT)
// Delete Document if there are not transactions

If ($countLines=0)
	If (Test path name:C476($fileName)=Is a document:K24:1)
		DELETE DOCUMENT:C159($filename)
	End if 
	
Else 
	
	If (Test path name:C476($fileName)=Is a document:K24:1)
		$oldFileName:=$fileName
		$fileName:=Replace string:C233($fileName; ".txt"; "")
		generatedFiles:=generatedFiles+"\n"+$fileName
		APPEND TO ARRAY:C911(arrFileNames; $fileName)
		MOVE DOCUMENT:C540($oldFileName; $fileName)
		
		If (hasInvalidTags($fileName))
			APPEND TO ARRAY:C911(arrFileNamesErr; "The File "+Replace string:C233($fileName; ".txt"; "")+CRLF+"Has missing values in some fields. Please review!")
			//myAlert ("The File "+Replace string($workFile;".txt";"")+CRLF +"Has missing values in some fields. The file cannot be manually submitted to the FIJI FIU Platform. Please review!")
		End if 
		
	End if 
	
	
End if 

ARRAY TEXT:C222($arrInvoices; 0)
SELECTION TO ARRAY:C260([Wires:8]CXR_InvoiceID:12; $arrInvoices)
QUERY WITH ARRAY:C644([Invoices:5]InvoiceID:1; $arrInvoices)


QUERY WITH ARRAY:C644([Wires:8]CXR_WireID:1; arrALLEFT)
vCount:=Records in selection:C76([Wires:8])
