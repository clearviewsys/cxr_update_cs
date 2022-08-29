//%attributes = {"shared":true,"publishedWeb":true}

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


If ([WireTemplates:42]WireTemplateID:1="")
	[WireTemplates:42]WireTemplateID:1:=createSerializedID(->[WireTemplates:42]; 10000; "WEB")  //makeWireTemplateID
End if 

Case of 
	: (webContext="agents")
		
		
	: (webContext="customers")
		
		webSelectCustomerRecord
		[WireTemplates:42]CustomerID:2:=[Customers:3]CustomerID:1
		
End case 

$0:=1  //OK to save