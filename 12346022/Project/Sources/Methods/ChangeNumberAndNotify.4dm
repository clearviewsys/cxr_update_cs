//%attributes = {}
//changeNumberAndNotify(->currentVariable;newValue;"notification message")

C_POINTER:C301($1)
C_REAL:C285($2)
C_TEXT:C284($3)

If ($1->>$2)
	$1->:=$2
	notifyUser($3; True:C214)
Else 
	$1->:=$2
End if 