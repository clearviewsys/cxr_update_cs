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

var $response : Object
$response:=sl_requestOpenSanctionScreening($result.FullName; $searchList)

$result.ResponseJSON:=$response.response

// MARK:- Fill results

Case of 
	: ($response.status=200)
		$result.isSuccessful:=True:C214
		If ($response.response.total.value=0)
			$result.CheckResult:=0
		Else 
			
			If (utils_getValueFromObject($searchList.Details; False:C215; "OpenSanctions"; "fuzzy"))
				$result.CheckResult:=1
				$result.ResponseText:="Similiar match found!"
			Else 
				$result.CheckResult:=2
				$result.ResponseText:="Exact match found!"
			End if 
		End if 
		
	: (OB Is defined:C1231($response; "detail"))
		$result.isSuccessful:=False:C215
		$result.CheckResult:=-1
		$result.ResponseText:=String:C10($result.status)+" Error: "+$response.detail
	Else 
		$result.isSuccessful:=False:C215
		$result.CheckResult:=-1
		$result.ResponseText:="Sanction Check server returns HTTP error code: "+String:C10($response.status)
End case 

