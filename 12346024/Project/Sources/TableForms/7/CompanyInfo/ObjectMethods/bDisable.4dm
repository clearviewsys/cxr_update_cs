Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		READ WRITE:C146([SanctionLists:113])
		C_TEXT:C284($listboxSetName)
		$listboxSetName:=makeSetNameForTable(->[SanctionLists:113])
		USE SET:C118($listboxSetName)
		CREATE SET:C116([SanctionLists:113]; $listboxSetName)
		//_O_REDRAW LIST(mainListBox)
		
		APPLY TO SELECTION:C70([SanctionLists:113]; [SanctionLists:113]IsEnabled:4:=False:C215)
		
		
End case 
