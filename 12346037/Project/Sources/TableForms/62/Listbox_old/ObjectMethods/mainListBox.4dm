C_LONGINT:C283(mainListBox)

C_POINTER:C301($ptrListbox)
C_LONGINT:C283($iTable; $iView)
$ptrListbox:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
		iLB_Init_NewProcess
		
		$iTable:=Table:C252(->[Countries:62])
		$iView:=1
		
		iLB_Current_Table($ptrListbox; $iTable)
		iLB_Current_View($ptrListbox; $iView)
		iLB_Load_Form($ptrListbox; $iTable; $iView; True:C214)
		
		
	Else 
		iLB_ObjectMethod($ptrListbox; Self:C308)
End case 