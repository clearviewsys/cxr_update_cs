//%attributes = {}
// newAML_RuleFilter ($ruleEntity; $invoiceID; customerID; group)
// this method create a filter object to be used for querying by the rule engine later on

C_OBJECT:C1216($ruleObj; $1)
C_TEXT:C284($invoiceID; $2; $customer; $3; $group; $4)
C_OBJECT:C1216($filterObj; $0)

Case of 
	: (Count parameters:C259=4)
		$ruleObj:=$1
		$customer:=$2
		$invoiceID:=$3
		$group:=$4
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
// why do we have the following parameters and not all the object data members? 
// the following data members are used for filtering the customer profile


$filterObj:=New object:C1471  // return object
$filterObj.customerID:=$customer  // filter by customerID
$filterObj.invoiceID:=$invoiceID  // and by Invoice ID
$filterObj.group:=$group  // and customer group

$filterObj.branchID:=$ruleObj.ifBranchID
$filterObj.accountID:=$ruleObj.ifAccountID
$filterObj.currency:=$ruleObj.ifCurrency

$filterObj.days:=$ruleObj.inDays
$filterObj.direction:=$ruleObj.ifIsReceived
$filterObj.isCash:=$ruleObj.ifIsCash
$filterObj.isEFT:=$ruleObj.ifIsEFT
$filterObj.isByInvoice:=Num:C11($ruleObj.ifIsByInvoice)
$filterObj.relationType:=Num:C11($ruleObj.ifRelationType)  // this will affect the query

$0:=$filterObj