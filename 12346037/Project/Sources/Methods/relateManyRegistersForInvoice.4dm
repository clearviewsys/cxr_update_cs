//%attributes = {}
// WARNING; PRE; vInvoiceNumber must be a valid number before calling this method


C_TEXT:C284(vInvoiceNumber; vLabelDue)
C_REAL:C285(vFromAmount; vToAmounts; vTotalTax1Paid; vSumTax1Received; vSumTax2Paid; vSumTax2Received)
C_REAL:C285(vTax1Received; vTax2Received; vTax1Paid; vTax2Paid; vSumTax1Received; vSumTaxReceived; vSumTaxPaid)

relateMany(->[Registers:10]; ->[Registers:10]InvoiceNumber:10; ->vInvoiceNumber)
orderByRegisters
// everytime it display the registers it must update the sums

vSumDebitsLocal:=Sum:C1([Registers:10]DebitLocal:23)
vSumCreditsLocal:=Sum:C1([Registers:10]CreditLocal:24)
vSumTotalFees:=Sum:C1([Registers:10]totalFees:30)

vTax1Received:=Sum:C1([Registers:10]tax1_Received:31)
vTax1Paid:=Sum:C1([Registers:10]tax1_Paid:33)
vTax2Received:=Sum:C1([Registers:10]tax2_Received:32)
vTax2Paid:=Sum:C1([Registers:10]tax2_Paid:34)

vSumTaxReceived:=vTax1Received+vTax2Received
vSumTaxPaid:=vTax1Paid+vTax2Paid

C_REAL:C285(vDueFromCustomer; vDueToCustomer)

Case of 
	: (vSumDebitsLocal>vSumCreditsLocal)
		vDueFromCustomer:=0
		vDueToCustomer:=vSumDebitsLocal-vSumCreditsLocal
		vLabelDue:="Due payable"
	: (vSumDebitsLocal<vSumCreditsLocal)
		vDueToCustomer:=0
		vDueFromCustomer:=vSumCreditsLocal-vSumDebitsLocal
		vLabelDue:="Due receivable"
	Else 
		vDueToCustomer:=0
		vDueFromCustomer:=0
		vLabelDue:=""
End case 

// if the debits are only in one single currency then add them up
C_TEXT:C284($setName)
$setName:="relatedInvoiceRegisters"
CREATE SET:C116([Registers:10]; $setName)

QUERY SELECTION:C341([Registers:10]; [Registers:10]Debit:8>0)
vFromAmount:=sumSelectionHomogeneous(->[Registers:10]; ->[Registers:10]Currency:19; ->vFromCurrency; ->[Registers:10]Debit:8)
setFlagPicture(->vFromFlag; vFromCurrency)

// if the credits are in a single currency then add them up
USE SET:C118($setName)
QUERY SELECTION:C341([Registers:10]; [Registers:10]Credit:7>0)
vToAmount:=sumSelectionHomogeneous(->[Registers:10]; ->[Registers:10]Currency:19; ->vToCurrency; ->[Registers:10]Credit:7)
setFlagPicture(->vToFlag; vToCurrency)


USE SET:C118($setName)
CLEAR SET:C117($setName)

