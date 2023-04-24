//%attributes = {}
// printInvoiceUsingForm_v17 ("printInvoice_Large") 
// printInvoiceUsingForm (formName)
//[invoices];"printInvoice_Tabular"

C_LONGINT:C283($tableNum; $i; $j; $n; $x)

C_TEXT:C284($1; $form)

C_REAL:C285(vAmountLocal; vTaxes; vAmountLC)
C_LONGINT:C283($printedHeight)
C_LONGINT:C283($titleBarLine)
C_LONGINT:C283($lineCashInOut2; $lineCashInOut; $lineTitleBar; $cashLine1; $cashLine2; $wireLine; $eWireLine; $productLine; $accountLine; $chequeLine; $lastLine; $eWireLine2)
C_LONGINT:C283($customerAddressTop; $cutomerIDBottom; $customerAddressBottom; $customerCellTop; $customerCellBottom; $customerSOFTop; $customerSOFBottom; $customerPOTTop; $customerPOTBottom)
C_TEXT:C284($isDisplayAddress; $isDisplayCell; $isDisplaySOF; $isDisplayPOT)

vAmountLocal:=0
vAMountLC:=0
vTaxes:=0  // appears in the bottom of the invoice (adds only for products)

vTax1Received:=0
vTax2Received:=0
//[invoices];"print_tabular"

Case of 
	: (Count parameters:C259=0)
		$form:="print_Tabular"
	: (Count parameters:C259=1)
		$form:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$n:=Records in selection:C76([Registers:10])

FORM LOAD:C1103([Invoices:5]; $form)  // this is necessary to get access to the form objects

// Adjust Size depending on printing type
// Define the paper size and printer to be used
C_TEXT:C284($printerName; $paperName)
C_LONGINT:C283($left; $top; $right; $bottom)
Case of 
	: ($form="print_Medium")
		//Get Customers Printer name and paper Size
		//$printerName:=getKeyValue()
		//$paperName:=getKeyValue()
		SET CURRENT PRINTER:C787(PDFCreator Printer name:K47:13)
		SET PRINT OPTION:C733(Paper option:K47:1; "A5")
		SET PRINT PREVIEW:C364(False:C215)
		$left:=40
		$top:=15
		$right:=590
		$bottom:=565
		
	: ($form="print_Thermal")
		//Get Customers Printer name and paper Size
		//$printerName:=getKeyValue()
		//$paperName:=getKeyValue()
		SET CURRENT PRINTER:C787(PDFCreator Printer name:K47:13)
		SET PRINT PREVIEW:C364(False:C215)
		$left:=40
		$top:=15
		$right:=590
		$bottom:=50000
	Else 
		//Get Customers Printer name and paper Size
		//$printerName:=getKeyValue()
		//$paperName:=getKeyValue()
		
		// Choose printer name
		SET CURRENT PRINTER:C787(PDFCreator Printer name:K47:13)
		// Choose Paper name
		SET PRINT OPTION:C733(Paper option:K47:1; "Letter")
		// Show print preview (yes/no)
		SET PRINT PREVIEW:C364(False:C215)
		//OBJECT GET COORDINATES(*;"paperArea";$left;$top;$right;$bottom)  // total printable area
		$left:=40
		$top:=15
		$right:=590
		$bottom:=800
End case 


$lineTitleBar:=getObjectBottom("lineTitleBar")  // 78
$cashLine1:=getObjectBottom("lineCash1")  // 156
$cashLine2:=getObjectBottom("lineCash2")  // 174 247  //
$accountLine:=getObjectBottom("lineAccount")  // 298  //
$chequeLine:=getObjectBottom("lineCheque")  // 351  //
$productLine:=getObjectBottom("lineProduct")  // 427  //  
$wireLine:=getObjectBottom("lineWire")  // 585  // 
$eWireLine:=getObjectBottom("lineEWire")  // eWire (first section without the bank details) 716  //
//$eWireLine2:=getObjectBottom ("lineEWire2")
$lastLine:=getObjectBottom("lineLast")  // 785  // 
$lineCashInOut:=getObjectBottom("lineCashInOut")
$lineCashInOut2:=getObjectBottom("lineCashInOut2")

//FORM UNLOAD
// cashTransactions
// accounts
// wires
// eWires
// products
// cheques

C_TEXT:C284(vInvoiceCanceled)
If ([Registers:10]isCancelled:59)
	vInvoiceCanceled:="Invoice Cancelled"
Else 
	vInvoiceCanceled:=""
End if 


