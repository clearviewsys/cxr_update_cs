//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_GenerateEFTIReport
// Generate the EFT Report for FINTRAC
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
C_LONGINT:C283($reportSeq; $totReports)
$totReports:=0

C_BLOB:C604($content)
C_BOOLEAN:C305($isRelatedIran)
C_TEXT:C284($branchAct; $branchRef; $tot; $footer; $reportSeqstr)
C_LONGINT:C283($i; $seq; $subSeq; $maxTx; $subHeaderSeq; $numRepxSubhdr)


Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222(arrFTBranchId; 0)
SELECTION TO ARRAY:C260([eWires:13]BranchID:50; arrFTBranchId)

FIRST RECORD:C50([eWires:13])

// Get Next batch sequence
$batchSeqId:=FT_NextSequence("EFTI_BatchSeq")
FIRST RECORD:C50([eWires:13])

ARRAY TEXT:C222(arrFTBranchId; 0)
SELECTION TO ARRAY:C260([eWires:13]BranchID:50; arrFTBranchId)

// Write the headers report

// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------
$seq:=FT_NextSequence("FINTRAC_ReportSeq")
FT_GenerateHeader1A_EFTI($fileName; $batchSeqId; $seq)
$subSeq:=0

$maxTx:=Records in selection:C76([eWires:13])
FIRST RECORD:C50([eWires:13])

$i:=1
While ($i<=$maxTx)
	
	$branchAct:=[eWires:13]BranchID:50
	$branchRef:=$branchAct
	
	READ ONLY:C145([Branches:70])
	QUERY:C277([Branches:70]; [Branches:70]BranchID:1=$branchAct)
	
	READ ONLY:C145([Registers:10])
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=[eWires:13]RegisterID:24)
	
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
		
		READ ONLY:C145([Invoices:5])
		$isRelatedIran:=isInvoiceRelatedIran([eWires:13]InvoiceNumber:29; initialDate)
		QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[eWires:13]InvoiceNumber:29)
		
		
		// -----------------------------------------------------------------------------------------------------------------
		// Part A: Information about where the transaction took place
		// This part is for information about when the EFT was sent.
		//
		// -----------------------------------------------------------------------------------------------------------------
		$reportSeqStr:=getReportNumber($subHeaderSeq; $isRelatedIran; "E"; "ewire")
		//$reportSeqstr:=[eWires]InvoiceNumber+FT_StringFormat (String($subHeaderSeq);2;"_";"RJ")  //FT_NextSequence ("FINTRAC_ReportSeq")
		FT_GeneratePartA1_EFT($fileName; $subHeaderSeq; $reportSeqstr; $i; $isRelatedIran)
		$numRepxSubhdr:=$numRepxSubhdr+1
		// -----------------------------------------------------------------------------------------------------------------
		// Part B1: This part is for information about the individual or entity ordering you to send the EFT. 
		// If the individual or entity that ordered the EFT did so on someone else's behalf, you also have to complete Part D.
		// -----------------------------------------------------------------------------------------------------------------
		
		
		
		If (getKeyValue("FT.reportingOrderingPart"; "Links")="Links")
			FT_Generatepart_BFD_1($fileName; [eWires:13]CustomerID:15; "B1"; "Links"; False:C215)
		Else 
			FT_Generatepart_BFD_1($fileName; [eWires:13]CustomerID:15; "B1"; "Customers"; False:C215)
		End if 
		
		
		// -----------------------------------------------------------------------------------------------------------
		// Part B2: Information about the disposition
		// This part is for information about how the transaction was completed(that is, where the money went)
		// -----------------------------------------------------------------------------------------------------------
		
		READ ONLY:C145([ThirdParties:101])
		QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=[eWires:13]InvoiceNumber:29)
		
		// -----------------------------------------------------------------------------------------------------------
		// Part C1: This part is for information about the reporting entity sending the payment instructions.
		// -----------------------------------------------------------------------------------------------------------
		
		FT_GeneratePartC1_EFTI($fileName)
		
		// -----------------------------------------------------------------------------------------------------------
		// Part D1: InInformation about a third party if the client ordering the EFT is acting on behalf of a third 
		// party (if applicable)
		// -----------------------------------------------------------------------------------------------------------
		If ([Invoices:5]ThirdPartyisInvolved:22=False:C215)
			FT_GeneratePartD1_EFTO($fileName)
		End if 
		
		// -----------------------------------------------------------------------------------------------------------
		// Part E: Part E – Information about the receiver of the EFT (i.e., the individual or entity that receives 
		// the payment instructions)
		// This part is for information about the individual or entity to which you are sending the payment instructions.
		// -----------------------------------------------------------------------------------------------------------
		FT_GeneratePartE1_EFTI($fileName)
		
		// Part F – Information about the beneficiary client(i.e., individual or entity to whose benefit the payment is made)
		// This part is for information about the individual or entity to whose benefit the(or will be made)0
		If (getKeyValue("FT.reportingBeneficiaryPart"; "Customers")="Customers")
			FT_Generatepart_BFD_1($fileName; [eWires:13]CustomerID:15; "F1"; "Customers"; False:C215)  // JA on Dec 13/2022
		Else 
			// FT.reportingBeneficiaryPart = "Ewires"
			//FT_GeneratePartF1EFTO ($fileName) JA Dec 12/2022
			FT_Generatepart_BFD_1($fileName; [eWires:13]CustomerID:15; "F1"; "Links"; False:C215)
		End if 
		
		
		// Part G-Information about a third Party if the beneficiary client is acting on behalf of(if applicable)
		// This part is for information about any third party on whose behalf the EFT payme
		// Doesn't Apply
		
		If ([Invoices:5]ThirdPartyisInvolved:22)
			FT_GeneratePartD1_EFTO($fileName; "G1")
		End if 
		
		// -----------------------------------------------------------------------------------------------------------
		// Update the flag to indicate that record was used in a EFT report
		// -----------------------------------------------------------------------------------------------------------
		
		
		If ((operationMode=0) & False:C215)  // Production  Mode?
			// Never update the record as reported
			READ WRITE:C146([Registers:10])
			QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=arrFTRegisterID{$i})
			If (Records in selection:C76([Registers:10])=1)
				[Registers:10]isExported:44:=True:C214
				SAVE RECORD:C53([Registers:10])
			End if 
			
		End if 
		NEXT RECORD:C51([eWires:13])
		
		
		$i:=$i+1
		If ($i<=$maxTx)
			$branchAct:=[eWires:13]BranchID:50
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
End while 
// Loop Transactions


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

myAlert("Report generated:\n"+$fileName)
