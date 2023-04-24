//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 04/24/18, 21:36:17
// ----------------------------------------------------
// Method: webCreateBookings
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1; $ptrNameArray)
C_POINTER:C301($2; $ptrValueArray)
C_LONGINT:C283($0)


Case of 
	: (webContext="agents")
		
		
	: (webContext="customers")
		
		webSelectCustomerRecord
		
		[WebAttachments:86]RelatedTableNum:11:=Table:C252(->[Customers:3])
		[WebAttachments:86]RelatedID:2:=[Customers:3]CustomerID:1
		
		If ([WebAttachments:86]FileName:5="")
			[WebAttachments:86]FileName:5:="TEMP"  //this will get set later - need this for validation
		End if 
		
		If ([WebAttachments:86]FilePath:3="")
			[WebAttachments:86]FilePath:3:="TEMP"
		End if 
		
End case 

$0:=1