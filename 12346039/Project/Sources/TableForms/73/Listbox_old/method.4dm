

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Outside Call:K2:11)
		C_POINTER:C301($ptrListBox)
		
		$ptrListBox:=->RPT_iListbox
		iLB_Load_Form($ptrListBox; iLB_Current_Table($ptrListBox); iLB_Current_View($ptrListBox); True:C214)  //;$iView)
		
	: (Form event code:C388=On Menu Selected:K2:14)
		
		
	Else 
		
		
End case 