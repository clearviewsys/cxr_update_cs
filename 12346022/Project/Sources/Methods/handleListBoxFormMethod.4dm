//%attributes = {}
// handleListBoxForm Method (current form table; ->counter var)

C_POINTER:C301($tablePtr; $1)
C_POINTER:C301($countPtr; $2)

C_TEXT:C284($set)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$countPtr:=$2
		$countPtr->:=Records in selection:C76($tablePtr->)
End case 

Case of 
	: (Form event code:C388=On Load:K2:1)
		//XLIFF_TranslateFormObjects
		READ ONLY:C145(*)  //1/11/21 IBB
		
		$set:=getTableNamedSet($tablePtr)
		If (Records in set:C195($set)>0)
			USE SET:C118($set)
			CLEAR SET:C117($set)
		End if 
		
		setFormObjectCustomProperties("ListBox")
		GOTO OBJECT:C206(vSearchString)  // highlight the search
		
	: (Form event code:C388=On Unload:K2:2)
		
		
	: (Form event code:C388=On Close Box:K2:21)
		CLOSE WINDOW:C154(Frontmost window:C447)
		CANCEL:C270
		
		
End case 

