//%attributes = {}
/* Handles `[eWires]BeneficiaryFullName`, `[eWires]BeneficiaryBankName` or `[eWires]BeneficiaryCompanyName` screening and return status
#params $commandTypeParam 
      - starts with `sl_eWiresBank`, `sl_eWiresPerson`, `sl_eWiresCompany` or '' see sl_handleScreening
      - ends with see `sl_handleScreening`
#params $optionsParam
      - uses options from `sl_createDefaultOptionsObject`
#param $formEventParam
       overrides `Form Event Code` in sl_handleScreening
#formEvents see sl_handleScreening, can overridden with $fromEventParam
#author @Wai-Kin
*/
#DECLARE($commandTypeParam : Text; $optionsParam : Object; \
$formEventParam : Integer)->$match : Integer

//MARK:- Parameters Setup
var $commandType : Text
var $tablePtr : Pointer
var $options : cs:C1710.SanctionScreeningOptions
var $formEvent : Integer
$tablePtr:=Current form table:C627
$options:=cs:C1710.SanctionScreeningOptions.new()
$formEvent:=Form event code:C388
Case of 
	: (Count parameters:C259=1)
		$commandType:=$commandTypeParam
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

//MARK:- Company or Person
var $type; $COMPANY; $BANK; $PERSON : Integer
$COMPANY:=1
$BANK:=2
$PERSON:=3
Case of 
	: ($commandType=(sl_eWireBank+"@"))
		$type:=$BANK
		$isCompany:=True:C214
	: ($commandType=(sl_eWireCompany+"@"))
		$type:=$COMPANY
		$isCompany:=True:C214
	: ($commandType=(sl_eWirePerson+"@"))
		$type:=$PERSON
		$isCompany:=False:C215
	Else 
		$isCompany:=[eWires:13]isBeneficiaryCompany:93
		$type:=Choose:C955($isCompany; $COMPANY; $PERSON)
End case 

//MARK:- sl_handleScrenning setup

var $checkName : Text
var $isCompany : Boolean
var $logIdPtr : Pointer
var $ressultText : Text

// Sets module flag
$options.moduleFlag:=sl_eWiresFlag

// Sets $checkName and resultIconPtr
Case of 
	: ($type=$PERSON)
		$checkName:=[eWires:13]BeneficiaryFullName:5
	: ($type=$COMPANY)
		$checkName:=[eWires:13]BeneficiaryCompanyName:92
	: ($type=$BANK)
		$checkName:=[eWires:13]BeneficiaryBankName:76
End case 

// set logIdPtr and resultTextPtr
$logIdPtr:=->[eWires:13]eWireID:1

//MARK:- Actual Screening
var $result : cs:C1710.SanctionListResult
$result:=sl_handleScreening($commandType; $isCompany; $checkName; $options; \
$logIdPtr; $formEvent)

$match:=$result.resultCode
$ressultText:=$result.resultText

Case of 
	: ($type=$PERSON)
		latestListCheckBeneficiary4:=sl_setSanctionListIcon($match)
	: ($type=$COMPANY)
		latestListCheckBeneficiary5:=sl_setSanctionListIcon($match)
	: ($type=$BANK)
		latestListCheckBeneficiary8:=sl_setSanctionListIcon($match)
End case 

// Clear or set other eWires flags
// TODO: apply the same to companies? 
If ($type=$PERSON)
	setSanctionCheckFields($ressultText)
	[eWires:13]didCheckAgainstSanctionList:69:=True:C214
	appendToStringOnCondition($ressultText#""; ->[eWires:13]sanctionCheckResultString:71; $ressultText; True:C214)
	If (($match=2) | ($match=1))
		[eWires:13]didMatchWithSanctionList:70:=True:C214
		OBJECT SET ENTERABLE:C238([eWires:13]isFalsePositiveMatch:78; True:C214)
		OBJECT SET VISIBLE:C603([eWires:13]didMatchWithSanctionList:70; True:C214)
		OBJECT SET VISIBLE:C603(*; "NameisCleared"; False:C215)
	Else 
		[eWires:13]didMatchWithSanctionList:70:=False:C215
		OBJECT SET ENTERABLE:C238([eWires:13]isFalsePositiveMatch:78; False:C215)
		OBJECT SET VISIBLE:C603([eWires:13]didMatchWithSanctionList:70; False:C215)
		OBJECT SET VISIBLE:C603(*; "NameisCleared"; True:C214)  // name is cleared
	End if 
End if 