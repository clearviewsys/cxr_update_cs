//%attributes = {}
// newRuleObjectFromFormObject() -> rule: object
// creates a rule object from Form object data
// This is necessary for being able to pass the Rule as an object to other methods

C_OBJECT:C1216($ruleObj; $0)


$ruleObj:=New object:C1471  // later replace with datastore dataclass

// rules that need to be compared against the stats
//[AML_AggrRules]Name
$ruleObj.ruleName:=String:C10(Form:C1466.Rule.ruleName)
$ruleObj.ifQtyGTOE:=Num:C11(Form:C1466.Rule.ifQtyGTOE)
$ruleObj.ifVolumeGTOE:=Num:C11(Form:C1466.Rule.ifVolumeGTOE)
$ruleObj.ifCustomerID:=String:C10(Form:C1466.Rule.ifCustomerID)
$ruleObj.ifAmountGTOE:=Num:C11(Form:C1466.Rule.ifAmountGTOE)
$ruleObj.ifValueGTOE:=Num:C11(Form:C1466.Rule.ifValueGTOE)
$ruleObj.toCurrency:=String:C10(Form:C1466.Rule.toCurrency)

// Filter rules! 
$ruleObj.accountID:=String:C10(Form:C1466.Rule.ifAccountID)  // rule
$ruleObj.currency:=String:C10(Form:C1466.Rule.ifCurrency)  // rule

$ruleObj.days:=Num:C11(Form:C1466.Rule.inDays)  // rule
$ruleObj.fromDate:=Date:C102(Form:C1466.Rule.ifFromDate)
$ruleObj.toDate:=Date:C102(Form:C1466.Rule.ifToDate)

$ruleObj.direction:=Num:C11(Form:C1466.Rule.ifIsReceived)  // rule
$ruleObj.isCash:=Num:C11(Form:C1466.Rule.ifIsCash)  // rule
$ruleObj.isEFT:=Num:C11(Form:C1466.Rule.ifIsEFT)  // rule
$ruleObj.isByInvoice:=Num:C11(Form:C1466.Rule.ifIsByInvoice)  // rule
$ruleObj.isActive:=Form:C1466.Rule.isActive

$ruleObj.ifIsWalkin:=Num:C11(Form:C1466.Rule.ifIsWalkin)
$ruleObj.ifIsInsider:=Num:C11(Form:C1466.Rule.ifIsInsider)
$ruleObj.ifIsCompany:=Num:C11(Form:C1466.Rule.ifIsCompany)
$ruleObj.ifIsSuspicious:=Num:C11(Form:C1466.Rule.ifIsSuspicious)
$ruleObj.ifIsHighRisk:=Num:C11(Form:C1466.Rule.ifIsHighRisk)
$ruleObj.ifGroup:=String:C10(Form:C1466.Rule.ifGroup)

$0:=$ruleObj