//%attributes = {}
// JAM_GL_DraftsAndWiresReport 
// Generate the GL Drafts And Wires Report for Bank of Jamaica
// Author: JA 03/20/2020

C_LONGINT:C283($i; $sequence)
C_BLOB:C604($blob)
C_TEXT:C284($sep)
C_OBJECT:C1216($invoices)
C_TEXT:C284($fileName)
ARRAY TEXT:C222(arrRegID; 0)
C_REAL:C285(JAM_totalCredits; JAM_totalDebits; JAM_SumUnrealizedGains)
C_REAL:C285(JAM_totalCreditsAmnt; JAM_totalDebitsAmnt; vrOurRate)

// Inital values
JAM_SumUnrealizedGains:=0
JAM_totalDebits:=0
JAM_totalCredits:=0

JAM_totalDebitsAmnt:=0
JAM_totalCreditsAmnt:=0

$sep:=""  // For production is null
reportView:=""

// Get Report Transactions


$invoices:=JAM_GetDraftsGLTransactions(False:C215; (operationMode#1))

If ($invoices.length>0)
	
	// Create file according to the BOJ Specifications BKEXMMDD+2 digit file #
	$fileName:=JAM_GetFileName
	
	// Create report Name
	JAM_CreateReportHeader($fileName; $sep)
	
	// Create Detail lines
	$i:=1
	$sequence:=1
	C_OBJECT:C1216($invoice)
	
	For each ($invoice; $invoices)
		JAM_CreateDetailLinesDrafsW($fileName; $invoice; $i; ->$sequence; $sep)
		$i:=$i+1
	End for each 
	
	// Create the acumulated differences for Gains
	JAM_CreateGainLine($fileName; $i; $sep)
	
	// Create the Control Line for the file
	JAM_CreateControlLine($fileName; $sep)
	
	notifyAlert("Report Complete"; "GL Drafts and Wires Report File was Generated successfully"; 5)
	
	DOCUMENT TO BLOB:C525($fileName; $blob)
	reportView:=BLOB to text:C555($blob; UTF8 text without length:K22:17)
	
	
Else 
	notifyAlert("Information"; "There are not transactions for the selected date range"; 5)
	
End if 

QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; arrRegID)



