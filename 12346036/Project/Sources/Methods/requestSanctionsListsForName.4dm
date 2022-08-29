//%attributes = {}
// requestSanctionsListForName($searchName;$statusPtr;$isEntity;{$searchList;{$forced}})
// 
// Check sanction list by making HTTP request to https://cloud.clearviewsys.net/cxblacklist/json
//
// Parameters:
// $searchName (C_TEXT)
//     The name to search
// $statusPtr (C_POINTER to C_TEXT)
//     The result message, came from either this method or from the endpoint
// $isEntity (C_BOOLEAN)
//     Is the entity a individual (false) or an organization (true)
// $searchList (C_TEXT)
//     The list to search
// $forced (C_BOOLEAN)
//     Is the test is being done
// 
// Return: (C_OBJECT)
//     The list matched items in the format: {"Blacklist"=[...],"Whitelist"=[...]}
//     If the an error is return, it will still return the same format

// Set $clientCode and $clientKey
C_TEXT:C284($1; $searchName)
C_POINTER:C301($2; $statusPtr)
C_BOOLEAN:C305($3; $isEntity)
C_TEXT:C284($4; $searchList)
C_BOOLEAN:C305($5; $force)
C_OBJECT:C1216($0; $response)

C_TEXT:C284($clientCode; $clientKey; $searchType; $search)
C_LONGINT:C283($timeout; $status)

$clientCode:=replaceUnsafeURLCharacters(<>ClientCode2)
$clientKey:=replaceUnsafeURLCharacters(<>ClientKey2)

Case of 
	: (Count parameters:C259=3)
		$searchName:=$1
		$statusPtr:=$2
		$isEntity:=$3
		$searchList:="PEP"
		$force:=<>doCheckSanctionLists
		
	: (Count parameters:C259=4)
		$searchName:=$1
		$statusPtr:=$2
		$isEntity:=$3
		$searchList:=$4
		$force:=<>doCheckSanctionLists
		
	: (Count parameters:C259=5)
		$searchName:=$1
		$statusPtr:=$2
		$isEntity:=$3
		$searchList:=$4
		$force:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
ASSERT:C1129(Type:C295($statusPtr->)=Is text:K8:3)

$searchName:=replaceUnsafeURLCharacters($searchName)
$searchList:=replaceUnsafeURLCharacters($searchList)

If ($isEntity)
	$searchType:="entity"
Else 
	$searchType:="person"
End if 
C_OBJECT:C1216($listEntity)

// #ORDA
C_OBJECT:C1216($selection)
$selection:=ds:C1482.SanctionLists.query("ShortName = :1"; $searchList)
If ($selection.length=1)
	$listEntity:=ds:C1482.SanctionLists.query("ShortName = :1"; $searchList)[0]
End if 
$search:="EXACT"
If (OB Is defined:C1231($listEntity; "MatchType"))
	If ($listEntity.MatchType#"")
		C_TEXT:C284($searchFound)
		$searchFound:=$listEntity.MatchType
		
		// Loads a list to check if [SanctionLists]MatchType has a valid option
		C_LONGINT:C283($list)
		$list:=Load list:C383("SanctionListMatchType")
		If (Find in list:C952($list; $searchFound; 0)#0)
			$search:=$searchFound
		End if 
	End if 
End if 
C_TEXT:C284($output)
$output:="json"

C_TEXT:C284($url)
$url:=CXR_getSetting("JSONSanctionListURL")
If ($url="")
	
	$url:="https://cloud.clearviewsys.net/cxblacklist/json/"  // JSON base url
	
	$url:=$url+"matchnameagainstlist?version=2"  // Endpoint
End if 


// Client code + key
$url:=$url+"&clientcode="+$clientCode
$url:=$url+"&clientkey="+$clientKey

// List to use
$url:=$url+"&list="+$searchList

// Search name + type
$url:=$url+"&type="+$searchType
$url:=$url+"&name="+$searchName

// Other options
$url:=$url+"&output="+$output
$url:=$url+"&search="+$search

//C_BOOLEAN($unloadResponse)  // Replace error result with empty blacklist?

If ($force)
	
	C_TEXT:C284($content)
	C_OBJECT:C1216($response)
	$timeout:=Num:C11(CXR_getSetting("SanctionListTimeOut"))
	If ($timeout=0)
		$timeout:=10
	End if 
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; $timeout)
	ON ERR CALL:C155("sl_sanctionRequestTimeout")
	$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
	ON ERR CALL:C155("")
	
	//$unloadResponse:=True
	Case of 
		: ($status=0)
			$statusPtr->:="ERROR: HTTP Request timeout!"
			
		: ($status#200)
			$statusPtr->:="ERROR: "+$searchList+" List returns HTTP "+String:C10($status)+"error."
			
		: (OB Is defined:C1231($response; "Blacklist"))
			Case of 
				: ($response.Blacklist.count()=0)
					$statusPtr->:="No Matches."
				Else 
					$statusPtr->:="ALERT: "+String:C10($response.Blacklist.count())+" matches!"
			End case 
			//$unloadResponse:=False
			
		: (OB Is defined:C1231($response; "error"))
			$statusPtr->:="ERROR: "+$response.error
			
		Else 
			$statusPtr->:="ERROR: "+$searchList+" List return JSON without blacklist or error values!"
	End case 
	
Else 
	$statusPtr->:="No check are made."
End if 

//If ($unloadResponse)
//$response:=New object
//$response.Blacklist:=New collection
//$response.Whitelist:=New collection
//End if 

$0:=$response