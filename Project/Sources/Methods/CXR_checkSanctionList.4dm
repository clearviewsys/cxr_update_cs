//%attributes = {}
/*
#author Wai-Kin

properties.name
properties.isEntity
properties.birthCounty
record.id
record.table
screenList
screenType

*/

#DECLARE($jsonParam : Object)->$result : Object
var $json : Object
Case of 
	: (Count parameters:C259=0)
		$json:=New object:C1471("properties"; \
			New object:C1471("name"; "barclay berry"; "birthCountry"; "US"); \
			"record"; New object:C1471("id"; "cus12345"))
	: (Count parameters:C259=1)
		$json:=$jsonParam
End case 
var $errors : Object
$errors:=utils_validateJsonWithFile($json; "CXR_screenSanctionList.json")

If (Not:C34($errors.success))
	$result:=New object:C1471(\
		"status"; "422"; \
		"message"; "Request contains "+String:C10($errors.errors.length)+" json errors."; \
		"errors"; $errors.errors; \
		"resultStatus"; -1; \
		"input"; $json\
		)
	return $result
End if 

var $isForced; $isEntity : Boolean
var $name : Text
var $logIdPtr : Pointer
var $options : cs:C1710.SanctionScreeningOptions
var $unprocesableEntity : Integer
var $options : cs:C1710.SanctionScreeningOptions
$unprocesableEntity:=422
$options:=cs:C1710.SanctionScreeningOptions.new($json)

// auto = less tests
$isForced:=True:C214
$name:=$json.properties.name

If (OB Is defined:C1231($json.properties; "isEntity"))
	$isEntity:=$json.properties.isEntity="true"
Else 
	$isEntity:=False:C215
End if 

var $property : Text
For each ($property; $json.properties)
	If ($property#"name")  // name is not added to data
		$options.data[$property]:=$json.properties[$property]
	End if 
End for each 

If (OB Is defined:C1231($json; "record"))
	var $id : Text
	If (OB Is defined:C1231($json; "id"))
		
		$id:=$json.record.id
	End if 
	
	If (OB Is defined:C1231($json.record; "table"))
		Case of 
			: ($json.record.table="Customers")
				$options.moduleFlag:=sl_CustomersFlag
				QUERY:C277([Customers:3]; [Customers:3]CustomerID:1; =; $json.record.id)
				FIRST RECORD:C50([Customers:3])
				$logIdPtr:=->[Customers:3]CustomerID:1
				
			: ($json.record.table="Invoices")
				$options.moduleFlag:=sl_InvoicesFlag
				QUERY:C277([Customers:3]; [Customers:3]CustomerID:1; =; $json.record.id)
				FIRST RECORD:C50([Customers:3])
				$logIdPtr:=->[Customers:3]CustomerID:1
				
			: ($json.record.table="Links")
				$options.moduleFlag:=sl_LinksFlag
				QUERY:C277([Links:17]; [Links:17]LinkID:1; =; $json.record.id)
				FIRST RECORD:C50([Links:17])
				$logIdPtr:=->[Links:17]LinkID:1
				
			: ($json.record.table="eWires")
				$options.moduleFlag:=sl_eWiresFlag
				QUERY:C277([eWires:13]; [eWires:13]eWireID:1; =; $json.record.id)
				FIRST RECORD:C50([eWires:13])
				$logIdPtr:=->[eWires:13]eWireID:1
				
			: ($json.record.table="Agents")
				$options.moduleFlag:=sl_AgentsFlag
				QUERY:C277([Agents:22]; [Agents:22]AgentID:1; =; $json.record.id)
				FIRST RECORD:C50([Agents:22])
				$logIdPtr:=->[Agents:22]AgentID:1
				
			: ($json.record.table="Third Parties")
				$options.moduleFlag:=sl_ThirdPartiesFlag
				QUERY:C277([ThirdParties:101]; [ThirdParties:101]ThirdPartiesID:31; =; $json.record.id)
				FIRST RECORD:C50([ThirdParties:101])
				$logIdPtr:=->[ThirdParties:101]ThirdPartiesID:31
				
			: ($json.record.table="Wires")
				$options.moduleFlag:=sl_WiresFlag
				QUERY:C277([Wires:8]; [Wires:8]WireNo:48; =; $json.record.id)
				FIRST RECORD:C50([Wires:8])
				$logIdPtr:=->[Wires:8]WireNo:48
				
		End case 
		
	Else 
		$options.moduleFlag:=sl_NoFlag
		
	End if 
Else 
	$options.moduleFlag:=sl_NoFlag
End if 

$options.showInterface:=False:C215

Case of 
	: (OB Is defined:C1231($json; "screenList"))
		$options.screenList:=$json.screenList
	: (OB Is defined:C1231($json; "screenType"))
		Case of 
			: ($json.screenType="SL")
				$options.screenGroup:=$json.screenType
			: ($json.screenType="PEP")
				$options.screenGroup:=$json.screenType
			: ($json.screenType="")
				$options.screenGroup:=""
		End case 
End case 

If ($options.moduleFlag#sl_NoFlag)
	$options.handleScreenResult:="sl_saveSanctionListResult"
End if 
var $screening : cs:C1710.SanctionListResult
$screening:=sl_screenMainlyNameWithOptions($isForced; $name; $isEntity; $logIdPtr; $options)
$result:=New object:C1471(\
"status"; "200"; \
"message"; $result.resultText; \
"resultStatus"; $result.resultCode; \
"input"; $json\
)


var $i : Integer
var $entity : Object
var $data : Object
If ($screening.cxrBlacklistJson.length#0)
	$result.cxrBlacklist:=New collection:C1472
	For ($i; 0; $screening.cxrBlacklistJson.length-1)
		$entity:=$screening.cxrBlacklistJson[$i]
		$data:=New object:C1471("details"; $entity.ResponseJSON; "sanctionList"; $entity.SanctionList)
		$result.cxrBlacklist.push($data)
	End for 
End if 

If ($screening.kyc2020.length#0)
	$result.kyc2020:=New collection:C1472
	For ($i; 0; $screening.kyc2020.length-1)
		$entity:=$screening.kyc2020[$i]
		$data:=New object:C1471("details"; $entity.ResponseJSON; "sanctionList"; $entity.SanctionList)
		$result.kyc2020.push($data)
	End for 
End if 

If ($screening.openSanctions.length#0)
	$result.openSanctions:=New collection:C1472
	For ($i; 0; $screening.openSanctions.length-1)
		$entity:=$screening.openSanctions[$i]
		$data:=New object:C1471("details"; $entity.ResponseJSON; "sanctionList"; $entity.SanctionList)
		$result.openSanctions.push($data)
	End for 
End if 

If ($screening.localBlackList.length#0)
	$result.localBlackList:=New collection:C1472
	For ($i; 0; $screening.localBlackList.length-1)
		$entity:=$screening.localBlackList[$i]
		$data:=New object:C1471("details"; $entity.ResponseJSON; "sanctionList"; $entity.SanctionList)
		$result.localBlackList.push($data)
	End for 
End if 
return $result
