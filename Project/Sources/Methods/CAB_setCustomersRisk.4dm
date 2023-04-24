//%attributes = {}
// CAB_setCustomersRisk
// this method will set customer to high risk based on CAB policies
// run this in a calendar event

QUERY:C277([Customers:3]; [Customers:3]AML_RiskRating:75<=3)  // low risk customers only

READ WRITE:C146([Customers:3])
APPLY TO SELECTION:C70([Customers:3]; CAB_setCustomerRisk)
UNLOAD RECORD:C212([Customers:3])
READ ONLY:C145([Customers:3])

