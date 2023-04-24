//%attributes = {}
/** Handles `[Links]CompanyName` or `[Links]FirstName+[Links]LastName` screening and return status

#params $commandTypeParam 
      - starts with `sl_LinksPerson`, `sl_LinksCompany` or '' see sl_handleScreening
      - ends with see `sl_handleScreening`
#params $optionsParam
      - uses options from sl_createDefaultOptionsObject
#formEvents see sl_handleScreening, can overridden with $fromEventParam
#Author @Wai-Kin
*/
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

$options.moduleFlag:=sl_LinksFlag

var $checkName : Text
var $isCompany : Boolean
var $logIdPtr : Pointer

//MARK:- Company or Person
Case of 
	: ($commandType=(sl_LinksPerson+"@"))
		$isCompany:=False:C215
		
	: ($commandType=(sl_LinksCompany+"@"))
		$isCompany:=True:C214
	Else 
		$isCompany:=[Links:17]isCompany:43
End case 

//MARK:- sl_handleScrenning setup

// set $checkName, namePartsFilled, reusltIconPtr
If ($isCompany)
	$checkName:=[Links:17]CompanyName:42
Else 
	$checkName:=makeFullName([Links:17]FirstName:2; [Links:17]LastName:3)
	$options.isScreenReady:=([Links:17]FirstName:2#"") & ([Links:17]LastName:3#"")
End if 

$logIdPtr:=->[Links:17]LinkID:1

//MARK:- Actual Screening
var $result : cs:C1710.SanctionListResult
$result:=sl_handleScreening($commandType; $isCompany; $checkName; $options; $logIdPtr; $formEvent)

$match:=$result.resultCode


If ($isCompany)
	latestLinkIcon10:=sl_setEmojiStatusIcon($match)
Else 
	latestLinkIcon7:=sl_setSanctionListIcon($match)
End if 

