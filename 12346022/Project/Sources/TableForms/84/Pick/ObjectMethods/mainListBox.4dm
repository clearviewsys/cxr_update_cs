C_LONGINT:C283(mainListBox)

C_POINTER:C301($ptrListbox)
C_LONGINT:C283($iTable; $iView)
$ptrListbox:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")


Case of 
	: (Form event code:C388=On Load:K2:1)
		iLB_Init_NewProcess
		
		$iTable:=Table:C252(->[CommonLists:84])
		$iView:=vPickView
		
		iLB_Current_Table($ptrListbox; $iTable)
		iLB_Current_View($ptrListbox; $iView)
		iLB_Load_Form($ptrListbox; $iTable; $iView; True:C214)
		
	: (Form event code:C388=On Clicked:K2:4)
		$iTable:=iLB_Current_Table($ptrListbox)
		GOTO SELECTED RECORD:C245(Table:C252($iTable)->; Selected record number:C246(Table:C252($iTable)->))
		
		vPickSearchText:=[CommonLists:84]ItemName:2  //hard code for now.. should allow change... also could be the "code"
		vPickRecNum:=Record number:C243(Table:C252($iTable)->)
		
	: (Form event code:C388=On Double Clicked:K2:5)
		$iTable:=iLB_Current_Table($ptrListbox)
		GOTO SELECTED RECORD:C245(Table:C252($iTable)->; Selected record number:C246(Table:C252($iTable)->))
		vPickRecNum:=Record number:C243(Table:C252($iTable)->)
		ACCEPT:C269
		
	Else 
		iLB_ObjectMethod($ptrListbox; Self:C308)
End case 