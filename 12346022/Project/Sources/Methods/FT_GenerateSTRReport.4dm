//%attributes = {}
// ------------------------------------------------------------------------------
// Method: FT_GenerateSTRReport
// Generate the STR Report for FINTRAC
//
// Parameters: 
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 4/2/2019
// ------------------------------------------------------------------------------
C_TEXT:C284($1; $fileName)
ARRAY TEXT:C222($reportsToBeReplaced; 0)
ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_LONGINT:C283($batchSeqId)
C_LONGINT:C283($reportSeq; $subHdr; $numRepxSubhdr; $totReports; $countLines)

C_LONGINT:C283($i; $j; $k; $t; $m; $a1Seq; $seq; $subSeq; $maxTx; $subHeaderSeq; $numRepxSubhdr)
C_TEXT:C284($branchAct; $branchRef; $tot; $footer; $accountType)
C_BLOB:C604($content)
C_BOOLEAN:C305($isEwire; $isRelatedIran)
C_TEXT:C284($accountHolder; $accountOtherDesc; $tmp)

$a1Seq:=0
$subHdr:=0
$totReports:=0
$numRepxSubhdr:=0
$countLines:=0

Case of 
	: (Count parameters:C259=1)
		$fileName:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get Next batch sequence
$batchSeqId:=FT_NextSequence("STR_BatchSeq")

// Write the headers report

// ---------------------------------------------------------------------------------------------------------
// Batch Header - The batch header contains information identifying the individual or 
// institution originating the transmission. There can be only one batch header for 
// each transmitted file. 
// ---------------------------------------------------------------------------------------------------------
$seq:=FT_NextSequence("STR_BatchSeq")
FT_GenerateHeader1A($fileName; $batchSeqId; "STR "; $seq)
$i:=1
$subSeq:=1
C_LONGINT:C283($max)
C_TEXT:C284($repEntityRefNum)


ORDER BY:C49([AML_Reports:119]BranchID:15; >; [AML_Reports:119]DecisionDate:17)
FIRST RECORD:C50([AML_Reports:119])

$max:=Records in selection:C76([AML_Reports:119])
FIRST RECORD:C50([AML_Reports:119])