PRINT SETTINGS:C106
If (OK=1)
	// print header
	C_LONGINT:C283($customerNameTop)
	$customerNameTop:=getObjectTop("CustomersFullName")
	Print form:C5([Invoices:5]; $form; 0; $customerNameTop)
	
	$customerAddressTop:=getObjectTop("CustomerAddress")
	If (Length:C16([Invoices:5]CustomerFullAddress:59)>2)  // customer has an address (non walk-in)
		C_LONGINT:C283($cutomerIDBottom)
		$cutomerIDBottom:=getObjectBottom("CustomersID")
		Print form:C5([Invoices:5]; $form; $customerNameTop; $cutomerIDBottom)
	End if 
	
	// Displays Address, Phone, SOF, POT according to user preference
	$isDisplayAddress:=getKeyValue("print.format.isDisplayAddress"; "false")
	If ($isDisplayAddress="true")
		$customerAddressBottom:=getObjectBottom("CustomerAddress")
		Print form:C5([Invoices:5]; $form; $customerAddressTop; $customerAddressBottom)
	End if 
	
	$isDisplayCell:=getKeyValue("print.format.isDisplayPhone"; "false")
	If ($isDisplayCell="true")
		$customerCellTop:=getObjectTop("CustomerCell")
		$customerCellBottom:=getObjectBottom("CustomerCell")
		Print form:C5([Invoices:5]; $form; $customerCellTop; $customerCellBottom)
	End if 
	
	$isDisplaySOF:=getKeyValue("print.format.isDisplaySourceOfFunds"; "false")
	If ($isDisplaySOF="true")
		$customerSOFTop:=getObjectTop("CustomerSOF")
		$customerSOFBottom:=getObjectBottom("CustomerSOF")
		Print form:C5([Invoices:5]; $form; $customerSOFTop; $customerSOFBottom)
	End if 
	
	$isDisplayPOT:=getKeyValue("print.format.isDisplayPurposeOfTransaction"; "false")
	If ($isDisplayPOT="true")
		$customerPOTTop:=getObjectTop("CustomerPOT")
		$customerPOTBottom:=getObjectBottom("CustomerPOT")
		Print form:C5([Invoices:5]; $form; $customerPOTTop; $customerPOTBottom)
	End if 
	
	Print form:C5([Invoices:5]; $form; Form header2:K43:5)
	
	For ($i; 1; Records in selection:C76([Registers:10]))
		GOTO SELECTED RECORD:C245([Registers:10]; $i)
		$tableNum:=[Registers:10]InternalTableNumber:17
		C_TEXT:C284($UID; vFeeString; vDiscountString; vRateString; vQtyAndPrice)
		$UID:=[Registers:10]InternalRecordID:18
		vAmountLocal:=([Registers:10]Debit:8-[Registers:10]Credit:7)
		
		READ ONLY:C145(Table:C252($tableNum)->)  // to prevent locking during viewing
		queryByID(Table:C252($tableNum); $UID)  // this works like Relate One but works on multiple tables
		
		// Display fees only if there is a fee
		If ([Registers:10]totalFees:30>0)
			vFeeString:="Fee: "+String:C10([Registers:10]totalFees:30; "|Currency")
		Else 
			vFeeString:=""
		End if 
		
		// Display Rate only if the Rate is not 1 (local Currency)
		If ([Registers:10]OurRate:25=1)
			vRateString:=""
		Else 
			vRateString:="Rate: "+String:C10([Registers:10]OurRate:25; "|Rates")+"  /  Inv. Rate: "+String:C10((1/[Registers:10]OurRate:25); "|Rates")
		End if 
		
		// Display Discount For Products only if discount is applied to purchase
		If ([ItemInOuts:40]discount:33=0)
			vDiscountString:=""
		Else 
			vDiscountString:="Discount: "+String:C10([ItemInOuts:40]discount:33; "|Percent")
		End if 
		
		// Get Flag pictures for display
		QUERY:C277([Flags:19]; [Flags:19]CurrencyCode:1=[Registers:10]Currency:19)
		// Quantity and Unit Price of Products sold
		vQtyAndPrice:="Qty:  "+String:C10([ItemInOuts:40]Qty:8)+"       Unit Price:  "+String:C10([ItemInOuts:40]UnitPrice:9)
		
		
		Case of 
			: ($tableNum=Table:C252(->[CashTransactions:36]))  // cash transactions
				
				READ ONLY:C145([CashInOuts:32])
				QUERY:C277([CashInOuts:32]; [CashInOuts:32]CashTransactionID:1=$UID)  // if there are denominations linked to this cash transaction print the denomination form
				ORDER BY:C49([CashInOuts:32]; [CashInOuts:32]Denomination:7; <)
				
				If ([CashTransactions:36]Currency:4=<>baseCurrency)
					accumulateReal(->vAmountLC; vAmountLocal)
				End if 
				
				If ((Records in selection:C76([CashInOuts:32])>0))  // For printing denominations or large comments
					// TODO There are records in cashinouts, for each records print a line (The line needs to be added in the form.)
					Print form:C5([Invoices:5]; $form; $lineTitleBar; $cashLine1)  // Print Cash form denomination line
					C_TEXT:C284(vDispalyDenomination)
					For ($x; 1; Records in selection:C76([CashInOuts:32]))
						GOTO SELECTED RECORD:C245([CashInOuts:32]; $x)
						If ($x=1)
							vDispalyDenomination:="In Denominations of:"
						Else 
							vDispalyDenomination:=""
						End if 
						
						
						Case of 
							: ([CashInOuts:32]QtyIN:8>0)
								If (Records in selection:C76([CashInOuts:32])=$x)
									Print form:C5([Invoices:5]; $form; $lineCashInOut+1; $lineCashInOut2)
								Else 
									Print form:C5([Invoices:5]; $form; $lineCashInOut+1; $lineCashInOut2-1)
								End if 
								
							: ([CashInOuts:32]QtyOut:9>0)
								If (Records in selection:C76([CashInOuts:32])=$x)
									Print form:C5([Invoices:5]; $form; $lineCashInOut2+1; $lastLine)
								Else 
									Print form:C5([Invoices:5]; $form; $lineCashInOut2+1; $lastLine-1)
								End if 
						End case 
					End for 
				Else 
					Print form:C5([Invoices:5]; $form; $cashLine1; $cashLine2)  // cash form narrow line
				End if 
				
				
				
				
			: ($tableNum=Table:C252(->[AccountInOuts:37]))  // account transactions
				Print form:C5([Invoices:5]; $form; $cashLine2; $accountLine)
				
			: ($tableNum=Table:C252(->[Cheques:1]))  // cheque transactions
				Print form:C5([Invoices:5]; $form; $accountLine; $chequeLine)
				
			: ($tableNum=Table:C252(->[ItemInOuts:40]))  // product transactions
				
				RELATE ONE:C42([ItemInOuts:40]ItemID:2)  // load the product
				//If ([ProductRows]isSold)
				vTaxes:=vTaxes+[ItemInOuts:40]tax1:20+[ItemInOuts:40]tax2:21
				//End if 
				Print form:C5([Invoices:5]; $form; $chequeLine; $productLine)
				
			: ($tableNum=Table:C252(->[Wires:8]))  // wire transactions
				Print form:C5([Invoices:5]; $form; $productLine; $wireLine)
				
			: ($tableNum=Table:C252(->[eWires:13]))  // eWire Transactions
				Print form:C5([Invoices:5]; $form; $wireLine; $eWireLine)
				
				If ([eWires:13]doTransferToBank:33)
					Print form:C5([Invoices:5]; $form; $eWireLine; $lineCashInOut)
				End if 
				
			Else   // else case
				
		End case 
		
		$printedHeight:=Get printed height:C702
		If (($printedHeight+35)>=$bottom)  // when we are reaching the bottom of the page, print a break
			Print form:C5([Invoices:5]; $form; Form break0:K43:14)  // close the line
			// The parameter '>' prints pages as one document instead of seperate documents @viktor
			PAGE BREAK:C6(>)
			Print form:C5([Invoices:5]; $form; 0; $customerNameTop)  // print the company and invoice #
			Print form:C5([Invoices:5]; $form; Form header2:K43:5)  // reprint the headers for the subsequent page breaks
		End if 
		
		
	End for 
	// print the break
	Print form:C5([Invoices:5]; $form; Form break0:K43:14)
	C_TEXT:C284(vLabelDue)
	If (vAmountLC>0)
		vLabelDue:=getLocalizedKeyword("cash_received")+" "+<>baseCurrency
	Else 
		vLabelDue:=getLocalizedKeyword("cash_paid")+" "+<>baseCurrency
	End if 
	vAmountLC:=Abs:C99(vAmountLC)
	
	// print footer
	Print form:C5([Invoices:5]; $form; Form footer:K43:2)
	$printedHeight:=Get printed height:C702
	If ($printedHeight>=$bottom)
		PAGE BREAK:C6(>)
	End if 
	
End if 