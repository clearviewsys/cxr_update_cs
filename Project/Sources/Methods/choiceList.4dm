//%attributes = {}
// Method: ChoiceList (dialog title; ->string or text array; ...
//           ... {help topic}; {ICON/cicn number};{use user set}) -> selected item
// Set gCenterWind to True if you want this dialog centered over the frontmost
//   window.

C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3; $windowTitle)
C_LONGINT:C283($4)
C_BOOLEAN:C305($5; vbUserSet)  //<>IBB 02/14/03  - 0=don't use; 1=use user set

C_LONGINT:C283($0)


C_LONGINT:C283($position; $i; $winRef; $iWinRef)
C_PICTURE:C286(vDlogIcon)

vDlogTitle:=$1  // this is the dialog title

$position:=Position:C15("|"; vDlogTitle)
If ($position=0)
	$windowTitle:=""  //<>DB_NAME  // Same default as CenterFormWindow without a Title parameter.
Else 
	$windowTitle:=Substring:C12(vDlogTitle; 1; ($position-1))
	vDlogTitle:=Substring:C12(vDlogTitle; ($position+1))
End if 


If (Is a list:C621($2->))
	hlChoices:=Copy list:C626($2->)
Else   //we assume a text array
	hlChoices:=New list:C375
	
	For ($i; 1; Size of array:C274($2->))
		APPEND TO LIST:C376(hlChoices; $2->{$i}; $i)
	End for 
End if 

vDlogHelp:=""
If (Count parameters:C259>=3)
	vDlogHelp:=$3
End if 

vDlogIcon:=vDlogIcon*0  // So we can check the size after the next call and On Load.
If (Count parameters:C259=4)
	//loadPictureResource($4; ->vDlogIcon)
	GET PICTURE FROM LIBRARY:C565($4; vDlogIcon)
End if 

vbUserSet:=False:C215  //<>IBB 02/14/03
If (Count parameters:C259=5)
	vbUserSet:=$5
End if 


//CenterFormWindow(->[FND_Reg];"ChoiceList";Movable form dialog box;$windowTitle)
//SetMenuBar(Modal on)  // Turn off all menus.

$iWinRef:=Open form window:C675("ChoiceList"; Modal form dialog box:K39:7; Horizontally centered:K39:1; Vertically centered:K39:4)

DIALOG:C40("ChoiceList")
CLOSE WINDOW:C154
//SetMenuBar(Modal off)  // Restore the menus.

REDRAW WINDOW:C456  //◊IBB added 10/13/00

If (OK=1)
	$0:=vLastChoice  //  ` returns the position of the selected choice or the item reference number
Else 
	$0:=0
End if 

//ARRAY TEXT(aChoices;0)  ` Clear the array.

CLEAR LIST:C377(hlChoices; *)  //clear the hList