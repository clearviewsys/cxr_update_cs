//%attributes = {}
// acc_fillAccountsListBoxRow (row)
C_LONGINT:C283($i; $1)
$i:=$1

If (False:C215)  // for compiler's sake)
	ewr_initPOListBox
End if 

ewr_arrRowNo{$i}:=$i
ewr_arrewireID{$i}:=[eWires:13]eWireID:1
ewr_arrInvoiceID{$i}:=[eWires:13]InvoiceNumber:29
ewr_arrSendDate{$i}:=[eWires:13]SendDate:2
ewr_arrCustomerName{$i}:=[eWires:13]SenderName:7
RELATE ONE:C42([eWires:13]LinkID:8)
ewr_arrLinkName{$i}:=[Links:17]FullName:4
ewr_arrToAmount{$i}:=[eWires:13]ToAmount:14
//ewr_arrToCurrency{$i}:=[eWires]ToCurrency
//ewr_arrSubject{$i}:=[eWires]Subject

ewr_arrIsSelected{$i}:=True:C214

