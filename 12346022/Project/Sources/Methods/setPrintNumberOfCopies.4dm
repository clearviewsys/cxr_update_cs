//%attributes = {}
// setPrintNumberOfCopies(numberOfCopies)

C_LONGINT:C283($copies; $1)
$copies:=$1

If ($copies>0)
	SET PRINT OPTION:C733(4; $copies)
End if 