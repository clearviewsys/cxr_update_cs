// Form Method: [Constants]ChoiceList
// Whenever you disable a standard button (OK, Cancel) your should not use the
//   standard variable name (bOK, bCancel) because that might disable other
//   buttons. So we use bOK2.




Case of 
	: (Form event code:C388=On Load:K2:1)
		//C_LONGINT($i)
		
		
		If (Picture size:C356(vDlogIcon)#0)
			FORM GOTO PAGE:C247(2)
		End if 
		SELECT LIST ITEMS BY POSITION:C381(hlChoices; 1)  // 01/19/2006 -- I. Barclay Berry
		SET LIST PROPERTIES:C387(hlChoices; 0; 0; 0; 0; 0; 0)
		
		//MoveWinButtons (On the Right;->bOK2;->bCancel;->bWinHelp)
		vLastChoice:=1
		viUserSet:=0
		
		If (vbUserSet)
			OBJECT SET VISIBLE:C603(*; "UserSet@"; True:C214)
		Else   //don't use so hide
			OBJECT SET VISIBLE:C603(*; "UserSet@"; False:C215)
			//  MOVE OBJECT(*;"hlChoices@";0;0;0;20)  `expand the list
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		//CLEAR LIST(hlChoices;*)
		
	Else 
		
		GET LIST ITEM:C378(hlChoices; Selected list items:C379(hlChoices); $itemRef; $itemText)
		
		If ($itemRef=0)
			//_O_DISABLE BUTTON(bOK2)
			OBJECT SET ENABLED:C1123(bOK2; False:C215)
		Else 
			//_O_ENABLE BUTTON(bOK2)
			OBJECT SET ENABLED:C1123(bOK2; True:C214)
			//If (<>Platform=Windows)
			//If (vLastChoice=0)
			//GOTO OBJECT(bOK2)  // Make the OK button the selected button.
			//End if 
			//End if 
		End if 
		
		vLastChoice:=$itemRef
		
End case 