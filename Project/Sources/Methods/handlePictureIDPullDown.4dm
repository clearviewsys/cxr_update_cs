//%attributes = {}
// handlePictureIDPullDown (->fieldPtr)
// this method populate the dropdown menu used for attaching picture IDs to a field
// using the content of a preset folder in Client prefs (where the scanned images are)


C_POINTER:C301($pictureFieldPtr; $1)
C_TEXT:C284($path)

Case of 
	: (Count parameters:C259=1)
		$pictureFieldPtr:=$1
		
	Else 
		$pictureFieldPtr:=->[Customers:3]PictureID_Image:53
End case 


If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrPictures; 0)  // Modified by: Barclay (1/26/2012)
	$path:=getClientPictureIDSource  // Jan 17, 2012 13:41:48 -- I.Barclay Berry Added to test for valid path first
	If (Test path name:C476($path)=Is a folder:K24:2)
		DOCUMENT LIST:C474($path; arrPictures)
	Else 
		If ($path#"")  // TB ; empty path is okay
			myAlert("<X> is an incorrect path. Please fix picture ID path in client prefs"; $path)
		End if 
	End if 
	
	INSERT IN ARRAY:C227(arrPictures; 1)
	arrPictures{1}:="Refresh List..."
End if 

If (Form event code:C388=On Clicked:K2:4)
	If (arrPictures=1)  // refresh
		$path:=getClientPictureIDSource
		If (Test path name:C476($path)=Is a folder:K24:2)
			DOCUMENT LIST:C474($path; arrPictures)
			INSERT IN ARRAY:C227(arrPictures; 1)
			arrPictures{1}:="Refresh List..."
		End if 
	Else 
		loadPicture(getClientPictureIDSource+arrPictures{arrPictures}; $pictureFieldPtr)
	End if 
	
	
	
End if 