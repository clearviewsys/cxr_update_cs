HandleEntryForm

If (Form event code:C388=On Load:K2:1)
	GOTO OBJECT:C206([eWires:13]LinkID:8)
End if 

If (onNewRecordEvent)
	//[eWires]isPaymentSent:=True
	//[eWires]fromCountry:=◊CompanyCountry
	//[eWires]toCountry:=""
	
End if 


If (onModifyRecordEvent)
	RELATE ONE:C42([eWires:13]LinkID:8)
End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	If ([eWires:13]isPaymentSent:20)  // customer -> link
		[eWires:13]fromCountry:9:=<>CompanyCountry
		[eWires:13]toCountry:10:=[Links:17]Country:12
	Else   // receving money link -> Customer
		[eWires:13]fromCountry:9:=[Links:17]Country:12
		[eWires:13]toCountry:10:=<>CompanyCountry
	End if 
End if 

RELATE ONE:C42([Links:17]AuthorizedUser:13)


//SET ENTERABLE([eWires]isCancelled;(([eWires]isPaymentSent=True) & ([eWires]isMoneyPaid=False)))
If ([eWires:13]isSettled:23)
	OBJECT SET ENTERABLE:C238([eWires:13]isUnlisted:35; True:C214)
Else 
	OBJECT SET ENTERABLE:C238([eWires:13]isUnlisted:35; [eWires:13]isCancelled:34)
End if 