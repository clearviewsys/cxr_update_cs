//%attributes = {}
// handleConvertPictureButton

C_POINTER:C301($picturePtr; $1)
C_REAL:C285($quality; $2; $3)


Case of 
	: (Count parameters:C259=1)
		$picturePtr:=$1
		$quality:=0.8
	: (Count parameters:C259=2)
		$picturePtr:=$1
		$quality:=$2
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
CONVERT PICTURE:C1002($picturePtr->; ".jpg"; $quality)
POST OUTSIDE CALL:C329(Current process:C322)