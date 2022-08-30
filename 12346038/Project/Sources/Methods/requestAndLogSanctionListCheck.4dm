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

C_TEXT:C284($1; $searchName)
C_LONGINT:C283($2; $nameType)
C_OBJECT:C1216($3; $searchList)  // #ORDA
C_LONGINT:C283($4; $tableNum)
C_TEXT:C284($5; $recordId)
C_POINTER:C301($6; $resultPtr)
C_OBJECT:C1216($0; $result)

Case of 
	: (Count parameters:C259=3)
		$searchName:=$1
		$nameType:=$2
		$searchList:=$3
		
	: (Count parameters:C259=5)
		$searchName:=$1
		$nameType:=$2
		$searchList:=$3
		$tableNum:=$4
		$recordId:=$5
		
	: (Count parameters:C259=6)
		$searchName:=$1
		$nameType:=$2
		$searchList:=$3
		$tableNum:=$4
		$recordId:=$5
		$resultPtr:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_OBJECT:C1216($result)
C_TEXT:C284($searchType; $search; $escapedName; $shortName)

$result:=New object:C1471
$shortName:=$searchList.ShortName
C_BOOLEAN:C305($shouldLog)
$shouldLog:=($recordId#"")

QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]FullName:9; =; $searchName; *)
QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]CheckDate:3; =; Current date:C33(*); *)
QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]CheckResult:10; #; -1; *)
QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]SanctionList:5; =; $searchList.ShortName)
If (Records in selection:C76([SanctionCheckLog:111])>0)
	$status:=200
	$result.SanctionList:=$searchList.ShortName
	$response:=[SanctionCheckLog:111]ResponseJSON:17
	QUERY SELECTION:C341([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12; =; $tableNum; *)
	QUERY SELECTION:C341([SanctionCheckLog:111]; [SanctionCheckLog:111]InternalRecordID:2; =; $recordId)
	$shouldLog:=Records in selection:C76([SanctionCheckLog:111])=0
	
Else 
	
	C_TEXT:C284($url)
	$url:=CXR_getSetting("JSONSanctionListURL")
	If ($url="")
		
		$url:="https://cloud.clearviewsys.net/cxblacklist/json/"  // JSON base url
		
		$url:=$url+"matchnameagainstlist?version=2"  // Endpoint
	End if 
	
	
	C_TEXT:C284($clientCode; $clientKey)
	$clientCode:=replaceUnsafeURLCharacters(<>ClientCode2)
	$url:=$url+"&clientcode="+$clientCode
	
	$clientKey:=replaceUnsafeURLCharacters(<>ClientKey2)
	$url:=$url+"&clientkey="+$clientKey
	
	$escapedName:=replaceUnsafeURLCharacters($searchName)
	$url:=$url+"&name="+$escapedName
	
	$url:=$url+"&list="+replaceUnsafeURLCharacters($shortName)
	$result.SanctionList:=$shortName
	
	C_BOOLEAN:C305($isEntity)
	Case of 
		: ($nameType=1)
			$searchType:="person"
			$isEntity:=False:C215
		: ($nameType=2)
			$searchType:="entity"
			$isEntity:=True:C214
		Else 
			ASSERT:C1129(False:C215; "Unknown search type: "+$searchType)
	End case 
	C_OBJECT:C1216($listEntity)
	$url:=$url+"&type="+$searchType
	
	$search:="EXACT"
	If (OB Is defined:C1231($searchList; "MatchType"))
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
	End if 
	$url:=$url+"&search="+$search
	
	C_TEXT:C284($output; $url)
	$output:="json"
	$url:=$url+"&output="+$output
	
	C_TEXT:C284($content)
	C_OBJECT:C1216($response)
	C_LONGINT:C283($timeout)
	$timeout:=Num:C11(CXR_getSetting("SanctionListTimeOut"))
	If ($timeout=0)
		$timeout:=10
	End if 
	HTTP SET OPTION:C1160(HTTP timeout:K71:10; $timeout)
	
	C_LONGINT:C283($status)
	ON ERR CALL:C155("sl_sanctionRequestTimeout")
	$status:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $content; $response)
	ON ERR CALL:C155("")
End if 

$result.ResponseJSON:=$response

Case of 
	: ($status=0)
		$result.CheckResult:=-1
		$result.ResponseText:="ERROR: HTTP Request timeout!"
		
	: ($status#200)
		$result.CheckResult:=-1
		$result.ResponseText:="ERROR: "+$shortName+" List returns HTTP "+String:C10($status)+"error."
		
	: (OB Is defined:C1231($response; "Blacklist"))
		Case of 
			: ($response.Blacklist.count()=0)
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
				
				If ($exactMatches>0)
					$result.CheckResult:=2
				Else 
					If ($similarMatches>0)
						$result.CheckResult:=1
					End if 
				End if 
				
				$result.ResponseText:="ALERT: "+String:C10($exactMatches)+" exact match(es) and "+String:C10($similarMatches)+" possible match(es)."
		End case 
		
	: (OB Is defined:C1231($response; "error"))
		$result.CheckResult:=-1
		$result.ResponseText:="ERROR: "+$response.error
		
	Else 
		$result.CheckResult:=-1
		$result.ResponseText:="ERROR: "+$shortName+" List return JSON without blacklist or error values!"
End case 

If ($shouldLog)
	// $_1, $_2, ... $_n = parameters needed for createSanctionCheckLogRecord
	C_TEXT:C284($_1)
	$_1:=$searchName
	
	C_LONGINT:C283($_2)
	$_2:=$tableNum
	
	C_TEXT:C284($_3; $_4; $_5; $_6)
	$_3:=$recordId
	$_4:=getApplicationUser  //<>ApplicationUser
	$_5:=$shortName
	$_6:=$result.ResponseText
	
	C_BOOLEAN:C305($_7)
	$_7:=$result.CheckResult=0
	
	C_REAL:C285($_8)
	$_8:=$result.CheckResult
	
	C_BOOLEAN:C305($_9)
	$_9:=$isEntity
	
	C_DATE:C307($_10)
	$_10:=Current date:C33(*)
	
	C_TIME:C306($_11)
	$_11:=Current time:C178(*)
	
	C_OBJECT:C1216($_12)
	$_12:=$response
	
	createSanctionCheckLogRecord($_1; $_2; $_3; $_4; $_5; $_6; $_7; $_8; $_9; $_10; $_11; $_12)
End if 

If ($resultPtr#Null:C1517)
	$resultPtr->:=$result.ResponseText
End if 
$0:=$result