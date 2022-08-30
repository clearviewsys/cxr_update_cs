//%attributes = {}
// FT_GenerateLCTRReport2 ($filename; $exported)

// Geenrate LCTR Report for FINTRAC

// Define transaction arrays
C_TEXT:C284($1; $filename)
C_BOOLEAN:C305($2; $exported; underThreshold)

ARRAY TEXT:C222(arrFTTxType; 0)
ARRAY REAL:C219(arrFTDebit; 0)
ARRAY DATE:C224(arrFTTxDate; 0)

ARRAY TEXT:C222(arrFTCustomerID; 0)
ARRAY TEXT:C222(arrFTCustomerID2; 0)

ARRAY TEXT:C222(arrFTCurrencies; 0)
ARRAY DATE:C224(arrFTPostingDate; 0)

ARRAY TEXT:C222(arrFTInvoiceNumber; 0)
ARRAY LONGINT:C221(arrFTPostingTime; 0)

ARRAY TEXT:C222(arrBaseCurrency; 0)
ARRAY REAL:C219(arrFTTxAmount; 0)
ARRAY TEXT:C222(arrFTRegisterID; 0)
ARRAY BOOLEAN:C223(arr24HourIndicator; 0)
ARRAY TEXT:C222(arrFTBranchId; 0)

C_LONGINT:C283($countTx; $countDisp; $countLines; $k; $p)
C_TEXT:C284($report; $reportSeqStr)
C_LONGINT:C283($i; $j; $t; $m; $max; $totReports; $reportSeq; $subSeq; $subHdr; $numRepxSubhdr; $a1Seq; $reportSeq)
C_TEXT:C284($branchAct; $branchRef; $tot)
C_LONGINT:C283($totReports; $b1Counter)
C_BLOB:C604($content)
C_TEXT:C284($repEntityRefNum)
ARRAY TEXT:C222($reportsToBeReplaced; 0)
C_TEXT:C284($accountType; $accountType; $accountHolder)
C_BOOLEAN:C305($processed; $isEwire; $isRelatedIran)

$isEwire:=False:C215
Case of 
		
	: (Count parameters:C259=1)
		$fileName:=$1
		$exported:=False:C215
		
		
	: (Count parameters:C259=2)
		$fileName:=$1
		$exported:=$2
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($subHederSeq; $numRepxSubhdr; $subHeaderCnt; $batchSeqId)
C_TEXT:C284($recordType; $codeFormat; $reportType; $contactSurName; $contactGivenName; $contactPhoneNumber; $contactPhoneNumberExt; $pkiCertificateId)
C_TEXT:C284($batchTime; $batchType; $formatIndicator; $opMode; $repEntityIdNum; $batchDate; $footer; $dispositionOfFounds)
C_TEXT:C284($reportCnt; $tx; $accountOtherDesc; $OnBehalfOfIndicator)
C_BLOB:C604($seqAddr)
C_REAL:C285($maxLimitLCTR)
C_LONGINT:C283($b2part)

$countLines:=0
$b1Counter:=0

ARRAY TEXT:C222($arrRegisterIDDisp; 0)
ARRAY TEXT:C222($arrRecordId; 0)
ARRAY TEXT:C222($arrRegisterIDTx; 0)
ARRAY TEXT:C222($arrOnlyCashTx; 0)

C_BOOLEAN:C305($isEFT)
ARRAY TEXT:C222(arrInvoicesFT; 0)
C_DATE:C307($refDate; $daybefore)
C_TEXT:C284($queryType; $reportNumType)

$isEFT:=False:C215
$refDate:=initialDate
$daybefore:=Add to date:C393($refDate; 0; 0; -1)
FT_SetReadOnlyTables

// Get the LCTR threshhold

ALL RECORDS:C47([ServerPrefs:27])
$maxLimitLCTR:=[ServerPrefs:27]twoIDsLimit:15

