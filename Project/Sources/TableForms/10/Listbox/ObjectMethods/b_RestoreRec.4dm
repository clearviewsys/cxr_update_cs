

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Current user:C182="designer") | (Current user:C182="administrator")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
		
	: (Form event code:C388=On Clicked:K2:4)
		CREATE RECORD:C68([Registers:10])
		loadCurrentRecordFromFile
		SAVE RECORD:C53([Registers:10])
		
	Else 
		
End case 