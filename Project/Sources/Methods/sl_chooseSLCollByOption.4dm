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
#DECLARE($isEntity : Boolean; $options : cs:C1710.SanctionScreeningOptions)->$result : Collection

//MARK:- Paramter Setup
Case of 
	: (Count parameters:C259=2)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $searchLists : cs:C1710.SanctionCheckLogSelection
var $manualList; $useList : Text
var $autoType : Integer
var $isAuto : Boolean
$result:=New collection:C1472

// MARK:- Get the list based on the options

Case of 
	: ($options.screenGroup="PEP")
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true and isPEP = true")
		
	: ($options.screenGroup="SL")
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true and isPEP = false")
		
	: ($options.screenList#"")
		$searchLists:=ds:C1482.SanctionLists.query(\
			"ShortName = :1 and IsEnabled = true"; $options.screenList)
		
	: ($options.isAuto)
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true & isManual = false")
		
	Else 
		$searchLists:=ds:C1482.SanctionLists.query("IsEnabled = true")
End case 

// MARK:- Remove PEP for company name checking

If ($isEntity)
	$searchLists:=$searchLists.query("isPEP = false")
End if 

//MARK:- Remove lists base on indiviual list
var $list : cs:C1710.SanctionLists
var $allowed : Boolean
For each ($list; $searchLists)
	$allowed:=False:C215
	var $version : Text
	$version:=sl_getSanctionSourceForRecord($list)
	Case of 
			// MARK: Remove list base on OpenSanctions Options
		: ($version=sl_useOpenSanctions)
			var $type : Text
			$type:=utils_getValueFromObject($list.Details; "Thing"; \
				"OpenSanctions"; "schema")
			If ($isEntity)
				If ($type="Company")
					$allowed:=True:C214
				End if 
			Else 
				If ($type="Person")
					$allowed:=True:C214
				End if 
			End if 
			
			// MARK: Remove list base on KYC2020 Options
		: ($version=sl_useKYC2020)
			var $recordType : Integer
			$recordType:=utils_getValueFromObject($list.details; 1; \
				"KYC2020"; "recordType")
			If ($isEntity)
				$allowed:=$recordType#3
			Else 
				$allowed:=$recordType#2
			End if 
			
			// MARK: Remove list base for most cases
		Else 
			$allowed:=True:C214
	End case 
	
	// MARK: Remove list base of module flag
	If ($allowed && ($options.moduleFlag#sl_NoFlag))
		// [SanctionList]isEnabled is true but turn off while screen no table =
		// the record made before [SanctionLists]automaticFlags 
		// which at the time was to screen for all tables.
		If ($list.automaticFlags#0)
			If (Not:C34(sl_isScreeningForTable($options.moduleFlag; $list.automaticFlags)))
				$allowed:=False:C215
			End if 
		End if 
	End if 
	
	// MARK: Add list if allowed
	If ($allowed)
		$result.push($list.ShortName)
	End if 
End for each 