//%attributes = {}
// matchNameAgainstList ($name; -$matchPtr; $type; $list; $force)
//
// Searches a person or an entity name in a specified sanction list. 
// This is the most powerful and most generic method available in CXBlacklist. 
// Clients can initiate any entity or person search for any supported sanction lists. 
// It is highly recommended to always use this endpoint rather than using list-specific methods.

// Parameters:
// name: Name of a person or an entity to search(example: Jan Zada)
// type: Type of the name(possible values: True for ENTITY or False for PERSON)
// list: Name of the sanction list being used in search
//       (possible values: OFAC, OSFI, EU, PEP, SWISS, UK, AUSTRAC, NEW ZEALAND, SEMA)

// Return Value:(type: string)
// Search result: if the name found
// Invalid Client!": if user’s credentials are not correct
// Not Authorized!": if user has no/expired license
// Empty string(""): if the search fails

// Newer JSON Sanction Check: checkInputToSanctionLists

//Unit Test @Zoya 10 Feb 2021

C_TEXT:C284($1)
C_POINTER:C301($2; $matchPtr)
C_BOOLEAN:C305($3; $type)
C_TEXT:C284($4; $id)
C_BOOLEAN:C305($5; $force)
C_TEXT:C284($0; $clientCode; $clientKey; $name; $list; $sanctionCheckResult; $typeStr)

$clientCode:=<>CLIENTCODE2
$clientKey:=<>clientkey2
$force:=<>doCheckSanctionLists

Case of 
	: (Count parameters:C259=0)
		$name:="Hillary Clinton"
		$type:=False:C215
		$list:="PEP"
		$force:=True:C214
		
	: (Count parameters:C259=3)
		$name:=$1
		$matchPtr:=$2
		$type:=$3
		$list:="PEP"
		
	: (Count parameters:C259=4)
		$name:=$1
		$matchPtr:=$2
		$type:=$3
		$list:=$4
	: (Count parameters:C259=5)
		$name:=$1
		$matchPtr:=$2
		$type:=$3
		$list:=$4
		$force:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($type)
	$typeStr:="ENTITY"
Else 
	$typeStr:="PERSON"
End if 

If ($force)
	If (checkSanctionListCallsAvailable($list))
		$sanctionCheckResult:=ws_matchNameAgainstList($clientCode; $clientKey; $name; $typeStr; $list)
		updateSanctionListCallsLimit($list)
		$matchPtr->:=getMatchType($sanctionCheckResult)
	Else 
		// Do not delete the "Limit" Word on next statement. This will affect the icon color
		$sanctionCheckResult:="The limit for "+$list+" sanction list has been reached"
	End if 
End if 

$0:=$sanctionCheckResult

