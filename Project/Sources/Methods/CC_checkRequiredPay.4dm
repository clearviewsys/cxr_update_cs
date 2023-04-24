//%attributes = {}
//**************************************************************
//Method for Checking required fields for payment creation on 
//the currency cloud platform
//
//Required Parameters:
//@Payment (Object): Contains all fields for payment
//@Error (Pointer): Pointer to text variable
//
//Outputs:
//On Success: True
//On Failure: False, Error message -> @Error
//**************************************************************

C_BOOLEAN:C305($0)
C_OBJECT:C1216($1; $payment)
C_POINTER:C301($2; $pError)
C_LONGINT:C283($i)

$0:=True:C214
$payment:=$1

ASSERT:C1129(Is nil pointer:C315($2)=False:C215)
$pError:=$2

If (OB Is defined:C1231($payment; "currency")=False:C215)
	$0:=False:C215
	$pError->:="Beneficiary object must include a currency field"
End if 

ARRAY TEXT:C222($required; 4)
$required{1}:="beneficiary_id"
$required{2}:="amount"
$required{3}:="reason"
$required{4}:="reference"

For ($i; 1; Size of array:C274($required))
	If (OB Is defined:C1231($payment; $required{$i})=False:C215)
		$0:=False:C215
		$pError->:="Beneficiary object must include a "+$required{$i}+" field"
	End if 
End for 
