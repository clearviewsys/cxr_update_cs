//%attributes = {}

// ----------------------------------------------------
// User name (OS): Barclay Berry
// Date and time: 12/18/13, 15:46:16
// Copyright 2012 -- IBB Consulting, LLC
// ----------------------------------------------------
// Method: AUDIT_Trigger
// Description
//     Seem to be having issues with TRIGGER PROPERTIES
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($i; $iEvent; $iRecNum; $iTable; $iType; $iField; $ii)
C_PICTURE:C286($pPict)
C_BLOB:C604($xBlob)
C_POINTER:C301($ptrPK; $ptrField; $ptrTable)
C_BOOLEAN:C305($bLog)


TRIGGER PROPERTIES:C399(Trigger level:C398; $iEvent; $iTable; $iRecNum)
$ptrTable:=Table:C252($iTable)
$iField:=0  //init
$bLog:=True:C214  //init

READ ONLY:C145([AuditControls:117])
QUERY:C277([AuditControls:117]; [AuditControls:117]tableNum:3=$iTable; *)
QUERY:C277([AuditControls:117];  & ; [AuditControls:117]eventNum:2=$iEvent)

If (Records in selection:C76([AuditControls:117])>0)
	//should probably save [Audit] records in separate process???
	
	If (True:C214)
		//---- THE AUDIT CONDITION HERE ----   
		
		For ($i; 1; Records in selection:C76([AuditControls:117]))
			$iField:=[AuditControls:117]fieldNum:4
			
			If ([AuditControls:117]isLog:6)  //log this event
				
				Case of 
					: ($iEvent=On Deleting Record Event:K3:3) & ([AuditControls:117]isArchive:7)
						AUDIT_createAudit($iEvent; $iTable; $iField)
						
					: ($iField=-1)  //ALL fields
						//TRACE
						For ($ii; 1; Get last field number:C255($iTable))
							If (Is field number valid:C1000($iTable; $ii))
								AUDIT_createAudit($iEvent; $iTable; $ii)
							End if 
						End for 
						
					: ($iField>0)
						AUDIT_createAudit($iEvent; $iTable; $iField)
					Else 
						
				End case 
				
			End if 
			
			NEXT RECORD:C51([AuditControls:117])
		End for 
		
	End if 
	
	
End if 


UNLOAD RECORD:C212([Audit:118])
REDUCE SELECTION:C351([AuditControls:117]; 0)