// --------------------------------------------------
// Set 24 hours indicator for all the invoices.
// --------------------------------------------------
$queryType:=getKeyValue("FT.UseAMLRules"; "0")
Case of 
		
	: ($queryType="0")  // By Default: Do not use the AML Agr Rules
		
		FT_Get_LCTR_InvoicesByQuery($refDate; ->arrInvoicesFT; ->arr24HourIndicator)
		
	: ($queryType="1")  // By Default: Do not use the AML Agr Rules
		
		FT_Get_LCTR_InvoicesByRules($refDate; ->arrInvoicesFT; ->arr24HourIndicator)
		
End case 



// --------------------------------------------------
// Create Transactions SET
// --------------------------------------------------

QUERY WITH ARRAY:C644([Invoices:5]InvoiceID:1; arrInvoicesFT)
QUERY SELECTION:C341([Invoices:5]; [Invoices:5]invoiceDate:44=initialDate)
ORDER BY:C49([Invoices:5]BranchID:53; >; [Invoices:5]InvoiceID:1; >; [Invoices:5]CustomerID:2; >; [Invoices:5]invoiceDate:44; >; [Invoices:5]CreationTime:14)

$j:=1
$max:=Records in selection:C76([Invoices:5])

If ($max>0)
	
	// Get Next batch sequence
	$batchSeqId:=FT_NextSequence("LCTR_BatchSeq")
	
	// Get the config information from the fintrac.ini saved in the active 4D Database Folder
	setKeyValue("AML.Reporting.CA.last.report.date"; String:C10(initialDate))
	//FT_GetEntityAndContactInfo 
	
	// Write the headers report
	
	// ---------------------------------------------------------------------------------------------------------
	// Batch Header - The batch header contains information identifying the individual or 
	// institution originating the transmission. There can be only one batch header for 
	// each transmitted file. 
	// ---------------------------------------------------------------------------------------------------------
	FT_GenerateHeader1A($fileName; $batchSeqId; "LCTR")
	
	$totReports:=0
	$reportSeq:=0
	$subSeq:=1
	$subHdr:=0
	$numRepxSubhdr:=0
	
	FIRST RECORD:C50([Invoices:5])
	
	While (($j<=$max) & (Not:C34(End selection:C36([Invoices:5]))))
		
		
		$branchAct:=[Invoices:5]BranchID:53
		$branchRef:=$branchAct
		
		QUERY:C277([Branches:70]; [Branches:70]BranchID:1=$branchAct)
		reportingEntityLocationName:=[Branches:70]BranchName:2
		
		$subHdr:=$subHdr+1
		FT_GenerateHeader1B($fileName; 0; $subHdr)
		
		$numRepxSubhdr:=0
		$a1Seq:=0
		
		
		While (($branchAct=$branchRef) & ($j<=$max))
			
			
			
			$isRelatedIran:=invoiceRelatedIran([Invoices:5]InvoiceID:1; initialDate)
			
			// --------------------------------------------------
			// Create Transactions SET
			// --------------------------------------------------
			C_OBJECT:C1216($registersDebit; $registersCredit; startRegisters; endRegisters)
			C_OBJECT:C1216($reportObj)
			$registersDebit:=FT_GetDebitTxs
			$registersCredit:=FT_GetCrediTxs
			
			QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)
			
			If (($registersDebit.length>0) & (isCustomerReportable([Customers:3]CustomerID:1)))  // Has the invoice Cash Tansactions? No walk-in Customer?
				
				// The batch sub-header contains information that allows you to group reports included in the batch 
				// according to your organizational structure or any other group
				
				REDUCE SELECTION:C351([Registers:10]; 0)
				USE ENTITY SELECTION:C1513($registersDebit)
				FIRST RECORD:C50([Registers:10])
				CLEAR VARIABLE:C89($arrRegisterIDTx)
				
				For ($i; 1; Records in selection:C76([Registers:10]))
					
					QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)
					If ([Accounts:9]isCashAccount:3)
						APPEND TO ARRAY:C911($arrRegisterIDTx; [Registers:10]RegisterID:1)
					End if 
					
					NEXT RECORD:C51([Registers:10])
				End for 
				//SELECTION TO ARRAY([Registers]RegisterID;$arrRegisterIDTx)
				underThreshold:=False:C215
				
				REDUCE SELECTION:C351([Registers:10]; 0)
				USE ENTITY SELECTION:C1513($registersCredit)
				SELECTION TO ARRAY:C260([Registers:10]RegisterID:1; $arrRegisterIDDisp)
				
				
				For ($i; 1; Size of array:C274($arrRegisterIDTx))
					
					// Generate A1 Report Part: Information about where the transaction took place
					$a1Seq:=$a1Seq+1
					$numRepxSubhdr:=$numRepxSubhdr+1
					
					$reportSeqStr:=getReportNumber($a1Seq; $isRelatedIran; "L"; "lctr")
					
					QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$arrRegisterIDTx{$i})
					QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Registers:10]AccountID:6)
					
					FT_GeneratePartA1($fileName; $a1Seq; $reportSeqStr; $i; $isRelatedIran)
					
					$b1Counter:=$b1Counter+1
					FT_PartB1v2($fileName; ->$arrRegisterIDTx; $i; 1)
					$countLines:=$countLines+1
					
					$isEwire:=False:C215
					$b2part:=1
					// Generate Dispositions
					For ($k; 1; Size of array:C274($arrRegisterIDDisp))
						QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$arrRegisterIDDisp{$k})
						
						Case of 
								
							: ([Registers:10]InternalTableNumber:17=Table:C252(->[Wires:8]))
								$isEwire:=True:C214
								
								READ ONLY:C145([Wires:8])
								READ ONLY:C145([WireTemplates:42])
								
								QUERY:C277([Wires:8]; [Wires:8]CXR_WireID:1=[Registers:10]InternalRecordID:18)
								QUERY:C277([WireTemplates:42]; [WireTemplates:42]WireTemplateID:1=[Wires:8]WireTemplateID:83)
								
								$accountType:="A"
								$accountHolder:=""
								$accountOtherDesc:=" "
								
								If ([WireTemplates:42]BeneficiaryIsCompany:39)
									$accountType:="B"
								End if 
								
								C_TEXT:C284($currencyCode; $otherInst)
								$currencyCode:=[Wires:8]Currency:15
								//$b2part:=$b2part+1
								//Part B2: Information about transaction disposition
								
								If ([Wires:8]Currency:15=getKeyValue("TOMCode"; "TOM"))
									$otherInst:=" "
									// $otherInst:=[Links]BankName
									$currencyCode:="IRR"
									$dispositionOfFounds:="B"
									$OnBehalfOfIndicator:=FT_OnBehalfOfIndicator
									
									FT_PartB2($fileName; "B2"; $k; $dispositionOfFounds; " "; " "; [Wires:8]Amount:14*10; $currencyCode; $otherInst; [Links:17]BankName:28; $OnBehalfOfIndicator)
								Else 
									$dispositionOfFounds:="B"
									$OnBehalfOfIndicator:=FT_OnBehalfOfIndicator
									FT_PartB2($fileName; "B2"; $k; $dispositionOfFounds; " "; " "; [Wires:8]Amount:14; $currencyCode; $otherInst; [Links:17]BankName:28; $OnBehalfOfIndicator)
								End if 
								
								//Part C: Account information (if applicable)
								FT_PartC($fileName; "C1"; $k; [Wires:8]BeneficiarySWIFT:28; [Wires:8]BeneficiaryAccountNo:9; $accountType; $accountOtherDesc; [eWires:13]Currency:12; [Wires:8]BeneficiaryFullName:10; $accountHolder; $accountHolder)
								// ----------------------------------------------------------
								
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
								
								C_TEXT:C284($currencyCode; $otherInst)
								$currencyCode:=[eWires:13]Currency:12
								//$b2part:=$b2part+1
								
								//Part B2: Information about transaction disposition
								
								$dispositionOfFounds:="B"
								If ([eWires:13]Currency:12=getKeyValue("TOMCode"; "TOM"))
									$otherInst:=" "
									// $otherInst:=[Links]BankName
									$currencyCode:="IRR"
									
									
									// Part B2: Dispostion of funds:
									// A-Deposit to an account
									// B-Outgoing electronic funds transfer
									// C-Conducted currency exchange
									// E-Purchase of bank draft
									// F-Purchase of money order
									// G-Purchase of traveller's cheques
									// K-Cash out
									// L-Other, Mandatory to Provide a description of "Other"
									
									
									// Questions: 
									
									// How do I know if the Disposition of funds is A-Deposit to an account?
									// How do I know if the Disposition of funds is B-Outgoing electronic funds transfer?
									// How do I know if the Disposition of funds is C-Conducted currency exchange ?
									// How do I know if the Disposition of funds is E-Purchase of bank draft?
									// How do I know if the Disposition of funds is F-Purchase of money order?
									// How do I know if the Disposition of funds is G-Purchase of traveller's cheques?
									// How do I know if the Disposition of funds is K-Cash out?
									// How do I know if the Disposition of funds is L-Other, Mandatory to Provide a description of "Other"?
									
									
									// Part B2: On Behalf Of Indicator:
									// C-Not applicable (on behalf of self, complete Part D)
									// E-On behalf of an entity (complete Part D or Part E, as appropriate, and complete Part F)
									// F-On behalf of another individual (complete Part D and Part G)
									// G-Employee depositing cash to employer's business account (complete Part E). 
									//   To include Part E, for all dispositions within a transaction, the disposition of funds in field 
									//   B8 must be "A" (deposit to an account) and account type in field C3 must be "B" (business).
									
									// Questions: 
									
									// How do I know if the disposition is on behalf of Self?   On Behalf Of Indicator: C-Not applicable 
									//    Because the customer is an individual and we don't have a third party created (customer is the conductor)
									
									
									// How do I know if the disposition is on behalf of a Company? On Behalf Of Indicator: E-On behalf of an entity 
									//    Because the customer is a Company and third party is an Individual (The conductor)
									
									// How do I know if the disposition is on behalf of another Person? On Behalf Of Indicator: F-On behalf of another individual
									//    Because the customer is an individual and the third party is a different Individual  (The conductor)
									
									
									$OnBehalfOfIndicator:=FT_OnBehalfOfIndicator
									FT_PartB2($fileName; "B2"; $k; $dispositionOfFounds; " "; " "; [eWires:13]ToAmount:14*10; $currencyCode; $otherInst; [Links:17]BankName:28; $OnBehalfOfIndicator)
								Else 
									$OnBehalfOfIndicator:=FT_OnBehalfOfIndicator
									FT_PartB2($fileName; "B2"; $k; $dispositionOfFounds; " "; " "; [eWires:13]ToAmount:14; $currencyCode; $otherInst; [Links:17]BankName:28; $OnBehalfOfIndicator)
								End if 
								
								//Part C: Account information (if applicable)
								FT_PartC($fileName; "C1"; $k; [Links:17]BankTransitCode:29; [Links:17]BankAccountNo:31; $accountType; $accountOtherDesc; [eWires:13]Currency:12; [Links:17]FullName:4; $accountHolder; $accountHolder)
								// ----------------------------------------------------------
								
								
							: ([Registers:10]InternalTableNumber:17=Table:C252(->[Cheques:1]))
								
								FT_GeneratePartB2Check($fileName; $arrRegisterIDDisp{$k}; $k)
								
								
							: ([Registers:10]InternalTableNumber:17=Table:C252(->[Accounts:9]))
								
								FT_GeneratePartB2($fileName; <>baseCurrency; [Registers:10]CreditLocal:24; $k)
								
							: ([Registers:10]InternalTableNumber:17=Table:C252(->[CashTransactions:36]))
								If ([Registers:10]RegisterType:4="Sell")
									FT_GeneratePartB2($fileName; [Registers:10]Currency:19; [Registers:10]Credit:7; $k)
								Else 
									FT_GeneratePartB2($fileName; [Registers:10]Currency:19; [Registers:10]Debit:8; $k)
								End if 
								
								
							Else 
								
								FT_GeneratePartB2($fileName; <>baseCurrency; [Registers:10]CreditLocal:24; $k)
								//FT_GeneratePartB2 ($fileName;[Registers]Currency;[Registers]DebitLocal;$k)
						End case 
						
						
						$p:=Find in array:C230(arrInvoicesFT; [Invoices:5]InvoiceID:1)
						
						
						
						QUERY:C277([ThirdParties:101]; [ThirdParties:101]InvoiceID:30=[Invoices:5]InvoiceID:1)
						
						If ([Invoices:5]ThirdPartyisInvolved:22)
							
							
							Case of 
									
								: ([ThirdParties:101]IsCompany:2)
									// PartG : Information about the individual on whose behalf the transaction was conducted 
									FT_GeneratePart_GF_1($fileName)
									
									
								: ([ThirdParties:101]IsCompany:2=False:C215)
									If ([Customers:3]isCompany:41)
										// Part F: Information about the entity on whose behalf the transaction was conduct(if applicable)
										FT_GeneratePart_F1_FromCustomer($fileName)
									Else 
										//FT_GeneratePart_GF_1 ($fileName)
										FT_GeneratePartGFromCustomer($fileName; [Invoices:5]CustomerID:2)
									End if 
									
									
									
							End case 
							
							
							
						End if 
						
						
						
					End for 
					
					
					
					// -----------------------------------------------------------------------------------------------------------
					// Part D: Information about the individual conducting the transaction
					// -----------------------------------------------------------------------------------------------------------
					
					If ([Invoices:5]ThirdPartyisInvolved:22)
						FT_GeneratepartD1_From3Party($fileName)
					Else 
						FT_GeneratePartD1($fileName; [Invoices:5]CustomerID:2)
					End if 
					
					
					
					$countLines:=$countLines+1
					APPEND TO ARRAY:C911($arrOnlyCashTx; $arrRegisterIDTx{$i})
					//FT_createTxReport($arrRegisterIDTx{$i}; ->$a1Seq; ->$numRepxSubhdr; $i; ->$b1Counter; ->$arrRegisterIDDisp)
				End for 
				
				
			End if 
			
			
			NEXT RECORD:C51([Invoices:5])
			$branchAct:=[Invoices:5]BranchID:53
			
			$j:=$j+1
			
		End while 
		
		$totReports:=$totReports+$numRepxSubhdr
		
		DOCUMENT TO BLOB:C525($fileName; $content)
		$report:=Convert to text:C1012($content; "UTF-8")
		
		$tot:=FT_NumberFormat($numRepxSubhdr; 0; 5; "0"; "RJ")
		$report:=Replace string:C233($report; "_RS??"; $tot)
		
		TEXT TO BLOB:C554($report; $content; UTF8 text without length:K22:17)
		BLOB TO DOCUMENT:C526($fileName; $content)
	End while 
	
	QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; $arrOnlyCashTx)
	
	
	
	// --------------------- FOOTER -----------------------------
	
	CLEAR VARIABLE:C89($content)
	$footer:="1C00001"  // It is a Constant
	TEXT TO BLOB:C554($footer; $content; UTF8 text without length:K22:17; *)
	
	AppendBlobToFile($fileName; $content)
	
	C_TEXT:C284($report; $tmp)
	DOCUMENT TO BLOB:C525($fileName; $content)
	$report:=Convert to text:C1012($content; "UTF-8")
	
	$tot:=FT_NumberFormat($subHdr; 0; 5; "0"; "RJ")
	$report:=Replace string:C233($report; "_SH??"; $tot)
	
	$tot:=FT_NumberFormat($totReports; 0; 5; "0"; "RJ")
	$report:=Replace string:C233($report; "_RC??"; $tot)
	
	//For ($i;1;Size of array($reportsToBeReplaced))
	//$tmp:="IR2020"+Substring($reportsToBeReplaced{$i};7)
	//$tmp:=substring("IR2020"+$reportsToBeReplaced{$i};1;20)
	//$report:=Replace string($report;$reportsToBeReplaced{$i};$tmp)
	//End for 
	
	TEXT TO BLOB:C554($report; $content; UTF8 text without length:K22:17)
	BLOB TO DOCUMENT:C526($fileName; $content)
End if 

// Delete Document if there are not transactions

If ($countLines=0)
	If (Test path name:C476($fileName)=Is a document:K24:1)
		DELETE DOCUMENT:C159($filename)
	End if 
End if 
