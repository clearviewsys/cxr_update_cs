C_TEXT:C284(vCustomerID; vAuthorizedUser)
HandleEntryForm(->[Links:17]; ->[Links:17]BranchID:38; ->[Links:17]createdByUser:39; ->[Links:17]modifiedByUser:40)

setApplicationUserForTable(->[Links:17]; ->[Links:17]TouchedByUserID:24; ->[Links:17]TouchedByUserID:24)

If (Form event code:C388=On Load:K2:1)
	GOTO OBJECT:C206(*; "vTitle")
	clearPictureField(->latestLinkIcon7)
	
	If (Record number:C243([Links:17])<0)  // new record
		createLinkID
		If (getNextCustomer#getWalkInCustomerID)
			vCustomerID:=getNextCustomer
			OBJECT SET ENTERABLE:C238([Links:17]CustomerID:14; False:C215)
		Else 
			vCustomerID:=""
			OBJECT SET ENTERABLE:C238([Links:17]CustomerID:14; True:C214)
			
		End if 
		initNextCustomer
		[Links:17]AuthorizedUser:13:=vAuthorizedUser
		[Links:17]CustomerID:14:=vCustomerID
		vAuthorizedUser:=""
		vCustomerID:=""
	End if 
	
	RELATE ONE:C42([Links:17]CustomerID:14)
	[Links:17]CustomerName:15:=[Customers:3]FullName:40  // then rewrite the correct name on top 
	
	getLatestCheckLogStatusIcon(Table:C252(->[Links:17]); [Links:17]LinkID:1; ->latestLinkIcon7; makeFullName([Links:17]FirstName:2; [Links:17]LastName:3))
	getLatestCheckLogStatusIcon(Table:C252(->[Links:17]); [Links:17]LinkID:1; ->latestLinkIcon10; [Links:17]CompanyName:42)
	getAllCheckLogByID(Table:C252(->[Links:17]); [Links:17]LinkID:1)
End if 


If (([Links:17]LinkID:1#"") & (Records in selection:C76([Customers:3])=1))
	OBJECT SET VISIBLE:C603(*; "link@"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "link@"; False:C215)
End if 

