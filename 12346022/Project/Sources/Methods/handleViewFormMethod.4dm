//%attributes = {}
// Form Handler View ( »table )


C_POINTER:C301($tablePtr; $1)
C_LONGINT:C283($event)
C_BOOLEAN:C305(DataChanged)

Case of 
	: (Count parameters:C259=0)
		$tablePtr:=Current form table:C627
	: (Count parameters:C259=1)
		$tablePtr:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$event:=Form event code:C388
//Handle VRecNum 


Case of 
	: ($event=On Load:K2:1)
		SET MENU BAR:C67(1)
		XLIFF_TranslateFormObjects
		setObjectShortcut
		
	: ($event=On Unload:K2:2)
		//GET WINDOW RECT($xCord;$yCord;$r;$b)
		//set Cord(Current form table;$xCord;$yCord)
		
		
	: ($event=On Close Box:K2:21)
		CANCEL:C270
		
		
End case 

