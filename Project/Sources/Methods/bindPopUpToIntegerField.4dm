//%attributes = {}
// bindPopUpToIntegerField (->popup;->intField)

C_POINTER:C301($1; $2)

var $popupPtr; $fieldPtr : Pointer

If (Count parameters:C259>0)
	$popupPtr:=$1
	If (Count parameters:C259>1)
		$fieldPtr:=$2
	End if 
End if 


Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		// utilDisplayCallChain(Get call chain)
		
		If (($popupPtr=Null:C1517) | ($fieldPtr=Null:C1517))
			utilDisplayCallChain(Get call chain:C1662)
		Else 
			
			If (Size of array:C274($popupPtr->)>0)
				
				$popupPtr->{0}:=$popupPtr->{$fieldPtr->+1}
				
			Else 
				
			End if 
		End if 
		
		$popupPtr->:=$fieldPtr->+1
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		$fieldPtr->:=$popupPtr->-1
		
End case 
