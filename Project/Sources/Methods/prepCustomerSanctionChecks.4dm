//%attributes = {}
// prepCustomerSanctionChecks($listObjectName;$statusDisplayName;$tableNum;{$forced;{$useWhitelistExpiry})
//
// setup the parameters for handleSanctionListDropDown. It is good for [Customer] table
// Author: Wai-Kin
C_TEXT:C284($listObjectName; $1; $statusDisplayName; $2; $holdMessage; $statusDisplayName; $listObjectName; $recordId)
C_LONGINT:C283($tableNum; $3)
C_BOOLEAN:C305($forced; $useWhitelistExpiry; $4; $useWhitelistExpiry; $5)
Case of 
	: (Count parameters:C259=3)
		$listObjectName:=$1
		$statusDisplayName:=$2
		$tableNum:=$3
		$forced:=<>doCheckSanctionLists
		$useWhitelistExpiry:=False:C215
	: (Count parameters:C259=4)
		$listObjectName:=$1
		$statusDisplayName:=$2
		$tableNum:=$3
		$forced:=$4
		$useWhitelistExpiry:=False:C215
	: (Count parameters:C259=5)
		$listObjectName:=$1
		$statusDisplayName:=$2
		$tableNum:=$3
		$forced:=$4
		$useWhitelistExpiry:=$5
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129(Is table number valid:C999($tableNum))

C_OBJECT:C1216($details)
C_TEXT:C284($firstName; $lastName)
C_TEXT:C284($recordId)
Case of 
	: ($tableNum=Table:C252(->[Customers:3]))
		$details:=New object:C1471
		
		If ($useWhitelistExpiry)
			// White list - add if there if you need it
			$details.AML_isWhitelisted:=[Customers:3]AML_isWhitelisted:131
			$details.AML_WhitelistExpiryDate:=[Customers:3]AML_WhitelistExpiryDate:130
		End if 
		
		$details.Gender:=[Customers:3]Gender:120
		$details.DOB:=[Customers:3]DOB:5
		
		// address - only CountryCode is used to match, but MemberCheck will store the whole address
		$details.Address:=[Customers:3]Address:7
		$details.City:=[Customers:3]City:8
		$details.Province:=[Customers:3]Province:9
		$details.PostalCode:=[Customers:3]PostalCode:10
		$details.CountryCode:=[Customers:3]CountryCode:113
		
		// Required
		$firstName:=[Customers:3]FirstName:3
		$lastName:=[Customers:3]LastName:4
		$recordId:=[Customers:3]CustomerID:1
		
		$holdMessage:=handleSanctionListDropDown($listObjectName; $statusDisplayName; $tableNum; $recordId; $firstName; $lastName; $details; $forced)
		If ($holdMessage#"")
			[Customers:3]isOnHold:52:=True:C214
			[Customers:3]AML_OnHoldNotes:127:=$holdMessage
		End if 
End case 