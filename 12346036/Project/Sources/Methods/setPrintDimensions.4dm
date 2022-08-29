//%attributes = {}
// setPrintDimensions (Pixel height; pixel width)
C_LONGINT:C283($height; $width; $1; $2)

$height:=$1
$width:=$2
If (($width>0) & ($height>0))
	SET PRINT OPTION:C733(1; $height; $width)
End if 