C_OBJECT:C1216($filterObj)
// the reason we are sending a filter is because the matching isn't happening yet.
// it's just a filter for getting stats on a customer
$filterObj:=agg_newFilterFromForm
C_LONGINT:C283(cb_connected)
Form:C1466.stats:=agg_getStatsObject($filterObj; newDateRange(Current date:C33); True:C214; (cb_connected=1))
