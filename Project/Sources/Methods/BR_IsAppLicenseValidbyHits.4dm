//%attributes = {}
// Created by: JAIME ALVAREZ (3/6/2023)

#DECLARE($clientCode : Text; $applicationID : Text)->$isLicenseValid : Boolean
var $url : Text
var $mm : Integer
var $err : Integer

Case of 
		
	: (Count parameters:C259=0)
		$clientCode:="MoneyWayNew"
		$applicationID:="CXW.SL.OFAC"
		
		
	: (Count parameters:C259=2)
		$clientCode:=$1
		$applicationID:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$isLicenseValid:=False:C215

var $clientsTableApiURL : Text
var $clientsTableApiUrl : Text

var $licenses; $usageList : Object
var $contents : Object
var $lics; $usage : Collection
var $montlyHits; $currentHits; $totalHits : Integer


$contents:=New object:C1471
$licenses:=New object:C1471

ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)

// get a collection of Applications 
//$url:="https://api.baserow.io/api/database/rows/table/146467/?user_field_names=true"

// get a collection of Licenses 
$url:="https://api.baserow.io/api/database/rows/table/146468/?user_field_names=true"
$url:=getKeyValue("baserow.clientsTableApiUrl"; $url)

BR_SetHeaders(->$headerNames; ->$headerValues)

HTTP SET OPTION:C1160(HTTP timeout:K71:10; 240)
ON ERR CALL:C155("onErrCallIgnore")

// Call API Rest to get collection of licenses
$err:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $contents; $licenses; $headerNames; $headerValues)
$lics:=$licenses.results.query("AppID == :1 && ClientCode == :2"; $applicationID; $clientCode)

ON ERR CALL:C155("")


If ($lics.length>0)
	
	$montlyHits:=Num:C11($lics[0].MontlyHits)
	$totalHits:=Num:C11($lics[0].TotalHits)
	
	
	ON ERR CALL:C155("onErrCallIgnore")
	
	// Call API Rest to get collection of Usage
	$url:="https://api.baserow.io/api/database/rows/table/147953/?user_field_names=true"
	$url:=getKeyValue("baserow.usageTableApiUrl"; $url)
	
	BR_SetHeaders(->$headerNames; ->$headerValues)
	
	$err:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $contents; $usageList; $headerNames; $headerValues)
	$usage:=$usageList.results.query("AppID == :1 && ClientCode == :2"; $applicationID; $clientCode)
	
	ON ERR CALL:C155("")
	
	C_DATE:C307($lastHit)
	
	If ($usage.length>0)
		$lastHit:=Date:C102($usage[0].LastHit)
		$mm:=Month of:C24($lastHit)
		Case of 
			: ($mm=1)
				$currentHits:=Num:C11($usage[0].Jan)
				
			: ($mm=2)
				$currentHits:=Num:C11($usage[0].Feb)
				
			: ($mm=3)
				$currentHits:=Num:C11($usage[0].Mar)
				
			: ($mm=4)
				$currentHits:=Num:C11($usage[0].Apr)
		End case 
		
		If (($currentHits<=$montlyHits) && ($currentHits<=$totalHits))
			$isLicenseValid:=True:C214
		End if 
		
	End if 
	
	
End if 

