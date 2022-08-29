C_POINTER:C301($ptrListbox)
C_TEXT:C284($tValue)


$ptrListbox:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")

If (Form event code:C388=On After Keystroke:K2:26)
	$tValue:=Get edited text:C655
Else 
	$tValue:=Self:C308->
End if 

QUERY:C277([CommonLists:84]; [CommonLists:84]ListName:1=vPickListName; *)
QUERY:C277([CommonLists:84];  & ; [CommonLists:84]ItemName:2=$tValue+"@")

If (Records in selection:C76([CommonLists:84])=1)
	//CREATE SET([CommonLists];"UserSet")
	//COPY SET("UserSet";iLB_Get_SetName ($ptrListbox))
	//GOTO SELECTED RECORD([CommonLists];Selected record number([CommonLists]))
	//GOTO OBJECT($ptrListbox->)
	//POST KEY(Down Arrow Key)
	//CREATE SET([CommonLists];"$FoundSet")
	//HIGHLIGHT RECORDS([CommonLists];"$FoundSet")
	//CLEAR SET("$FoundSet")
	//REDRAW WINDOW
End if 