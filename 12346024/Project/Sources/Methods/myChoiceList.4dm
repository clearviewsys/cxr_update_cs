//%attributes = {}

// ----------------------------------------------------
// User name (OS): Designer
// Date and time: 05/24/17, 18:21:03
// ----------------------------------------------------
// Method: myChoiceList
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Method: myChoiceList (dialog title; ->string or text array; -> longint array to return selection in)
//$0 = count of items selected by user or 0 if canceled


C_TEXT:C284($1)
C_POINTER:C301($2; $ptrChoiceArray)
C_POINTER:C301($3; $ptrSelectedArray)  //pass in an empty array and this will fill the array with the element numbers of selected items from choiceArray

C_LONGINT:C283($0; $position; $i; $winRef)

C_TEXT:C284($windowTitle)
C_LONGINT:C283($iCheckPict)



vDlogTitle:=$1  // this is the dialog title
$ptrChoiceArray:=$2
$ptrSelectedArray:=$3

$position:=Position:C15("|"; vDlogTitle)
If ($position=0)
	$windowTitle:=<>COMPANYNAME
Else 
	$windowTitle:=Substring:C12(vDlogTitle; 1; ($position-1))
	vDlogTitle:=Substring:C12(vDlogTitle; ($position+1))
End if 

If (Size of array:C274($ptrSelectedArray->)>0)
	//need to resize this to 0
	DELETE FROM ARRAY:C228($ptrSelectedArray->; 1; Size of array:C274($ptrSelectedArray->))
End if 

$iCheckPict:=131072+26292  //picture library check mark

hlChoices:=New list:C375

For ($i; 1; Size of array:C274($ptrChoiceArray->))
	APPEND TO LIST:C376(hlChoices; "  "+$ptrChoiceArray->{$i}; $i)  //include some padding
	SET LIST ITEM PROPERTIES:C386(hlChoices; $i; False:C215; 0; 131072+13616)  //unchecked box in picture library
End for 

SET LIST PROPERTIES:C387(hlChoices; 0; 0; 30; 1; 0; 0)


If (Application type:C494=4D Server:K5:6)
Else 
	$winRef:=Open form window:C675([CompanyInfo:7]; "ChoiceList"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40([CompanyInfo:7]; "ChoiceList")
	CLOSE WINDOW:C154
End if 

C_LONGINT:C283($iStyle; $iPict)
C_BOOLEAN:C305($bEnterable)

For ($i; 1; Count list items:C380(hlChoices))  //see what items the user selected - can select more than one
	
	GET LIST ITEM PROPERTIES:C631(hlChoices; $i; $bEnterable; $iStyle; $iPict)
	If ($iPict=$iCheckPict)
		APPEND TO ARRAY:C911($ptrSelectedArray->; $i)  //element number that was selected by user
	End if 
End for 

If (OK=1)
	$0:=Size of array:C274($ptrSelectedArray->)  //return count of selected items
Else 
	$0:=0
End if 

CLEAR LIST:C377(hlChoices; *)

