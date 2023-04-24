//%attributes = {}
// handleDropDownMenu (->fieldPtr; {fieldName} ; {form.attribute: string})

// Call this method to fill a dropdown menu values in a field
// PRE: this must be called from an array (DropDown menu) only ; 
// PRE: FORM EVENTS: ON LOAD ; ON CLICKED

#DECLARE($fieldPtr : Pointer; $fieldName : Text; $attribute : Text)

C_POINTER:C301($self; $tablePtr; $1)
C_LONGINT:C283($fieldNum; $tableNum; $n)
C_TEXT:C284($varName)


$self:=OBJECT Get pointer:C1124(Object current:K67:2)

$fieldPtr:=(Count parameters:C259<1) ? (->[Branches:70]BranchID:1) : $fieldPtr
$fieldName:=(Count parameters:C259<2) ? "" : $fieldName

If (Not:C34(Is nil pointer:C315($fieldPtr)))
	RESOLVE POINTER:C394($fieldPtr; $varName; $tableNum; $fieldNum)
	$tablePtr:=Table:C252($tableNum)
End if 

If (Form event code:C388=On Load:K2:1)
	If (Not:C34(Is nil pointer:C315($self)))
		READ ONLY:C145($tablePtr->)
		ALL RECORDS:C47($tablePtr->)
		DISTINCT VALUES:C339($fieldPtr->; $self->)
		SORT ARRAY:C229($self->)
		INSERT IN ARRAY:C227($self->; 1)
		$self->{1}:=$fieldName  // put the label on top
		$self->:=1  // select The first element
	End if 
End if 

// this case handles when a dropdown menus has a form variable assigned to it (e.g. Form.filterCurrency) 
// this part will make sure the form variable gets assigned the value of the picked line from the dropdown
// for example Form.filterCurrency will become "USD" if the user picks USD from the dropdown
If (Count parameters:C259=3)
	If (Form event code:C388=On Clicked:K2:4)
		If ($Self->>1)  // if the till was selected
			Form:C1466[$attribute]:=$Self->{$Self->}
		Else 
			Form:C1466[$attribute]:=""
		End if 
	End if 
End if 


If ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Data Change:K2:15))  // something else has to happen 
	
	//SET TIMER(1)
	//POST OUTSIDE CALL(Current process)
End if 

