//%attributes = {}
// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 05/24/13, 15:46:41
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: fixCustomerPictures
// Description
// 
//
// Parameters
// ----------------------------------------------------
// 
// Modified by: Tiran Behrouz (5/29/13)


//fixCustomerPictures (
C_REAL:C285($iProgress; $i; $iSize; $iWidth; $rScale; $iPercent; $iProgress; $iHeight)
READ WRITE:C146([Customers:3])

ALL RECORDS:C47([Customers:3])

$iProgress:=Progress New

For ($i; 1; Records in selection:C76([Customers:3]))
	
	$iSize:=Picture size:C356([Customers:3]PictureID_Image:53)
	
	If ($iSize>0)
		ARRAY TEXT:C222($atCodecs; 0)
		GET PICTURE FORMATS:C1406([Customers:3]PictureID_Image:53; $atCodecs)
		
		If (Find in array:C230($atCodecs; "@pict@")>0)
			
			PICTURE PROPERTIES:C457([Customers:3]PictureID_Image:53; $iWidth; $iHeight)  //get to about 640x480
			
			If ($iWidth>480)
				$rScale:=480/$iWidth
				TRANSFORM PICTURE:C988([Customers:3]PictureID_Image:53; Scale:K61:2; $rScale; $rScale)  //scale to 
			End if 
			
			CONVERT PICTURE:C1002([Customers:3]PictureID_Image:53; ".jpg"; 0.6)  // WILL NOT WORK IN 64 BIT
			
			If (OK=1)
				SAVE RECORD:C53([Customers:3])
			End if 
		End if 
		
	End if 
	
	$iPercent:=$i/Records in selection:C76([Customers:3])
	Progress SET PROGRESS($iProgress; $iPercent; "Converting pictures...")
	
	NEXT RECORD:C51([Customers:3])
End for 

Progress QUIT($iProgress)

//EOM

//progressBarHandlingTemplate