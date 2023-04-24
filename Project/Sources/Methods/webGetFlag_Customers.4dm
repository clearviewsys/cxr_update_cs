//%attributes = {"shared":true,"publishedWeb":true}

C_TEXT:C284($1)

C_PICTURE:C286($0)

C_PICTURE:C286($pict)


webSelectCustomerRecord

If (True:C214)
	QUERY:C277([Flags:19]; [Flags:19]Country:3=[Customers:3]Country_obs:11+"@")
	$pict:=[Flags:19]flag:4
Else 
	C_OBJECT:C1216($entity)
	$entity:=ds:C1482.Flags.query("Country == :1"; ([Customers:3]Country_obs:11+"@"))
	$pict:=$entity.Flag
End if 

If (Picture size:C356($pict)=0)
	$0:=$pict
Else 
	$pict:=WAPI_pict2Thumbnail(->$pict; 40)
	$0:=$pict
End if 