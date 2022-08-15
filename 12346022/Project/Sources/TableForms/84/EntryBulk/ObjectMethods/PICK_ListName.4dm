
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


C_TEXT:C284($tList)
C_POINTER:C301($ptrCodes; $ptrNames; $ptrOrders)
C_LONGINT:C283($iCount; $iSize)


Case of 
	: (Form event code:C388=On Load:K2:1)
		//Self->:=Abs(Find in array(Self->;[CommonLists]ListName))
		//[CommonLists]ListName:=Self->{Self->}
		
	: (Form event code:C388=On Clicked:K2:4)
		GOTO OBJECT:C206(*; "PICK_Add")
		
	: (Form event code:C388=On Data Change:K2:15)
		
		$tList:=Self:C308->{Self:C308->}
		
		$ptrCodes:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Codes")
		$ptrOrders:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Orders")
		$ptrNames:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Names")
		
		QUERY:C277([CommonLists:84]; [CommonLists:84]ListName:1=$tList)
		
		$iCount:=Records in selection:C76([CommonLists:84])
		$iSize:=Size of array:C274($ptrCodes->)
		
		OK:=1
		
		If (False:C215)
			If ($iCount>0)
				
				If (False:C215)  //revist this later
					Case of 
						: ($iSize=0)
						: ($iCount=$iSize)
						Else 
							myConfirm("Refresh common list? All changes will be lost.")
					End case 
				End if 
			End if 
		End if 
		
		If (OK=1)
			SELECTION TO ARRAY:C260([CommonLists:84]ItemCode:6; $ptrCodes->; [CommonLists:84]Order:4; $ptrOrders->; [CommonLists:84]ItemName:2; $ptrNames->)
		End if 
		
		
	Else 
		
		
End case 