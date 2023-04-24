//%attributes = {}
// pickLinkForCustomer(self;theCustomerID)

C_POINTER:C301($1)
C_TEXT:C284($2; theCustomerID)
theCustomerID:=$2
vQueryCommand:="selectLinksForCustomer"

QUERY:C277([Links:17]; [Links:17]CustomerID:14=theCustomerID)
pickRecordForTable(->[Links:17]; ->[Links:17]LinkID:1; $1; True:C214; True:C214)
//pickLinks($1; "selectLinksForCustomer")
