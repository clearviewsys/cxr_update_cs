//%attributes = {}
// compressPicture(->picture;maxWidth; maxHeight; compressionRate)
// compresses the picture and encodes it into JPG


C_REAL:C285($maxWidth; $maxHeight; $iWidth; $iHeight; $compressionRate; $rScale; $2; $3; $4)
C_POINTER:C301($picturePtr; $1)

Case of 
	: (Count parameters:C259=1)
		$picturePtr:=$1
		$maxWidth:=600
		$maxHeight:=700
		$compressionRate:=0.4
		
	: (Count parameters:C259=3)
		$picturePtr:=$1
		$maxWidth:=$2
		$maxHeight:=$3
		$compressionRate:=0.55
		
	: (Count parameters:C259=4)
		$picturePtr:=$1
		$maxWidth:=$2
		$maxHeight:=$3
		$compressionRate:=$4
	Else 
		$picturePtr:=-><>COMPANYLOGO
		$maxWidth:=640
		$maxHeight:=480
		$compressionRate:=0.5
		
End case 



PICTURE PROPERTIES:C457($picturePtr->; $iWidth; $iHeight)  //get to about 640x480  //

Case of 
		
	: ($iHeight>$iWidth)  // portrait
		If ($iHeight>$maxHeight)
			$rScale:=$maxHeight/$iHeight
			TRANSFORM PICTURE:C988($picturePtr->; Scale:K61:2; $rScale; $rScale)  //scale to 
		End if 
		
	: ($iHeight<=$iWidth)  // landscapre
		If ($iWidth>$maxWidth)
			$rScale:=$maxWidth/$iWidth
			TRANSFORM PICTURE:C988($picturePtr->; Scale:K61:2; $rScale; $rScale)  //scale to 
		End if 
	Else 
		
End case 

CONVERT PICTURE:C1002($picturePtr->; ".jpg"; $compressionRate)
