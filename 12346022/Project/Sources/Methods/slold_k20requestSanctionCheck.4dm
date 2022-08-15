//%attributes = {}
// Author: Wai-Kin
//sl_k20requestSanctionCheck($searchName : Text; $isEntity : Boolean; $searchList : Text; \
$logIdPtr : Pointer; $details : Object)->$result : cs.SanctionCheckLogEntity

var $searchName; $1 : Text
var $isEntity; $2 : Boolean
var $logId; $3 : Object
var $options; $4 : Object
var $result; $0 : cs:C1710.SanctionCheckLogEntity
Case of 
	: (Count parameters:C259=4)
		$searchName:=$1
		$isEntity:=$2
		$logId:=$3
		$options:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $progressBar : Boolean
$progressBar:=$options.showInterface

var $history : Object
var $content : Object
var $shouldLog : Boolean

$result:=sl_createSanctionCheckLog($searchName; $isEntity; "KYC2020"; \
"KYC2020"; $logId; ->$shouldLog)

$history:=slold_searchTodayScreening($searchName; "KYC2020"; \
New object:C1471("responseType"; $details.responseType; \
"isEntity"; $isEntity))

If ($history.length#0)
	var $entity : cs:C1710.SanctionCheckLog
	$entity:=$history.first()
	$result:=sl_createSanctionCheckLog($searchName; $isEntity; "KYC2020"; \
		"KYC2020"; $logId; ->$shouldLog)
	$result.isSuccessful:=$entity.isSuccessful
	$result.CheckResult:=$entity.CheckResult
	$result.ResponseText:=$entity.ResponseText
	$result.ResponseJSON:=$entity.ResponseJSON
	$result.Details:=$entity.Details
	
	// check if logging is needed
	If ($shouldLog)
		C_OBJECT:C1216($sameRecord)
		$sameRecord:=$history.query("internalTableID = :1 & InternalRecordID = :2)"; \
			$logId.table; $logId.value)
		$shouldLog:=$sameRecord=Null:C1517
	End if 
Else 
	If (Not:C34(isLicenseRecordExpired("KYC2020")))
		C_TEXT:C284($url)
		$url:="https://api.kyc2020.com:8088/KYC2020/V2/SearchSummary"
		
		If ($progressBar)
			var $httpProgress : Integer
			$httpProgress:=Progress New
			Progress SET WINDOW VISIBLE(True:C214)
			Progress SET MESSAGE($httpProgress; "Requesing summary.")
			Progress SET BUTTON ENABLED($httpProgress; False:C215)
		End if 
		
		var $content : Object
		$content:=New object:C1471
		$content.Email:=getLicenseValue("KYC2020")
		$content.APIKey:=getLicensePassword("KYC2020")
		
		$content.CategoryCodeList:="all"
		If ($options.autoList="")
		Else 
			$content.catGroupName:=$options.autoList
		End if 
		$content.Name:=$searchName
		If ($options.address#"")
			$content.Address:=$options.address
		End if 
		
		If ($options.idCard#"")
			$content.Identification:=$options.idCard
		End if 
		
		If ($options.birthday#!00-00-00!)
			$content.Date:=$options.birthday
		End if 
		
		
		C_TEXT:C284($mustMatch)
		$mustMatch:=getKeyValue("KYC2020.MustMatch"; "")
		If ($mustMatch="")
			OB SET:C1220($content; "SearchType"; "1")
		Else 
			OB SET:C1220($content; "SearchType"; "2")
			OB SET:C1220($content; "Mustmatch"; $mustMatch)
		End if 
		
		OB SET:C1220($content; "Query Count"; getKeyValue("KYC2020.QueryCount"; "100"))
		
		
		C_TEXT:C284($threshold)
		$threshold:=getKeyValue("KYC2020.FilterThreshold"; "1")
		OB SET:C1220($content; "userSrchPref_FilterThreshod"; $threshold)
		
		C_REAL:C285($responseType)
		C_TEXT:C284($key)
		$key:="KYC2020.ResponseType"
		If ($options.autoList#"")
			$key:=$key+"."+$options.autoList
		End if 
		$responseType:=Num:C11(getKeyValue($key; "1"))
		OB SET:C1220($content; "response-type"; $responseType)
		
		
		C_OBJECT:C1216($response)
		$response:=New object:C1471
		C_LONGINT:C283($statusCode)
		$statusCode:=HTTP Request:C1158(HTTP POST method:K71:2; $url; $content; $response)
		
		
		var $details : Collection
		$details:=New collection:C1472
		If ($progressBar)
			C_REAL:C285($count; $total)
			$count:=0
			$total:=$response["smart-scan-summary"].length
			Progress SET MESSAGE($httpProgress; "Requesting details.")
			Progress SET BUTTON ENABLED($httpProgress; False:C215)
		End if 
		If (OB Is defined:C1231($response; "smart-scan-summary"))
			var $item : Object
			For each ($item; $response["smart-scan-summary"])
				C_TEXT:C284($refID)
				$refID:="Search Reference ID"
				If (OB Is defined:C1231($item; $refID))
					C_TEXT:C284($id)
					$id:=$item[$refID]
					$details.push(New object:C1471("id"; $id; \
						"result"; slold_k20requestSanctionDetails($id)\
						))
					
				End if 
				If ($progressBar)
					$count:=$count+1
					Progress SET PROGRESS($httpProgress; $count/$total)
				End if 
			End for each 
		End if 
		
		If ($progressBar)
			Progress SET MESSAGE($httpProgress; "Clean up.")
			Progress SET PROGRESS($httpProgress; -1)
		End if 
		
		$result.ResponseJSON:=New object:C1471("summary"; $response; "details"; $details)
		
		var $detail : Object
		$detail:=OB Copy:C1225($content)
		OB REMOVE:C1226($detail; "Email")
		OB REMOVE:C1226($detail; "APIKey")
		$detail.checkType:=$result.Details.checkType
		$result.Details:=$detail
		Case of 
			: ($response.status="ERROR")
				$result.ResponseText:="KYC2020 Error:"+$response.reason
				$result.isSuccessful:=False:C215
				$result.CheckResult:=-1
			Else 
				$result.isSuccessful:=True:C214
				Case of 
					: (OB Is defined:C1231($response; "diq-summary"))
						If ($response["diq-summary"].decision="FAIL")
							$result.CheckResult:=1
							$result.ResponseText:="KYC 2020 DecisionIQ fails with score:"+\
								String:C10($response["diq-summary"].score)
						Else 
							$result.CheckResult:=0
							$result.ResponseText:=""
						End if 
					: (OB Is defined:C1231($response; "smart-scan-summary"))
						$result.CheckResult:=0
						If ($details.length>0)
							$result.CheckResult:=1
							$result.ResponseText:="KYC2020 finds a result."
						End if 
						
				End case 
				
		End case 
		
		If ($progressBar)
			Progress SET WINDOW VISIBLE(False:C215)
			Progress QUIT($httpProgress)
		End if   // $progressBar
		
	End if 
End if 

$0:=New object:C1471(\
"entity"; $result; \
"needSave"; $shouldLog\
)