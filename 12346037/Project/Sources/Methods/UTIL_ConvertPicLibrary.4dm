//%attributes = {}
//Name: UTIL_ConvertPICTs
// Path: UTIL_ConvertPICTs
//
// Purpose: Convert all PICT formatted images in the
// Picture Libraray to .PNG images and preserve transparency
// by converting the white channel to transparent
//
// The 4D Pack Plugin must be installed to use this method

//SET PICTURE TO LIBRARY -- ONLY IDS 0 TO 32767

//CURRENTLY ID 1 TO 850 IS NOT USED BY CXR SO USE THESE TO MOVE ITEMS
C_LONGINT:C283($iNewID)
$iNewID:=0

C_LONGINT:C283($Ndx; $SOA; $RIS; $PictRef_L)
C_TEXT:C284($PictName_T)
C_PICTURE:C286($Pict_G)
C_POINTER:C301($Pict_P)
ARRAY LONGINT:C221($PictRef_aL; 0)
ARRAY TEXT:C222($PictName_aT; 0)
PICTURE LIBRARY LIST:C564($PictRef_aL; $PictName_aT)
$SOA:=Size of array:C274($PictRef_aL)
If ($SOA>0)
	For ($Ndx; 1; $SOA)  // for each picture
		$PictRef_L:=$PictRef_aL{$Ndx}
		$PictName_T:=$PictName_aT{$Ndx}
		loadPictureResource($PictName_aT{$Ndx}; ->$Pict_G)
		//GET PICTURE FROM LIBRARY($PictRef_aL{$Ndx}; $Pict_G)
		$Pict_P:=->$Pict_G  // passage of a pointer
		//If (_o_AP Is Picture Deprecated($Pict_P)=1)  // if format is obsolete
		CONVERT PICTURE:C1002($Pict_G; ".PNG")  // conversion to png
		//TRANSFORM PICTURE($Pict_G;Transparency;0x00FFFFFF)  //0x00FFFFFF is white
		
		If ($PictRef_L<=32767)
			SET PICTURE TO LIBRARY:C566($Pict_G; $PictRef_L; $PictName_T)  // and storage in the library
		Else 
			$iNewID:=$iNewID+1
			If ($iNewID<851)
				SET PICTURE TO LIBRARY:C566($Pict_G; $iNewID; $PictName_T)  // and storage in the library
			Else 
				TRACE:C157
			End if 
		End if 
		//End if 
	End for 
Else 
	ALERT:C41("The picture library is empty.")
End if 