//%attributes = {}
//**************************************************************
//Method for Checking required fields for beneficiary creation on 
//the currency cloud platform
//
//Required Parameters:
//@Beneficiary (Object): Contains all fields for beneficiary
//@Error (Pointer): Pointer to text variable
//
//Outputs:
//On Success: True
//On Failure: False, Error message -> @Error
//**************************************************************

C_BOOLEAN:C305($0)
C_OBJECT:C1216($1; $beneficiary)
C_POINTER:C301($2; $pError)
C_LONGINT:C283($i)

$0:=True:C214
$beneficiary:=$1

ASSERT:C1129(Is nil pointer:C315($2)=False:C215)
$pError:=$2

If (OB Is defined:C1231($beneficiary; "currency")=False:C215)
	$0:=False:C215
	$pError->:="Beneficiary object must include a currency field"
End if 

ARRAY TEXT:C222($required; 4)
$required{1}:="bank_account_holder_name"
$required{2}:="bank_country"
$required{3}:="currency"
$required{4}:="name"

For ($i; 1; Size of array:C274($required))
	If (OB Is defined:C1231($beneficiary; $required{$i})=False:C215)
		$0:=False:C215
		$pError->:="Beneficiary object must include a "+$required{$i}+" field"
	End if 
End for 
