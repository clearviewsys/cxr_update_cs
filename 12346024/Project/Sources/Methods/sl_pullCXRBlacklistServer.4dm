//%attributes = {}
/** Screen name with CXRBlacklist Server

#param $resultParam
       The prefilled SanctionCheckLog Entity
#param $searchListParam
       The list to search
#param $option
       list of option, see sl_createDefaultOptionsObject for default values and keys
*/
#DECLARE($resultParam : cs:C1710.SanctionCheckLogEntity; $searchListParam : cs:C1710.SanctionListsEntity; $optionsParam : Object)
var $result : cs:C1710.SanctionCheckLogEntity
var $searchList : cs:C1710.SanctionListsEntity
var $options : Object
Case of 
	: (Count parameters:C259=3)
		$result:=$resultParam
		$searchList:=$searchListParam
		$options:=$optionsParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

//C_OBJECT($result)
C_TEXT:C284($searchType; $search; $escapedName; $shortName)
$shortName:=$searchList.ShortName

// MARK:- URL Setup

// Gets Server path
C_TEXT:C284($url)
//$url:=CXR_getSetting("JSONSanctionListURL")
//If ($url="")
$url:="https://cloud.clearviewsys.net/cxblacklist/json/"  // JSON base url
$url:=$url+"matchnameagainstlist?version=2"  // Endpoint
//End if 

// Fill client code
C_TEXT:C284($clientCode; $clientKey)
$clientCode:=replaceUnsafeURLCharacters(<>ClientCode2)
$url:=$url+"&clientcode="+$clientCode

// Fill Client key
$clientKey:=replaceUnsafeURLCharacters(<>ClientKey2)
$url:=$url+"&clientkey="+$clientKey

// Fill search name
$escapedName:=replaceUnsafeURLCharacters($result.FullName)
$url:=$url+"&name="+$escapedName

// Fill list name
$url:=$url+"&list="+replaceUnsafeURLCharacters($shortName)

// Add Name Type
If ($result.isEntity)
	$searchType:="entity"
Else 
	$searchType:="person"
End if 
C_OBJECT:C1216($listEntity)
$url:=$url+"&type="+$searchType

// Set Search Type
$search:="EXACT"
Case of 
	: ($options.options.matchType#"")
		$search:=$options.options.matchType
		
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

// Set Output Type, currently only json
C_TEXT:C284($output; $url)
$output:="json"
$url:=$url+"&output="+$output

// set the time out and empty content
C_TEXT:C284($content)
C_OBJECT:C1216($response)
C_LONGINT:C283($timeout)
//$timeout:=Num(CXR_getSetting("SanctionListTimeOut"))
//If ($timeout=0)
$timeout:=10
//End if 
HTTP SET OPTION:C1160(HTTP timeout:K71:10; $timeout)

// MATCH:- Actual Server Pull
C_LONGINT:C283($status)
$status:=0
C_OBJECT:C1216($response)
$response:=New object:C1471
ON ERR CALL:C155("sl_sanctionRequestTimeout")
$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
ON ERR CALL:C155("")

$result.ResponseJSON:=$response

// MARK:- Fill results
// still needs: ResponseText, isSuccessful, CheckResult
Case of 
	: ($status=0)
		// HTTP timeout
		$result.CheckResult:=-1
		$result.isSuccessful:=False:C215
		$result.ResponseText:="ERROR: HTTP Request timeout!"
		
	: ($status#200)
		// HTTP Error
		$result.CheckResult:=-1
		$result.isSuccessful:=False:C215
		$result.ResponseText:="ERROR: "+$shortName+" List returns HTTP "+String:C10($status)+"error."
		
	: (OB Is defined:C1231($response; "Blacklist"))
		
		$result.isSuccessful:=True:C214
		If ($response.Blacklist.count()=0)
			// Success + no match
			$result.CheckResult:=0
			$result.ResponseText:=""
		Else 
			// Success + matches
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
		// Error from CXRBlacklist
		$result.CheckResult:=-1
		$result.ResponseText:="ERROR: "+$response.error
		
	Else 
		$result.isSuccessful:=False:C215
		$result.CheckResult:=-1
		$result.ResponseText:="ERROR: "+$shortName+" List return JSON without blacklist or error values!"
End case 