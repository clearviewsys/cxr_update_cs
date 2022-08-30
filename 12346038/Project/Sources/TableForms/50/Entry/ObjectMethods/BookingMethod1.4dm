
//@Zoya - Sep 2021 - revised 8 Oct 2021 - revised 1 Dec
If (Form event code:C388=On Data Change:K2:15)
	[Bookings:50]AccountID:30:=""
	Case of 
		: (Self:C308->=c_Cash)
			OBJECT SET ENTERABLE:C238([Bookings:50]Currency:10; True:C214)
			OBJECT SET VISIBLE:C603(*; "AccountID"; False:C215)
			[Bookings:50]AccountID:30:=makeCashAccountID([Bookings:50]Currency:10)
		: (Self:C308->=c_eWire) | (Self:C308->=c_Wire) | (Self:C308->=c_Account)
			OBJECT SET ENTERABLE:C238([Bookings:50]Currency:10; False:C215)
			OBJECT SET VISIBLE:C603(*; "AccountID"; True:C214)
			
		Else 
			OBJECT SET VISIBLE:C603(*; "AccountID"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "AccountID"; True:C214)
			OBJECT SET ENTERABLE:C238([Bookings:50]Currency:10; True:C214)
	End case 
End if 

//Case of 
//: (Self->=c_Cash )
//OBJECT SET ENTERABLE(*;"AccountID";False)
//[Bookings]AccountID:=makeCashAccountID ([Bookings]Currency)

//Else 
//OBJECT SET ENTERABLE(*;"AccountID";True)
//  //[Bookings]AccountID:=""
//GOTO OBJECT([Bookings]AccountID)

//End case 
