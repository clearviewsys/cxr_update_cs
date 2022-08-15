//%attributes = {}
// JAM_GL_Report
// Generate the GL Report for Bank of Jamaica
// Author: JA 02/07/2020

C_LONGINT:C283($i)
C_BLOB:C604($blob)
C_TEXT:C284($sep; $fileName)
C_OBJECT:C1216($registers; $r)

C_REAL:C285(JAM_totalCredits; JAM_totalDebits; JAM_SumUnrealizedGains)
C_REAL:C285(JAM_totalCreditsAmnt; JAM_totalDebitsAmnt)
C_BOOLEAN:C305(invalidTxs)
invalidTxs:=False:C215


// Inital values
JAM_SumUnrealizedGains:=0
JAM_totalDebits:=0
JAM_totalCredits:=0

JAM_totalDebitsAmnt:=0
JAM_totalCreditsAmnt:=0

$sep:=""  // For production is null
reportView:=""

// Get Report Transactions
$registers:=JAM_GetGLTransactions(False:C215; (operationMode#1))

If ($registers.length>0)
	
	// Create file according to the BOJ Specifications BKEXMMDD+2 digit file #
	$fileName:=JAM_GetFileName
	
	// Create report Name
	JAM_CreateReportHeader($fileName; $sep)
	
	// Create Detail lines
	$i:=1
	For each ($r; $registers)
		JAM_CreateDetailLines($fileName; $r; $i; $sep)
		$i:=$i+1
	End for each 
	
	// Create the acumulated differences for Gains
	JAM_CreateGainLine($fileName; $i; $sep)
	
	// Create the Control Line for the file
	JAM_CreateControlLine($fileName; $sep)
	
	
	
	If (invalidTxs)
		notifyAlert("Report Complete with errors"; "GL Report have transactions done by not authorized users "; 5)
	Else 
		notifyAlert("Report Complete"; "GL Report File was Generated successfully"; 5)
	End if 
	
	DOCUMENT TO BLOB:C525($fileName; $blob)
	reportView:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
	
	
Else 
	notifyAlert("Information"; "There are not transactions for the selected date range"; 5)
	
End if 

//QUERY WITH ARRAY([Registers]RegisterID;arrRegID)



