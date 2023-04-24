//%attributes = {}
/** Screen name with CXRBlacklist Server

#param $resultParam
       The prefilled SanctionCheckLog Entity
#param $searchListParam
       The list to search
#param $option
       list of option, see sl_createDefaultOptionsObject for default values and keys
*/
#DECLARE($resultParam : cs:C1710.SanctionCheckLogEntity; $searchListParam : \
cs:C1710.SanctionListsEntity; $optionsParam : cs:C1710.SanctionScreeningOptions)


var $result : cs:C1710.SanctionCheckLogEntity
var $searchList : cs:C1710.SanctionListsEntity
var $options : cs:C1710.SanctionScreeningOptions

Case of 
	: (Count parameters:C259=3)
		$result:=$resultParam
		$searchList:=$searchListParam
		$options:=$optionsParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $content : Object
var $shouldLog : Boolean

// MARK:- Set URL 
C_TEXT:C284($url)
$url:="https://api.kyc2020.com:8088/search/v3/adhoc_search"

// MARK:- set heading values
ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)
APPEND TO ARRAY:C911($headerNames; "email")
APPEND TO ARRAY:C911($headerValues; getKeyValue("KYC2020.Email"))

APPEND TO ARRAY:C911($headerNames; "apikey")
APPEND TO ARRAY:C911($headerValues; getKeyValue("KYC2020.APIKey"))

// MARK:- set content JSON
var $content : Object
$content:=New object:C1471


$content.name:=$result.FullName
If ($options.data.address#"")
	$content.address:=$options.data.address
End if 

If ($options.data.idNumber#"")
	$content.identification:=$options.data.idNumber
End if 

If ($options.data.dob#!00-00-00!)
	$content.date:=$options.data.dob
End if 

var $listOptions : Object
If (OB Is defined:C1231($searchList.Details; "KYC2020"))
	$listOptions:=$searchList.Details.KYC2020
Else 
	$listOptions:=New object:C1471
End if 

If (OB Is defined:C1231($listOptions; "categoryCodeList"))
	$content.category_code_list:=$listOptions.categoryCodeList
Else 
	$content.category_code_list:="all"
End if 

If (OB Is defined:C1231($listOptions; "dataSource"))
	$content.datasource_group_name:=$listOptions.dataSource
End if 

If (OB Is defined:C1231($listOptions; "exact"))
	$content.search_type:=$listOptions.exact ? "2" : "1"
End if 

If (OB Is defined:C1231($listOptions; "mustMatch"))
	$content.must_match:=$listOptions.mustMatch
End if 

If (OB Is defined:C1231($listOptions; "queryCount"))
	$content.query_count:=$listOptions.queryCount
End if 

If (OB Is defined:C1231($listOptions; "recordType"))
	$content.record_type:=$listOptions.recordType
End if 

If (OB Is defined:C1231($listOptions; "minMatch"))
	$content.min_shld_match:=$listOptions.minMatch
End if 

If (OB Is defined:C1231($listOptions; "responseType"))
	$content.response_type:=$listOptions.responseType
End if 


// MARK:- Actual HTTP Post Request
C_OBJECT:C1216($response)
$response:=New object:C1471
C_LONGINT:C283($statusCode)
ON ERR CALL:C155("sl_sanctionRequestTimeout")
$statusCode:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response; $headerNames; $headerValues)
ON ERR CALL:C155("")

// MARK:- Fill in [SanctionCheckLog]
$result.ResponseJSON:=New object:C1471("summary"; $response; \
"details"; New object:C1471)

Case of 
	: (($statusCode=0) | Not:C34(OB Is defined:C1231($response; "responseStatus")))
		// Server conection problem
		$result.ResponseText:="Server Connection error."
		$result.isSuccessful:=False:C215
		$result.CheckResult:=-1
		$result.ResponseJSON:=New object:C1471("Error"; "Server Connection error"; \
			"status"; "ERROR"; \
			"search-dump-id"; Null:C1517)
		
	: ($response.responseStatus.status="ERROR")
		// HTTP Post Error
		$result.ResponseText:="KYC2020 Error:"+$response.responseStatus.message
		$result.isSuccessful:=False:C215
		$result.CheckResult:=-1
	Else 
		
		// Server return successfully
		$result.isSuccessful:=True:C214
		Case of 
			: (OB Is defined:C1231($response; "diq_summary"))
				
				// First check for DecisionIQ results
				var $decision : Text
				$decision:=$response.diq_summary.decision
				Case of 
					: ($decision="FAIL")
						$result.CheckResult:=2
						$result.ResponseText:=$response.diq_summary.reason
					: ($decision="VERIFY")
						$result.CheckResult:=1
						$result.ResponseText:=$response.diq_summary.reason
					: ($decision="PASS")
						$result.CheckResult:=0
						$result.ResponseText:=""
				End case 
				
				
			: (OB Is defined:C1231($response; "smart_scan_summary"))
				// Next check if there is anything in Smart Scan
				// TODO: Sanction List Module: KYC2020 Smart Scan separate similar match with exact match
				$result.CheckResult:=0
				If ($response.smart_scan_summary.length>0)
					$result.CheckResult:=1
					$result.ResponseText:="KYC2020 finds a result."
				End if 
				
			: (OB Is defined:C1231($response; "statistics"))
				// Next check on the Adverse Media Check
				var $resultText : Text
				$resultText:="Found exact name in "+String:C10($response.total_matching_name)+" articles and "+\
					String:C10($response.total_matching_namevariant)+" articles."
				Case of 
					: ($response.statistics.total_matching_name>0)
						$result.CheckResult:=2
						$result.ResponseText:=$resultText
					: ($response.statistics.total_matching_namevariant.length>0)
						$result.CheckResult:=1
						$result.ResponseText:=$resultText
					Else 
						$result.CheckResult:=0
						$result.ResponseText:=""
				End case 
		End case 
		
End case 