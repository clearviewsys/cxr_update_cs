//%attributes = {}
// listboxLoadPreferences ( ->listboxPtr; latestPreferences; $listBoxId )
// Load either the latest or default listbox preferences

C_OBJECT:C1216($0; $objPrefs)
C_POINTER:C301($1; $listboxPtr)
C_BOOLEAN:C305($2; $latestPrefs)
C_TEXT:C284($3; $objectName; $listBoxId)

Case of 
		
	: (Count parameters:C259=3)
		$listboxPtr:=$1
		$latestPrefs:=$2
		$listBoxId:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


READ ONLY:C145([DB_Listboxes:12])
QUERY:C277([DB_Listboxes:12]; [DB_Listboxes:12]UserID:4=getApplicationUser; *)
QUERY:C277([DB_Listboxes:12];  & ; [DB_Listboxes:12]ListboxID:2=$listBoxId)

Case of 
		
	: (Records in selection:C76([DB_Listboxes:12])=1)
		
		If ($latestPrefs)
			$0:=[DB_Listboxes:12]ListboxLatestPrefs:3
		Else 
			$0:=[DB_Listboxes:12]ListboxDefaultPrefs:5
		End if 
		
	Else 
		$0:=New object:C1471  // No preferences created for the listbox
End case 
REDUCE SELECTION:C351([DB_Listboxes:12]; 0)
