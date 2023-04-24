C_OBJECT:C1216($filterObj; $date)
// the reason we are sending a filter is because the matching isn't happening yet.
// it's just a filter for getting stats on a customer
$filterObj:=agg_newFilterFromForm
$date:=newDateRange(!00-00-00!; Current date:C33; False:C215)

C_LONGINT:C283(cb_connected)
Form:C1466.stats:=agg_getStatsObject($filterObj; $date; True:C214; (cb_connected=1))

