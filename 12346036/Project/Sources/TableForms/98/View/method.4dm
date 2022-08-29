handleViewFormMethod

If ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Outside Call:K2:11))
	OBJECT SET ENABLED:C1123(*; "b_editRecord"; False:C215)
	Form:C1466.date:=String:C10(ds:C1482.Shipments.query("shipmentID="+[ShipmentLines:98]shipmentID:2).first().shipmentDate)
End if 