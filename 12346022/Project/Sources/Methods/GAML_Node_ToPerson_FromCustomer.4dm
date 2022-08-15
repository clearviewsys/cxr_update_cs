//%attributes = {}
// GAML_Node_ToPerson_FromCustomer

C_TEXT:C284($0)
C_TEXT:C284($1; $to)

Case of 
		
	: (Count parameters:C259=1)
		$to:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


GAML_NodeT_PersonFromCustomer($to)