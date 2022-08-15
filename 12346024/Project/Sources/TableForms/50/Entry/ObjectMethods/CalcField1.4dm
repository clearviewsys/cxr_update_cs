//@Zoya - 8 Oct 2021 - revised 1 Dec 2021

//If ([Bookings]AccountID="Cash-@") | ([Bookings]AccountID="")
//OBJECT SET ENTERABLE(*;"CalcField1";True)
//pickCurrency (Self)
//Else 
//OBJECT SET ENTERABLE(*;"CalcField1";False)
//End if 

//some improvements are needed here
[Currencies:6]CurrencyCode:1:=[Bookings:50]Currency:10
[Bookings:50]Currency:10:=[Currencies:6]CurrencyCode:1

If (Form event code:C388=On Data Change:K2:15)  //| (Form event=On Losing Focus)
	pickCurrency(Self:C308)
	setExchangeRate(->[Bookings:50]ourRate:11; ->[Bookings:50]inverseRate:29; getReceivedOrPayString(Num:C11(Not:C34([Bookings:50]isSell:7))); [Currencies:6]OurBuyRateLocal:7; [Currencies:6]OurSellRateLocal:8; True:C214)
End if 

//If (Records in selection([Currencies])>=1)

//[Bookings]Currency:=[Currencies]CurrencyCode
//End if 
//[Bookings]Currency:=[Currencies]CurrencyCode
//setExchangeRate (->[Bookings]ourRate;->[Bookings]inverseRate;getReceivedOrPayString (Num(Not([Bookings]isSell)));[Currencies]OurBuyRateLocal;[Currencies]OurSellRateLocal;True)
//  // use the isForced option when you want the rate to be changed no matter what the use has already entered 