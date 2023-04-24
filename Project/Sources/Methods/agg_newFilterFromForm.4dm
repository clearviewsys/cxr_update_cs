//%attributes = {}
// newAML_AggrRuleFilter (customerID;invoiceID)
// Note: The filter object holds only the filters and parameters that agg_getStatsObject requires
// Note: This is not a comprehensive object that has all the rule data members inside it, it is only
// for example, EFT, Cash, Receive or Paid, Currency, Account, etc do make a difference in agg_getStatsObject

C_OBJECT:C1216($filterObj; $0)
C_TEXT:C284($customerID; $1; $invoiceID; $2)
C_BOOLEAN:C305($inPrototyper)

Case of 
	: (Count parameters:C259=0)
		$inPrototyper:=True:C214
		
	: (Count parameters:C259=1)
		$customerID:=$1
		$invoiceID:=""
		$inPrototyper:=False:C215
		
	: (Count parameters:C259=2)
		$customerID:=$1
		$invoiceID:=$2
		$inPrototyper:=False:C215
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$filterObj:=New object:C1471

If ($inPrototyper)
	$filterObj.customerID:=String:C10(Form:C1466.customerID)  // entered by the user
	$filterObj.invoiceID:=String:C10(Form:C1466.invoiceID)  // entered by the user
	$filterObj.group:=String:C10(Form:C1466.group)  // entered by the user (filled automatically based on the customer)
	
	// notice how the rest of these form objects have Form.Rule prefix! 
	
	$filterObj.branchID:=String:C10(Form:C1466.Rule.ifBranchID)  // rule 
	$filterObj.accountID:=String:C10(Form:C1466.Rule.ifAccountID)  // rule
	$filterObj.currency:=String:C10(Form:C1466.Rule.ifCurrency)  // rule
	
	$filterObj.days:=Num:C11(Form:C1466.Rule.inDays)  // rule
	$filterObj.fromDate:=Date:C102(Form:C1466.Rule.fromDate)  // from Date
	$filterObj.toDate:=Date:C102(Form:C1466.Rule.toDate)  // to Date
	
	$filterObj.direction:=Num:C11(Form:C1466.Rule.ifIsReceived)  // rule
	$filterObj.isCash:=Num:C11(Form:C1466.Rule.ifIsCash)  // rule
	$filterObj.isEFT:=Num:C11(Form:C1466.Rule.ifIsEFT)  // rule
	$filterObj.isByInvoice:=Num:C11(Form:C1466.Rule.ifIsByInvoice)  // rule
	
	$filterObj.relationType:=Num:C11(Form:C1466.Rule.ifRelationType)  // 
	
	$filterObj.purposeOfTransactions:=Form:C1466.Rule.ifObj.purposeOfTransactions
	$filterObj.sourceOfFunds:=Form:C1466.Rule.ifObj.sourceOfFunds
	$filterObj.typeOfTransactions:=Form:C1466.Rule.ifObj.typeOfTransactions
	$filterObj.events:=Form:C1466.Rule.whenObj.events
	
Else 
	$filterObj.customerID:=$customerID
	$filterObj.invoiceID:=$invoiceID
	$filterObj.group:=""  // entered by the user (filled automatically based on the customer)
	
	// notice how the rest of these form objects have Form.Rule prefix! 
	
	$filterObj.branchID:=""
	$filterObj.accountID:=""
	$filterObj.currency:=""
	
	$filterObj.days:=0
	$filterObj.fromDate:=!00-00-00!
	$filterObj.toDate:=!00-00-00!
	
	$filterObj.direction:=0
	$filterObj.isCash:=0
	$filterObj.isEFT:=0
	$filterObj.isByInvoice:=0
	$filterObj.relationType:=0
	
	$filterObj.purposeOfTransactions:=New collection:C1472
	$filterObj.sourceOfFunds:=New collection:C1472
	$filterObj.typeOfTransactions:=New collection:C1472
	$filterObj.events:=New collection:C1472
	
End if 
$0:=$filterObj