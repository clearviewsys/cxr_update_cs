//%attributes = {}
/* popluates Sanction list from the server

#param $updateDescParam
       If the list already exists, update the descriptions too?
#author @Wai-Kin Chau
*/
#DECLARE($updateDescParam : Boolean)

// MARK:- Parameter Setup
var $updateDesc : Boolean
$updateDesc:=False:C215
Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$updateDesc:=$updateDescParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// MARK:- Pulls the list from server
var $lists : Collection
$lists:=sl_pullSanctionListNames
If ($lists=Null:C1517)
	$lists:=New collection:C1472
End if 
var $descriptions : Object

/* MARK:- Set Descriptions to Names
Extracted from:
https://docs.google.com/document/d/1IpdS4QNjSQDQp5Z8cL7NqBhrQcF-xUKozbJnPWjM26g/edit#heading=h.p1gqrd6adomm
*/
$descriptions:=New object:C1471(\
"AUSTRAC"; "Australian Transaction Reports and Analysis Centre"; \
"CANADA"; "Covers all UNSC, SEMA=JVCFOR, PSCA=PSC=RELE, FACFO-Tunisia, FACFO-Ukraine"; \
"EU"; "European Union Sanction List"; \
"FACFO.TN"; "Freezing Assets of Corrupt Foreign Officials Act-Tunisia"; \
"FACFO.UA"; "Freezing Assets of Corrupt Foreign Officials Act-Ukraine"; \
"NZ"; "New Zealand Police List"; \
"OFAC"; "Office of Foreign Assets Control(OFAC)-U.S.A"; \
"PEP"; "Politically Exposed Persons(PEP)"; \
"PSCA"; "Public Safety Canada(PSCA or PSC)– Listed Terrorist Entities"; \
"RELE"; "Regulations Establishing a list of Entities(RELE)"; \
"SEMA"; "Listed Persons under the Special Economic Measures Act"; \
"SWISS"; "State Secretariat for Economic Affairs SECO-Switzerland"; \
"UK"; "Consolidated List of Financial Sanctions Targets in the UK"; \
"UNSC"; "United Nations Security Council Sanctions List"\
)
var $list : Text
var $hasCan : Real
var $results : Collection
$results:=New collection:C1472
$hasCan:=0
For each ($list; $lists)
	// Checks if there is a group for CANADA
	If (($list="UNSC") | ($list="SEMA") | ($list="RELE") | ($list="FACFO.TN") | ($list="FACFO.UA"))
		$hasCan:=$hasCan+1
	End if 
	$results.push(New object:C1471("ShortName"; $list; "isPEP"; $list="@PEP@"; \
		"Description"; $descriptions[$list]))
End for each 
// Adds group list "CANADA"
If ($hasCan=5)
	$results.push(New object:C1471("ShortName"; "CANADA"; "Description"; $descriptions["CANADA"]))
End if 

// MARK:- Adds the Sanction list, and update the description as needed
var $result : Object
For each ($result; $results)
	var $selected : cs:C1710.SanctionListsSelection
	var $update : cs:C1710.SanctionListsEntity
	$selected:=ds:C1482.SanctionLists.query("ShortName= :1"; $result.ShortName)
	If ($selected.length=0)
		$update:=ds:C1482.SanctionLists.new()
		$update.ShortName:=$result.ShortName
		$update.Description:=$result.Description
	Else 
		$update:=$selected.first()
		If ($updateDesc)
			$update.Description:=$result.Description
		End if 
	End if 
	$update.isPEP:=$result.isPEP
	$update.save()
End for each 

// MARK:- Refresh the lists
allRecordsSanctionLists