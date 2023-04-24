//%attributes = {}


C_POINTER:C301($1; $ptrNameArray)
C_POINTER:C301($2; $ptrValueArray)
C_LONGINT:C283($0; $iResult)

C_TEXT:C284($tContext; $tOptIn)
C_LONGINT:C283($iElem)

If ([Customers:3]CustomerID:1="NEW")
	[Customers:3]CustomerID:1:=""
End if 

If ([Customers:3]CustomerID:1="")
	[Customers:3]CustomerID:1:=createSerializedID(->[Customers:3]; 100000; "WEB")  //makeCustomerID
End if 


$tContext:=WAPI_getSession("context")


Case of 
	: ($tContext="customers")  //new profile
		
		If (Is new record:C668([Customers:3]))
			Case of 
				: ([Customers:3]Gender:120="M@")
					[Customers:3]Salutation:2:="Mr"
				: ([Customers:3]Gender:120="F@")
					[Customers:3]Salutation:2:="Ms"
				Else 
					
			End case 
			
			[Customers:3]CellPhone:13:=strRemoveNonNumeric([Customers:3]CellPhone:13)
			[Customers:3]HomeTel:6:=strRemoveNonNumeric([Customers:3]HomeTel:6)
			[Customers:3]WorkTel:12:=strRemoveNonNumeric([Customers:3]WorkTel:12)
			[Customers:3]WorkFax:46:=strRemoveNonNumeric([Customers:3]WorkFax:46)
			[Customers:3]RefPhone1:33:=strRemoveNonNumeric([Customers:3]RefPhone1:33)
			[Customers:3]BusinessPhone1:63:=strRemoveNonNumeric([Customers:3]BusinessPhone1:63)
			[Customers:3]BusinessPhone2:64:=strRemoveNonNumeric([Customers:3]BusinessPhone2:64)
			
			[Customers:3]Country_obs:11:=getCountryNameByCode([Customers:3]CountryCode:113)
			
			//---- assuming mailing country is country of residence----
			[Customers:3]CountryOfResidenceCode:114:=[Customers:3]CountryCode:113
			[Customers:3]CountryOfResidence_obs:61:=[Customers:3]Country_obs:11
			
			[Customers:3]Email:17:=WAPI_getSession("email")  //this is the link to the webUsers table
			[Customers:3]isOnHold:52:=True:C214
			[Customers:3]AML_OnHoldNotes:127:="Web profile unapproved"
			[Customers:3]approvalStatus:146:=3  //set to not approved
			[Customers:3]isAllowedInternetAccess:50:=True:C214
			[Customers:3]CreatedByUserID:58:="WEB-"+WAPI_getSession("username")
			[Customers:3]CreationDate:54:=Current date:C33
			[Customers:3]CreationTime:55:=Current time:C178
			
			
			webSelectWebUserRecord(False:C215)
			[WebUsers:14]requestDate:21:=Current date:C33
			SAVE RECORD:C53([WebUsers:14])
			UNLOAD RECORD:C212([WebUsers:14])
			READ ONLY:C145([WebUsers:14])
			
		Else 
			
			
		End if 
		
		$iResult:=1  //OK to save
		
	: ($tContext="agents")
		
		$iResult:=0
	Else 
		
		$iResult:=0
End case 

$0:=$iResult