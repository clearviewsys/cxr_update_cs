//%attributes = {}
C_TEXT:C284($customerLoginID)
$customerLoginID:=[Customers:3]CustomerID:1

If ([Customers:3]obs_password:48#"")
	QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=$customerLoginID)
	READ WRITE:C146([WebUsers:14])
	If (Records in selection:C76([WebUsers:14])>0)  // if such  alogin id currently exist
		
		LOAD RECORD:C52([WebUsers:14])
	Else 
		CREATE RECORD:C68([WebUsers:14])
		
	End if 
	[WebUsers:14]webUsername:1:=$customerLoginID
	[WebUsers:14]Password:2:=[Customers:3]obs_password:48
	[WebUsers:14]Email:3:=[Customers:3]Email:17
	[WebUsers:14]confirmationToken:6:=[Customers:3]City:8+"/"+[Customers:3]Province:9
	[WebUsers:14]countryCode:7:=[Customers:3]Country_obs:11
	[WebUsers:14]isAllowedAccess_NU:5:=[Customers:3]isAllowedInternetAccess:50
	[WebUsers:14]relatedTable:8:=Table:C252(->[Customers:3])
	[WebUsers:14]recordID:9:=[Customers:3]CustomerID:1
	SAVE RECORD:C53([WebUsers:14])
	UNLOAD RECORD:C212([WebUsers:14])
	READ ONLY:C145([WebUsers:14])
End if 