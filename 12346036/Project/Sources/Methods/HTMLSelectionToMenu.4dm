//%attributes = {}
// HTMLSelectionToMenu ( aName ; »table ;»titleField; »valueField;[don't care] ) -

// aName : string

// aTable: table pointer

// field: field pointer

// retusn a HTML code for a selection to list



// <select name="select">

//  <option>are</option>

// <option>you</option>

// </select>


C_TEXT:C284($html)
C_LONGINT:C283($i)
C_POINTER:C301($varPtr)
C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4)
ORDER BY:C49($2->; $3->; >)
FIRST RECORD:C50($2->)

If (Records in selection:C76($2->)>0)
	$html:=Char:C90(1)+"<select name="+Quotify($1)+">"
	
	For ($i; 1; Records in selection:C76($2->))
		$html:=$html+"<option value="+Quotify($4->)+">"+$3->+"</option>"
		NEXT RECORD:C51($2->)
	End for 
	
	$html:=$html+"</select>"
Else 
	$html:=""
End if 

$varPtr:=Get pointer:C304($1)
$varPtr->:=$html