//%attributes = {"publishedWeb":true}
// this is the new version of form handler list

// Form handler list
// this procdure should be called by all list forms
C_LONGINT:C283($event)
C_LONGINT:C283($XCord; $yCord; $r; $b)
C_POINTER:C301($currentTablePtr; $mainListBoxPtr)

$event:=Form event code:C388
$currentTablePtr:=Current form table:C627

Case of 
		
	: (($event=On Load:K2:1) | ($event=On Activate:K2:9))
		SET WINDOW TITLE:C213(getElegantTableName(Current form table:C627)+" List")
		
	: ($event=On Double Clicked:K2:5)
		handledoubleclickevent
		
	: ($event=On Clicked:K2:4)
		POST OUTSIDE CALL:C329(Current process:C322)
		
	: ($event=On Activate:K2:9)
		REDRAW WINDOW:C456
		
	: ($event=On Deactivate:K2:10)
		
	: ($event=On Close Box:K2:21)
		ACCEPT:C269  // this used to be cancel (but changed in due to canceling a transaction
		
	: ($event=On Outside Call:K2:11)  //3/29/18 IBB
		$mainListBoxPtr:=OBJECT Get pointer:C1124(Object named:K67:5; "mainListBox")
		
		If (Records in set:C195(iLB_Get_SetName($mainListBoxPtr))>0)  //debug IBB don't want to refresh a non-listmagic listbox
			iLB_Load_Form($mainListBoxPtr; iLB_Current_Table($mainListBoxPtr); iLB_Current_View($mainListBoxPtr))
		End if 
		
	: ($event=On Unload:K2:2)
		
	: ($event=On Selection Change:K2:29)
		
End case 
