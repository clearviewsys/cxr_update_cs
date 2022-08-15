//%attributes = {}
//**************************************************************
//Method for setting the headers and creating the body string 
//for an HTTP request to twilio
//
//Required Parameters:
//@pHeaderNames (Pointer): Pointer to text array
//@pHeaderValues (Pointer): Pointer to a text array
//@pBody (Pointer): Pointer to the body string variable
//@oBody (Object): Object containing all body values
//
//Output:
//HeaderNames and HeaderValues populated with required fields for
// a HTTP request, body string contains passed in values 
//**************************************************************
C_POINTER:C301($pHeaderNames; $pHeaderValues; $pBody; $1; $2; $3)
C_OBJECT:C1216($oBody; $4)
ARRAY TEXT:C222($paramNames; 0)
C_LONGINT:C283($i)


Case of 
	: (Count parameters:C259=4)
		$pHeaderNames:=$1
		$pHeaderValues:=$2
		$pBody:=$3
		$oBody:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

OB GET PROPERTY NAMES:C1232($oBody; $paramNames)
For ($i; 1; Size of array:C274($paramNames))
	If ($i>1)
		$pBody->:=$pBody->+"&"
	End if 
	$pBody->:=$pBody->+$paramNames{$i}+"="+$oBody[$paramNames{$i}]
End for 

twilioSetHeaders($pHeaderNames; $pHeaderValues; $pBody->)

