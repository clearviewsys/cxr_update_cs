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

var $matched : cs:C1710.CustomersSelection
var $exact : cs:C1710.CurrenciesSelection

var $nameMatch : Text
$nameMatch:="FullName = :1 and isOnHold = :2"
$matched:=ds:C1482.Customers.query($nameMatch; $result.FullName; True:C214)

var $response : Object
$response:=New object:C1471("matches"; New collection:C1472; \
"exact"; 0; "similiar"; 0; "total"; 0)
var $match : cs:C1710.CustomersEntity
var $key : Text
var $value; $checkAgainst
For each ($match; $matched)
	var $item : Object
	$item:=New object:C1471
	$item.isExact:=True:C214
	$item.id:=$match.CustomerID
	If ($match.DOB=Date:C102($options.dob))
		$item.dobMatch:=True:C214
	Else 
		$item.dobMatch:=False:C215
		$item.isExact:=False:C215
	End if 
	
	If ($match.Nationality=$options.data.nationality)
		$item.nationalityMatch:=True:C214
	Else 
		$item.nationalityMatch:=False:C215
		$item.isExact:=False:C215
	End if 
	
	If ($item.isExact)
		$response.exact:=$response.exact+1
	Else 
		$response.similiar:=$response.similiar+1
	End if 
	$response.total:=$response.total+1
	
	$response.matches.push($item)
End for each 

$result.CheckResult:=$response.exact>0 ? 2 : ($response.similiar>0 ? 1 : 0)
$result.ResponseJSON:=$response
$result.isSuccessful:=True:C214
If ($result.CheckResult#0)
	$result.ResponseText:=String:C10($response.exact)+" extra match and "+\
		String:C10($response.similiar)+" similiar matches"
End if 
