
C_POINTER:C301($ptrListbox)
C_LONGINT:C283($iTable; $iView)

$ptrListbox:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")

If (Form event code:C388=On Outside Call:K2:11)
	
	ARRAY TEXT:C222(LB_EditArrayName; 0)
	ARRAY LONGINT:C221(LB_EditArrayNum; 0)
	
	$iTable:=iLB_Current_Table($ptrListbox)
	$iView:=iLB_Current_View($ptrListbox)*-1
	iLB_Load_Form($ptrListbox; $iTable; $iView)
	iLB_Load_ViewArrays($iTable; $iView; ->LB_EditArrayNum; ->LB_EditArrayName)  //fill popup menu arrays
End if 