//%attributes = {}
// setPrintScale (% printScale)
C_REAL:C285($scale; $1)

$scale:=$1

If ($scale>0)
	SET PRINT OPTION:C733(3; $scale)
End if 