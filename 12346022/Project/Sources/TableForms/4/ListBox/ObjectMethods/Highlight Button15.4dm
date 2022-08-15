
C_LONGINT:C283($size)
$size:=Num:C11(Request:C163("Find picture IDs larger than (KB)"))*1000


If (OK=1)
	If (Records in selection:C76([LinkedDocs:4])>0)
		QUERY SELECTION BY FORMULA:C207([LinkedDocs:4]; Picture size:C356([LinkedDocs:4]ScannedImage:2)>$size)
	Else 
		QUERY BY FORMULA:C48([LinkedDocs:4]; Picture size:C356([LinkedDocs:4]ScannedImage:2)>$size)
	End if 
End if 

orderByLinkedDocs