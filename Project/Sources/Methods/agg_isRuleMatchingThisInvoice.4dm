//%attributes = {}
// agg_isRuleMatchingThisInvoice
// formerly called: matchThisInvoice_vs_AMLRule (thisInvoiceObj; customerObj; ruleObj ; inSimulator) -> isMatch: boolean
// match this invoice against one Rule only; the reason 'ThisInvoice' and not 'any' invoice is that this invoice is not saved yet
// therefore we cannot query it or we don't have access to an entity object nor can we query the table and create an entity object
// now there is the same issue about the customerObj. If the customer is not saved, then we cannot query it, so we have to assume it's
// a generic customer or create an entity object based on the customer object in memory
// this method requires thisInvoiceObj to be created prior to passing
// PRE:  ruleObj # null

// class thisInvoiceObj {
//  invoiceID: text;
//  invoiceDate: date;
//  customerID: text;
// }

// #ORDA

C_OBJECT:C1216($thisInvoiceObj; $1; $customerObj; $2)
C_OBJECT:C1216($customerObj; $ruleObj; $3; $statsObj)
C_OBJECT:C1216($filterObj)

C_BOOLEAN:C305($inSimulator; $4)
C_BOOLEAN:C305($match; $0)

C_TEXT:C284($thisInvoiceID; $customerID; $group)
C_DATE:C307($date)

Case of 
	: (Count parameters:C259=3)
		$thisInvoiceObj:=$1
		$customerObj:=$2
		$ruleObj:=$3
		$inSimulator:=True:C214
		
	: (Count parameters:C259=4)
		$thisInvoiceObj:=$1
		$customerObj:=$2
		$ruleObj:=$3
		$inSimulator:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
//

ASSERT:C1129($thisInvoiceObj#Null:C1517)
ASSERT:C1129($thisInvoiceObj.InvoiceID#Null:C1517)
ASSERT:C1129($thisInvoiceObj.CustomerID#Null:C1517)
ASSERT:C1129($thisInvoiceObj.invoiceDate#Null:C1517)
//[Invoices]invoiceDate

ASSERT:C1129($customerObj#Null:C1517)
ASSERT:C1129($ruleObj#Null:C1517)

$thisInvoiceID:=$thisInvoiceObj.InvoiceID
$date:=Date:C102($thisInvoiceObj.invoiceDate)
$customerID:=$thisInvoiceObj.CustomerID
$group:=$customerObj.GroupName


If ($customerObj#Null:C1517)
	
	If ($inSimulator)  // this is for the prototyper
		$filterObj:=agg_newFilterFromForm  // need to change this to map the rule to a filter
	Else 
		$filterObj:=agg_newFilterFromRule($ruleObj; $customerID; $thisInvoiceID; $group)
	End if 
	
	// we prepare the filter object $filterObj before getting the stats;
	// the filter works based on customer information and some of the rule filters (e.g. incoming cash for account Cash-03 only)
	// the stats are calculated based on a filter, the filter could include customer ID, invoice ID, group
	// or not. That's why why need to prepare the filter; two different ways to prepare for the simulator or the
	// invoice
	//$statsObj:=getTransactionStats($filterObj; newDateRange($date; $date); $inSimulator)
	$statsObj:=agg_getStatsObject($filterObj; newDateRange($date; $date); $inSimulator)
	
	$match:=($ruleObj.isActive | (Position:C15("group"; $ruleObj.ruleName)>0))  // always start with a assuming the match is true; if match is not active then there's no match
	
	// this recursive call was commented out by who? why?  This is a recursive call and shall be therefore called until the end of the chain @tiran\
																				//If ($ruleObj.chainToRuleID#"")// if there's a chain rule, then evaluate the chain first recursively
	//$match:=$match&matchThisInvoice_vs_AMLRule
	//end if
	
	If (($thisInvoiceID="") & (Num:C11($ruleObj.isByInvoice)=1))  // if the rule is by invoice and no invoiceID is provided then not a match
		$match:=False:C215
	End if 
	$match:=($match & (agg_isRuleMatchingThisCustomer($customerObj; $statsObj; $ruleObj)))
	
End if 

$0:=$match