//%attributes = {}
/* Handles `[Customer]FirstName + [Customer]LastName` or `[Customer]CompanyName] screening and return status
#params $commandTypeParam 
      - prefixed with `sl_CustomerPerson`, `sl_CustomerCompany` or ''
      - for postfix see `sl_handleScreening`
#params $optionsParam
      - uses options from `sl_createDefaultOptionsObject`
#param $formEventParam
       overrides `Form Event Code` in sl_handleScreening
#formEvents 
       see sl_handleScreening, can overridden with $fromEventParam
#author: @wai-kin
*/
#DECLARE($commandTypeParam : Text; $optionsParam : Object; $formEventParam : Integer)->$match : Integer

//MARK:- Parameters Setup
var $commandType : Text
var $tablePtr : Pointer
var $options : cs:C1710.SanctionScreeningOptions
var $formEvent : Integer
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
var $checkName : Text
var $isCompany : Boolean
var $logIdPtr : Pointer
Case of 
	: ($commandType=(sl_CustomerPerson+"@"))
		$isCompany:=False:C215
		
	: ($commandType=(sl_CustomerCompany+"@"))
		$isCompany:=True:C214
		
	Else 
		$isCompany:=[Customers:3]isCompany:41
End case 

//MARK:- sl_handleScrenning setup

// Sets module flag
$options.moduleFlag:=sl_CustomersFlag

// Sets $checkName, resultIconPtr, namePartsFilled
If ($isCompany)
	$checkName:=[Customers:3]CompanyName:42
Else 
	$checkName:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
	$options.isScreenReady:=([Customers:3]FirstName:3#"") & ([Customers:3]LastName:4#"")
End if 

$logIdPtr:=->[Customers:3]CustomerID:1

//MARK:- Actual Screening
var $result : cs:C1710.SanctionListResult
$result:=sl_handleScreening($commandType; $isCompany; $checkName; $options; $logIdPtr; $formEvent)
$match:=$result.resultCode

If ($isCompany)
	latestCheckStatus2:=sl_setSanctionListIcon($match)
Else 
	latestCheckStatus1:=sl_setEmojiStatusIcon($match)
End if 


QUERY:C277([SanctionCheckLog:111]; [SanctionCheckLog:111]internalTableID:12=Table:C252(->[Customers:3]CustomerID:1); *)
QUERY:C277([SanctionCheckLog:111];  & ; [SanctionCheckLog:111]InternalRecordID:2=[Customers:3]CustomerID:1)



