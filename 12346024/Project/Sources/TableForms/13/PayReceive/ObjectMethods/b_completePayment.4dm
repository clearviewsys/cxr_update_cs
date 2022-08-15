If ([eWires:13]isPaymentSent:20)
	[eWires:13]AccountID:30:=getAgentSettledAccountID([Links:17]AuthorizedUser:13; [eWires:13]isPaymentSent:20; [eWires:13]Currency:12)
Else 
	[eWires:13]AccountID:30:=getAgentSettledAccountID([Links:17]AuthorizedUser:13; [eWires:13]isPaymentSent:20; [eWires:13]FromCurrency:11)
End if 
[eWires:13]isSettled:23:=True:C214