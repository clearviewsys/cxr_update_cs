//%attributes = {"publishedWeb":true}
//If (True)
//webSendErrorMsg ("Please contact the head office for modification to this profile. You may send a m"+"odification request using eMessage. ")
//Else 
//webBUpdate (->[Links];->[Links]LinkID;->webLinkID)
//End if 


// new in version 3.330


C_TEXT:C284(webLinkID; webFirstName; webLastName)

web_ValidateLinks

If (checkErrorExist)
	web_SendErrorMsg(checkGetErrorString)
Else 
	web_BUpdate(->[Links:17]; ->[Links:17]LinkID:1; ->webLinkID)
End if 