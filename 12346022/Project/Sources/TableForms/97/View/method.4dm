handleViewFormMethod

OBJECT SET TITLE:C194(*; "status"; getShipmentStatusText([Shipments:97]shippingStatus:8))

If (Form event code:C388=On Load:K2:1)
	READ ONLY:C145([ShipmentLines:98])
	QUERY:C277([ShipmentLines:98]; [ShipmentLines:98]shipmentID:2=[Shipments:97]shipmentID:1)
End if 
