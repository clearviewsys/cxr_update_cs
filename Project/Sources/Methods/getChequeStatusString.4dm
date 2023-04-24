//%attributes = {}
// getChequeStatusString(int : status) ->status string
C_LONGINT:C283($1)
C_TEXT:C284($0)
$0:=""

Case of 
	: ($1=0)
		$0:="Pending"
	: ($1=1)
		$0:="Cleared"
	: ($1=2)
		$0:="Bounced"
End case 