
C_LONGINT:C283($size)
$size:=Num:C11(Request:C163("Find picture IDs larger than (KB)"))*1000


If (OK=1)
	If (Records in selection:C76([Customers:3])>0)
		QUERY SELECTION BY FORMULA:C207([Customers:3]; Picture size:C356([Customers:3]PictureID_Image:53)>$size)
	Else 
		QUERY BY FORMULA:C48([Customers:3]; Picture size:C356([Customers:3]PictureID_Image:53)>$size)
		
	End if 
End if 

orderbyCustomers
