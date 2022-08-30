//%attributes = {"publishedWeb":true}
// Form Handler View ( »table )


C_POINTER:C301($tablePtr)
C_LONGINT:C283($event)
C_BOOLEAN:C305(DataChanged)
$tablePtr:=Current form table:C627
$event:=Form event code:C388
//Handle VRecNum 


Case of 
	: ($event=On Load:K2:1)
		SET MENU BAR:C67(1)
		SET TIMER:C645(-1)
		
	: ($event=On Unload:K2:2)
		//GET WINDOW RECT($xCord;$yCord;$r;$b)
		//set Cord(Current form table;$xCord;$yCord)
		
	: ($event=On Timer:K2:25)
		//$ptrVar:=OBJECT Get pointer(Object named;"TransLevelInfo")
		//$ptrVar->:=UTIL_getTransLevelText 
		//REDRAW($ptrVar->)
		SET TIMER:C645(0)
		
	: ($event=On Close Box:K2:21)
		CANCEL:C270
		
		
End case 

