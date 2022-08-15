//%attributes = {}
ARRAY TEXT:C222(arrPartnerBank; 0)

QUERY:C277([Links:17]; [Links:17]LinkID:1=arrLinkIDs{arrLinkIDs})
[eWires:13]LinkID:8:=[Links:17]LinkID:1
If ([eWires:13]isPaymentSent:20)
	//[eWires]toCountry:=[Links]Country
Else 
	//[eWires]fromCountry:=[Links]Country
End if 
[eWires:13]SenderName:7:=[Links:17]CustomerName:15

//fillArrayWithAccounts (->arrPartnerBank;vToCurrency;True;[Links]AuthorizedUser)
