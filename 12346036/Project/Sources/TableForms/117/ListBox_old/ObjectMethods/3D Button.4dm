
C_LONGINT:C283($iTable; $iView)
C_POINTER:C301($ptrListbox)

$ptrListbox:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")

Case of 
	: (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(LB_EditArrayName; 0)
		ARRAY LONGINT:C221(LB_EditArrayNum; 0)
		
		iLB_ViewMenu(Form event code:C388; $ptrListbox; ->LB_EditArrayName; ->LB_EditArrayNum)
		
	: (Form event code:C388=On Clicked:K2:4)
		iLB_ViewMenu(Form event code:C388; $ptrListbox; ->LB_EditArrayName; ->LB_EditArrayNum)
		
	Else 
		
End case 