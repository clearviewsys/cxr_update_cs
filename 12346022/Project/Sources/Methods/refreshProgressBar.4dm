//%attributes = {}
// refreshProgressBar($progressBarID;$current;$total)
C_LONGINT:C283($progressID; $1; $2; $3; $current; $total)
C_BOOLEAN:C305(vProgressBarStopped)


$progressID:=$1
$current:=$2
$total:=$3

If ($total<2)
	SET PROCESS VARIABLE:C370($progressID; vProgressBarStopped; True:C214)
End if 


SET PROCESS VARIABLE:C370($progressID; vProgressCompleted; $current)
SET PROCESS VARIABLE:C370($progressID; vProgressTotal; $total)

If (Application type:C494#4D Server:K5:6)
	POST OUTSIDE CALL:C329($progressID)
End if 


//Progress SET PROGRESS ($progressID;$current/$total;"Converting pictures...")

