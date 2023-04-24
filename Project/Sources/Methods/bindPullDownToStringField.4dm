//%attributes = {}
// bindPullDownToStringField (->pullDown;->stringField)
C_POINTER:C301($1; $2; $pullDownPtr; $stringFieldPtr)
$pullDownPtr:=$1
$stringFieldPtr:=$2
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		$pullDownPtr->{0}:=$stringFieldPtr->  // init the default showing value
		$pullDownPtr->:=0
	: (Form event code:C388=On Clicked:K2:4)
		$stringFieldPtr->:=$pullDownPtr->{$pullDownPtr->}
		
End case 
