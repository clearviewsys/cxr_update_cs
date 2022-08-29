
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


C_POINTER:C301($ptrVar)
C_LONGINT:C283($iTable)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Is new record:C668([AuditControls:117]))
			[AuditControls:117]tableNum:3:=2
			[AuditControls:117]fieldNum:4:=1
			[AuditControls:117]eventNum:2:=On Saving Existing Record Event:K3:2
		End if 
		
		$ptrVar:=OBJECT Get pointer:C1124(Object named:K67:5; "AUDIT_TableList")
		$ptrVar->:=New list:C375
		UTIL_tables2List($ptrVar->)
		SELECT LIST ITEMS BY REFERENCE:C630($ptrVar->; [AuditControls:117]tableNum:3)
		
		If ([AuditControls:117]eventNum:2=On Saving New Record Event:K3:1) | ([AuditControls:117]eventNum:2=On Deleting Record Event:K3:3)
			OBJECT SET VISIBLE:C603(*; "AUDIT_FieldList"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "AUDIT_FieldList"; True:C214)
			
			$ptrVar:=OBJECT Get pointer:C1124(Object named:K67:5; "AUDIT_FieldList")
			$ptrVar->:=New list:C375
			
			UTIL_fields2List($ptrVar->; [AuditControls:117]tableNum:3)
			SELECT LIST ITEMS BY REFERENCE:C630($ptrVar->; [AuditControls:117]fieldNum:4)
		End if 
		
		
		
	: (Form event code:C388=On Data Change:K2:15)
		
		$iTable:=Selected list items:C379(Self:C308->; *)
		
		If ($iTable=[AuditControls:117]tableNum:3)  //no change
		Else 
			[AuditControls:117]tableNum:3:=$iTable
			
			If ([AuditControls:117]eventNum:2=On Saving New Record Event:K3:1) | ([AuditControls:117]eventNum:2=On Deleting Record Event:K3:3)
				OBJECT SET VISIBLE:C603(*; "AUDIT_FieldList"; False:C215)
				[AuditControls:117]fieldNum:4:=0
			Else 
				//now build field list
				$ptrVar:=OBJECT Get pointer:C1124(Object named:K67:5; "AUDIT_FieldList")
				
				CLEAR LIST:C377($ptrVar->)
				$ptrVar->:=New list:C375
				UTIL_fields2List($ptrVar->; [AuditControls:117]tableNum:3)
				SELECT LIST ITEMS BY POSITION:C381($ptrVar->; 1)
				[AuditControls:117]fieldNum:4:=1
			End if 
			
			//SELECT LIST ITEMS BY REFERENCE(Self->;$iTable)
			
		End if 
		
		
		
		
		
	Else 
		
		
End case 