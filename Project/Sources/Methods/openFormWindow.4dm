//%attributes = {}
// openFormWindow(->table;formName;windowType; {hpos};{vPos};{keepLastWindowPosition}): windowref
// opens a plain window , horizontally centered

C_POINTER:C301($1; $tablePtr)
C_TEXT:C284($2; $form)
C_LONGINT:C283($3; $windowType)
C_LONGINT:C283($4; $5; $hpos; $vpos)
C_BOOLEAN:C305($6; $doKeepPosition; <>doRememberWindowPositions)
C_LONGINT:C283($winRef; $0)

$doKeepPosition:=<>doRememberWindowPositions

Case of 
		
	: (Count parameters:C259=2)
		
		$tablePtr:=$1
		$form:=$2
		$windowType:=Plain window:K34:13
		$hpos:=Horizontally centered:K39:1
		$vpos:=Vertically centered:K39:4
		
		
		
	: (Count parameters:C259=3)
		
		$tablePtr:=$1
		$form:=$2
		$windowType:=$3
		$hpos:=Horizontally centered:K39:1
		$vpos:=Vertically centered:K39:4
		
		
	: (Count parameters:C259=3)
		
		$tablePtr:=$1
		$form:=$2
		$windowType:=$3
		$hpos:=$4
		$vpos:=Vertically centered:K39:4
		
	: (Count parameters:C259=5)
		
		$tablePtr:=$1
		$form:=$2
		$windowType:=$3
		$hpos:=$4
		$vpos:=$5
		
	: (Count parameters:C259=6)
		
		$tablePtr:=$1
		$form:=$2
		$windowType:=$3
		$hpos:=$4
		$vpos:=$5
		$doKeepPosition:=$6
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
		
End case 

If (Application type:C494#4D Server:K5:6)
	If (Is nil pointer:C315($tablePtr))  // this is a project form 
		$winRef:=Open form window:C675($form; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40($form)
	Else 
		
		//$winRef:=Open form window($tablePtr->;$form;-Palette form window;$hpos;$vpos)
		If (($doKeepPosition=True:C214) & (Not:C34(Shift down:C543)))  // if shift not down and remember is on
			
			$winRef:=Open form window:C675($tablePtr->; $form; $windowType; $hpos; $vpos; *)
		Else 
			$winRef:=Open form window:C675($tablePtr->; $form; $windowType; $hpos; $vpos)
		End if 
		
		DIALOG:C40($tablePtr->; $form)
		SET MENU BAR:C67(1)
		menuItemCustomizationUpdate
		$0:=$winRef
		
		BRING TO FRONT:C326(Current process:C322)
	End if 
End if 
