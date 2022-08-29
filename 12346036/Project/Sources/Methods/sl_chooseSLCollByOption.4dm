//%attributes = {}
/** Choosing Sanction List/PEP base of name type (person or company) and options
#param $isEntityParam
     - is name a entity?
#param $optionsParam
     - options, see `sl_createDefaultOptionsObject
#return 
       a list of SL/PEP
#author @wai-kin
*/
#DECLARE($isEntity : Boolean; $options : Object)->$result : Collection

//MARK:- Paramter Setup

Case of 
	: (Count parameters:C259=2)
		// no need the code below as parameters are declared and assigned above
		// $isEntity:=$1
		// $options:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $searchLists : cs:C1710.SanctionCheckLogSelection
var $manualList; $useList : Text
var $autoType : Integer
var $isAuto : Boolean
$result:=New collection:C1472

// MARK:- Get the list based on the options
$manualList:=utils_getValueFromObject($options; ""; "options"; "manualList")
$useList:=utils_getValueFromObject($options; ""; "options"; "list")
$autoType:=utils_getValueFromObject($options; sl_NoFlag; "options"; "autoType")
$isAuto:=utils_getValueFromObject($options; False:C215; "options"; "isAuto")

Case of 
	: ($manualList="PEP")
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true and isPEP = true")
		
	: ($manualList="SL")
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true and isPEP = false")
		
	: ($useList#"")
		$searchLists:=ds:C1482.SanctionLists.query(\
			"ShortName = :1 and IsEnabled = true"; $options.options.list)
		
	: (($autoType#sl_NoFlag) & $isAuto)
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true")
		C_LONGINT:C283($value)
		C_OBJECT:C1216($remove)
		$remove:=ds:C1482.SanctionLists.newSelection()
		var $entity : cs:C1710.SanctionCheckLogEntity
		For each ($entity; $searchLists)
			If ($entity.isManual)
				C_LONGINT:C283($flags)
				$flags:=$entity.automaticFlags
				If (Not:C34(sl_isAutoScreeningForTable($flags; $options.options.autoType)))
					$searchLists:=$searchLists.minus($entity)
				End if 
			End if 
		End for each 
		
	: ($isAuto)
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true & isManual = false")
		
	Else 
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true")
End case 

// MARK:- Remove PEP for company name checking

If ($isEntity)
	$searchLists:=$searchLists.query("isPEP = false")
End if 

//MARK:- Remove expired/invalid license lists
var $list : cs:C1710.SanctionLists
For each ($list; $searchLists)
	var $name : Text
	$name:=""
	
	Case of 
		: (sl_getSanctionSourceForRecord($list)="v2")
			var $query : cs:C1710.LicensesSelection
			$query:=ds:C1482.Licenses.query("LicenseID = :1 | Value = :1"; "@"+$list.ShortName+"@")
			// $query:=ds.Licenses.query("LicenseID = '@:1@' | Value = '@:1@'"; $list.ShortName)
			If ($query.length#0)
				$name:=$query.first().LicenseID
			End if 
			
		Else 
			$name:=sl_getSanctionSourceForRecord($list)
	End case 
	
	If ($name#"")
		If (Not:C34(isLicenseRecordExpired($name)))
			$result.push($list.ShortName)
		End if 
	End if 
End for each 