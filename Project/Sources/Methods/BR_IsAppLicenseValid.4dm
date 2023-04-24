//%attributes = {}
// Created by: JAIME ALVAREZ (3/6/2023)
// Takes in an ApplicationID and returns whether or not the clients license for that application is valid
// RAL2_isLicenseValid(String: $applicationID) -> bool: $isLicenseValid

#DECLARE($clientCode : Text; $applicationID : Text)->$isLicenseValid : Boolean

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

$isLicenseValid:=True:C214

var $clientsTableApiUrl : Text
var $clientsTableApiURL; $url : Text

var $err : Integer
var $lics : Collection
var $licenses : Object
var $contents : Object
var $accountExpiryDate : Date

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
	
	If ($lics[0].ExpirationDate=Null:C1517)
		
		
	Else 
		
		$accountExpiryDate:=BR_setDate2MMDDYYY($lics[0].ExpirationDate)
		$isLicenseValid:=$accountExpiryDate>Current date:C33(*)
		
		
	End if 
	
End if 

