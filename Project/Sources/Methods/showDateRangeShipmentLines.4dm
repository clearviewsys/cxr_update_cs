//%attributes = {}
// getBuild
showDateRangeTable(->[Shipments:97]; ->[Shipments:97]shipmentDate:3)  // notice the date range search is on the related table
RELATE MANY SELECTION:C340([ShipmentLines:98]shipmentID:2)  // map the found dates to shipmentLines 