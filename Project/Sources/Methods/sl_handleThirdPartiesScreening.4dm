//%attributes = {}
// Handles `[ThirdParties]CompanyName` or `[ThirdParties]FirstName+[ThirdParties]LastName` screening and return status
// #params $commandTypeParam
//    - starts with `sl_ThirdPartiesPerson`, `sl_ThirdPartiesCompany` or '' see sl_handleScreening
//    - for ending see `sl_handleScreening`
// #params $optionsParam
//    - uses options from sl_createDefaultOptionsObject
// #formEvents see sl_handleScreening, can overridden with $fromEventParam
// #author: Wai-Kin
#DECLARE($commandTypeParam : Text; $optionsParam : Object; \
$formEventParam : Integer)->$match : Integer

//MARK:- Parameters Setup
var $commandType : Text
var $tablePtr : Pointer
var $options : cs:C1710.SanctionScreeningOptions
var $formEvent : Integer
$tablePtr:=Current form table:C627
$formEvent:=Form event code:C388
Case of 
	: (Count parameters:C259=1)
		$commandType:=$commandTypeParam
		$options:=cs:C1710.SanctionScreeningOptions.new()
	: (Count parameters:C259=2)
		$commandType:=$commandTypeParam
		$options:=cs:C1710.SanctionScreeningOptions.new($optionsParam)
	: (Count parameters:C259=3)
		$commandType:=$commandTypeParam
		$options:=cs:C1710.SanctionScreeningOptions.new($optionsParam)
		$formEvent:=$formEventParam
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $isCompany : Boolean
var $checkName : Text
var $logIdPtr : Pointer
//MARK:- Company or Person
Case of 
	: ($commandType=(sl_ThirdPartiesPerson+"@"))
		$isCompany:=False:C215
		
	: ($commandType=(sl_ThirdPartiesCompany+"@"))
		$isCompany:=True:C214
	Else 
		$isCompany:=[ThirdParties:101]IsCompany:2
End case 

//MARK:- sl_handleScrenning setup
// Sets module flag
$options.moduleFlag:=sl_ThirdPartiesFlag

// Sets $checkName and reusltIconPtr
If ($isCompany)
	$checkName:=[ThirdParties:101]CompanyName:23
Else 
	$checkName:=makeFullName([ThirdParties:101]FirstName:4; [ThirdParties:101]LastName:3)
	$options.isScreenReady:=([ThirdParties:101]FirstName:4#"") & ([ThirdParties:101]LastName:3#"")
End if 

// Sets  $logIdPtr
If ([ThirdParties:101]ThirdPartiesID:31="")
	[ThirdParties:101]ThirdPartiesID:31:=makeThirdPartiesID
End if 
$logIdPtr:=->[ThirdParties:101]ThirdPartiesID:31

//MARK:- Actual Screening
var $result : cs:C1710.SanctionListResult
$result:=sl_handleScreening($commandType; $isCompany; $checkName; $options; $logIdPtr; $formEvent)
$match:=$result.resultCode

If ($isCompany)
	latestLinkIcon10:=sl_setEmojiStatusIcon($match)
Else 
	latestLinkIcon1:=sl_setSanctionListIcon($match)
End if 

