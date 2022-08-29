
handleListBoxObjectMethod(Self:C308; Current form table:C627)
//handleListboxColumnsSettings (Self)



C_LONGINT:C283($iTable; $iView)

C_POINTER:C301($ptrObject)
$ptrObject:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")

Case of 
	: (Form event code:C388=On Load:K2:1)
		C_LONGINT:C283(mainListBox)  // Oct 22, 2009 22:51:33 -- I.Barclay Berry 
		
		iLB_Init_NewProcess
		
		$iTable:=Table:C252(Current form table:C627)
		$iView:=iLB_LastView($iTable)
		
		iLB_Current_View($ptrObject; $iView)  //set the view
		iLB_Current_Table($ptrObject; $iTable)  //set listbox table
		iLB_Load_Form($ptrObject; $iTable; $iView; True:C214)
		
		//ARRAY STRING(80;Output_asViews;0)  //arrays to setup view popup menu
		//ARRAY LONGINT(Output_aiViews;0)
		//
		//iLB_Load_ViewArrays ($iTable;$iView;->Output_aiViews;->Output_asViews)  //fill popup menu arrays
		//
		//If (Size of array(Output_asViews)=1)  //only 1 view and no editing
		//OBJECT SET VISIBLE(Output_asViews;False)
		//OBJECT SET VISIBLE(Output_iViews;False)  //view button
		//Else 
		//OBJECT SET VISIBLE(Output_asViews;True)
		//OBJECT SET VISIBLE(Output_iViews;True)  //view button
		//End if 
		
		iLB_Current_View($ptrObject; Abs:C99($iView))  //if was neg num change to positive
		
		If (Is Windows:C1573)  // changed by @tiran for v18
			OBJECT MOVE:C664(Self:C308->; 0; 0; 0; -2)
		End if 
		
		DEFAULT TABLE:C46(Current form table:C627->)
		
		showRelevant(Current form table:C627)
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		handledoubleclickevent(Current form table:C627)
		
	Else 
		iLB_ObjectMethod($ptrObject; Self:C308)
End case 


If (Form event code:C388=On Selection Change:K2:29)  //  Click
	
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	
	If (Records in set:C195("UserSet")=1)
		
	End if 
	
	//APP_Contextual_Menu (gTablePtr;"UserSet")  // Mar 25, 2011 11:50:45 -- I.Barclay Berry 
	
End if 


