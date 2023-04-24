C_OBJECT:C1216($filterObj)
// the reason we are sending a filter is because the matching isn't happening yet.
// it's just a filter for getting stats on a customer
$filterObj:=New object:C1471
$filterObj.customerID:=[Customers:3]CustomerID:1
$filterObj.group:=""
$filterObj.invoiceID:=""
$filterObj.accountID:=""  // rule
$filterObj.currency:=""  // rule
$filterObj.days:=0  // rule
$filterObj.direction:=0  // rule
$filterObj.isCash:=0  // rule
$filterObj.isEFT:=0  // rule
$filterObj.isByInvoice:=0  // rule

Form:C1466.stats:=agg_getStatsObject($filterObj)
