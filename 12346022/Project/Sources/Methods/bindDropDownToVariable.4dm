//%attributes = {}
// bindDropDownToVariable (->self;->dropdownArray)
// this method should be called from a variable or field object method that is bound to drop down menu
// updating the variable will automatically update the dropdown menu
// NOTE: This method only works on change form event



C_POINTER:C301($self; $arrayPointer; $1; $2)
C_LONGINT:C283($n)


$self:=$1
$arrayPointer:=$2
$n:=Size of array:C274($arrayPointer->)

If (Form event code:C388=On Data Change:K2:15)
	Self:C308->:=calcMin($self->; $n-1)  // do not let the selection exceed the size of the array
	Self:C308->:=calcMax($self->; 0)  // do not let the selection be negative
	
	$arrayPointer->:=$self->+1  // update the array to reflect the value of the variable
End if 
