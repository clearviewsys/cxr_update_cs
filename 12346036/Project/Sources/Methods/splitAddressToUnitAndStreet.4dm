//%attributes = {}
//Amir 18th May 2020
//seperates mixed street address and unit number into parts
//C_OBJECT{"streetAddress";"unitNumber"}:=splitAddressTextToUnitAndAddress("street address containing both street and unit number")

// Unit test is written @Nora
C_TEXT:C284($mixedStreetAddress; $1)

ASSERT:C1129(Count parameters:C259=1)
$mixedStreetAddress:=$1
ASSERT:C1129(Type:C295($mixedStreetAddress)=Is text:K8:3)

C_OBJECT:C1216($streetAddressObj; $0)

$streetAddressObj:=New object:C1471("streetAddress"; ""; "unitNumber"; "")
If ($mixedStreetAddress#"")
	C_COLLECTION:C1488($addressCol)
	C_BOOLEAN:C305($shouldContinueSearch)
	
	If (Position:C15(","; $mixedStreetAddress)#0)  //comma seperated, for example 123 test st, unit 100
		$addressCol:=Split string:C1554($mixedStreetAddress; ","; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	End if 
	
	If (Position:C15("-"; $mixedStreetAddress)#0)  //dash seperated, for example 100 - 123 test st
		$addressCol:=Split string:C1554($mixedStreetAddress; "-"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	End if 
	
	If (Position:C15("/"; $mixedStreetAddress)#0)  //slash seperated, for example 100 / 123 test st
		$addressCol:=Split string:C1554($mixedStreetAddress; "/"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	End if 
	
	If ($addressCol.length=2)
		$shouldContinueSearch:=True:C214
	End if 
	
	If ($shouldContinueSearch)
		C_TEXT:C284($collectionItem; $lowercaseItem)
		C_BOOLEAN:C305($unitNumberPatternMatched)
		$unitNumberPatternMatched:=False:C215
		For each ($collectionItem; $addressCol)
			$lowercaseItem:=Lowercase:C14($collectionItem)
			Case of 
				: (Match regex:C1019("^[0-9]*$"; $collectionItem))
					$streetAddressObj.unitNumber:=$collectionItem
					$unitNumberPatternMatched:=True:C214
				: (Match regex:C1019("^unit [0-9]*$"; $lowercaseItem))
					$streetAddressObj.unitNumber:=Replace string:C233($lowercaseItem; "unit "; "")
					$unitNumberPatternMatched:=True:C214
				: (Match regex:C1019("^unit number [0-9]*$"; $lowercaseItem))
					$streetAddressObj.unitNumber:=Replace string:C233($lowercaseItem; "unit number "; "")
					$unitNumberPatternMatched:=True:C214
				: (Match regex:C1019("^suite [0-9]*$"; $lowercaseItem))
					$streetAddressObj.unitNumber:=Replace string:C233($lowercaseItem; "suite "; "")
					$unitNumberPatternMatched:=True:C214
				: (Match regex:C1019("^suite number [0-9]*$"; $lowercaseItem))
					$streetAddressObj.unitNumber:=Replace string:C233($lowercaseItem; "suite number "; "")
					$unitNumberPatternMatched:=True:C214
					
				: (Match regex:C1019("^apt [0-9]*$"; $lowercaseItem))
					$streetAddressObj.unitNumber:=Replace string:C233($lowercaseItem; "apt "; "")
					$unitNumberPatternMatched:=True:C214
					
				: (Match regex:C1019("^apartment [0-9]*$"; $lowercaseItem))
					$streetAddressObj.unitNumber:=Replace string:C233($lowercaseItem; "apartment "; "")
					$unitNumberPatternMatched:=True:C214
				Else 
					$streetAddressObj.streetAddress:=$collectionItem
			End case 
		End for each 
		
		If ($unitNumberPatternMatched=False:C215)
			$streetAddressObj.streetAddress:=$mixedStreetAddress
			$streetAddressObj.unitNumber:=""
		End if 
		
	Else 
		$streetAddressObj.streetAddress:=$mixedStreetAddress
	End if 
	
End if 

$0:=$streetAddressObj