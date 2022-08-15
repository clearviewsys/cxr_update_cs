//%attributes = {}
//**************************************************************
//Method for decreasing the internal twilio number of texts balance
//#ORDA?
//
//Required Parameters:
//@textsSent (Int): Number of texts sent
//
//**************************************************************
C_LONGINT:C283($numTexts; $textsSent; $1)

Case of 
	: (Count parameters:C259=1)
		$textsSent:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$numTexts:=Num:C11(getKeyValue("twilio.accountTextBalance"))

$numTexts:=$numTexts-$textsSent

setKeyValue("twilio.accountTextBalance"; String:C10($numTexts))