//%attributes = {}

// ----------------------------------------------------
// User name (OS): milan
// Date and time: 06/10/21, 13:11:27
// ----------------------------------------------------
// Method: mgQR_getReceiver
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)


If ([WebEWires:149]paymentInfo:35#Null:C1517)
	
	If ([WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverLastName#Null:C1517)
		
		$0:=[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverFirstName+" "+[WebEWires:149]paymentInfo:35.passedToMoneyGram.receiverLastName
		
	End if 
	
End if 
