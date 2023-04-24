//%attributes = {"shared":true,"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 11/04/19, 15:45:32
// ----------------------------------------------------
// Method: webGetLinkPicure
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_PICTURE:C286($0)

C_PICTURE:C286($pict)


webSelectCustomerRecord


If (Picture size:C356([Customers:3]PictureID_Image:53)=0)
	
	READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16; *)+"placeholder.png"; $pict)
	$0:=$pict
Else 
	$pict:=WAPI_pict2Thumbnail(->[Customers:3]PictureID_Image:53; 128)
	$0:=$pict
End if 