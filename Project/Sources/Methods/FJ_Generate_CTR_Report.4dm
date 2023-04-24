//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FJ_Generate_CTR_Report
// Generate the Ascii Report for FIJI FIU 
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 2/19/2019
// ------------------------------------------------------------------------------

C_TEXT:C284($1; $fileName)
C_DATE:C307($2; $refDate)
C_BLOB:C604($blobReport)
C_LONGINT:C283($countLines)

Case of 
	: (Count parameters:C259=2)
		$fileName:=$1
		$refDate:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_LONGINT:C283($maxTx; $i)
C_TEXT:C284($format; $rptInfo; $workFile; $oldFileName)
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

$countLines:=0

// Get the config information from the fiji.ini saved in the active 4D Database Folder
//FJ_GetEntityAndContactInfo 

// Generate the Report Header

FJ_SetReportHeader($fileName)


// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------
CREATE EMPTY SET:C140([Invoices:5]; "$setCashTx")
READ ONLY:C145([Invoices:5])


$maxTx:=Records in selection:C76([Invoices:5])
FIRST RECORD:C50([Invoices:5])

For ($i; 1; $maxTx)
	
	
	If ($progressBar)
		If ($loadListCount%10=0)
			
			C_REAL:C285($loadListPrecent)
			$loadListPrecent:=$loadListCount/$loadListTotal
			Progress SET TITLE($loadListProgress; "Processing invoice: "+[Invoices:5]InvoiceID:1)
			Progress SET PROGRESS($loadListProgress; $loadListPrecent)
			Progress SET MESSAGE($loadListProgress; "Completed "+String:C10($loadListCount)+" of "+String:C10($loadListTotal))
			$loadListCount:=$loadListCount+1
			//DELAY PROCESS(Current process;40)
			$loadListContinue:=Not:C34(Progress Stopped($loadListProgress))
		End if 
		
		
	End if 
	
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=[Invoices:5]InvoiceID:1)
	FIRST RECORD:C50([Registers:10])
	
	
	While (Not:C34(End selection:C36([Registers:10])))
		
		// Report Transaction if it is a Cash Transaction over 10K. 
		// [ServerPrefs]twoIDsLimit Server Preference variable must be 10000
		
		If (FJ_IsCashOver(<>twoIDsLimit))
			
			$format:="SC"
			FJ_SetReportReportDetail($fileName; $format)
			
			// General Transactions Detail
			FJ_SetGeneralTxDetail($fileName; [Invoices:5]fromAmountLC:38; [Invoices:5]CreationDate:13; [Invoices:5]fromAmountLC:38)
			
			$countLines:=$countLines+1
			
			If (operationMode=0)  // Production  Mode?
				[Registers:10]isExported:44:=True:C214
				SAVE RECORD:C53([Registers:10])
			End if 
			
			ADD TO SET:C119([Invoices:5]; "$setCashTx")
			
		End if 
		
		
		NEXT RECORD:C51([Registers:10])
	End while 
	
	
	NEXT RECORD:C51([Invoices:5])
	
End for   // Loop Transactions

C_LONGINT:C283($loadItemProgress)

If ($progressBar)
	Progress SET WINDOW VISIBLE(False:C215)
	Progress QUIT($loadListProgress)
End if   // $progressBar

USE SET:C118("$setCashTx")


$rptInfo:="=Z01:TR"+CRLF
$rptInfo:=$rptInfo+"=Z02:"+String:C10(countOccurrences($fileName; "=B01:"))+CRLF
CLEAR SET:C117("$setCashTx")

appendToFile($fileName; ->$rptInfo; False:C215)


//REDUCE SELECTION([Invoices];0)
//REDUCE SELECTION([Customers];0)
//REDUCE SELECTION([Registers];0)



$workFile:=$fileName
DOCUMENT TO BLOB:C525($workFile; $blobReport)
xmlFile:=BLOB to text:C555($blobReport; UTF8 text without length:K22:17)

If (hasInvalidTags($workFile))
	APPEND TO ARRAY:C911(arrFileNamesErr; "The File "+Replace string:C233($workFile; ".txt"; "")+CRLF+"Has missing values in some fields. Please review!")
	//myAlert ("The File "+Replace string($workFile;".txt";"")+CRLF +"Has missing values in some fields. The file cannot be manually submitted to the FIJI FIU Platform. Please review!")
End if 


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
		FORM GOTO PAGE:C247(4)
		
	End if 
	
	
End if 


