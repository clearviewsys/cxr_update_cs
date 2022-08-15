//%attributes = {}
// acc_fillAccountsListBoxRow (row)
C_LONGINT:C283($i; $1)
$i:=$1

If (False:C215)  // for compiler's sake)
	ewr_initeWiresListBox
End if 

ewr_arrewireID{$i}:=[eWires:13]eWireID:1
ewr_arrChannelConfirmationNo{$i}:=[eWires:13]ReferenceNo:28
ewr_arrSendDate{$i}:=[eWires:13]SendDate:2
ewr_arrCustomerName{$i}:=[eWires:13]SenderName:7
ewr_arrisPaymentSent{$i}:=[eWires:13]isPaymentSent:20
ewr_arrisCancelled{$i}:=[eWires:13]isCancelled:34
ewr_arrForeignAccount{$i}:=[eWires:13]AccountID:30
ewr_arrFromAmount{$i}:=[eWires:13]FromAmount:13
ewr_arrfromCountry{$i}:=[eWires:13]fromCountry:9
ewr_arrFromCurrency{$i}:=[eWires:13]FromCurrency:11
ewr_arrToAmount{$i}:=[eWires:13]ToAmount:14
ewr_arrtoCountry{$i}:=[eWires:13]toCountry:10
ewr_arrToCurrency{$i}:=[eWires:13]Currency:12
ewr_arrisPaymentSent{$i}:=[eWires:13]isPaymentSent:20
ewr_arrisMoneyPaid{$i}:=[eWires:13]isSettled:23
ewr_arrSubject{$i}:=[eWires:13]Subject:6
RELATE ONE:C42([eWires:13]LinkID:8)
ewr_arrLinkName{$i}:=[Links:17]FullName:4

