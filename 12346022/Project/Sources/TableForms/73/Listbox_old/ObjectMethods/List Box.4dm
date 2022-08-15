C_POINTER:C301($ptrListBox)
C_LONGINT:C283($iTable; $iView)
$ptrListBox:=->RPT_iListbox

Case of 
	: (Form event code:C388=On Load:K2:1)
		$iTable:=Table:C252(->[Reports:73])  //set the table
		$iView:=iLB_LastView($iTable)  //set the initial view - pass a negative number to allow editing
		
		iLB_Current_Table($ptrListBox; $iTable)  //set list box table 
		iLB_Load_Form($ptrListBox; $iTable; $iView; True:C214)
		
		
		
	Else 
		iLB_ObjectMethod($ptrListBox; Self:C308)
End case 