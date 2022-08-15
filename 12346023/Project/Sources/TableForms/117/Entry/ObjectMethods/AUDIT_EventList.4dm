
// ----------------------------------------------------
// User name (OS): Barclay
// Date and time: 06/14/18, 17:30:34
// ----------------------------------------------------
// Method: [CommonLists].Entry.PICK_ListName
// Description
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Is new record:C668([AuditControls:117]))
			[AuditControls:117]eventNum:2:=On Saving Existing Record Event:K3:2
		End if 
		
		Self:C308->:=New list:C375
		APPEND TO LIST:C376(Self:C308->; "On Saving New Record"; On Saving New Record Event:K3:1)
		APPEND TO LIST:C376(Self:C308->; "On Saving Existing Record"; On Saving Existing Record Event:K3:2)
		APPEND TO LIST:C376(Self:C308->; "On Deleting Record"; On Deleting Record Event:K3:3)
		
		SELECT LIST ITEMS BY REFERENCE:C630(OBJECT Get pointer:C1124(Object named:K67:5; "AUDIT_EventList")->; [AuditControls:117]eventNum:2)
		
		
	: (Form event code:C388=On Data Change:K2:15)
		//$ptrVar:=OBJECT Get pointer(Object named;"AUDIT_EventList")
		[AuditControls:117]eventNum:2:=Selected list items:C379(Self:C308->; *)
		
		If ([AuditControls:117]eventNum:2=On Saving New Record Event:K3:1) | ([AuditControls:117]eventNum:2=On Deleting Record Event:K3:3) | ([AuditControls:117]eventNum:2=4)
			OBJECT SET VISIBLE:C603(*; "AUDIT_FieldList"; False:C215)
			[AuditControls:117]fieldNum:4:=0
		Else 
			OBJECT SET VISIBLE:C603(*; "AUDIT_FieldList"; True:C214)
			If ([AuditControls:117]fieldNum:4=0)
				[AuditControls:117]fieldNum:4:=1
				SELECT LIST ITEMS BY REFERENCE:C630(OBJECT Get pointer:C1124(Object named:K67:5; "AUDIT_FieldList")->; 1)
			End if 
		End if 
		
	Else 
		
		
End case 


If ([AuditControls:117]eventNum:2=On Deleting Record Event:K3:3)
	OBJECT SET VISIBLE:C603(*; "AUDIT_Archive"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "AUDIT_Archive"; False:C215)
End if 

If ([AuditControls:117]eventNum:2<10)
	OBJECT SET VISIBLE:C603(*; "AUDIT_Log"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "AUDIT_Log"; False:C215)
End if 