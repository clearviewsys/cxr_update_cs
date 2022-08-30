//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_GenerateEFTOReport_NonSwift // TODELETE
// Generate the EFT Report for FINTRAC Non-Swift
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 4/2/2019
// ------------------------------------------------------------------------------
C_TEXT:C284($1; $fileName)

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_LONGINT:C283($batchSeqId)
C_LONGINT:C283($reportSeq; $totReports; $i)

C_LONGINT:C283($subHeaderSeq; $numRepxSubhdr)
C_BLOB:C604($content)
C_TEXT:C284($tot; $footer)
C_BOOLEAN:C305($isRelatedIran)

$totReports:=0
C_TEXT:C284($branchRef; $branchAct)

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get Next batch sequence
$batchSeqId:=FT_NextSequence("EFTO_BatchSeq")


ARRAY TEXT:C222(arrFTBranchId; 0)
SELECTION TO ARRAY:C260([Wires:8]BranchID:47; arrFTBranchId)

FIRST RECORD:C50([Wires:8])


// Write the headers report

// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------
C_LONGINT:C283($seq; $subSeq; $maxTx; $i)

$seq:=FT_NextSequence("EFTO_ReportSeq")
FT_GenerateHeader1A($fileName; $batchSeqId; "EFTO"; $seq)
$subSeq:=0


$maxTx:=Records in selection:C76([Wires:8])
$i:=1
While ($i<=$maxTx)
	$branchRef:=[Wires:8]BranchID:47
	$branchAct:=[Wires:8]BranchID:47
	
	READ ONLY:C145([Branches:70])
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=$branchAct)
	
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[Wires:8]CXR_RegisterID:13)
	
	reportingEntityLocationName:=[Branches:70]BranchName:2
	
	// ---------------------------------------------------------------------------------------------------------
	// The batch sub-header contains information that allows you to group reports 
	// included in the batch according to your organizational structure or any other 
	// grouping need. The use of different sub-headers is optional, but you must include 
	// at least one sub-header in a batch. 
	// ---------------------------------------------------------------------------------------------------------
	
	
	$subSeq:=$subSeq+1
	FT_GenerateHeader1B($fileName; 0; $subSeq)
	$reportSeq:=1
	// ------------------------------------------------------------------------------------
	// Create the reports once per transaction
	// ------------------------------------------------------------------------------------
	
	$subHeaderSeq:=1
	$numRepxSubhdr:=0
	
	While (($branchAct=$branchRef) & ($i<=$maxTx))
		
		
		$isRelatedIran:=isInvoiceRelatedIran([Wires:8]CXR_InvoiceID:12; initialDate)
		QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Wires:8]CXR_InvoiceID:12)
		// -----------------------------------------------------------------------------------------------------------------
		// Part A: Information about where the transaction took place
		// This part is for information about when the EFT was sent.
		//
		// -----------------------------------------------------------------------------------------------------------------
		//$reportSeq:=FT_NextSequence ("FINTRAC_ReportSeq")
		C_TEXT:C284($reportSeqStr)
		$reportSeqStr:=getReportNumber($subHeaderSeq; $isRelatedIran; "E"; "wire")
		
		FT_generatePartA1_EFT_NS($fileName; $subHeaderSeq; $reportSeqStr; $i; $isRelatedIran)
		$numRepxSubhdr:=$numRepxSubhdr+1
		
		// -----------------------------------------------------------------------------------------------------------------
		// Part B1: This part is for information about the individual or entity ordering you to send the EFT. 
		// If the individual or entity that ordered the EFT did so on someone else's behalf, you also have to complete Part D.
		// -----------------------------------------------------------------------------------------------------------------
		
		FT_Generatepart_BFD_1($fileName; [Wires:8]CustomerID:2; "B1"; "Customers"; True:C214)
		
		// -----------------------------------------------------------------------------------------------------------
		// Part B2: Information about the disposition
		// This part is for information about how the transaction was completed(that is, where the money went)
		// -----------------------------------------------------------------------------------------------------------
		READ ONLY:C145([Invoices:5])
		QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[Wires:8]CXR_InvoiceID:12)
		READ ONLY:C145([ThirdParties:101])
		QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=[Wires:8]CXR_InvoiceID:12)
		
		// -----------------------------------------------------------------------------------------------------------
		// Part C1: This part is for information about the reporting entity sending the payment instructions.
		// -----------------------------------------------------------------------------------------------------------
		
		FT_GeneratePartC1_EFTO($fileName)
		
		// -----------------------------------------------------------------------------------------------------------
		// Part D1: Information about a third party if the client ordering the EFT is acting on behalf of a third 
		// party (if applicable)
		// -----------------------------------------------------------------------------------------------------------
		
		FT_GeneratePartD1_EFTO($fileName)
		
		// -----------------------------------------------------------------------------------------------------------
		// Part E: Part E – Information about the receiver of the EFT (i.e., the individual or entity that receives 
		// the payment instructions)
		// This part is for information about the individual or entity to which you are sending the payment instructions.
		// -----------------------------------------------------------------------------------------------------------
		FT_GeneratePartE1_EFTO_NS($fileName)
		
		// Part F – Information about the beneficiary client(i.e., individual or entity to whose benefit the payment is made)
		// This part is for information about the individual or entity to whose benefit the(or will be made)0
		
		FT_GeneratePartF1EFTO_NonSwift($fileName)
		
		
		// Part G-Information about a third Party if the beneficiary client is acting on behalf of(if applicable)
		// This part is for information about any third party on whose behalf the EFT payme
		// No Apply
		
		// -----------------------------------------------------------------------------------------------------------
		// Update the flag to indicate that record was used in a EFT report
		// -----------------------------------------------------------------------------------------------------------
		
		
		If (operationMode=0)  // Production  Mode?
			//READ WRITE([Wires])
			//[Wires]wasReported:=True
			//SAVE RECORD([Wires])
			
		End if 
		
		
		NEXT RECORD:C51([Wires:8])
		
		
		$i:=$i+1
		If ($i<=$maxTx)
			$branchAct:=[Wires:8]BranchID:47
			$reportSeq:=$reportSeq+1
		End if 
		$subHeaderSeq:=$subHeaderSeq+1
	End while 
	
	
	$totReports:=$totReports+$numRepxSubhdr
	
	DOCUMENT TO BLOB:C525($fileName; $content)
	$report:=Convert to text:C1012($content; "UTF-8")
	
	$tot:=FT_NumberFormat($numRepxSubhdr; 0; 5; "0"; "RJ")
	$report:=Replace string:C233($report; "_RS??"; $tot)
	
	TEXT TO BLOB:C554($report; $content; UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($fileName; $content)
End while   // Loop Transactions


// --------------------- FOOTER -----------------------------

CLEAR VARIABLE:C89($content)
$footer:="1C00001"  // It is a Constant
TEXT TO BLOB:C554($footer; $content; UTF8 text without length:K22:17; *)
AppendBlobToFile($fileName; $content)

C_TEXT:C284($report)
DOCUMENT TO BLOB:C525($fileName; $content)
$report:=Convert to text:C1012($content; "UTF-8")

$tot:=FT_NumberFormat($subSeq; 0; 5; "0"; "RJ")
$report:=Replace string:C233($report; "_SH??"; $tot)

$tot:=FT_NumberFormat($totReports; 0; 5; "0"; "RJ")
$report:=Replace string:C233($report; "_RC??"; $tot)

TEXT TO BLOB:C554($report; $content; UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($fileName; $content)

myAlert("Report generated:\n"+$fileName+".")
