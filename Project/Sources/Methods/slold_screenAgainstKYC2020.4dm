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
$url:="https://api.kyc2020.com:8088/KYC2020/V2/SearchSummary"

// MARK:- set content JSON
var $content : Object
$content:=New object:C1471
$content.Email:=getLicenseValue("KYC2020")
$content.APIKey:=getLicensePassword("KYC2020")

$content.CategoryCodeList:=utils_getValueFromObject($searchList; "all"; \
"Details"; "KYC2020"; "categoryCodeList")
var $catGroupName : Text
$catGroupName:=utils_getValueFromObject($searchList; ""; \
"Details"; "KYC2020"; "catGroupName")
If ($catGroupName#"")
	$content.catGroupName:=$catGroupName
End if 

$content.Name:=$result.FullName
If ($options.data.address#"")
	$content.Address:=$options.data.address
End if 

If ($options.data.idNumber#"")
	$content.Identification:=$options.data.idNumber
End if 

If ($options.data.dob#!00-00-00!)
	$content.Date:=$options.data.dob
End if 


C_TEXT:C284($mustMatch)
$mustMatch:=utils_getValueFromObject($searchList; "true"; \
"Details"; "KYC2020"; "mustMatch")
Case of 
	: ($mustMatch="true")
		OB SET:C1220($content; "SearchType"; "1")
	: ($mustMatch="false")
		OB SET:C1220($content; "SearchType"; "2")
	Else 
		OB SET:C1220($content; "SearchType"; "2")
		OB SET:C1220($content; "Mustmatch"; $mustMatch)
End case 

var $queryCount : Text
OB SET:C1220($content; "Query Count"; String:C10(utils_getValueFromObject($searchList; 100; \
"Details"; "KYC2020"; "queryCount")))

OB SET:C1220($content; "ExcludeTerms"; String:C10(utils_getValueFromObject(\
$searchList; "1"; "Details"; "KYC2020"; "excludeTerms")))

OB SET:C1220($content; "userSrchPref_FilterThreshod"; utils_getValueFromObject($searchList; \
"1"; "Details"; "KYC2020"; "filterThreshold"))
OB SET:C1220($content; "response-type"; String:C10(utils_getValueFromObject($searchList; 1; \
"Details"; "KYC2020"; "responseType")))


// MARK:- Actual HTTP Post Request
C_OBJECT:C1216($response)
$response:=New object:C1471
C_LONGINT:C283($statusCode)
ON ERR CALL:C155("sl_sanctionRequestTimeout")
$statusCode:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)
ON ERR CALL:C155("")

// MARK:- Fill in [SanctionCheckLog]
$result.ResponseJSON:=New object:C1471("summary"; $response; \
"details"; New object:C1471)

var $detail : Object
$detail:=OB Copy:C1225($content)
OB REMOVE:C1226($detail; "Email")
OB REMOVE:C1226($detail; "APIKey")
$detail.checkType:=$result.Details.checkType
$result.Details:=$detail
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
			: (OB Is defined:C1231($response; "diq-summary"))
				
				// First check for DecisionIQ results
				var $decision : Text
				$decision:=$response["diq-summary"].decision
				Case of 
					: ($decision="FAIL")
						$result.CheckResult:=2
						$result.ResponseText:=$response["diq-summary"]["reason"]
					: ($decision="VERIFY")
						$result.CheckResult:=1
						$result.ResponseText:=$response["diq-summary"]["reason"]
					: ($decision="PASS")
						$result.CheckResult:=0
						$result.ResponseText:=""
				End case 
				
			: (OB Is defined:C1231($response; "smart-scan-summary"))
				// Next check if there is anything in Smart Scan
				// TODO: Sanction List Module: KYC2020 Smart Scan separate similar match with exact match
				$result.CheckResult:=0
				If ($response["smart-scan-summary"].length>0)
					$result.CheckResult:=1
					$result.ResponseText:="KYC2020 finds a result."
				End if 
				
			: (OB Is defined:C1231($response; "statistics"))
				// Next check on the Adverse Media Check
				If ($response["statistics"]["articles"].length>0)
					$result.CheckResult:=1
					$result.ResponseText:="Found "+\
						String:C10($response["statistics"]["articles"].length)+" articles."
				Else 
					$result.CheckResult:=0
					$result.ResponseText:=""
				End if 
		End case 
		
End case 