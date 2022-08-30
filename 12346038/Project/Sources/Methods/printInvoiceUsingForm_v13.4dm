//%attributes = {}
// printInvoiceUsingForm (formName)
//[invoices];"printInvoice_Tabular"

C_LONGINT:C283($tableNum; $i; $j; $n)
C_TEXT:C284($1; $form)

C_REAL:C285(vAmountLocal; vTaxes; vAmountLC)
C_LONGINT:C283($printedHeight)
C_LONGINT:C283($titleBarLine)

C_LONGINT:C283($lineTitleBar; $cashLine1; $cashLine2; $wireLine; $eWireLine; $productLine; $accountLine; $chequeLine; $lastLine; $eWireLine2)

vAmountLocal:=0
vAMountLC:=0

vTaxes:=0  // appears in the bottom of the invoice (adds only for products)

vTax1Received:=0
vTax2Received:=0
//[invoices];"printInvoice_tabular"
Case of 
	: (Count parameters:C259=0)
		$form:="printInvoice_Tabular"
	: (Count parameters:C259=1)
		$form:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$n:=Records in selection:C76([Registers:10])

//FORM LOAD([Invoices];$form)  // this is necessary to get access to the form objects

OBJECT GET COORDINATES:C663(*; "paperArea"; $left; $top; $right; $bottom)  // total printable area
$left:=40
$top:=15
$right:=590
$bottom:=800

$lineTitleBar:=78
$cashLine1:=156  //getObjectBottom ("lineCash1")
$cashLine2:=174  //getObjectBottom ("lineCash2")
$accountLine:=192  //getObjectBottom ("lineAccount")
$chequeLine:=245  //getObjectBottom ("lineCheque")
$productLine:=321  //getObjectBottom ("lineProduct")
$wireLine:=479  //getObjectBottom ("lineWire")
$eWireLine:=610  //getObjectBottom ("lineEWire")  // eWire (first section without the bank details)
//$eWireLine2:=getObjectBottom ("lineEWire2")
$lastLine:=679  //getObjectBottom ("lineLast")

//FORM UNLOAD
// cashTransactions
// accounts
// wires
// eWires
// products
// cheques



PRINT SETTINGS:C106
If (OK=1)
	// print header
	Print form:C5([Invoices:5]; $form; Form header:K43:3)
	
	If (Length:C16([Invoices:5]CustomerFullAddress:59)>2)  // customer has an address (non walk-in)
		Print form:C5([Invoices:5]; $form; Form header1:K43:4)
	End if 
	
	Print form:C5([Invoices:5]; $form; Form header2:K43:5)
	
	For ($i; 1; Records in selection:C76([Registers:10]))
		GOTO SELECTED RECORD:C245([Registers:10]; $i)
		$tableNum:=[Registers:10]InternalTableNumber:17
		C_TEXT:C284($UID)
		$UID:=[Registers:10]InternalRecordID:18
		vAmountLocal:=([Registers:10]Debit:8-[Registers:10]Credit:7)
		
		READ ONLY:C145(Table:C252($tableNum)->)  // to prevent locking during viewing
		queryByID(Table:C252($tableNum); $UID)  // this works like Relate One but works on multiple tables
		
		Case of 
			: ($tableNum=Table:C252(->[CashTransactions:36]))  // cash transactions
				
				READ ONLY:C145([CashInOuts:32])
				QUERY:C277([CashInOuts:32]; [CashInOuts:32]CashTransactionID:1=$UID)  // if there are denominations linked to this cash transaction print the denomination form
				
				If ([CashTransactions:36]Currency:4=<>baseCurrency)
					accumulateReal(->vAmountLC; vAmountLocal)
				End if 
				
				If (Records in selection:C76([CashInOuts:32])>0)
					Print form:C5([Invoices:5]; $form; $lineTitleBar; $cashLine1)  // cash printout larger height
				Else   // no denominations were entered
					Print form:C5([Invoices:5]; $form; $cashLine1; $cashLine2)  // casn form narrow line
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
					Print form:C5([Invoices:5]; $form; $eWireLine; $lastLine)
				End if 
				
			Else   // else case
				
		End case 
		
		$printedHeight:=Get printed height:C702
		If (($printedHeight+35)>=$bottom)  // when we are reaching the bottom of the page, print a break
			Print form:C5([Invoices:5]; $form; Form break0:K43:14)  // close the line
			PAGE BREAK:C6
			Print form:C5([Invoices:5]; $form; Form header:K43:3)  // print the company and invoice #
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
		PAGE BREAK:C6
	End if 
	
End if 