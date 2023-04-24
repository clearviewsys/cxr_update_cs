//%attributes = {"shared":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 10/10/18, 16:55:09
// ----------------------------------------------------
// Method: webDefaultValues_Links
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_POINTER:C301($1; $ptrNameArray)
C_POINTER:C301($2; $ptrValueArray)
C_LONGINT:C283($0)

C_TEXT:C284($name; $sanctionCheckResult)
C_LONGINT:C283($iTable; $iMatch)
C_BOOLEAN:C305($isEntity; $isForced)

//agent or customer creating this

If ([Links:17]LinkID:1="NEW")
	[Links:17]LinkID:1:=createSerializedID(->[Links:17]; 10000; "WW")
End if 



Case of 
	: (webContext="agents")
		webSelectAgentRecord
		
		[Links:17]Country:12:=[Agents:22]Country:5
		[Links:17]countryCode:50:=[Agents:22]CountryCode:21
		
		[Links:17]CreationDate:20:=Current date:C33
		[Links:17]createdByUser:39:="WEB-"+[Agents:22]FullName:6
		[Links:17]CreationTime:21:=Current time:C178
		
		[Links:17]UnconfirmedCustomerName:18:=[Links:17]FullName:4
		
		//add sanctonlist validaton
		
		C_TEXT:C284($iID)
		If ([Links:17]FirstName:2#"") & ([Links:17]LastName:3#"")
			
			
			$name:=makeFullName([Links:17]FirstName:2; [Links:17]LastName:3)
			$iTable:=Table:C252(->[Links:17])
			$isEntity:=False:C215
			$isForced:=True:C214
			$iMatch:=-9999
			$sanctionCheckResult:=checkNameAgainstAllLists($name; ->$iMatch; $isEntity; $iTable; $iID; $isForced)  //  saves sanction lists checks for this link
		End if 
		
		If ([Links:17]CompanyName:42#"")
			$name:=[Links:17]CompanyName:42
			$iTable:=Table:C252(->[Links:17])
			$isEntity:=True:C214
			$isForced:=True:C214
			$iMatch:=-9999
			$sanctionCheckResult:=checkNameAgainstAllLists($name; ->$iMatch; $isEntity; $iTable; $iID; $isForced)  //  saves sanction lists checks for this link
		End if 
		
		
	: (webContext="customers")
		webSelectCustomerRecord
		
		[Links:17]CustomerID:14:=[Customers:3]CustomerID:1
		[Links:17]CustomerBankInfo:17:=[Customers:3]BankInfo1_obs:44
		[Links:17]CustomerName:15:=[Customers:3]FullName:40
		[Links:17]CustomerPhone:16:=[Customers:3]CellPhone:13
		
		
		If ([Links:17]CreationDate:20=!00-00-00!)  //new record
			[Links:17]CreationDate:20:=Current date:C33
			[Links:17]createdByUser:39:="WEB-"+[Customers:3]LastName:4
			[Links:17]CreationTime:21:=Current time:C178
		Else 
			[Links:17]ModificationDate:22:=Current date:C33
			[Links:17]ModificationTime:23:=Current time:C178
			[Links:17]modifiedByUser:40:="WEB-"+[Customers:3]LastName:4
		End if 
		
		If ([Links:17]Relationship:26="-Select@")
			[Links:17]Relationship:26:=""
		End if 
		
		If ([Links:17]FullName:4="")
			If ([Links:17]isCompany:43)
				[Links:17]FullName:4:=[Links:17]CompanyName:42
			Else 
				[Links:17]FullName:4:=makeFullName([Links:17]FirstName:2; [Links:17]LastName:3)
			End if 
		End if 
		
		
		If ([Links:17]countryCode:50="")
			[Links:17]countryCode:50:=getCountryCode([Links:17]Country:12)
		Else 
			[Links:17]Country:12:=getCountryNameByCode([Links:17]countryCode:50)
		End if 
		
	Else 
		
End case 

//webSendRecordChangeEmail (->[Links])

$0:=1  //OK to save