//%attributes = {}
// Handles `[Wires]BeneficiaryBankName` or `[Wires]BeneficiaryFullName` screening and return status
// #params $commandTypeParam 
//    - starts with `sl_WiresBank`, `sl_WiresPerson`, `sl_WiresCompany` or '' see sl_handleScreening
//    - ends with see `sl_handleScreening`
// #params $optionsParam
//    - uses options from `sl_createDefaultOptionsObject`
// #formEvents see sl_handleScreening, can overridden with $fromEventParam
// Author: Wai-Kin
#DECLARE($commandTypeParam : Text; $optionsParam : Object; $formEventParam : Integer)->$match : Integer

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
		$options:=$optionsParam
		$formEvent:=cs:C1710.SanctionScreeningOptions.new($optionsParam)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

var $checkName : Text
var $isCompany : Boolean
var $logIdPtr : Pointer

//MARK:- Company or Person
var $type; $COMPANY; $BANK; $PERSON : Integer
$COMPANY:=1
$BANK:=2
$PERSON:=3
Case of 
	: ($commandType=(sl_WiresBank+"@"))
		$type:=$BANK
		$isCompany:=True:C214
	: ($commandType=(sl_WiresCompany+"@"))
		$type:=$COMPANY
		$isCompany:=True:C214
	: ($commandType=(sl_WiresPerson+"@"))
		$type:=$PERSON
		$isCompany:=False:C215
	Else 
		$type:=Choose:C955([Wires:8]isBeneficiaryEntity:71; $COMPANY; $PERSON)
End case 

//MARK:- sl_handleScrenning setup

// Sets autoType
$options.moduleFlag:=sl_WiresFlag

// set $checkName, resultIconPtr
Case of 
	: ($type=$BANK)
		$checkName:=[Wires:8]BeneficiaryBankName:3
		
	: ($type=$COMPANY)
		$checkName:=[Wires:8]BeneficiaryFullName:10
		$isCompany:=True:C214
		
	: ($type=$PERSON)
		$checkName:=[Wires:8]BeneficiaryFullName:10
		$isCompany:=False:C215
		
End case 

$logIdPtr:=->[Wires:8]CXR_WireID:1

//MARK:- Actual Screening
var $result : cs:C1710.SanctionListResult
$result:=sl_handleScreening($commandType; $isCompany; $checkName; $options; $logIdPtr; $formEvent)
$match:=$result.resultCode

Case of 
	: ($type=$BANK)
		latestListCheckBeneficiary2:=sl_setEmojiStatusIcon($match)
		
	: ($type=$COMPANY)
		latestListCheckBeneficiary1:=sl_setSanctionListIcon($match)
		
	: ($type=$PERSON)
		latestListCheckBeneficiary1:=sl_setSanctionListIcon($match)
End case 

