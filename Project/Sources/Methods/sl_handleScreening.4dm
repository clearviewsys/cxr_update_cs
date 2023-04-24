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
#DECLARE($commandType : Text; $isCompany : Boolean; $checkName : Text; \
$options : Object; $logIdPtr : Pointer; $formEvent : Integer)->$result : cs:C1710.SanctionListResult

//MARK:- Parameters Setup

//$logIdPtr:=Null
$formEvent:=Form event code:C388
Case of 
	: (Count parameters:C259=3)
		$options:=cs:C1710.SanctionScreeningOptions.new()
	: (Count parameters:C259=4)
		$formEvent:=Form event code:C388
	: (Count parameters:C259=5)
		$formEvent:=Form event code:C388
	: (Count parameters:C259=6)
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
		If (($formEvent=On Clicked:K2:4) && Is new record:C668(Table:C252(Table:C252($logIdPtr))->))
			$shouldRun:=True:C214
		End if 
		$isForced:=False:C215
		$options.comfirmReject:=True:C214
		
		//MARK:- Handle Textbox Updates
	: ($commandType=("@"+sl_ForInputBox))
		// handle text box
		If ($formEvent=On Data Change:K2:15)
			$shouldRun:=True:C214
			Form:C1466.hadAutoScreened:=False:C215
		End if 
		$isForced:=False:C215
		
		//MARK:- Handle SL Button
	: ($commandType=("@"+sl_ForSLButton))
		// handle sanction list button
		If ($formEvent=On Clicked:K2:4)
			$shouldRun:=True:C214
		End if 
		
		$options.screenGroup:="SL"
		$isForced:=True:C214
		
		//MARK:- Handle PEP Button
	: ($commandType=("@"+sl_ForPEPButton))
		// handle Pep button
		$options.screenGroup:="PEP"
		$isForced:=True:C214
		
		If ($formEvent=On Clicked:K2:4)
			$shouldRun:=True:C214
		End if 
		
		//MARK:- Handle Dropdown Button
	: ($commandType=("@"+sl_ForDropdown))
		// setup
		$isForced:=True:C214  // for sl_screenMainlyNameWithOptions
		C_TEXT:C284($line; $noneEnabled; $screenAll)
		$line:="═════════════════"  // line break
		$noneEnabled:="No Sanction List Enabled"  // so that there are no list enabled
		$screenAll:="All SL and PEP"
		
		var $pointer : Pointer  // the droupbox button, can be overrided
		$pointer:=$options.dropdownButton
		
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
				
				If ($listNames.length=0)
					$listNames.push($noneEnabled)
				Else 
					$listNames.push($line)
					$listNames.push($screenAll)
				End if 
				
				$pointer->:=New object:C1471("values"; $listNames)
				
			: (Form event code:C388=On Clicked:K2:4)
				// sets list to screen with, if possible
				var $name : Text
				$name:=$pointer->currentValue
				If (($name#$line) & ($name#$noneEnabled))
					If ($name#$screenAll)
						$options.screenList:=$name
					End if 
					$shouldRun:=True:C214
				End if 
		End case 
	Else 
		ASSERT:C1129(False:C215; "parameter 1 ($commandType) must end with a constant prefixed with sl_For")
End case 

If (Not:C34(OB Is defined:C1231(Form:C1466; "hadAutoScreened")))
	Form:C1466.hadAutoScreened:=False:C215
End if 
$options.hadAutoScreened:=Form:C1466.hadAutoScreened

//MARK:- common screening actions

// runs the screening if ready
If ($shouldRun)
	$result:=sl_screenMainlyNameWithOptions($isForced; $checkName; $isCompany; $logIdPtr; $options)
	
	If ($result#Null:C1517)
		// No issues, screening completed
		If ($options.showInterface && ($result.resultCode#0))
			$result.displayResults($options.comfirmReject)
		End if 
		If ($logIdPtr#Null:C1517)
			$result.save()
		End if 
	End if 
	Form:C1466.hadAutoScreened:=True:C214
End if 
