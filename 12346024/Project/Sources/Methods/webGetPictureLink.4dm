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


C_PICTURE:C286($0; $pict)


READ ONLY:C145([WebAttachments:86])

QUERY:C277([WebAttachments:86]; [WebAttachments:86]RelatedID:2=[Links:17]LinkID:1; *)
QUERY:C277([WebAttachments:86];  & ; [WebAttachments:86]RelatedTableNum:11=Table:C252(->[Links:17]))


If (Picture size:C356([WebAttachments:86]Preview:12)=0)
	
	READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16; *)+"placeholder.png"; $pict)
	$0:=$pict
Else 
	$pict:=WAPI_pict2Thumbnail(->[WebAttachments:86]Preview:12; 128)
	$0:=$pict
End if 