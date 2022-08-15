C_TEXT:C284(vSearchText)
C_LONGINT:C283(slb_picker)  // selection based listboxes are always a longint



If (Form event code:C388=On Activate:K2:9)
	GOTO OBJECT:C206(vSearchText)
	//handleAutoFillSearch(->vSearchText; Current form table; ->[Customers]CustomerID; ->[Customers]FullName; ->[Customers]FullName)
	handlePickFormSearchField(->vSearchText; ->[Customers:3]; ->[Customers:3]CustomerID:1; ->[Customers:3]FullName:40; ->[Customers:3]FullName:40)  //
	
End if 
handleCustomerRedFlagSigns
//showObjectOnTrue (([Customers]isOnHold | [Customers]AML_isSuspicious);"onHold@")
//showObjectOnTrue (isPictureIDExpired ([Customers]PictureID_ExpiryDate);"oExpired@")
showObjectOnTrue(isCustomerDueForKYCReview; "needsReview@")
//showObjectOnTrue ([Customers]isAccount;"isAccount@")
//stampText ("onHOLD";"ON HOLD 😞";"red";[Customers]isOnHold)
//stampText ("expiredID";"Expired 😐";"red";isPictureIDExpired ([Customers]PictureID_ExpiryDate))
//stampText ("needsReview";"Needs Review ✖";"black";isCustomerDueForReview )

If (Form event code:C388=On Double Clicked:K2:5)
	handlepickCustomerButton
End if 