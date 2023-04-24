//%attributes = {}
// Created by: JAIME ALVAREZ (3/6/2023)
// takes a CustomerID and returns whether or not the client license is valid
// RAL2_isLicenseValid(String: $customerID) -> bool: $isLicenseValid

#DECLARE($clientCode : Text)->$isLicenseValid : Boolean

Case of 
		
	: (Count parameters:C259=0)
		$clientCode:="MoneyWayNew"
		
		
	: (Count parameters:C259=1)
		$clientCode:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$isLicenseValid:=False:C215

var $clientsTableApiURL; $url : Text
var $clientsTableApiUrl : Text

var $err : Integer
var $client : Collection
var $accountExpiryDate : Date
var $clients; $contents; $licenses : Object

ARRAY TEXT:C222($headerNames; 0)
ARRAY TEXT:C222($headerValues; 0)

$contents:=New object:C1471
$licenses:=New object:C1471

// get a collection of Customers
$url:="https://api.baserow.io/api/database/rows/table/146462/?user_field_names=true"
$url:=getKeyValue("baserow.clientsTableApiUrl"; $url)

BR_SetHeaders(->$headerNames; ->$headerValues)

HTTP SET OPTION:C1160(HTTP timeout:K71:10; 240)
ON ERR CALL:C155("onErrCallIgnore")

// Verify if the customer has an expired license
$url:="https://api.baserow.io/api/database/rows/table/146462/?user_field_names=true"
$err:=HTTP Request:C1158(HTTP GET method:K71:1; $url; $contents; $clients; $headerNames; $headerValues)
$client:=$clients.results.query("ClientCode == :1"; $clientCode)

If ($client.length>0)
	
	If ($client[0].ExpiryDate=Null:C1517)
		$isLicenseValid:=False:C215
		
	Else 
		$accountExpiryDate:=BR_setDate2MMDDYYY($client[0].ExpiryDate)
		$isLicenseValid:=$accountExpiryDate>=Current date:C33(*)
		
	End if 
	
End if 