//%attributes = {}
// requestAndLogSanctionListCheck($searchName;$nameType;$searchList;{$logIdPtr})
//
// Check sanction list by making HTTP request to https://cloud.clearviewsys.net/cxblacklist/json
//
// Parameters:
// $name       (C_TEXT)    the customer full name or the company name
// $nameType   (C_INTEGER) 1 = Full Name, 2 = Company Name, (future: 3 = product name, etc.)
// $searchList (C_OBJECT)    The list to search
// $resultPtr  (C_POINTER) status pointer
// $fieldPtr   (C_POINTER) field pointer to log
// $messagePtr (C_POINTER) message pointer
//
// Return: (C_OBJECT)
//     The list matched items in the format: {"Blacklist"=[...],"Whitelist"=[...]}
//     If the an error is return, it will still return the same format
//
// Author: Wai-Kin
//sl_requestAndLogSanctionCheck($searchName : Text; $isEntity : Boolean; $searchList : cs.SanctionListsEntity; \
$logId : Object)->$return : Object
var $searchName; $1 : Text
var $isEntity; $2 : Boolean
var $searchList; $3 : cs:C1710.SanctionListsEntity
var $logId; $4 : Object
var $options; $5 : Object
var $return; $0 : Object
Case of 
	: (Count parameters:C259=5)
		$searchName:=$1
		$isEntity:=$2
		$searchList:=$3
		$logId:=$4
		$options:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_BOOLEAN:C305($shouldLog)

C_OBJECT:C1216($result)
C_TEXT:C284($searchType; $search; $escapedName; $shortName)

$shortName:=$searchList.ShortName
C_BOOLEAN:C305($shouldLog)
$shouldLog:=True:C214

// setup #ORDA
$result:=sl_createSanctionCheckLog($searchName; $isEntity; "v2"; \
$shortName; $logId; ->$shouldLog)

// Find previous check with the same name and no server error
var $history : cs:C1710.SanctionCheckLogEntity
$history:=slold_searchTodayScreening($searchName; "v2"; \
New object:C1471("shortName"; $searchList.ShortName; \
"isEntity"; $isEntity))

If ($history.length#0)
	var $entity : cs:C1710.SanctionCheckLog
	$entity:=$history.first()
	$result.isSuccessful:=$entity.isSuccessful
	$result.CheckResult:=$entity.CheckResult
	$result.ResponseText:=$entity.ResponseText
	$result.ResponseJSON:=$entity.ResponseJSON
	$result.Details:=$entity.Details
	
	// check if logging is needed
	If ($shouldLog)
		C_OBJECT:C1216($sameRecord)
		$sameRecord:=$history.query("internalTableID = :1 & InternalRecordID = :2)"; \
			Table:C252($logId.table); $logId.value)
		$shouldLog:=Not:C34(OB Is defined:C1231($sameRecord))
	End if 
Else 
	// Get the server path
	C_TEXT:C284($url)
	$url:=CXR_getSetting("JSONSanctionListURL")
	If ($url="")
		
		$url:="https://cloud.clearviewsys.net/cxblacklist/json/"  // JSON base url
		
		$url:=$url+"matchnameagainstlist?version=2"  // Endpoint
	End if 
	
	// fill client key + code
	C_TEXT:C284($clientCode; $clientKey)
	$clientCode:=replaceUnsafeURLCharacters(<>ClientCode2)
	$url:=$url+"&clientcode="+$clientCode
	
	$clientKey:=replaceUnsafeURLCharacters(<>ClientKey2)
	$url:=$url+"&clientkey="+$clientKey
	
	// fill serach name
	$escapedName:=replaceUnsafeURLCharacters($searchName)
	$url:=$url+"&name="+$escapedName
	
	// fill list name
	$url:=$url+"&list="+replaceUnsafeURLCharacters($shortName)
	
	// check name type
	If ($isEntity)
		$searchType:="entity"
	Else 
		$searchType:="person"
	End if 
	C_OBJECT:C1216($listEntity)
	$url:=$url+"&type="+$searchType
	
	// set serach type
	$search:="EXACT"
	Case of 
		: ($options.matchType#"")
			$search:=$options.matchType
		: (OB Is defined:C1231($searchList; "MatchType"))
			If ($searchList.MatchType#"")
				C_TEXT:C284($searchFound)
				$searchFound:=$searchList.MatchType
				
				// Loads a list to check if [SanctionLists]MatchType has a valid option
				C_LONGINT:C283($list)
				$list:=Load list:C383("SanctionListMatchType")
				If (Find in list:C952($list; $searchFound; 0)#0)
					$search:=$searchFound
				End if 
			End if 
	End case 
	$url:=$url+"&search="+$search
	$result.Details.searchType:=$search
	
	// other output type
	C_TEXT:C284($output; $url)
	$output:="json"
	$url:=$url+"&output="+$output
	
	// set the time out and empty content
	C_TEXT:C284($content)
	C_OBJECT:C1216($response)
	C_LONGINT:C283($timeout)
	$timeout:=Num:C11(CXR_getSetting("SanctionListTimeOut"))
	If ($timeout=0)
		$timeout:=10
	End if 
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; $timeout)
	
	C_LONGINT:C283($status)
	$status:=0
	C_OBJECT:C1216($response)
	$response:=New object:C1471
	ON ERR CALL:C155("sl_sanctionRequestTimeout")
	$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
	ON ERR CALL:C155("")
	
	$result.ResponseJSON:=$response
	
	
	// still needs: ResponseText, isSuccessful, CheckResult
	Case of 
		: ($status=0)
			$result.CheckResult:=-1
			$result.isSuccessful:=False:C215
			$result.ResponseText:="ERROR: HTTP Request timeout!"
			
		: ($status#200)
			$result.CheckResult:=-1
			$result.isSuccessful:=False:C215
			$result.ResponseText:="ERROR: "+$shortName+" List returns HTTP "+String:C10($status)+"error."
			
		: (OB Is defined:C1231($response; "Blacklist"))
			
			$result.isSuccessful:=True:C214
			If ($response.Blacklist.count()=0)
				$result.CheckResult:=0
				$result.ResponseText:=""
			Else 
				C_LONGINT:C283($exactMatches; $similarMatches)
				$exactMatches:=0
				$similarMatches:=0
				C_OBJECT:C1216($item)
				For each ($item; $response.Blacklist)
					Case of 
						: ($item.MatchType="@EXACT@")
							$exactMatches:=$exactMatches+1
						Else   // "SIMILAR"
							$similarMatches:=$similarMatches+1
					End case 
				End for each 
				
				Case of 
					: ($exactMatches>0)
						$result.CheckResult:=2
					: ($similarMatches>0)
						$result.CheckResult:=1
				End case 
				
				$result.ResponseText:="ALERT: "+String:C10($exactMatches)+" exact match(es) and "+String:C10($similarMatches)+" possible match(es)."
			End if 
			
		: (OB Is defined:C1231($response; "error"))
			$result.CheckResult:=-1
			$result.ResponseText:="ERROR: "+$response.error
			
		Else 
			$result.isSuccessful:=False:C215
			$result.CheckResult:=-1
			$result.ResponseText:="ERROR: "+$shortName+" List return JSON without blacklist or error values!"
	End case 
End if 
$return:=New object:C1471(\
"entity"; $result; \
"needSave"; $shouldLog)
$0:=$return