//%attributes = {}
// HTMLSelectionToMenu ( aName ; »table ;»titleField1;->titleField2; »valueField;seperator ) -

// aName : string

// aTable: table pointer

// field: field pointer

// retusn a HTML code for a selection to list



// <select name="select">

//  <option>are</option>

// <option>you</option>

// </select>


C_TEXT:C284($html)
C_TEXT:C284($1; $6)
C_POINTER:C301($2; $3; $4; $5)
C_POINTER:C301($varPtr)
C_LONGINT:C283($i)
ORDER BY:C49($2->; $3->; >)
FIRST RECORD:C50($2->)

If (Records in selection:C76($2->)>0)
	$html:=Char:C90(1)+"<select name="+Quotify($1)+">"
	
	For ($i; 1; Records in selection:C76($2->))
		$html:=$html+"<option value="+Quotify($5->)+">"+$3->+$6+$4->+"</option>"
		NEXT RECORD:C51($2->)
	End for 
	
	$html:=$html+"</select>"
Else 
	$html:=""
End if 

$varPtr:=Get pointer:C304($1)
$varPtr->:=$html