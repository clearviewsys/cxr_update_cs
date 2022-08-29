C_TEXT:C284($sMenu)

Case of 
	: (Form event code:C388=On Load:K2:1)
		//Case of 
		//: (<>CLIENTCODE="MoneyWay@")  //for MoneyWay
		//OBJECT SET VISIBLE(Self->;True)
		//OBJECT SET TITLE(Self->;"Central1 Export")
		
		//: (<>CLIENTCODE="CanAm@")  //for CanAm
		//OBJECT SET VISIBLE(Self->;True)
		//OBJECT SET TITLE(Self->;"BOM Export")
		
		//: (Current user="designer")
		//OBJECT SET VISIBLE(Self->;True)
		//OBJECT SET TITLE(Self->;"Export")
		
		//Else 
		//OBJECT SET VISIBLE(Self->;False)
		//End case 
		
		
	: (Form event code:C388=On Clicked:K2:4)  //convert to a popup menu
		$sMenu:=Create menu:C408
		
		If (<>CLIENTCODE="MoneyWay@") | (keyValue_getValue("eft.isActive")="true") | (Current user:C182="designer")
			APPEND MENU ITEM:C411($sMenu; "Central1 EFT Export"; *)
			SET MENU ITEM PARAMETER:C1004($sMenu; -1; "Central1")
		End if 
		
		If (<>CLIENTCODE="CanAm@") | (keyValue_getValue("bom.eft.isActive")="true") | (Current user:C182="designer")
			APPEND MENU ITEM:C411($sMenu; "BOM EFT Export"; *)
			SET MENU ITEM PARAMETER:C1004($sMenu; -1; "BOM")
		End if 
		
		If (Count menu items:C405($sMenu)=0)
			APPEND MENU ITEM:C411($sMenu; "No export options"; *)
			SET MENU ITEM PARAMETER:C1004($sMenu; -1; "NONE")
		End if 
		
		C_TEXT:C284($tFilter)
		$tFilter:=Dynamic pop up menu:C1006($sMenu)
		
		If ($tFilter="")
		Else 
			Case of 
				: ($tFilter="Central1@")
					exportCentral1AFT_Wires
					
				: ($tFilter="BOM@")
					exportBOMEFT_Wires
					
				Else 
					BEEP:C151
			End case 
			
		End if 
		
End case 