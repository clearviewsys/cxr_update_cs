//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/19/13, 11:42:46
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: AUDIT_GetEventName
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1)

C_TEXT:C284($0; $sEvent)

$sEvent:=""

Case of 
	: ($1=On Saving New Record Event:K3:1)
		$sEvent:="Create Record"
	: ($1=On Saving Existing Record Event:K3:2)
		$sEvent:="Modify Record"
		
	: ($1=On Deleting Record Event:K3:3)
		$sEvent:="Delete Record"
		
	: ($1=4)  //on load record
		$sEvent:="Load Record"
		
	: ($1=10)
		$sEvent:="Mandatory Element"
		
	: ($1=11)
		$sEvent:="Critical Element"
		
	: ($1=12)
		$sEvent:="Important Element"
		
		
	Else 
		$sEvent:="Unknown Event: "+String:C10($1)
		
End case 


$0:=$sEvent