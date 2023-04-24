//%attributes = {}
C_TEXT:C284($eWireID; $0; $1)
$eWireID:=$1
READ ONLY:C145([eWires:13])
QUERY:C277([eWires:13]; [eWires:13]eWireID:1=$ewireID)

// more check to see if the transaction is still incomplete

// after that fill in the information for the invoice

[Invoices:5]eWireID:23:=[eWires:13]eWireID:1
//vecFromCurrency{0}:=[eWires]fromCurrency

//vecToCurrency{0}:=[eWires]toCurrency

If ([Invoices:5]CustomerID:2="")  // if the user didn't fill in the customer
	
	RELATE ONE:C42([eWires:13]LinkID:8)  // load the link id
	
	RELATE ONE:C42([Links:17]CustomerID:14)  // load the customer record
	
	vCustomerID:=[Customers:3]CustomerID:1
	[Invoices:5]CustomerID:2:=[Customers:3]CustomerID:1
Else   // user has filled in the customer id
	
	RELATE ONE:C42([eWires:13]LinkID:8)  // load the link id
	
	RELATE ONE:C42([Links:17]CustomerID:14)  // load the customer record
	
	If ([Invoices:5]CustomerID:2#[Customers:3]CustomerID:1)
		myAlert("eWire customer "+[Customers:3]FullName:40+"is different from invoice customer.")
		vCustomerID:=[Customers:3]CustomerID:1
		[Invoices:5]CustomerID:2:=[Customers:3]CustomerID:1
	End if 
End if 
RELATE ONE:C42([Invoices:5]CustomerID:2)

ARRAY TEXT:C222(vecFromCurrency; 1)  // lock the FromCurrency (so user cannot modify it)

vecFromCurrency{1}:=[eWires:13]FromCurrency:11
vecFromCurrency{0}:=[eWires:13]FromCurrency:11
vFromCurrency:=[eWires:13]FromCurrency:11
vToCurrency:=[eWires:13]Currency:12
setFlagPicture(->vFromFlag; [eWires:13]FromCurrency:11)  // assign the flag of buyCurrency

[Invoices:5]fromCurrency:3:=[eWires:13]FromCurrency:11  // assign value of fromCurrency

cbFeePaidSeparately:=0
vServiceFee:=0
vFromAmount:=[eWires:13]FromAmount:13  // one of these value is zero

handleVecFromCurrency([Invoices:5]fromCurrency:3; ->vFromMarketAvg; ->vFromOurBuy; ->vRate1)

If ([eWires:13]ToAmount:14>0)  // deal is closed by channel
	
	// fromAmount and toAmount are entered
	
	// we need to find the ratevecToCurrency{0}:=[eWires]ToCurrency
	
	vecToCurrency{0}:=[eWires:13]Currency:12
	vToAmount:=[eWires:13]ToAmount:14  // one of these values is zero
	
	vExchangeRate:=[eWires:13]ToAmount:14/[eWires:13]FromAmount:13  // from amount is not zero
	
	setFlagPicture(->vToFlag; [eWires:13]Currency:12)
	[Invoices:5]toCurrency:8:=[eWires:13]Currency:12
	lockCalculatorRadioButtons(2)
	handleVecToCurrency([Invoices:5]toCurrency:8; ->vToMarketAvg; ->vToOurSell; ->vRate2)
Else   // deal is open for us to decide about toCurrency 
	
	lockCalculatorRadioButtons(4)
End if 
READ WRITE:C146([eWires:13])
