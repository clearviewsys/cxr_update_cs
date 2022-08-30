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
var $options : Object
var $formEvent : Integer
$options:=New object:C1471
$formEvent:=Form event code:C388
Case of 
	: (Count parameters:C259=1)
		$commandType:=$commandTypeParam
	: (Count parameters:C259=2)
		$commandType:=$commandTypeParam
		$options:=$optionsParam
	: (Count parameters:C259=3)
		$commandType:=$commandTypeParam
		$options:=$optionsParam
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

// Sets autoType
utils_setUndefinedObjectValue($options; sl_CustomersFlag; "options"; "autoType")

// Sets $checkName, resultIconPtr, namePartsFilled
If ($isCompany)
	$checkName:=[Customers:3]CompanyName:42
	utils_setUndefinedObjectValue($options; ->latestCheckStatus2; "pointers"; "resultIconPtr")
Else 
	$checkName:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
	utils_setUndefinedObjectValue($options; ->latestCheckStatus1; "pointers"; "resultIconPtr")
	utils_setUndefinedObjectValue($options; ([Customers:3]FirstName:3#"") & ([Customers:3]LastName:4#""); \
		"options"; "namePartsFilled")
End if 

$logIdPtr:=->[Customers:3]CustomerID:1

//MARK:- Actual Screening
$match:=sl_handleScreening($commandType; $isCompany; $checkName; $options; $logIdPtr; $formEvent)

