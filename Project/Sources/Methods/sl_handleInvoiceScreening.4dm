//%attributes = {}
/** Handles `[Customer]FirstName + [Customer]LastName` or `[Customer]CompanyName] screening and return status
#params $commandTypeParam 
      - starts with `sl_CustomerPerson`, `sl_CustomerCompany` or '' see sl_handleScreening
      - ends with see `sl_handleScreening`
#params $optionsParam
      - uses options from `sl_createDefaultOptionsObject`
#formEvents 
        see sl_handleScreening, can overridden with $fromEventParam
#author @Wai-Kin
*/
#DECLARE($commandTypeParam : Text; $optionsParam : Object; \
$formEventParam : Integer)->$match : Integer

//MARK:- Parameters Setup
var $commandType : Text
var $options : cs:C1710.SanctionScreeningOptions
var $formEvent : Integer
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
$options.moduleFlag:=sl_InvoicesFlag

// Sets $checkName, namePartsFilled
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