Class constructor($optionsParam : Object)
	var $options : Object
	
	Case of 
		: (Count parameters:C259=0)
			$options:=New object:C1471
		: (Count parameters:C259=1)
			$options:=$optionsParam
	End case 
	
	// MARK: Ready Check
	
/* check if this is ready to run screening
set in: 
 - sl_handleCustomerScreening.4dm
 - sl_handleInvoiceScreening.4dm
 - sl_handleLinksScreening.4dm
 - sl_handleThirdPartiesScreening.4dm
 - sl_screenMainlyNameWithOptions.4dm
	
used by  
 - sl_screenMainlyNameWithOptions
	
used to be namePartsFilled
*/
	This:C1470.isScreenReady:=utils_getValueFromObject($options; True:C214; "isScreenReady")
	
/* cehck if automatic checking is needed or not
*/
	This:C1470.hadAutoScreened:=utils_getValueFromObject($options; False:C215; "hadAutoScreened")
	
	// MARK: Interface
/** show progress bar (mainly) and comfirm reject dialog
used by
 - sl_checkBySanctionListColl (for progress bar)
 - sl_handleScreening (for comfirm reject)
	
used to be interface
*/
	This:C1470.showInterface:=utils_getValueFromObject($options; True:C214; "showInterface")
	
/** asks for rejection
used by 
 - sl_handleScreening
*/
	This:C1470.comfirmReject:=utils_getValueFromObject($options; False:C215; "comfirmReject")
	
/** the dropdown button to add sanction lists.
used by
- sl_handleScreening
*/
	This:C1470.dropdownButton:=utils_getValueFromObject($options; Self:C308; "dropdownButton")
	
	// MARK: picking lists
	
/** the list to screen with
used by 
 - sl_chooseSLCollByOption
	
set by
 - sl_handleScreening
	
used to be list
*/
	This:C1470.screenList:=utils_getValueFromObject($options; ""; "screenList")
	
/** screening SL or PEP.
set by 
- sl_handleScreening
	
use to be manualList
*/
	This:C1470.screenGroup:=utils_getValueFromObject($options; ""; "screenGroup")
	
/** the module where the data comes from
used by 
 - sl_chooseSLCollByOption
	
set by
 - all sl_handle(Table)Screening
	
used to be autoType
*/
	This:C1470.moduleFlag:=utils_getValueFromObject($options; sl_NoFlag; "moduleFlag")
	
/** Choose the list from automatic screening
used by
 - sl_chooseSLCollByOption
*/
	This:C1470.isAuto:=utils_getValueFromObject($options; False:C215; "isAuto")
	
	// MARK: using a worker process
	// TODO: has the ability to screen name in worker, but not in used
	
/** Runs in a worker progress
used by 
 - sl_screenMainlyNameWithOptions
*/
	This:C1470.useWorker:=utils_getValueFromObject($options; False:C215; "useWorker")
	
/** Form signal name
used by
 - sl_screenMainlyNameWithOptions
*/
	This:C1470.signalName:=utils_getValueFromObject($options; ""; "signalName")
	
/** Current form name
used by
 - sl_screenMainlyNameWithOptions
*/
	This:C1470.currentForm:=Current form window:C827
	
/** Current form name
used by
 - sl_screenMainlyNameWithOptions
*/
	This:C1470.currentProcess:=Current process:C322
	
	// MARK: Override options
	// TODO: more [SanctionLists] fields overridden is needed
/** Overrides [SanctionLists]MatchType. 
used by
 - sl_pullCXRBlacklistServer
*/
	This:C1470.matchType:=utils_getValueFromObject($options; ""; "matchType")
	
	// MARK: method to call after completing code
/** The method to call after the screening call is completed.
used by
 - sl_checkBySanctionListColl
	
set in
 - sl_handleDemoListResult
 - sl_handleScreening
	
used to be handleDetailMethod
*/
	
	This:C1470.handleScreenResult:=utils_getValueFromObject($options; ""; "handleScreenResult")
	
	// MARK: other data
	This:C1470.data:=New object:C1471()
	This:C1470.data.nationality:=utils_getValueFromObject($options; ""; "data"; "nationality")
	This:C1470.data.idNumber:=utils_getValueFromObject($options; ""; "data"; "idNumber")
	This:C1470.data.dob:=utils_getValueFromObject($options; !00-00-00!; "data"; "dob")
	This:C1470.data.address:=utils_getValueFromObject($options; ""; "data"; "address")
	
Function sendOptionData()->$data : Object
	var $module : Text
	Case of 
		: (This:C1470.moduleFlag=sl_AgentsFlag)
			$module:="Agent"
		: (This:C1470.moduleFlag=sl_CustomersFlag)
			$module:="Customer"
		: (This:C1470.moduleFlag=sl_eWiresFlag)
			$module:="eWires"
		: (This:C1470.moduleFlag=sl_InvoicesFlag)
			$module:="Invoice"
		: (This:C1470.moduleFlag=sl_LinksFlag)
			$module:="Links"
		: (This:C1470.moduleFlag=sl_ThirdPartiesFlag)
			$module:="Third Parties"
		: (This:C1470.moduleFlag=sl_WiresFlag)
			$module:="Wires"
	End case 
	
	$data:=New object:C1471("module"; $module; \
		"isAuto"; This:C1470.isAuto; \
		"isScreenReady"; This:C1470.isScreenReady; \
		"screenList"; This:C1470.screenList; \
		"data"; This:C1470.data)
	
Function setNationality($nationality : Text)
	Case of 
		: (Count parameters:C259=0)
			This:C1470.data.nationality:=""
		: (Count parameters:C259=1)
			This:C1470.data.nationality:=$nationality
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
Function setIdNumber($idNumberParam : Text)
	Case of 
		: (Count parameters:C259=0)
			This:C1470.data.idNumber:=""
		: (Count parameters:C259=1)
			This:C1470.data.idNumber:=$idNumberParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
Function setBrithday($birthdayParam : Date)
	Case of 
		: (Count parameters:C259=0)
			This:C1470.data.dob:=!00-00-00!
		: (Count parameters:C259=1)
			This:C1470.data.dob:=$birthdayParam
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 
	
Function setAddress($address : Text)
	Case of 
		: (Count parameters:C259=0)
			This:C1470.data.address:=""
		: (Count parameters:C259=1)
			This:C1470.data.address:=$address
		Else 
			assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
	End case 