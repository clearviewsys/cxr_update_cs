
C_TEXT:C284($tListName)
C_POINTER:C301($ptrCodes; $ptrOrders; $ptrNames)
C_LONGINT:C283($i; $iFound; $iList; $iSize)


$tListName:=OBJECT Get pointer:C1124(Object named:K67:5; "PICK_ListName")->{0}

If ($tListName="")
	myAlert("Please specify a list name.")
	REJECT:C38
Else 
	READ WRITE:C146([CommonLists:84])
	QUERY:C277([CommonLists:84]; [CommonLists:84]ListName:1=$tListName)
	
	If (Records in selection:C76([CommonLists:84])>0)  //clean up old lists
		DELETE SELECTION:C66([CommonLists:84])
	End if 
	
	//test to see if $tListName exists in the 
	$iList:=Load list:C383("CommonLists")
	
	$iFound:=Find in list:C952($iList; $tListName; 0)
	If ($iFound=0)  //not found so add to the list and save
		APPEND TO LIST:C376($iList; $tListName; Count list items:C380($iList; *)+1)
		SAVE LIST:C384($iList; "CommonLists")
	End if 
	
	
	
	//*** NEED TO CREATE STARTUP FUNCTION THAT CHECKS THE LIST AND UPDATES BASED ON DATABASE RECORDS ****
	
	$ptrCodes:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Codes")
	$ptrOrders:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Orders")
	$ptrNames:=OBJECT Get pointer:C1124(Object named:K67:5; "BULK_Names")
	
	$iSize:=Size of array:C274($ptrCodes->)
	
	For ($i; 1; $iSize)
		If ($ptrNames->{$i}="") | ($ptrNames->{$i}="<ITEM NAME>")
		Else 
			CREATE RECORD:C68([CommonLists:84])
			[CommonLists:84]ItemCode:6:=$ptrCodes->{$i}
			[CommonLists:84]Order:4:=$ptrOrders->{$i}
			[CommonLists:84]ItemName:2:=$ptrNames->{$i}
			[CommonLists:84]ListName:1:=$tListName
			SAVE RECORD:C53([CommonLists:84])
		End if 
	End for 
	
	CLEAR LIST:C377($iList)
End if 