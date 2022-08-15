
//@Zoya - 8 Oct 2021 - Revised 1 Dec 2021
If (Form event code:C388=On Data Change:K2:15)
	
	pickAccountID("@"+Self:C308->; Self:C308)
End if 

[Bookings:50]AccountID:30:=Self:C308->
READ ONLY:C145([Accounts:9])
QUERY:C277([Accounts:9]; [Accounts:9]AccountID:1=[Bookings:50]AccountID:30)

If (Records in selection:C76([Accounts:9])=1)
	
	If ([Accounts:9]CurrencyAlias:26="")
		QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=[Accounts:9]Currency:6)
	Else 
		
		QUERY:C277([Currencies:6]; [Currencies:6]CurrencyCode:1=[Accounts:9]CurrencyAlias:26)
	End if 
	
	If (Records in selection:C76([Currencies:6])>=1)
		[Bookings:50]Currency:10:=[Currencies:6]CurrencyCode:1
	End if 
	
End if 
setExchangeRate(->[Bookings:50]ourRate:11; ->[Bookings:50]inverseRate:29; getReceivedOrPayString(Num:C11(Not:C34([Bookings:50]isSell:7))); [Currencies:6]OurBuyRateLocal:7; [Currencies:6]OurSellRateLocal:8; True:C214)