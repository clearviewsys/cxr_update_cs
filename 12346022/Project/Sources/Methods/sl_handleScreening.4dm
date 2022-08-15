//%attributes = {}
/* Handle screening common to all table screening methods
  #param $commandTypeParam
         #pre: end with a constant prefixed with sl_for
  #param $isCompanyParam
         is the name a company or a person
  #param $checkNameParam
         name to check
  #param $optionsParam
         uses keys from `sl_createDefaultOptionsObject`
  #formEvents 
       - Required for $commandType sl_ForNextButton: On Clicked
       - Required for $commandType sl_ForInputBox: on Data Change
       - Required for $commandType sl_ForSLButton: On Clicked
       - Required for $commandType sl_ForPEPButton: On Clicked
       - Required for $commandType sl_ForDropdown: On Clicked, On Load
  #return the result for 
  #Author Wai-Kin
*/
#DECLARE($commandTypeParam : Text; $isCompanyParam : Boolean; $checkNameParam : Text; \
$optionsParam : Object; $logIdPtrParam : Pointer; $formEventParam : Integer)->$match : Integer

//MARK:- Parameters Setup
var $commandType : Text
var $isCompany : Boolean
var $checkName : Text
var $options : Object
var $logIdPtr : Pointer
var $formEvent : Integer

//$logIdPtr:=Null
$options:=New object:C1471
$formEvent:=Form event code:C388
Case of 
	: (Count parameters:C259=3)
		$commandType:=$commandTypeParam
		$isCompany:=$isCompanyParam
		$checkName:=$checkNameParam
	: (Count parameters:C259=4)
		$commandType:=$commandTypeParam
		$isCompany:=$isCompanyParam
		$checkName:=$checkNameParam
		$options:=$optionsParam
	: (Count parameters:C259=5)
		$commandType:=$commandTypeParam
		$isCompany:=$isCompanyParam
		$checkName:=$checkNameParam
		$options:=$optionsParam
		$logIdPtr:=$logIdPtrParam
	: (Count parameters:C259=6)
		$commandType:=$commandTypeParam
		$isCompany:=$isCompanyParam
		$checkName:=$checkNameParam
		$options:=$optionsParam
		$logIdPtr:=$logIdPtrParam
		$formEvent:=$formEventParam
End case 

var $isForced; $shouldRun : Boolean
$shouldRun:=False:C215
Case of 
		
		//MARK:- Handle Automatic Call (sl_ForAutoCall)
	: ($commandType=("@"+sl_ForAutoCall))
		$shouldRun:=True:C214
		$isForced:=False:C215
		
		//MARK:- Handle Manual Call
	: ($commandType=("@"+sl_ForManualCall))
		$shouldRun:=True:C214
		$isForced:=True:C214
		
		//MARK:- Handle Next or Save Buttons
	: ($commandType=("@"+sl_ForNextButton))
		// handle next/save buttons
		If ($formEvent=On Clicked:K2:4)
			$shouldRun:=True:C214
		End if 
		$isForced:=False:C215
		
		//MARK:- Handle Textbox Updates
	: ($commandType=("@"+sl_ForInputBox))
		// handle text box
		If ($formEvent=On Data Change:K2:15)
			$shouldRun:=True:C214
		End if 
		$isForced:=False:C215
		
		//MARK:- Handle SL Button
	: ($commandType=("@"+sl_ForSLButton))
		// handle sanction list button
		If ($formEvent=On Clicked:K2:4)
			$shouldRun:=True:C214
		End if 
		utils_setUndefinedObjectValue($options; "SL"; "options"; "manualList")
		$isForced:=True:C214
		
		//MARK:- Handle PEP Button
	: ($commandType=("@"+sl_ForPEPButton))
		// handle Pep button
		utils_setUndefinedObjectValue($options; "PEP"; "options"; "manualList")
		$isForced:=True:C214
		
		If ($formEvent=On Clicked:K2:4)
			$shouldRun:=True:C214
		End if 
		
		//MARK:- Handle Dropdown Button
	: ($commandType=("@"+sl_ForDropdown))
		// setup
		$isForced:=True:C214  // for sl_screenMainlyNameWithOptions
		C_TEXT:C284($line; $noneEnabled)
		$line:="═════════════════"  // line break
		$noneEnabled:="No Sanction List Enabled"  // so that there are no list enabled
		
		var $pointer : Pointer  // the droupbox button, can be overrided
		$pointer:=utils_getValueFromObject($options; Self:C308; "pointers"; "dropdownButton")
		
		Case of 
			: (Form event code:C388=On Load:K2:1)
				// add enabled sanction lists to drop box options
				var $data : Object
				var $listNames : Collection
				$listNames:=ds:C1482.SanctionLists.query("IsEnabled = True and isPEP = False").ShortName
				
				// separates PEP and Sanction list
				If ($listNames.length#0)
					$listNames.push($line)
				End if 
				
				// add enabled PEP lists to drop box options
				C_COLLECTION:C1488($pepList)
				$pepList:=ds:C1482.SanctionLists.query("IsEnabled = True and isPEP = True").ShortName
				var $name : Text
				For each ($name; $pepList)
					$listNames.push($name)
				End for each 
				
				$pointer->:=New object:C1471("values"; $listNames)
				
			: (Form event code:C388=On Clicked:K2:4)
				// sets list to screen with, if possible
				var $name : Text
				$name:=$pointer->currentValue
				If (($name#$line) & ($name#$noneEnabled))
					utils_setUndefinedObjectValue($options; $name; "options"; "list")
					$shouldRun:=True:C214
				End if 
		End case 
	Else 
		ASSERT:C1129(False:C215; "parameter 1 ($commandType) must end with a constant prefixed with sl_For")
End case 

//MARK:- common screening actions

// adds the save action
utils_setUndefinedObjectValue($options; "sl_saveSanctionListResult"; "pointers"; "handleDetailMethod")

// runs the screening if ready
If ($shouldRun)
	$match:=sl_screenMainlyNameWithOptions($isForced; $checkName; $isCompany; $logIdPtr; $options)
	//If ($isCompany)
	//$match:=sl_screenCompany($isForced; $checkName; $logIdPtr; $options)
	//Else 
	//$match:=sl_screenPerson($isForced; $checkName; $logIdPtr; $options)
	//End if 
End if 
