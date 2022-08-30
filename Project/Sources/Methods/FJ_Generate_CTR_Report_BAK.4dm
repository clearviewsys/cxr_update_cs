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


$countLines:=0

// Get the config information from the fiji.ini saved in the active 4D Database Folder
//FJ_GetEntityAndContactInfo 

// Generate the Report Header

FJ_SetReportHeader($fileName)


// ------------------------------------------------------------------------------------
// Create the report part
// ------------------------------------------------------------------------------------

$maxTx:=Size of array:C274(arrFTCustomerId)

For ($i; 1; $maxTx)
	
	READ ONLY:C145([Invoices:5])
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=arrFTInvoiceNumber{$i})
	
	READ ONLY:C145([ThirdParties:101])
	QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=arrFTInvoiceNumber{$i})
	
	READ ONLY:C145([Customers:3])
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
	
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
	
	QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=arrFTInvoiceNumber{$i})
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
	
	
	READ ONLY:C145([Branches:70])
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=[Invoices:5]BranchID:53)
	
	$format:="SC"
	FJ_SetReportReportDetail($fileName; $format)
	
	// General Transactions Detail
	FJ_SetGeneralTxDetail($fileName; arrFTTxAmount{$i}; [Invoices:5]CreationDate:13; [Registers:10]DebitLocal:23-[Registers:10]totalFees:30)
	
	$countLines:=$countLines+1
	
	If (operationMode=0)  // Production  Mode?
		
		READ WRITE:C146([Registers:10])
		QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
		If (Records in selection:C76([Registers:10])=1)
			
			[Registers:10]isExported:44:=True:C214
			SAVE RECORD:C53([Registers:10])
		End if 
	End if 
	
	
	
End for   // Loop Transactions


$rptInfo:="=Z01:TR"+CRLF
//$rptInfo:=$rptInfo+"=Z02:"+String($i-1)+CRLF 
$rptInfo:=$rptInfo+"=Z02:"+String:C10(countOccurrences($fileName; "=B01"))+CRLF
appendToFile($fileName; ->$rptInfo; False:C215)


REDUCE SELECTION:C351([Invoices:5]; 0)
REDUCE SELECTION:C351([Customers:3]; 0)
REDUCE SELECTION:C351([Registers:10]; 0)



$workFile:=$fileName
DOCUMENT TO BLOB:C525($workFile; $blobReport)
xmlFile:=BLOB to text:C555($blobReport; UTF8 text without length:K22:17)

If (hasInvalidTags($workFile))
	myAlert("The File "+Replace string:C233($workFile; ".txt"; "")+CRLF+"Has missing values in some fields. The file cannot be manually submitted to the FIJI FIU Platform. Please review!")
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
		
		
	End if 
	
	
End if 



