//%attributes = {}
// getTriggerShortName (trigger event)

C_LONGINT:C283($1)
C_TEXT:C284($0)

Case of 
	: ($1=On Saving New Record Event:K3:1)
		$0:="NEW"
	: ($1=On Saving Existing Record Event:K3:2)
		$0:="MOD"
	: ($1=On Deleting Record Event:K3:3)
		$0:="DEL"
	Else 
		$0:=""
End case 
