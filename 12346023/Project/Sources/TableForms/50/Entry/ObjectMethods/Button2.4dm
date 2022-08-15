
C_TEXT:C284($link)

pickLinkForCustomer(->$link; [Bookings:50]CustomerID:2)
If (OK=1)
	$link:=""
	appendLabelString(->$link; "Beneficiary Name: "; [Links:17]FullName:4; True:C214)
	appendLabelString(->$link; "Bank Name: "; [Links:17]BankName:28; True:C214)
	appendLabelString(->$link; "Branch No.: "; [Links:17]BankTransitCode:29; True:C214)
	appendLabelString(->$link; "Banking info.: "; [Links:17]BankingDetails:9; True:C214)
	appendLabelString(->$link; "Account No.: "; [Links:17]BankAccountNo:31; True:C214)
	appendLabelString(->$link; "Country: "; [Links:17]Country:12; True:C214)
	appendLabelString(->$link; "Relationship : "; [Links:17]Relationship:26; True:C214)
	
	//  //Corrected @Zoya 13 Aug 2021
	
	//  //If ([Bookings]ourRemarks="")
	
	[Bookings:50]ourRemarks:13:=$link
	
	//[Bookings]ourRemarks:="Beneficiary Name: "+[Links]FullName+CRLF +"Bank Name: "+[Links]BankName
	
	
	
	//OBJECT SET FONT STYLE(*;ourRemarks;Bold and Italic)
	//ST SET ATTRIBUTES(*;ourRemarks;0;1;Attribute bold style;1)
	//Else 
	//[Bookings]ourRemarks:=[Bookings]ourRemarks+CRLF +$beneficiary
	//End if 
	
End if 