While ($i<=$max)
	
	$branchAct:=[AML_Reports:119]BranchID:15
	$branchRef:=$branchAct
	
	//QUERY([Branches];[Branches]BranchID=$branchAct)
	reportingEntityLocationName:=getGroupDesc($branchAct)
	//reportingEntityLocationName:=[Branches]BranchName
	
	$subHdr:=$subHdr+1
	// ------------------------------------------------------------------------------------
	// Create the reports once per transaction
	// ------------------------------------------------------------------------------------
	QUERY:C277([Registers:10]; [Registers:10]InvoiceNumber:10=[AML_Reports:119]invoiceID:2; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]Debit:8>0; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]isCancelled:59=False:C215; *)
	QUERY:C277([Registers:10];  & ; [Registers:10]isTransfer:3=False:C215)
	//QUERY([Registers]; & ;[Registers]isExported=False)
	
	$maxTx:=Records in selection:C76([Registers:10])
	
	
	// ---------------------------------------------------------------------------------------------------------
	// The batch sub-header contains information that allows you to group reports 
	// included in the batch according to your organizational structure or any other 
	// grouping need. The use of different sub-headers is optional, but you must include 
	// at least one sub-header in a batch. 
	// ---------------------------------------------------------------------------------------------------------
	
	FT_GenerateHeader1B($fileName; $maxTx)
	
	While (($branchAct=$branchRef) & ($i<=$max))
		
		$isRelatedIran:=invoiceRelatedIran([Invoices:5]InvoiceID:1; initialDate)
		
		$numRepxSubhdr:=$numRepxSubhdr+1
		$a1Seq:=$a1Seq+1
		
		$repEntityRefNum:=getReportNumber($a1Seq; $isRelatedIran; "S"; "str")
		FT_GeneratePartA1_STR($fileName; "A1"; $a1Seq; $repEntityRefNum; "A"; reportingEntityCertificateID; [Branches:70]LocationNumberFT:19; contactSurName; contactGivenName; contactOtherName; contactPhoneNumber; contactPhoneNumberExt; "K"; "0")
		
		
		//FT_Generatepart_BFD_1 ($fileName;[AML_Reports]CustomerID)
		QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[AML_Reports:119]invoiceID:2)
		
		C_OBJECT:C1216($registersDebit; $registersCredit; startRegisters; endRegisters)
		
		$registersDebit:=ds:C1482.Registers.query("InvoiceNumber == :1"; [Invoices:5]InvoiceID:1)
		$registersDebit:=$registersDebit.query("DebitLocal > 0 ")
		$registersDebit:=$registersDebit.query("isCancelled == false")
		
		
		REDUCE SELECTION:C351([Registers:10]; 0)
		USE ENTITY SELECTION:C1513($registersDebit)
		SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; $arrRegisterIDTx)
		
		
		$registersCredit:=ds:C1482.Registers.query("InvoiceNumber == :1"; [Invoices:5]InvoiceID:1)
		
		$registersCredit:=$registersCredit.query("CreditLocal > 0 ")
		$registersCredit:=$registersCredit.query("isCancelled == false")
		
		
		$registersDebit:=$registersDebit.orderBy("DebitLocal desc,")
		$registersCredit:=$registersCredit.orderBy("CreditLocal desc")
		
		REDUCE SELECTION:C351([Registers:10]; 0)
		USE ENTITY SELECTION:C1513($registersCredit)
		SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; $arrRegisterIDDisp)
		
		QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[AML_Reports:119]CustomerID:19)
		
		
		For ($t; 1; Size of array:C274($arrRegisterIDTx))
			
			QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$arrRegisterIDTx{$t})
			
			// Part B1: Information about transaction
			FT_PartB1v2_STR($fileName; ->$arrRegisterIDTx; $t; $isRelatedIran)
			$countLines:=$countLines+1
			
			For ($k; 1; Size of array:C274($arrRegisterIDDisp))
				QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$arrRegisterIDDisp{$k})
				
				Case of 
						
					: ([Registers:10]InternalTableNumber:17=Table:C252(->[eWires:13]))
						$isEwire:=True:C214
						QUERY:C277([eWires:13]; [eWires:13]eWireID:1=[Registers:10]InternalRecordID:18)
						QUERY:C277([Links:17]; [Links:17]LinkID:1=[eWires:13]LinkID:8)
						
						$accountType:="A"
						$accountHolder:=""
						$accountOtherDesc:=" "
						
						If ([Links:17]isCompany:43)
							$accountType:="B"
						End if 
						// Saleh Question: is it Deposit to an account the Disposition of funds?? yes ok
						
						C_TEXT:C284($currencyCode; $otherInst)
						$currencyCode:=[eWires:13]Currency:12
						//$b2part:=$b2part+1
						
						//Part B2: Information about transaction disposition
						
						If ([eWires:13]Currency:12=getKeyValue("TOMCode"; "TOM"))
							$otherInst:=[Links:17]BankName:28
							$currencyCode:="IRR"
							FT_PartB2($fileName; "B2"; $k; "C"; " "; " "; [eWires:13]ToAmount:14*10; $currencyCode; $otherInst; [Links:17]FullName:4; "C")
						Else 
							FT_PartB2($fileName; "B2"; $k; "C"; " "; " "; [eWires:13]ToAmount:14; $currencyCode; $otherInst; [Links:17]FullName:4; "C")
						End if 
						
						If (([eWires:13]Currency:12="TOM") | ([eWires:13]Currency:12="IRR"))
							APPEND TO ARRAY:C911($reportsToBeReplaced; $repEntityRefNum)
						End if 
						
						//Part C: Account information (if applicable)
						//FT_PartC ($fileName;"C1";$k;[Links]BankTransitCode;[Links]BankAccountNo;$accountType;$accountOtherDesc;[eWires]Currency;[Links]FullName;$accountHolder;$accountHolder)
						// ----------------------------------------------------------
						
						
					: ([Registers:10]InternalTableNumber:17=Table:C252(->[Cheques:1]))
						
						FT_GeneratePartB2Check($fileName; $arrRegisterIDDisp{$k}; $k)
						
						
					: ([Registers:10]InternalTableNumber:17=Table:C252(->[Accounts:9]))
						
						FT_GeneratePartB2($fileName; <>baseCurrency; [Registers:10]CreditLocal:24; $k)
						
					Else 
						
						FT_GeneratePartB2($fileName; <>baseCurrency; [Registers:10]CreditLocal:24; $k)
				End case 
				
				
			End for 
			
		End for 
		
		If ([AML_Reports:119]invoiceID:2#"")
			
			READ ONLY:C145([Invoices:5])
			QUERY:C277([Invoices:5]; [Invoices:5]InvoiceID:1=[AML_Reports:119]invoiceID:2)
			
			READ ONLY:C145([ThirdParties:101])
			QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=[AML_Reports:119]invoiceID:2)
			
			READ ONLY:C145([Customers:3])
			QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
			
			// -----------------------------------------------------------------------------------------------------------
			// Part B2: This part is for information about how the transaction was completed (i.e., where the money went). 
			// In the case of an attempted transaction, this would include information about how it was proposed to be completed.
			// -----------------------------------------------------------------------------------------------------------
			// TODO: Fix: 2nd parameter 
			
			//FT_GeneratePartB2 ($fileName;[Registers]Currency;[Registers]DebitLocal)
			
			
			
			// -----------------------------------------------------------------------------------------------------------------
			// Part D1: This part is for information about the individual who conducted or attempted to conduct the transaction.
			// -----------------------------------------------------------------------------------------------------------------
			
			FT_PartD1_STR($fileName; [Customers:3]CustomerID:1; "D1"; 1)
			// -----------------------------------------------------------------------------------------------------------
			// Part E: Information about the entity on whose behalf the transaction was conducted (if applicable)
			// This part only applies if the disposition was conducted or attempted on behalf o.To include Part E, the on behalf of indicator in Part B2(field B17)has to be “E”.
			// -----------------------------------------------------------------------------------------------------------
			
			If ([Invoices:5]ThirdPartyisInvolved:22)
				
				Case of 
						
					: ([ThirdParties:101]IsCompany:2)
						// Part E: Information about the entity on whose behalf the transaction was conduct(if applicable-Company)
						FT_GeneratePart_EF1($fileName; "E1")
						
					: ([ThirdParties:101]IsCompany:2=False:C215)
						
						// PartF : Information about the individual on whose behalf the transaction was conducted  (individual)
						FT_PartF1_STR($fileName; "F1"; 1)
						
				End case 
				
			End if 
			
			// Part G: Description of suspicious activity, Insert the IR2020 Prefix as necessary
			If ($isRelatedIran)
				FT_STR_Part_GH($fileName; "G1"; "IR2020 "+[AML_Reports:119]DiscoveryNotes:8)
			Else 
				FT_STR_Part_GH($fileName; "G1"; [AML_Reports:119]DiscoveryNotes:8)
			End if 
			
			// Part H: Description of action Taken
			FT_STR_Part_GH($fileName; "H1"; [AML_Reports:119]ReportNotes:16)
			
			
		End if 
		
		
		NEXT RECORD:C51([AML_Reports:119])
		$branchAct:=[AML_Reports:119]BranchID:15
		
		$i:=$i+1
		
		$totReports:=$totReports+$numRepxSubhdr
		
		DOCUMENT TO BLOB:C525($fileName; $content)
		$report:=Convert to text:C1012($content; "UTF-8")
		
		$tot:=FT_NumberFormat($numRepxSubhdr; 0; 5; "0"; "RJ")
		$report:=Replace string:C233($report; "_RS??"; $tot)
		
		
		//For ($m;1;Size of array($reportsToBeReplaced))
		//$tmp:="IR2020"+Substring($reportsToBeReplaced{$m};7)
		//$report:=Replace string($report;$reportsToBeReplaced{$m};$tmp)
		//End for 
		
		TEXT TO BLOB:C554($report; $content; UTF8 text without length:K22:17)
		BLOB TO DOCUMENT:C526($fileName; $content)
	End while 
	
	If (operationMode=0)  // Production  Mode?
		
		READ WRITE:C146([AML_Reports:119])
		[AML_Reports:119]ReportDate:6:=Current date:C33(*)
		SAVE RECORD:C53([AML_Reports:119])
		
		
	End if 
	
	
	
End while 




// --------------------- FOOTER -----------------------------

CLEAR VARIABLE:C89($content)
$footer:="1C00001"  // It is a Constant
TEXT TO BLOB:C554($footer; $content; UTF8 text without length:K22:17; *)
AppendBlobToFile($fileName; $content)

C_TEXT:C284($report)
DOCUMENT TO BLOB:C525($fileName; $content)
$report:=Convert to text:C1012($content; "UTF-8")

$tot:=FT_NumberFormat($subHdr; 0; 5; "0"; "RJ")
$report:=Replace string:C233($report; "_SH??"; $tot)

$tot:=FT_NumberFormat($totReports; 0; 5; "0"; "RJ")
$report:=Replace string:C233($report; "_RC??"; $tot)

//For ($i;1;Size of array($reportsToBeReplaced))
//$tmp:="IR2020"+Substring($reportsToBeReplaced{$i};7)
//$report:=Replace string($report;$reportsToBeReplaced{$i};$tmp)
//End for 
TEXT TO BLOB:C554($report; $content; UTF8 text without length:K22:17)
BLOB TO DOCUMENT:C526($fileName; $content)

myAlert("Report generated:\n"+$fileName)