//%attributes = {}
// bindPopUpToIntegerField (->popup;->intField)

C_POINTER:C301($1; $2)

var $methodCalledOnError : Text

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		// utilDisplayCallChain(Get call chain)
		
		If (($1=Null:C1517) | ($2=Null:C1517))
			utilDisplayCallChain(Get call chain:C1662)
		Else 
			If (Size of array:C274($1->)>0)
				$1->{0}:=$1->{$2->+1}
			Else 
				
			End if 
		End if 
		
		$1->:=$2->+1
		
		
	: (Form event code:C388=On Clicked:K2:4)
		$2->:=$1->-1
		
End case 
